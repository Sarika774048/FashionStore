package com.fashion.store.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.fashion.store.dao.CartDAO;
import com.fashion.store.model.Cart;
import com.fashion.store.util.DBConnection;

public class CartDAOImpl implements CartDAO {

    @Override
    public Cart getCartByUserId(int userId) {

        Cart cart = null;

        try (Connection con = DBConnection.getConnection()) {

            String query =
                    "SELECT * FROM cart WHERE user_id=?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                cart = new Cart();

                cart.setCartId(rs.getInt("cart_id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setCreatedAt(rs.getTimestamp("created_at"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cart;
    }

    @Override
    public boolean createCart(int userId) {

        try (Connection con = DBConnection.getConnection()) {

            String query =
                    "INSERT INTO cart(user_id) VALUES(?)";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public int getCartIdByUserId(int userId) {

        try (Connection con = DBConnection.getConnection()) {

            String query =
                    "SELECT cart_id FROM cart WHERE user_id=?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("cart_id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}