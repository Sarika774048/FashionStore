package com.fashion.store.model;

import java.sql.Timestamp;

public class Product {

    private int productId;
    private int categoryId;
    private String productName;
    private String brand;
    private String description;
    private Timestamp createdAt;

    public Product() {
    }

    public Product(int productId, int categoryId, String productName,
                   String brand, String description,
                   Timestamp createdAt) {

        this.productId = productId;
        this.categoryId = categoryId;
        this.productName = productName;
        this.brand = brand;
        this.description = description;
        this.createdAt = createdAt;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Product [productId=" + productId +
                ", categoryId=" + categoryId +
                ", productName=" + productName +
                ", brand=" + brand + "]";
    }
}