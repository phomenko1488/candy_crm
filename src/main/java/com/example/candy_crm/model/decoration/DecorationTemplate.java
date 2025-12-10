package com.example.candy_crm.model.decoration;

import com.example.candy_crm.model.user.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor


@Entity
@Table(name = "decoration_templates")
public class DecorationTemplate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String description;

    @OneToMany(mappedBy = "template", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DecorationTemplateItem> items;

    @ManyToOne(fetch = FetchType.LAZY)
    private User createdBy;

    @ManyToOne
    private Decoration decoration;

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
