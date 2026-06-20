package com.fashion.store.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fashion.store.dao.CategoryDAO;
import com.fashion.store.model.Category;
import com.fashion.store.util.DBConnection;

public class CategoryDAOImpl implements CategoryDAO {

    @Override
    public List<Category> getAllCategories() {

        List<Category> categories = new ArrayList<>();

        String query = "SELECT * FROM categories";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Category category = new Category();

                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));

                categories.add(category);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return categories;
    }

    @Override
    public Category getCategoryById(int categoryId) {

        String query =
                "SELECT * FROM categories WHERE category_id=?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                Category category = new Category();

                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));

                return category;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}