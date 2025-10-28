package com.example.candy_crm.repository.finance;


import com.example.candy_crm.model.finance.FinanceOperation;
import com.example.candy_crm.model.finance.FinanceOperationType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FinanceOperationRepository extends JpaRepository<FinanceOperation, Long> {
    Page<FinanceOperation> findAllByType(FinanceOperationType type, Pageable pageable);
}