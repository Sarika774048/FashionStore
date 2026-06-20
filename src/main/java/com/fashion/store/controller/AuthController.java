package com.fashion.store.controller;

import java.io.IOException;

import com.fashion.store.model.User;
import com.fashion.store.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/auth")
public class AuthController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("register".equals(action)) {

            registerUser(request, response);

        } else if ("login".equals(action)) {

            loginUser(request, response);
        }
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("showLogin".equals(action)) {

            request.getRequestDispatcher(
                    "/WEB-INF/views/auth/login.jsp")
                    .forward(request, response);

        } else if ("showRegister".equals(action)) {

            request.getRequestDispatcher(
                    "/WEB-INF/views/auth/register.jsp")
                    .forward(request, response);

        } else if ("logout".equals(action)) {

            HttpSession session =
                    request.getSession(false);

            if (session != null) {
                session.invalidate();
            }

            response.sendRedirect(
                    request.getContextPath()
                    + "/auth?action=showLogin");
        }
    }

    private void registerUser(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {

        User user = new User();

        user.setFullName(
                request.getParameter("fullName"));

        user.setEmail(
                request.getParameter("email"));

        user.setPhone(
                request.getParameter("phone"));

        user.setPassword(
                request.getParameter("password"));

        user.setAddressLine(
                request.getParameter("addressLine"));

        user.setCity(
                request.getParameter("city"));

        user.setState(
                request.getParameter("state"));

        user.setPincode(
                request.getParameter("pincode"));

        System.out.println("===== REGISTER REQUEST =====");
        System.out.println("Email = " + user.getEmail());

        boolean registered =
                userService.registerUser(user);

        System.out.println("REGISTERED = " + registered);

        if (registered) {

            request.setAttribute(
                    "successMessage",
                    "Registration Successful. Please Login.");

            request.getRequestDispatcher(
                    "/WEB-INF/views/auth/login.jsp")
                    .forward(request, response);

        } else {

            request.setAttribute(
                    "errorMessage",
                    "Registration Failed.");

            request.getRequestDispatcher(
                    "/WEB-INF/views/auth/register.jsp")
                    .forward(request, response);
        }
    }

    private void loginUser(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        System.out.println("================================");
        System.out.println("LOGIN REQUEST RECEIVED");
        System.out.println("EMAIL = " + email);
        System.out.println("PASSWORD = " + password);

        User user =
                userService.loginUser(email, password);

        System.out.println("USER OBJECT = " + user);

        if (user != null) {

            System.out.println("LOGIN SUCCESS");

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "loggedInUser",
                    user);

            session.setAttribute(
                    "userId",
                    user.getUserId());

            response.sendRedirect(
                    request.getContextPath()
                    + "/index.jsp");

        } else {

            System.out.println("LOGIN FAILED");

            request.setAttribute(
                    "errorMessage",
                    "Invalid Email or Password");

            request.getRequestDispatcher(
                    "/WEB-INF/views/auth/login.jsp")
                    .forward(request, response);
        }
    }
}