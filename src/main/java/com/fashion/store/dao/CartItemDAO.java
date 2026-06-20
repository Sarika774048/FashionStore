package com.fashion.store.dao;

import java.util.List;

import com.fashion.store.model.CartItem;

public interface CartItemDAO {

    boolean addCartItem(CartItem cartItem);

    List<CartItem> getCartItemsByCartId(int cartId);

    CartItem getCartItemByCartAndVariant(
            int cartId,
            int variantId);

    boolean updateQuantity(
            int cartItemId,
            int quantity);

    boolean deleteCartItem(int cartItemId);

    boolean clearCart(int cartId);
}