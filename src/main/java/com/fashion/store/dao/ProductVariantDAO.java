package com.fashion.store.dao;

import java.util.List;

import com.fashion.store.model.ProductVariant;

public interface ProductVariantDAO {

    List<ProductVariant> getVariantsByProductId(int productId);

    ProductVariant getVariantById(int variantId);

    boolean updateStock(int variantId, int newStock);
}