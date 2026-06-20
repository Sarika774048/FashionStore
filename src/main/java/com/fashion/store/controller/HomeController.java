package com.fashion.store.controller;

import java.io.IOException;
import java.util.List;

import com.fashion.store.model.Category;
import com.fashion.store.model.Product;
import com.fashion.store.service.CategoryService;
import com.fashion.store.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CategoryService categoryService;
    private ProductService productService;

    @Override
    public void init() {
        categoryService = new CategoryService();
        productService = new ProductService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories =
                categoryService.getAllCategories();

        List<Product> products =
                productService.getAllProducts();

        request.setAttribute(
                "categories",
                categories);

        request.setAttribute(
                "products",
                products);

        request.getRequestDispatcher(
                "/WEB-INF/views/home/home.jsp")
                .forward(request, response);
    }
}