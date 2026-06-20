package com.fashion.store.util;

import java.util.List;

import com.fashion.store.dao.CategoryDAO;
import com.fashion.store.dao.impl.CategoryDAOImpl;
import com.fashion.store.model.Category;

public class CategoryDAOTest {

    public static void main(String[] args) {

        CategoryDAO dao = new CategoryDAOImpl();

        List<Category> categories = dao.getAllCategories();

        for(Category category : categories) {
        		System.out.println("The code is working!");
            System.out.println(category);
        }
    }
}