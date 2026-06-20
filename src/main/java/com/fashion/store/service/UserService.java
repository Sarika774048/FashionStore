package com.fashion.store.service;

import com.fashion.store.dao.UserDAO;
import com.fashion.store.dao.impl.UserDAOImpl;
import com.fashion.store.model.User;
import com.fashion.store.util.PasswordUtil;
import com.fashion.store.util.ValidationUtil;

public class UserService {

    private final UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAOImpl();
    }

    public boolean registerUser(User user) {

        System.out.println("===== USER SERVICE DEBUG =====");

        if (user == null) {
            System.out.println("User is null");
            return false;
        }

        System.out.println("Email = " + user.getEmail());
        System.out.println("Phone = " + user.getPhone());
        System.out.println("Pincode = " + user.getPincode());

        boolean emailValid =
                ValidationUtil.isEmailValid(user.getEmail());

        boolean phoneValid =
                ValidationUtil.isPhoneValid(user.getPhone());

        boolean pincodeValid =
                ValidationUtil.isPincodeValid(user.getPincode());

        System.out.println("Email Valid = " + emailValid);
        System.out.println("Phone Valid = " + phoneValid);
        System.out.println("Pincode Valid = " + pincodeValid);

        if (!emailValid) {
            System.out.println("Email validation failed");
            return false;
        }

        if (!phoneValid) {
            System.out.println("Phone validation failed");
            return false;
        }

        if (!pincodeValid) {
            System.out.println("Pincode validation failed");
            return false;
        }

        User existingUser =
                userDAO.getUserByEmail(user.getEmail());

        System.out.println("Existing User = " + existingUser);

        if (existingUser != null) {
            System.out.println("Email already exists");
            return false;
        }

        String encryptedPassword =
                PasswordUtil.encryptPassword(user.getPassword());

        System.out.println("Encrypted Password = "
                + encryptedPassword);

        user.setPassword(encryptedPassword);

        boolean result =
                userDAO.registerUser(user);

        System.out.println("Insert Result = " + result);

        return result;
    }

    public User loginUser(String email, String password) {

        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            return null;
        }

        boolean passwordMatched =
                PasswordUtil.matchPassword(
                        password,
                        user.getPassword());

        return passwordMatched ? user : null;
    }

    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }

    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }
}