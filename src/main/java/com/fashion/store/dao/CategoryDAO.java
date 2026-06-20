package com.fashion.store.dao;

import java.util.List;
import com.fashion.store.model.Category;

public interface CategoryDAO {

    List<Category> getAllCategories();

    Category getCategoryById(int categoryId);
}