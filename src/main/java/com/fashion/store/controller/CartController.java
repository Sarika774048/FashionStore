package com.fashion.store.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.fashion.store.dto.CartResponse;
import com.fashion.store.model.CartItem;
import com.fashion.store.model.Product;
import com.fashion.store.model.ProductVariant;
import com.fashion.store.model.User;
import com.fashion.store.service.CartService;
import com.fashion.store.service.ProductService;
import com.fashion.store.service.ProductVariantService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartService cartService;
    private ProductVariantService variantService;
    private ProductService productService;

    @Override
    public void init() {
        cartService = new CartService();
        variantService = new ProductVariantService();
        productService = new ProductService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        User user =
                (User) request.getSession()
                        .getAttribute("loggedInUser");

        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/auth?action=showLogin");

            return;
        }

        List<CartItem> cartItems =
                cartService.getCartItems(
                        user.getUserId());

        List<CartResponse> cartResponses = new ArrayList<>();
        BigDecimal cartTotal = BigDecimal.ZERO;

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
            cartTotal = cartTotal.add(subtotal);

            cartResponses.add(res);
        }

        request.setAttribute(
                "cartItems",
                cartResponses);

        request.setAttribute(
                "cartTotal",
                cartTotal);

        request.getRequestDispatcher(
                "/WEB-INF/views/cart/cart.jsp")
                .forward(request, response);
    }
}