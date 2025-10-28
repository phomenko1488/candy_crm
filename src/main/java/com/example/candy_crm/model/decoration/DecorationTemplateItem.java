package com.example.candy_crm.model.decoration;

import com.example.candy_crm.model.product.Product;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor


@Entity
@Table(name = "decoration_template_items")
public class DecorationTemplateItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Product product;
    private Integer qty;


    @ManyToOne(fetch = FetchType.LAZY)
    private DecorationTemplate template;
}
