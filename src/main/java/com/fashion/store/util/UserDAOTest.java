package com.fashion.store.util;

import com.fashion.store.dao.UserDAO;
import com.fashion.store.dao.impl.UserDAOImpl;
import com.fashion.store.model.User;

public class UserDAOTest {

    public static void main(String[] args) {

        UserDAO dao = new UserDAOImpl();

        User user = new User();

        user.setFullName("Sarika");
        user.setEmail("sarika@gmail.com");
        user.setPhone("9876543210");
        user.setPassword("123456");
        user.setAddressLine("Chennai");
        user.setCity("Chennai");
        user.setState("Tamil Nadu");
        user.setPincode("600001");

        boolean status = dao.registerUser(user);

        System.out.println(status
                ? "User Registered Successfully"
                : "Registration Failed");
    }
}