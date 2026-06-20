package com.fashion.store.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashion.store.dao.ProductVariantDAO;
import com.fashion.store.model.ProductVariant;
import com.fashion.store.util.DBConnection;

public class ProductVariantDAOImpl implements ProductVariantDAO {

    @Override
    public List<ProductVariant> getVariantsByProductId(int productId) {

        List<ProductVariant> variants = new ArrayList<>();

        String query =
                "SELECT * FROM product_variants WHERE product_id=?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, productId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                ProductVariant variant = new ProductVariant();

                variant.setVariantId(rs.getInt("variant_id"));
                variant.setProductId(rs.getInt("product_id"));
                variant.setSize(rs.getString("size"));
                variant.setColor(rs.getString("color"));
                variant.setPrice(rs.getBigDecimal("price"));
                variant.setStockQuantity(rs.getInt("stock_quantity"));
                variant.setImageUrl(rs.getString("image_url"));

                variants.add(variant);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return variants;
    }

    @Override
    public ProductVariant getVariantById(int variantId) {

        String query =
                "SELECT * FROM product_variants WHERE variant_id=?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, variantId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                ProductVariant variant = new ProductVariant();

                variant.setVariantId(rs.getInt("variant_id"));
                variant.setProductId(rs.getInt("product_id"));
                variant.setSize(rs.getString("size"));
                variant.setColor(rs.getString("color"));
                variant.setPrice(rs.getBigDecimal("price"));
                variant.setStockQuantity(rs.getInt("stock_quantity"));
                variant.setImageUrl(rs.getString("image_url"));

                return variant;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean updateStock(int variantId, int newStock) {

        String query = "UPDATE product_variants SET stock_quantity=? WHERE variant_id=?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, newStock);
            ps.setInt(2, variantId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}