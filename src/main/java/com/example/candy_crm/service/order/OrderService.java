package com.example.candy_crm.service.order;


import com.example.candy_crm.dto.CreateResponse;
import com.example.candy_crm.dto.order.OrderCreateRequest;
import com.example.candy_crm.dto.order.OrderEditRequest;
import com.example.candy_crm.model.order.Order;
import com.example.candy_crm.model.user.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface OrderService {
    Page<Order> getAllOrders(Pageable pageable);

    Order getOrderById(Long id);

    CreateResponse<Order> create(OrderCreateRequest request, User user);

    CreateResponse<Order> edit(OrderEditRequest request, User user);
}