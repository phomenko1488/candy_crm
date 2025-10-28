package com.example.candy_crm.service.finance.impl;

import com.example.candy_crm.dto.CreateResponse;
import com.example.candy_crm.dto.finance.SalaryCreateRequest;
import com.example.candy_crm.model.finance.FinanceOperation;
import com.example.candy_crm.model.finance.FinanceOperationType;
import com.example.candy_crm.model.finance.Salary;
import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.model.order.Order;
import com.example.candy_crm.model.product.Product;
import com.example.candy_crm.repository.finance.FinanceOperationRepository;
import com.example.candy_crm.service.finance.FinanceOperationService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class FinanceOperationServiceImpl implements FinanceOperationService {
    private final FinanceOperationRepository repository;

    @Override
    public Page<FinanceOperation> getPage(Pageable pageable) {
        return repository.findAll(pageable);
    }

    @Override
    public Page<FinanceOperation> getPageByType(FinanceOperationType type, Pageable pageable) {
        return repository.findAllByType(type, pageable);
    }

    @Override
    public Optional<FinanceOperation> getById(Long id) {
        return repository.findById(id);
    }

    @Override
    public CreateResponse<FinanceOperation> createByOrderComplete(Order order) {
        FinanceOperation operation = new FinanceOperation();
        operation.setOrder(order);
        operation.setAmount(order.getPrice());
        operation.setComment(String.format("Order %s complete", order.getId()));
        operation.setType(FinanceOperationType.INCOME);
        return new CreateResponse<>(repository.save(operation));
    }

    @Override
    public CreateResponse<FinanceOperation> createByProductBuy(Operation operation) {
        Long amount = operation.getAmount();
        Product product = operation.getProduct();
        FinanceOperation financeOperation = new FinanceOperation();
        financeOperation.setProduct(product);
        financeOperation.setType(FinanceOperationType.OUTCOME);
        String unit = product.getUnit();
        financeOperation.setComment(String.format("Product %s buy %s %s", product.getName(), amount, unit));
        financeOperation.setAmount(operation.getPrice());
        return new CreateResponse<>(repository.save(financeOperation));
    }

    @Override
    public CreateResponse<FinanceOperation> createBySalary(SalaryCreateRequest salaryCreateRequest) {
        Salary salary = new Salary();
        salary.setStartDate(salaryCreateRequest.getStartDate());
        salary.setEndDate(salaryCreateRequest.getEndDate());
        salary.setAmount(salaryCreateRequest.getAmount());
        salary.setDescription(salaryCreateRequest.getComment());

        FinanceOperation financeOperation = new FinanceOperation();
        financeOperation.setSalary(salary);
        financeOperation.setAmount(salaryCreateRequest.getAmount());
        financeOperation.setType(FinanceOperationType.OUTCOME);
        financeOperation.setComment(String.format("Salary %s", salaryCreateRequest.getComment()));
        return new CreateResponse<>(repository.save(financeOperation));
    }
}
