package com.example.candy_crm.dto.decoration;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DecorationCreateRequest {
    private String name;
    private String description;
    private String color;
    private String base;
    private BigDecimal price;
}
