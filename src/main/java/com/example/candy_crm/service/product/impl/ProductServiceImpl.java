package com.example.candy_crm.service.product.impl;

import com.example.candy_crm.dto.product.ProductCreateRequest;
import com.example.candy_crm.dto.product.ProductOperationCreateRequest;
import com.example.candy_crm.dto.product.ProductOperationCreateResponse;
import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.model.operation.OperationType;
import com.example.candy_crm.model.product.Product;
import com.example.candy_crm.model.user.User;
import com.example.candy_crm.repository.product.ProductRepository;
import com.example.candy_crm.service.finance.FinanceOperationService;
import com.example.candy_crm.service.operation.OperationService;
import com.example.candy_crm.dto.product.ProductCreateResponse;
import com.example.candy_crm.service.product.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {
    private final ProductRepository repository;
    private final OperationService operationService;
    private final FinanceOperationService financeOperationService;

    @Override
    public Page<Product> getAllProducts(Pageable pageable) {
        return repository.findAll(pageable);
    }

    @Override
    public Product getById(Long id) {
        return repository.getProductById(id);
    }

    @Override
    public Page<Operation> getOperationsForProduct(Long id, Pageable pageable) {
        return operationService.getOperationsByProductId(id, pageable);
    }

    @Override
    public ProductCreateResponse create(ProductCreateRequest dto, User auth) {
        Product product = new Product();
        List<String> errors = new ArrayList<>();

        String name = dto.getName();
        if (name == null)
            errors.add("name");
        else
            product.setName(name);

        String description = dto.getDescription();
        if (description == null)
            errors.add("description");
        else
            product.setDescription(description);

        Integer minQuantity = dto.getMinQuantity();
        if (minQuantity == null)
            errors.add("minQuantity");
        else
            product.setMinQuantity(minQuantity);

        Double price = dto.getPrice();
        if (price == null)
            errors.add("price");
        else
            product.setPrice(BigDecimal.valueOf(price));

        String unit = dto.getUnit();
        if (unit == null)
            errors.add("unit");
        else
            product.setUnit(unit);

        if (!errors.isEmpty())
            return new ProductCreateResponse(errors);
        return new ProductCreateResponse(repository.save(product));
    }

    @Override
    public ProductOperationCreateResponse add(Long id, ProductOperationCreateRequest request, User user) {
        ProductOperationCreateResponse response = new ProductOperationCreateResponse();
        List<String> errors = new ArrayList<>();
        Operation operation = new Operation();
        Product product = getById(id);
        OperationType type = request.getType();
        Long amount = request.getAmount();
        if (amount <= 0)
            errors.add("Amount");
        if (type == OperationType.OUTCOME) {
            product.setQuantity(product.getQuantity() - amount);
        } else {
            operation.setPrice(request.getPrice());
            product.setQuantity(product.getQuantity() + amount);
        }
        operation.setCreatedBy(user);
        operation.setType(type);
        operation.setProduct(product);
        operation.setAmount(request.getAmount());
        operation.setLocalDateTime(LocalDateTime.now());
        operation.setType(type);
        operation.setComment(request.getComment());
        operation.setProduct(product);
        product.getOperations().add(operation);
        repository.save(product);
        if (!errors.isEmpty())
            return new ProductOperationCreateResponse(errors);
        if (type.equals(OperationType.INCOME)) {
            financeOperationService.createByProductBuy(operation);
        }
        return response;
    }
}