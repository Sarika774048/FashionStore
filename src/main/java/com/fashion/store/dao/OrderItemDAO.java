package com.fashion.store.dao;

import java.util.List;

import com.fashion.store.model.OrderItem;

public interface OrderItemDAO {

    boolean addOrderItem(OrderItem item);

    List<OrderItem> getOrderItemsByOrderId(int orderId);
}