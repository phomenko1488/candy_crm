package com.example.candy_crm.dto.order;

import com.example.candy_crm.model.order.OrderStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class OrderEditRequest {
    private Long orderId;
    private OrderStatus newStatus;
}
