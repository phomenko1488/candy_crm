package com.example.candy_crm.dto.finance;

import com.example.candy_crm.model.finance.Position;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SalaryCreateRequest {
    private LocalDate startDate;
    private LocalDate endDate;
    private Position position;
    private BigDecimal amount;
}
