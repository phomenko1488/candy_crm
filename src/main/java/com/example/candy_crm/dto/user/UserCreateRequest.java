package com.example.candy_crm.dto.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserCreateRequest {
    private String name;
    private String password;
    private Long roleId; // ID роли вместо enum
}