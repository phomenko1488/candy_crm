package com.example.candy_crm.repository.operation;

import com.example.candy_crm.model.operation.Operation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OperationRepository extends JpaRepository<Operation,Long> {
    Page<Operation> findByProductIdOrderByCreatedAtDesc(Long productId, Pageable pageable);
    Page<Operation> findByDecorationIdOrderByCreatedAtDesc(Long productId, Pageable pageable);
}