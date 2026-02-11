package com.example.candy_crm.model.decoration;

import com.example.candy_crm.model.Tradable;
import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.model.user.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor

@Entity
@Table(name = "decorations")
public class Decoration implements Tradable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String description;
    private String color;
    private String base;

    private BigDecimal price;
    private Long quantity = 0L;
    private String photo;

    @OneToMany(mappedBy = "decoration", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DecorationTemplate> templates = new ArrayList<>();

    @OneToMany(mappedBy = "decoration", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Operation> operations = new ArrayList<>();


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
