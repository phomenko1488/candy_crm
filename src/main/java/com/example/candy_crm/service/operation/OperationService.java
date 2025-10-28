package com.example.candy_crm.service.operation;


import com.example.candy_crm.dto.product.ProductOperationCreateResponse;
import com.example.candy_crm.model.operation.Operation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

public interface OperationService{
    Page<Operation> getOperationsByProductId(Long id, Pageable pageRequest);
    Page<Operation> getOperationsByDecorationId(Long id, Pageable pageRequest);

    Operation save(Operation operation);
}