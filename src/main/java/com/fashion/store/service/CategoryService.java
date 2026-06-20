package com.fashion.store.service;

import java.util.List;

import com.fashion.store.dao.CategoryDAO;
import com.fashion.store.dao.impl.CategoryDAOImpl;
import com.fashion.store.model.Category;

public class CategoryService {

    private final CategoryDAO categoryDAO;

    public CategoryService() {
        this.categoryDAO = new CategoryDAOImpl();
    }

    public List<Category> getAllCategories() {
        return categoryDAO.getAllCategories();
    }

    public Category getCategoryById(int categoryId) {
        return categoryDAO.getCategoryById(categoryId);
    }
}