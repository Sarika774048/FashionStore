package com.fashion.store.util;

import java.util.List;

import com.fashion.store.dao.ProductDAO;
import com.fashion.store.dao.impl.ProductDAOImpl;
import com.fashion.store.model.Product;

public class ProductDAOTest {

    public static void main(String[] args) {

        ProductDAO dao = new ProductDAOImpl();

        List<Product> products = dao.getAllProducts();

        for(Product product : products) {
            System.out.println(product);
        }
    }
}