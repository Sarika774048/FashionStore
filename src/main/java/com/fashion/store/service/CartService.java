package com.fashion.store.service;

import java.util.List;

import com.fashion.store.dao.CartDAO;
import com.fashion.store.dao.CartItemDAO;
import com.fashion.store.dao.impl.CartDAOImpl;
import com.fashion.store.dao.impl.CartItemDAOImpl;
import com.fashion.store.model.CartItem;

public class CartService {

    private CartDAO cartDAO = new CartDAOImpl();
    private CartItemDAO cartItemDAO = new CartItemDAOImpl();

    public void createCartIfNotExists(int userId) {

        if (cartDAO.getCartByUserId(userId) == null) {
            cartDAO.createCart(userId);
        }
    }

    public boolean addToCart(
            int userId,
            int variantId,
            int quantity) {

        createCartIfNotExists(userId);

        int cartId =
                cartDAO.getCartIdByUserId(userId);

        CartItem item = new CartItem();

        item.setCartId(cartId);
        item.setVariantId(variantId);
        item.setQuantity(quantity);

        return cartItemDAO.addCartItem(item);
    }

    public List<CartItem> getCartItems(int userId) {

        int cartId =
                cartDAO.getCartIdByUserId(userId);

        return cartItemDAO.getCartItemsByCartId(cartId);
    }

    public boolean clearCart(int userId) {
        int cartId = cartDAO.getCartIdByUserId(userId);
        if (cartId > 0) {
            return cartItemDAO.clearCart(cartId);
        }
        return false;
    }

    public int getCartIdByUserId(int userId) {
        return cartDAO.getCartIdByUserId(userId);
    }
}