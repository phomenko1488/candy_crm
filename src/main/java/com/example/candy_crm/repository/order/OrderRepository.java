package com.example.candy_crm.repository.order;

import com.example.candy_crm.model.order.Order;
import com.example.candy_crm.model.order.OrderStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order,Long> {
    Order getOrderById(Long id);

    Page<Order> findByOrderStatus(OrderStatus orderStatus, Pageable pageable);
}