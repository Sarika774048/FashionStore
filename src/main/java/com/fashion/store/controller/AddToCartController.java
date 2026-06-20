package com.fashion.store.controller;

import java.io.IOException;

import com.fashion.store.model.User;
import com.fashion.store.service.CartService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/add-to-cart")
public class AddToCartController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartService cartService;

    @Override
    public void init() {
        cartService = new CartService();
    }

    @Override
    protected void doPost(
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

        int variantId =
                Integer.parseInt(
                        request.getParameter("variantId"));

        int quantity =
                Integer.parseInt(
                        request.getParameter("quantity"));

        cartService.addToCart(
                user.getUserId(),
                variantId,
                quantity);

        response.sendRedirect(
                request.getContextPath()
                + "/cart");
    }
}