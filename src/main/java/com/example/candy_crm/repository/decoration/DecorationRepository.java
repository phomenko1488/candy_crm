package com.example.candy_crm.repository.decoration;

import com.example.candy_crm.model.decoration.Decoration;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DecorationRepository extends JpaRepository<Decoration, Long> {
    Decoration getDecorationById(Long id);

    @Query("SELECT d FROM Decoration d WHERE lower(d.name) LIKE lower(concat('%', :query, '%'))")
    Page<Decoration> findByNameContainingIgnoreCase(@Param("query") String query, Pageable pageable);
}
