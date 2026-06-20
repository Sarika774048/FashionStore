package com.fashion.store.util;

import java.util.List;

import com.fashion.store.dao.ProductVariantDAO;
import com.fashion.store.dao.impl.ProductVariantDAOImpl;
import com.fashion.store.model.ProductVariant;

public class ProductVariantDAOTest {

    public static void main(String[] args) {

        ProductVariantDAO dao =
                new ProductVariantDAOImpl();

        List<ProductVariant> variants =
                dao.getVariantsByProductId(1);

        for(ProductVariant variant : variants) {
            System.out.println(variant);
        }
    }
}