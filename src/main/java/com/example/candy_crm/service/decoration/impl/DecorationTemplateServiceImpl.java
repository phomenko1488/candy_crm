package com.example.candy_crm.service.decoration.impl;

import com.example.candy_crm.dto.decorationTemplate.DecorationTemplateCreateRequest;
import com.example.candy_crm.dto.decorationTemplate.DecorationTemplateItemDTO;
import com.example.candy_crm.model.decoration.*;
import com.example.candy_crm.model.product.Product;
import com.example.candy_crm.model.user.User;
import com.example.candy_crm.repository.decoration.DecorationTemplateRepository;
import com.example.candy_crm.repository.product.ProductRepository;
import com.example.candy_crm.repository.decoration.DecorationRepository;
import com.example.candy_crm.repository.user.UserRepository;
import com.example.candy_crm.service.decoration.DecorationTemplateService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class DecorationTemplateServiceImpl implements DecorationTemplateService {

    private final DecorationTemplateRepository decorationTemplateRepository;
    private final DecorationRepository decorationRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    @Override
    public DecorationTemplate createTemplate(DecorationTemplateCreateRequest request, String username) {
        User user = userRepository.getUserByUsername(username);
        Decoration decoration = decorationRepository.findById(request.getDecorationId())
                .orElseThrow(() -> new RuntimeException("Decoration not found"));

        DecorationTemplate template = new DecorationTemplate();
        template.setName(request.getName());
        template.setDescription(request.getDescription());
        template.setDecoration(decoration);
        template.setCreatedBy(user);

        List<DecorationTemplateItem> items = new ArrayList<>();
        if (request.getItems() != null) {  // Защита от пустого списка
            for (DecorationTemplateItemDTO itemDto : request.getItems()) {
                if (itemDto.getProductId() != null && itemDto.getQty() != null && itemDto.getQty() > 0) {
                    Product product = productRepository.findById(itemDto.getProductId())
                            .orElseThrow(() -> new RuntimeException("Product not found: " + itemDto.getProductId()));
                    DecorationTemplateItem item = new DecorationTemplateItem();
                    item.setProduct(product);
                    item.setQty(itemDto.getQty());
                    item.setTemplate(template);
                    items.add(item);
                }
            }
        }
        template.setItems(items);

        return decorationTemplateRepository.save(template);
    }

    @Override
    public Page<DecorationTemplate> getTemplatesByDecoration(Long decorationId, Pageable pageable) {
        Decoration decoration = decorationRepository.findById(decorationId)
                .orElseThrow(() -> new RuntimeException("Decoration not found"));
        return decorationTemplateRepository.findByDecoration(decoration, pageable);
    }

    @Override
    public DecorationTemplate getById(Long id) {
        return decorationTemplateRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Template not found"));
    }
}
