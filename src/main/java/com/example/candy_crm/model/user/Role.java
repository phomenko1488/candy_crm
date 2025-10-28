package com.example.candy_crm.model.user;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;

@Data
@AllArgsConstructor
@NoArgsConstructor


@Entity
@Table(name = "roles")
public class Role implements GrantedAuthority {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private Integer level;

    @Override
    public String getAuthority() {
        return name;
    }

    public boolean isHigherThan(Role other) {
        return this.level < other.level;
    }

    public boolean isLowerThan(Role other) {
        return this.level > other.level;
    }
}
