package com.example.candy_crm.repository.finance;


import com.example.candy_crm.model.finance.FinanceOperation;
import com.example.candy_crm.model.finance.FinanceOperationType;
import com.example.candy_crm.model.finance.Position;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface FinanceOperationRepository extends JpaRepository<FinanceOperation, Long> {
    Page<FinanceOperation> findAllByType(FinanceOperationType type, Pageable pageable);

    @Query("SELECT f FROM FinanceOperation f " +
            "LEFT JOIN f.salary s " +  // LEFT JOIN для salary (не исключает null)
            "WHERE f.type = :type AND " +
            "( " +
            "(f.order IS NOT NULL AND FUNCTION('DATE', f.createdAt) >= :startDate AND FUNCTION('DATE', f.createdAt) <= :endDate) OR " +
            "(f.product IS NOT NULL AND FUNCTION('DATE', f.createdAt) >= :startDate AND FUNCTION('DATE', f.createdAt) <= :endDate) OR " +
            "(s IS NOT NULL AND FUNCTION('DATE', s.startDate) <= :endDate AND FUNCTION('DATE', s.endDate) >= :startDate) " +
            ")")
    Page<FinanceOperation> findAllByTypeAndDateRange(@Param("type") FinanceOperationType type,
                                                     @Param("startDate") LocalDate startDate,
                                                     @Param("endDate") LocalDate endDate,
                                                     Pageable pageable);
    @Query("SELECT f FROM FinanceOperation f WHERE f.type = :type AND f.salary IS NOT NULL AND f.salary.position = :position")
    Page<FinanceOperation> findAllByTypeAndSalaryPosition(@Param("type") FinanceOperationType type,
                                                          @Param("position") Position position,
                                                          Pageable pageable);
}