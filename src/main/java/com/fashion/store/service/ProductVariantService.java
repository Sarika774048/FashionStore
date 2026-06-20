package com.fashion.store.service;

import java.util.List;

import com.fashion.store.dao.ProductVariantDAO;
import com.fashion.store.dao.impl.ProductVariantDAOImpl;
import com.fashion.store.model.ProductVariant;

public class ProductVariantService {

    private final ProductVariantDAO productVariantDAO;

    public ProductVariantService() {
        this.productVariantDAO = new ProductVariantDAOImpl();
    }

    public List<ProductVariant> getVariantsByProductId(int productId) {
        return productVariantDAO.getVariantsByProductId(productId);
    }

    public ProductVariant getVariantById(int variantId) {
        return productVariantDAO.getVariantById(variantId);
    }

    public boolean updateStock(int variantId, int newStock) {
        return productVariantDAO.updateStock(variantId, newStock);
    }
}