package com.example.candy_crm.dto.product;

import com.example.candy_crm.model.product.Product;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductCreateResponse {
    private boolean success = true;

    private Product product;

    private List<String> errors;

    public ProductCreateResponse(Product product) {
        this.product = product;
    }

    public ProductCreateResponse(List<String> errors) {
        this.success = false;
        this.errors = errors;
    }
}
