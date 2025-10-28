package com.example.candy_crm.service.operation.impl;

import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.repository.operation.OperationRepository;
import com.example.candy_crm.service.operation.OperationService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OperationServiceImpl implements OperationService {
    private final OperationRepository repository;


    @Override
    public Page<Operation> getOperationsByProductId(Long id, Pageable pageRequest) {
        return repository.findByProductIdOrderByCreatedAtDesc(id, pageRequest);
    }

    @Override
    public Page<Operation> getOperationsByDecorationId(Long id, Pageable pageRequest) {
        return repository.findByDecorationIdOrderByCreatedAtDesc(id, pageRequest);
    }

    @Override
    public Operation save(Operation operation) {
        return repository.save(operation);
    }
}
