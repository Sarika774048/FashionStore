package com.fashion.store.controller;

import java.io.IOException;

import com.fashion.store.model.User;
import com.fashion.store.service.UserService;
import com.fashion.store.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
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

        // Fetch fresh copy from database
        User dbUser = userService.getUserById(user.getUserId());
        request.setAttribute("user", dbUser);

        request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User loggedInUser = (User) (session != null ? session.getAttribute("loggedInUser") : null);

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=showLogin");
            return;
        }

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String addressLine = request.getParameter("addressLine");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");

        if (fullName == null || fullName.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            addressLine == null || addressLine.trim().isEmpty() ||
            city == null || city.trim().isEmpty() ||
            state == null || state.trim().isEmpty() ||
            pincode == null || pincode.trim().isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required.");
            doGet(request, response);
            return;
        }

        if (!ValidationUtil.isPhoneValid(phone)) {
            request.setAttribute("errorMessage", "Invalid phone number. Must be exactly 10 digits.");
            doGet(request, response);
            return;
        }

        if (!ValidationUtil.isPincodeValid(pincode)) {
            request.setAttribute("errorMessage", "Invalid pincode. Must be exactly 6 digits.");
            doGet(request, response);
            return;
        }

        User userToUpdate = new User();
        userToUpdate.setUserId(loggedInUser.getUserId());
        userToUpdate.setFullName(fullName);
        userToUpdate.setPhone(phone);
        userToUpdate.setAddressLine(addressLine);
        userToUpdate.setCity(city);
        userToUpdate.setState(state);
        userToUpdate.setPincode(pincode);

        boolean updated = userService.updateUser(userToUpdate);

        if (updated) {
            // Update session user
            loggedInUser.setFullName(fullName);
            loggedInUser.setPhone(phone);
            loggedInUser.setAddressLine(addressLine);
            loggedInUser.setCity(city);
            loggedInUser.setState(state);
            loggedInUser.setPincode(pincode);
            session.setAttribute("loggedInUser", loggedInUser);

            request.setAttribute("successMessage", "Profile updated successfully.");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile.");
        }

        doGet(request, response);
    }
}
