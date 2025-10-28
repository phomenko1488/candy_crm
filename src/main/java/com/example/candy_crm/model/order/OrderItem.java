package com.example.candy_crm.model.order;

import com.example.candy_crm.model.Tradable;
import com.example.candy_crm.model.decoration.Decoration;
import com.example.candy_crm.model.product.Product;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Any;

@Data
@AllArgsConstructor
@NoArgsConstructor


@Entity
@Table(name = "order_items")
public class OrderItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Product product;

    @ManyToOne
    private Decoration decoration;

    @Transient
    public Tradable getItem() {
        return product != null ? product : decoration;
    }

    private Long qty;
}
