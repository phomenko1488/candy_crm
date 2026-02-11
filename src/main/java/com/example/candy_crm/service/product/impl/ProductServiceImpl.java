package com.example.candy_crm.service.product.impl;

import com.example.candy_crm.dto.decoration.DecorationCreateResponse;
import com.example.candy_crm.dto.product.*;
import com.example.candy_crm.model.decoration.Decoration;
import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.model.operation.OperationType;
import com.example.candy_crm.model.product.Product;
import com.example.candy_crm.model.user.User;
import com.example.candy_crm.repository.product.ProductRepository;
import com.example.candy_crm.service.FileUploadService;
import com.example.candy_crm.service.finance.FinanceOperationService;
import com.example.candy_crm.service.operation.OperationService;
import com.example.candy_crm.service.product.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {
    private final ProductRepository repository;
    private final OperationService operationService;
    private final FinanceOperationService financeOperationService;
    @Autowired
    private FileUploadService fileUploadService;

    @Override
    public Page<Product> getAllProducts(Pageable pageable, String search) {
        if (search == null || search.isBlank()) {
            return repository.findAll(pageable);
        }
        return repository.findByNameContainingIgnoreCase(search.trim(), pageable);
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
    public ProductCreateResponse create(ProductCreateRequest dto, User auth) throws IOException {
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
        String color = dto.getColor();
        if (color == null)
            errors.add("color");
        else
            product.setColor(color);
        String cover = dto.getCover();
        if (cover == null)
            errors.add("cover");
        else
            product.setCover(cover);
        if (dto.getPhoto() != null && !dto.getPhoto().isEmpty()) {
            String photoPath = fileUploadService.saveFile(dto.getPhoto());
            product.setPhoto(photoPath);
        }
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
        operation.setLocalDate(LocalDate.now());
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

    @Override
    public ProductCreateResponse rename(ProductRenameRequest request, User user) {
        List<String> errors = new ArrayList<>();

        if (request.getId() == null) errors.add("ID не указан");
        if (request.getName() == null || request.getName().isBlank()) errors.add("Название не может быть пустым");

        if (!errors.isEmpty()) return new ProductCreateResponse(errors);

        Product decoration = repository.findById(request.getId())
                .orElseThrow(() -> new IllegalArgumentException("Украшение не найдено"));

        decoration.setName(request.getName().trim());
        repository.save(decoration);

        return new ProductCreateResponse(decoration);
    }
}