package com.example.candy_crm.dto.product;

import com.example.candy_crm.model.operation.Operation;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductOperationCreateResponse {
    private boolean success = true;

    private Operation operation;

    private List<String> errors;

    public ProductOperationCreateResponse(Operation operation) {
        this.operation = operation;
    }

    public ProductOperationCreateResponse(List<String> errors) {
        this.success = false;
        this.errors = errors;
    }
}
