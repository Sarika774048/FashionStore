package com.fashion.store.controller;

import java.io.IOException;
import java.util.List;

import com.fashion.store.model.Product;
import com.fashion.store.model.ProductVariant;
import com.fashion.store.service.ProductService;
import com.fashion.store.service.ProductVariantService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/products")
public class ProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductService productService;
    private ProductVariantService variantService;

    @Override
    public void init() {

        productService = new ProductService();
        variantService = new ProductVariantService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        if ("details".equals(action)) {

            int productId =
                    Integer.parseInt(
                            request.getParameter("id"));

            Product product =
                    productService.getProductById(productId);

            List<ProductVariant> variants =
                    variantService.getVariantsByProductId(productId);

            request.setAttribute(
                    "product",
                    product);

            request.setAttribute(
                    "variants",
                    variants);

            request.getRequestDispatcher(
                    "/WEB-INF/views/product/product-details.jsp")
                    .forward(request, response);
        }
        else {

            List<Product> products;
            String categoryIdParam = request.getParameter("categoryId");
            String searchKeyword = request.getParameter("search");

            if (categoryIdParam != null && !categoryIdParam.trim().isEmpty()) {
                try {
                    int categoryId = Integer.parseInt(categoryIdParam);
                    products = productService.getProductsByCategory(categoryId);
                } catch (NumberFormatException e) {
                    products = productService.getAllProducts();
                }
            } else if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                products = productService.searchProducts(searchKeyword);
            } else {
                products = productService.getAllProducts();
            }

            request.setAttribute(
                    "products",
                    products);

            request.getRequestDispatcher(
                    "/WEB-INF/views/product/products.jsp")
                    .forward(request, response);
        }
    }
}