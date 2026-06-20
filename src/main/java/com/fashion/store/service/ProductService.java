package com.fashion.store.service;

import java.util.List;

import com.fashion.store.dao.ProductDAO;
import com.fashion.store.dao.impl.ProductDAOImpl;
import com.fashion.store.model.Product;

public class ProductService {

    private final ProductDAO productDAO;

    public ProductService() {
        this.productDAO = new ProductDAOImpl();
    }

    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    public Product getProductById(int productId) {
        return productDAO.getProductById(productId);
    }

    public List<Product> getProductsByCategory(int categoryId) {
        return productDAO.getProductsByCategory(categoryId);
    }

    public List<Product> searchProducts(String keyword) {
        return productDAO.searchProducts(keyword);
    }
}