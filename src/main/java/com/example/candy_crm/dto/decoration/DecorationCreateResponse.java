package com.example.candy_crm.dto.decoration;

import com.example.candy_crm.model.decoration.Decoration;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DecorationCreateResponse {
    private boolean success = true;

    private Decoration decoration;

    private List<String> errors;

    public DecorationCreateResponse(Decoration decoration) {
        this.decoration = decoration;
    }

    public DecorationCreateResponse(List<String> errors) {
        this.success = false;
        this.errors = errors;
    }
}
