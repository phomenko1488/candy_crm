package com.example.candy_crm.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CreateResponse<T> {
    private boolean success = true;
    private T response;
    private List<String> errors;

    public CreateResponse(T response) {
        this.response = response;
    }

    public CreateResponse(List<String> errors) {
        this.success = false;
        this.errors = errors;
    }
}
