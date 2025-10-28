package com.example.candy_crm.dto.order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderItemDTO {
    //    private Boolean isProduct;
    private Long productId;
    private Long decorationId;

    private Long quantity;
}
