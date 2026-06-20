package com.fashion.store.dao;

import com.fashion.store.model.Cart;

public interface CartDAO {

    Cart getCartByUserId(int userId);

    boolean createCart(int userId);

    int getCartIdByUserId(int userId);
}