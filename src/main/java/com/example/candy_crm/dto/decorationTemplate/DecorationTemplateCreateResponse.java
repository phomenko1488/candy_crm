package com.example.candy_crm.dto.decorationTemplate;

import com.example.candy_crm.model.decoration.DecorationTemplate;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DecorationTemplateCreateResponse {
    private boolean success = true;
    private DecorationTemplate template;
    private List<String> errors;

    public DecorationTemplateCreateResponse(DecorationTemplate template) {
        this.template = template;
    }

    public DecorationTemplateCreateResponse(List<String> errors) {
        this.success = false;
        this.errors = errors;
    }
}
