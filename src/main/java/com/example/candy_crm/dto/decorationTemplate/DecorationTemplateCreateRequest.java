package com.example.candy_crm.dto.decorationTemplate;

import lombok.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DecorationTemplateCreateRequest {
    private Long decorationId;
    private String name;
    private String description;

    /**
     * Массив вида { productId: qty }
     * Пример: { 1: 10, 5: 2, 8: 4 }
     */
    private List<DecorationTemplateItemDTO> items = new ArrayList<>();  // Инициализируйте, чтобы избежать null
}
