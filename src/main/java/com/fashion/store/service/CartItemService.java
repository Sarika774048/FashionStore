package com.fashion.store.service;

import java.util.List;

import com.fashion.store.dao.CartItemDAO;
import com.fashion.store.dao.impl.CartItemDAOImpl;
import com.fashion.store.model.CartItem;

public class CartItemService {

    private final CartItemDAO cartItemDAO;

    public CartItemService() {
        cartItemDAO = new CartItemDAOImpl();
    }

    public boolean addCartItem(CartItem item) {
        return cartItemDAO.addCartItem(item);
    }

    public List<CartItem> getCartItemsByCartId(
            int cartId) {

        return cartItemDAO
                .getCartItemsByCartId(cartId);
    }

    public CartItem getCartItemByCartAndVariant(
            int cartId,
            int variantId) {

        return cartItemDAO
                .getCartItemByCartAndVariant(
                        cartId,
                        variantId);
    }

    public boolean updateQuantity(
            int cartItemId,
            int quantity) {

        return cartItemDAO.updateQuantity(
                cartItemId,
                quantity);
    }

    public boolean deleteCartItem(
            int cartItemId) {

        return cartItemDAO.deleteCartItem(
                cartItemId);
    }

    public boolean clearCart(
            int cartId) {

        return cartItemDAO.clearCart(cartId);
    }
}