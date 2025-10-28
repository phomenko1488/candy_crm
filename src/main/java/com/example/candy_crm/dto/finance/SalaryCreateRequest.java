package com.example.candy_crm.dto.finance;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SalaryCreateRequest {
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private String comment;
    private BigDecimal amount;
}
