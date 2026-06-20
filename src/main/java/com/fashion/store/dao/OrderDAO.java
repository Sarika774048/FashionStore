package com.fashion.store.dao;

import java.util.List;

import com.fashion.store.model.Order;

public interface OrderDAO {

    int createOrder(Order order);

    List<Order> getOrdersByUserId(int userId);

    Order getOrderById(int orderId);
}