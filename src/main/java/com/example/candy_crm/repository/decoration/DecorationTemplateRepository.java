package com.example.candy_crm.repository.decoration;

import com.example.candy_crm.model.decoration.Decoration;
import com.example.candy_crm.model.decoration.DecorationTemplate;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DecorationTemplateRepository extends JpaRepository<DecorationTemplate, Long> {
    Page<DecorationTemplate> findByDecoration(Decoration decoration, Pageable pageable);

}