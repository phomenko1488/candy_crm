package com.example.candy_crm.model.finance;


import com.example.candy_crm.model.order.Order;
import com.example.candy_crm.model.product.Product;
import com.example.candy_crm.model.user.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor

@Entity
@Table(name = "finance_operations")
public class FinanceOperation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(value = EnumType.STRING)
    private FinanceOperationType type;

    private BigDecimal amount;

    private String comment;

    //if this is outcome - it can be only product's buy or salary
    //if this is income - it can be only orders complete

    @ManyToOne(cascade = CascadeType.ALL)
    private Salary salary;

    @ManyToOne
    private Order order;

    @ManyToOne
    private Product product;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    @PrePersist
    public void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
