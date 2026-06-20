package com.fashion.store.dao;

import java.util.List;

import com.fashion.store.model.Product;

public interface ProductDAO {

    List<Product> getAllProducts();

    Product getProductById(int productId);

    List<Product> getProductsByCategory(int categoryId);

    List<Product> searchProducts(String keyword);
}