package com.fashion.store.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashion.store.dao.CartItemDAO;
import com.fashion.store.model.CartItem;
import com.fashion.store.util.DBConnection;

public class CartItemDAOImpl implements CartItemDAO {

    @Override
    public boolean addCartItem(CartItem cartItem) {

        String query = """
                INSERT INTO cart_items
                (cart_id, variant_id, quantity)
                VALUES (?, ?, ?)
                """;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, cartItem.getCartId());
            ps.setInt(2, cartItem.getVariantId());
            ps.setInt(3, cartItem.getQuantity());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<CartItem> getCartItemsByCartId(int cartId) {

        List<CartItem> cartItems =
                new ArrayList<>();

        String query =
                "SELECT * FROM cart_items WHERE cart_id=?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, cartId);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                CartItem item =
                        new CartItem();

                item.setCartItemId(
                        rs.getInt("cart_item_id"));

                item.setCartId(
                        rs.getInt("cart_id"));

                item.setVariantId(
                        rs.getInt("variant_id"));

                item.setQuantity(
                        rs.getInt("quantity"));

                cartItems.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartItems;
    }

    @Override
    public CartItem getCartItemByCartAndVariant(
            int cartId,
            int variantId) {

        String query = """
                SELECT * FROM cart_items
                WHERE cart_id=? AND variant_id=?
                """;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, cartId);
            ps.setInt(2, variantId);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                CartItem item =
                        new CartItem();

                item.setCartItemId(
                        rs.getInt("cart_item_id"));

                item.setCartId(
                        rs.getInt("cart_id"));

                item.setVariantId(
                        rs.getInt("variant_id"));

                item.setQuantity(
                        rs.getInt("quantity"));

                return item;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean updateQuantity(
            int cartItemId,
            int quantity) {

        String query =
                "UPDATE cart_items SET quantity=? WHERE cart_item_id=?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean deleteCartItem(int cartItemId) {

        String query =
                "DELETE FROM cart_items WHERE cart_item_id=?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, cartItemId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean clearCart(int cartId) {

        String query =
                "DELETE FROM cart_items WHERE cart_id=?";

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, cartId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}