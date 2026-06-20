package com.fashion.store.dao;

import com.fashion.store.model.User;

public interface UserDAO {

    boolean registerUser(User user);

    User getUserByEmail(String email);

    User getUserById(int userId);

    boolean updateUser(User user);
}