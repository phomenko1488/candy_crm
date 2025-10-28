package com.example.candy_crm.dto.decoration;

import com.example.candy_crm.model.operation.OperationType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DecorationOperationCreateRequest {
    private Long decorationId;
    private Long decorationTemplateId;
    private OperationType type;
    private String comment;
    private Long amount;
    private BigDecimal price;
}
