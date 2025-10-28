package com.example.candy_crm.service.product;


import com.example.candy_crm.dto.product.ProductCreateRequest;
import com.example.candy_crm.dto.product.ProductCreateResponse;
import com.example.candy_crm.dto.product.ProductOperationCreateRequest;
import com.example.candy_crm.dto.product.ProductOperationCreateResponse;
import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.model.product.Product;
import com.example.candy_crm.model.user.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ProductService {
    Page<Product> getAllProducts(Pageable pageable);

    Product getById(Long id);

    Page<Operation> getOperationsForProduct(Long id, Pageable pageable);

    ProductCreateResponse create(ProductCreateRequest dto, User auth);

    ProductOperationCreateResponse add(Long id, ProductOperationCreateRequest request, User user);
}