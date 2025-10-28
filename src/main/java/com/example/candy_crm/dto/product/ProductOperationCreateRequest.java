package com.example.candy_crm.dto.product;

import com.example.candy_crm.model.operation.OperationType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductOperationCreateRequest {
    private Long productId;
    private OperationType type;
    private String comment;
    private Long amount;
    private BigDecimal price;
}
