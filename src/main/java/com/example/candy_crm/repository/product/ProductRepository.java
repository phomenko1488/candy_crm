package com.example.candy_crm.repository.product;

import com.example.candy_crm.model.product.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    Product getProductById(Long id);

    @Query("SELECT p FROM Product p WHERE lower(p.name) LIKE lower(concat('%', :query, '%'))")
    Page<Product> findByNameContainingIgnoreCase(@Param("query") String query, Pageable pageable);
}