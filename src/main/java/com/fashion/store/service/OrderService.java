package com.fashion.store.service;

import java.util.List;

import com.fashion.store.dao.OrderDAO;
import com.fashion.store.dao.OrderItemDAO;
import com.fashion.store.dao.impl.OrderDAOImpl;
import com.fashion.store.dao.impl.OrderItemDAOImpl;
import com.fashion.store.model.Order;
import com.fashion.store.model.OrderItem;

public class OrderService {

    private final OrderDAO orderDAO;
    private final OrderItemDAO orderItemDAO;

    public OrderService() {

        orderDAO = new OrderDAOImpl();
        orderItemDAO = new OrderItemDAOImpl();
    }

    public int createOrder(Order order) {

        return orderDAO.createOrder(order);
    }

    public boolean addOrderItem(OrderItem item) {

        return orderItemDAO.addOrderItem(item);
    }

    public List<Order> getOrdersByUserId(int userId) {

        return orderDAO.getOrdersByUserId(userId);
    }

    public List<OrderItem> getOrderItemsByOrderId(int orderId) {

        return orderItemDAO.getOrderItemsByOrderId(orderId);
    }

    public Order getOrderById(int orderId) {

        return orderDAO.getOrderById(orderId);
    }
}