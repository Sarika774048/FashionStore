package com.fashion.store.controller;

import java.io.IOException;

import com.fashion.store.service.CartItemService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/update-cart")
public class UpdateCartController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartItemService cartItemService;

    @Override
    public void init() {
        cartItemService = new CartItemService();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int cartItemId =
                Integer.parseInt(
                        request.getParameter("cartItemId"));

        int quantity =
                Integer.parseInt(
                        request.getParameter("quantity"));

        cartItemService.updateQuantity(
                cartItemId,
                quantity);

        response.sendRedirect(
                request.getContextPath()
                + "/cart");
    }
}