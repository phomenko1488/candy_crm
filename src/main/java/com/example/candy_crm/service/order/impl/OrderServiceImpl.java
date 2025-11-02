package com.example.candy_crm.service.order.impl;

import com.example.candy_crm.dto.CreateResponse;
import com.example.candy_crm.dto.order.*;
import com.example.candy_crm.model.decoration.Decoration;
import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.model.operation.OperationType;
import com.example.candy_crm.model.order.Order;
import com.example.candy_crm.model.order.OrderItem;
import com.example.candy_crm.model.order.OrderStatus;
import com.example.candy_crm.model.product.Product;
import com.example.candy_crm.model.user.User;
import com.example.candy_crm.repository.decoration.DecorationRepository;
import com.example.candy_crm.repository.order.OrderRepository;
import com.example.candy_crm.repository.product.ProductRepository;
import com.example.candy_crm.service.finance.FinanceOperationService;
import com.example.candy_crm.service.order.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
    private final OrderRepository repository;
    private final ProductRepository productRepository;
    private final DecorationRepository decorationRepository;
    private final FinanceOperationService financeOperationService;

    @Override
    public Page<Order> getAllOrders(Pageable pageable) {
        return repository.findAll(pageable);
    }

    @Override
    public Order getOrderById(Long id) {
        return repository.getOrderById(id);
    }

    @Override
    public CreateResponse<Order> create(OrderCreateRequest request, User user) {
        Order order = new Order();
        BigDecimal price = BigDecimal.ZERO;
        order.setContactInfo(request.getContactInfo());
        order.setDate(LocalDateTime.now());
        order.setOrderStatus(OrderStatus.CREATED);
        order.setCreatedBy(user);
        List<String> errors = new ArrayList<>();

        for (OrderItemDTO item : request.getItems()) {
            Long quantity = item.getQuantity();
            if (quantity <= 0) {
                errors.add(String.format("wrong qty"));
                continue;
            }
            OrderItem orderItem = new OrderItem();
            orderItem.setQty(quantity);
            if (item.getDecorationId() != null) {
                Decoration decoration = decorationRepository.getDecorationById(item.getDecorationId());
                orderItem.setDecoration(decoration);
                price = price.add(decoration.getPrice().multiply(BigDecimal.valueOf(quantity)));
                order.getItems().add(orderItem);
            } else if (item.getProductId() != null) {
                Product product = productRepository.getProductById(item.getProductId());
                orderItem.setProduct(product);
                price = price.add(product.getPrice().multiply(BigDecimal.valueOf(quantity)));
                order.getItems().add(orderItem);
            } else {
                errors.add("Null item");
            }
        }
        order.setPrice(price);
        if (!errors.isEmpty())
            return new CreateResponse<>(errors);
        return new CreateResponse<>(repository.save(order));
    }

    @Override
    public CreateResponse<Order> edit(OrderEditRequest request, User user) {
        List<String> errors = new ArrayList<>();
        Order order = repository.getOrderById(request.getOrderId());
        if (order == null)
            return new CreateResponse<>(Collections.singletonList("Order is null"));
        OrderStatus newStatus = request.getNewStatus();
        if (newStatus == null)
            return new CreateResponse<>(Collections.singletonList("Status is null"));
        order.setOrderStatus(newStatus);
        order.setEditedBy(user);
        List<Product> productsUpdate = new ArrayList<>();
        List<Decoration> decorationsUpdate = new ArrayList<>();
        if (newStatus == OrderStatus.DONE) {
            for (OrderItem item : order.getItems()) {
                Long qty = item.getQty();
                if (item.getProduct() != null) {
                    Product product = productRepository.getProductById(item.getProduct().getId());
                    if (product.getQuantity() < qty) {
                        errors.add(String.format("Product %s is not enough", product.getName()));
                    } else {
                        product.setQuantity(product.getQuantity() - qty);
                        Operation operation = new Operation();
                        operation.setAmount(qty);
                        operation.setType(OperationType.OUTCOME);
                        operation.setComment("Order " + order.getId());
                        operation.setCreatedBy(user);
                        operation.setLocalDateTime(LocalDateTime.now());
                        operation.setProduct(product);
                        operation.setOrder(order);
                        product.getOperations().add(operation);
                        productsUpdate.add(product);
                    }
                } else if (item.getDecoration() != null) {
                    Decoration decoration = decorationRepository.getDecorationById(item.getDecoration().getId());
                    if (decoration.getQuantity() < qty) {
                        errors.add(String.format("Decoration %s is not enough", decoration.getName()));
                    } else {
                        decoration.setQuantity(decoration.getQuantity() - qty);
                        Operation operation = new Operation();
                        operation.setAmount(qty);
                        operation.setComment("Order " + order.getId());
                        operation.setType(OperationType.OUTCOME);
                        operation.setCreatedBy(user);
                        operation.setLocalDateTime(LocalDateTime.now());
                        operation.setDecoration(decoration);
                        operation.setOrder(order);
                        decoration.getOperations().add(operation);
                        decorationsUpdate.add(decoration);
                    }
                }
            }
            if (errors.isEmpty()) {
                productRepository.saveAll(productsUpdate);
                decorationRepository.saveAll(decorationsUpdate);
                order = repository.save(order);
                financeOperationService.createByOrderComplete(order);
            } else
                return new CreateResponse<>(errors);
        } else {
            order = repository.save(order);
        }
        return new CreateResponse<>(order);
    }
}
