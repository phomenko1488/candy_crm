package com.example.candy_crm.dto.product;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductCreateRequest {
    private String name;
    private String description;
    private Double price;
    private Integer minQuantity;
    private String unit;
    private String color;
    private String cover;
    private MultipartFile photo;
}
