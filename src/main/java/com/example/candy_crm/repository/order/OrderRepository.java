package com.example.candy_crm.repository.order;

import com.example.candy_crm.model.order.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order,Long> {
    Order getOrderById(Long id);
}