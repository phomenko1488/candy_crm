package com.example.candy_crm.dto.decoration;

import com.example.candy_crm.model.operation.Operation;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DecorationOperationCreateResponse {
    private boolean success = true;

    private Operation operation;

    private List<String> errors;

    public DecorationOperationCreateResponse(Operation operation) {
        this.operation = operation;
    }

    public DecorationOperationCreateResponse(List<String> errors) {
        this.success = false;
        this.errors = errors;
    }
}
