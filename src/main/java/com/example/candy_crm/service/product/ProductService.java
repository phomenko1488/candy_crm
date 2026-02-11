package com.example.candy_crm.service.product;


import com.example.candy_crm.dto.decoration.DecorationCreateResponse;
import com.example.candy_crm.dto.decoration.DecorationRenameRequest;
import com.example.candy_crm.dto.product.*;
import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.model.product.Product;
import com.example.candy_crm.model.user.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.io.IOException;

public interface ProductService {
    Page<Product> getAllProducts(Pageable pageable,String search);

    Product getById(Long id);

    Page<Operation> getOperationsForProduct(Long id, Pageable pageable);

    ProductCreateResponse create(ProductCreateRequest dto, User auth) throws IOException;

    ProductOperationCreateResponse add(Long id, ProductOperationCreateRequest request, User user);

    ProductCreateResponse rename(ProductRenameRequest request, User user);
}