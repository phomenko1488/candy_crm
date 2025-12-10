package com.example.candy_crm.model.operation;

import com.example.candy_crm.model.decoration.Decoration;
import com.example.candy_crm.model.decoration.DecorationTemplate;
import com.example.candy_crm.model.order.Order;
import com.example.candy_crm.model.product.Product;
import com.example.candy_crm.model.user.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor

@Entity
@Table(name = "operations")
public class Operation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDate LocalDate;
    //    private String name;

    private String comment;
    private Long amount;
    @Enumerated(value = EnumType.STRING)
    private OperationType type;
    private BigDecimal price;
    @ManyToOne
    private Product product;

    @ManyToOne
    private Decoration decoration;

    @ManyToOne
    private DecorationTemplate decorationTemplate;

    @ManyToOne
    private Order order;


    @ManyToOne(fetch = FetchType.LAZY)
    private User createdBy;

    private LocalDate createdAt;
    private LocalDate updatedAt;

    @PrePersist
    public void onCreate() {
        createdAt = LocalDate.now();
        updatedAt = LocalDate.now();
    }

    @PreUpdate
    public void onUpdate() {
        updatedAt = LocalDate.now();
    }
}

//for decoration
// + = create new.