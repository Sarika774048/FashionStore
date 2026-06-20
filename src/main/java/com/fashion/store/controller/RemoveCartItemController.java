package com.fashion.store.controller;

import java.io.IOException;

import com.fashion.store.service.CartItemService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/remove-cart-item")
public class RemoveCartItemController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartItemService cartItemService;

    @Override
    public void init() {
        cartItemService = new CartItemService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int cartItemId =
                Integer.parseInt(
                        request.getParameter("cartItemId"));

        cartItemService.deleteCartItem(
                cartItemId);

        response.sendRedirect(
                request.getContextPath()
                + "/cart");
    }
}