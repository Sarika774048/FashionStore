package com.fashion.store.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.fashion.store.dto.CartResponse;
import com.fashion.store.dto.OrderItemResponse;
import com.fashion.store.dto.OrderResponse;
import com.fashion.store.model.CartItem;
import com.fashion.store.model.Order;
import com.fashion.store.model.OrderItem;
import com.fashion.store.model.Product;
import com.fashion.store.model.ProductVariant;
import com.fashion.store.model.User;
import com.fashion.store.service.CartService;
import com.fashion.store.service.OrderService;
import com.fashion.store.service.ProductService;
import com.fashion.store.service.ProductVariantService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/order")
public class OrderController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderService orderService;
    private CartService cartService;
    private ProductVariantService variantService;
    private ProductService productService;

    @Override
    public void init() {
        orderService = new OrderService();
        cartService = new CartService();
        variantService = new ProductVariantService();
        productService = new ProductService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("loggedInUser") : null);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=showLogin");
            return;
        }

        String action = request.getParameter("action");

        if ("checkout".equals(action)) {
            showCheckout(request, response, user);
        } else if ("success".equals(action)) {
            showSuccess(request, response, user);
        } else if ("list".equals(action)) {
            showOrdersList(request, response, user);
        } else if ("details".equals(action)) {
            showOrderDetails(request, response, user);
        } else {
            response.sendRedirect(request.getContextPath() + "/order?action=list");
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("loggedInUser") : null);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=showLogin");
            return;
        }

        String action = request.getParameter("action");

        if ("placeOrder".equals(action)) {
            processPlaceOrder(request, response, user);
        } else {
            response.sendRedirect(request.getContextPath() + "/order?action=list");
        }
    }

    private void showCheckout(
            HttpServletRequest request,
            HttpServletResponse response,
            User user)
            throws ServletException, IOException {

        List<CartItem> cartItems = cartService.getCartItems(user.getUserId());

        if (cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        List<CartResponse> cartResponses = new ArrayList<>();
        BigDecimal totalAmount = BigDecimal.ZERO;

        for (CartItem item : cartItems) {

            ProductVariant variant = variantService.getVariantById(item.getVariantId());
            if (variant == null) continue;

            Product product = productService.getProductById(variant.getProductId());
            if (product == null) continue;

            CartResponse res = new CartResponse();
            res.setCartItemId(item.getCartItemId());
            res.setVariantId(item.getVariantId());
            res.setProductId(product.getProductId());
            res.setProductName(product.getProductName());
            res.setBrand(product.getBrand());
            res.setSize(variant.getSize());
            res.setColor(variant.getColor());
            res.setPrice(variant.getPrice());
            res.setQuantity(item.getQuantity());

            BigDecimal subtotal = variant.getPrice().multiply(new BigDecimal(item.getQuantity()));
            res.setSubtotal(subtotal);
            totalAmount = totalAmount.add(subtotal);

            cartResponses.add(res);
        }

        request.setAttribute("cartItems", cartResponses);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("user", user);

        request.getRequestDispatcher("/WEB-INF/views/order/checkout.jsp")
                .forward(request, response);
    }

    private void processPlaceOrder(
            HttpServletRequest request,
            HttpServletResponse response,
            User user)
            throws ServletException, IOException {

        List<CartItem> cartItems = cartService.getCartItems(user.getUserId());

        if (cartItems.isEmpty()) {
            request.setAttribute("errorMessage", "Your cart is empty.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        BigDecimal totalAmount = BigDecimal.ZERO;
        List<ProductVariant> validatedVariants = new ArrayList<>();
        List<CartItem> validItems = new ArrayList<>();

        // Validate stock and calculate total
        for (CartItem item : cartItems) {
            ProductVariant variant = variantService.getVariantById(item.getVariantId());
            if (variant == null) {
                request.setAttribute("errorMessage", "Some items in your cart are no longer available.");
                showCheckout(request, response, user);
                return;
            }

            if (item.getQuantity() > variant.getStockQuantity()) {
                Product product = productService.getProductById(variant.getProductId());
                String pName = product != null ? product.getProductName() : "Product";
                request.setAttribute("errorMessage", "Insufficient stock for " + pName + " (" + variant.getColor() + ", " + variant.getSize() + "). Available stock: " + variant.getStockQuantity());
                showCheckout(request, response, user);
                return;
            }

            BigDecimal subtotal = variant.getPrice().multiply(new BigDecimal(item.getQuantity()));
            totalAmount = totalAmount.add(subtotal);
            validatedVariants.add(variant);
            validItems.add(item);
        }

        // Create Order header
        Order order = new Order();
        order.setUserId(user.getUserId());
        order.setTotalAmount(totalAmount);
        order.setOrderStatus("Placed");

        int orderId = orderService.createOrder(order);

        if (orderId > 0) {
            // Save Order items and update stock
            for (int i = 0; i < validItems.size(); i++) {
                CartItem item = validItems.get(i);
                ProductVariant variant = validatedVariants.get(i);

                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(orderId);
                orderItem.setVariantId(item.getVariantId());
                orderItem.setQuantity(item.getQuantity());
                orderItem.setPrice(variant.getPrice());

                orderService.addOrderItem(orderItem);

                // Update variant inventory
                int newStock = variant.getStockQuantity() - item.getQuantity();
                variantService.updateStock(variant.getVariantId(), newStock);
            }

            // Clear checkout cart
            cartService.clearCart(user.getUserId());

            response.sendRedirect(request.getContextPath() + "/order?action=success&id=" + orderId);
        } else {
            request.setAttribute("errorMessage", "Failed to place your order. Please try again.");
            showCheckout(request, response, user);
        }
    }

    private void showSuccess(
            HttpServletRequest request,
            HttpServletResponse response,
            User user)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/order?action=list");
            return;
        }

        int orderId = Integer.parseInt(idParam);
        Order order = orderService.getOrderById(orderId);

        if (order == null || order.getUserId() != user.getUserId()) {
            response.sendRedirect(request.getContextPath() + "/order?action=list");
            return;
        }

        List<OrderItem> items = orderService.getOrderItemsByOrderId(orderId);
        List<OrderItemResponse> itemResponses = new ArrayList<>();

        for (OrderItem item : items) {
            ProductVariant variant = variantService.getVariantById(item.getVariantId());
            if (variant == null) continue;

            Product product = productService.getProductById(variant.getProductId());
            if (product == null) continue;

            OrderItemResponse res = new OrderItemResponse();
            res.setOrderItemId(item.getOrderItemId());
            res.setVariantId(item.getVariantId());
            res.setProductId(product.getProductId());
            res.setProductName(product.getProductName());
            res.setBrand(product.getBrand());
            res.setSize(variant.getSize());
            res.setColor(variant.getColor());
            res.setQuantity(item.getQuantity());
            res.setPrice(item.getPrice());
            res.setSubtotal(item.getPrice().multiply(new BigDecimal(item.getQuantity())));

            itemResponses.add(res);
        }

        request.setAttribute("order", order);
        request.setAttribute("orderItems", itemResponses);

        request.getRequestDispatcher("/WEB-INF/views/order/order-success.jsp")
                .forward(request, response);
    }

    private void showOrdersList(
            HttpServletRequest request,
            HttpServletResponse response,
            User user)
            throws ServletException, IOException {

        List<Order> orders = orderService.getOrdersByUserId(user.getUserId());
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/WEB-INF/views/order/my-orders.jsp")
                .forward(request, response);
    }

    private void showOrderDetails(
            HttpServletRequest request,
            HttpServletResponse response,
            User user)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/order?action=list");
            return;
        }

        int orderId = Integer.parseInt(idParam);
        Order order = orderService.getOrderById(orderId);

        if (order == null || order.getUserId() != user.getUserId()) {
            response.sendRedirect(request.getContextPath() + "/order?action=list");
            return;
        }

        List<OrderItem> items = orderService.getOrderItemsByOrderId(orderId);
        List<OrderItemResponse> itemResponses = new ArrayList<>();

        for (OrderItem item : items) {
            ProductVariant variant = variantService.getVariantById(item.getVariantId());
            if (variant == null) continue;

            Product product = productService.getProductById(variant.getProductId());
            if (product == null) continue;

            OrderItemResponse res = new OrderItemResponse();
            res.setOrderItemId(item.getOrderItemId());
            res.setVariantId(item.getVariantId());
            res.setProductId(product.getProductId());
            res.setProductName(product.getProductName());
            res.setBrand(product.getBrand());
            res.setSize(variant.getSize());
            res.setColor(variant.getColor());
            res.setQuantity(item.getQuantity());
            res.setPrice(item.getPrice());
            res.setSubtotal(item.getPrice().multiply(new BigDecimal(item.getQuantity())));

            itemResponses.add(res);
        }

        request.setAttribute("order", order);
        request.setAttribute("orderItems", itemResponses);

        request.getRequestDispatcher("/WEB-INF/views/order/order-details.jsp")
                .forward(request, response);
    }
}
