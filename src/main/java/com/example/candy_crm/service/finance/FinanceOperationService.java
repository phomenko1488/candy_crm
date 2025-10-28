package com.example.candy_crm.service.finance;


import com.example.candy_crm.dto.CreateResponse;
import com.example.candy_crm.dto.finance.SalaryCreateRequest;
import com.example.candy_crm.model.finance.FinanceOperation;
import com.example.candy_crm.model.finance.FinanceOperationType;
import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.model.order.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface FinanceOperationService {

    Page<FinanceOperation> getPage(Pageable pageable);

    Page<FinanceOperation> getPageByType(FinanceOperationType type, Pageable pageable);

    Optional<FinanceOperation> getById(Long id);
    //order complete
    CreateResponse<FinanceOperation> createByOrderComplete(Order order);

    //products buy
    CreateResponse<FinanceOperation> createByProductBuy(Operation operation);

    //salary
    CreateResponse<FinanceOperation> createBySalary(SalaryCreateRequest salaryCreateRequest);
}