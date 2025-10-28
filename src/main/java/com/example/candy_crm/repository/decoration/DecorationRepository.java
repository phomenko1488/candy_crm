package com.example.candy_crm.repository.decoration;

import com.example.candy_crm.model.decoration.Decoration;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DecorationRepository extends JpaRepository<Decoration, Long> {
    Decoration getDecorationById(Long id);
}
