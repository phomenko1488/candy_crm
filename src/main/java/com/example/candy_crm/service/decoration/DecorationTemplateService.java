package com.example.candy_crm.service.decoration;


import com.example.candy_crm.dto.decorationTemplate.DecorationTemplateCreateRequest;
import com.example.candy_crm.model.decoration.DecorationTemplate;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface DecorationTemplateService {
    DecorationTemplate createTemplate(DecorationTemplateCreateRequest request, String username);
    Page<DecorationTemplate> getTemplatesByDecoration(Long decorationId, Pageable pageable);
    DecorationTemplate getById(Long id);

}