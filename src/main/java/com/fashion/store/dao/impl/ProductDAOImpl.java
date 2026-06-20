package com.fashion.store.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashion.store.dao.ProductDAO;
import com.fashion.store.model.Product;
import com.fashion.store.util.DBConnection;

public class ProductDAOImpl implements ProductDAO {

    @Override
    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        String query = "SELECT * FROM products";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Product product = new Product();

                product.setProductId(rs.getInt("product_id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setProductName(rs.getString("product_name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));

                products.add(product);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return products;
    }

    @Override
    public Product getProductById(int productId) {

        String query =
                "SELECT * FROM products WHERE product_id=?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, productId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                Product product = new Product();

                product.setProductId(rs.getInt("product_id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setProductName(rs.getString("product_name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));

                return product;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Product> getProductsByCategory(int categoryId) {

        List<Product> products = new ArrayList<>();

        String query =
                "SELECT * FROM products WHERE category_id=?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Product product = new Product();

                product.setProductId(rs.getInt("product_id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setProductName(rs.getString("product_name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));

                products.add(product);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return products;
    }

    @Override
    public List<Product> searchProducts(String keyword) {

        List<Product> products = new ArrayList<>();

        String query =
                "SELECT * FROM products WHERE product_name LIKE ?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setString(1, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Product product = new Product();

                product.setProductId(rs.getInt("product_id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setProductName(rs.getString("product_name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));

                products.add(product);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return products;
    }
}