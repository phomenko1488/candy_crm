package com.example.candy_crm.dto.order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClientCreateRequest {
    private String inst;
    private String name;
    private String phone;
    private String address;
}
