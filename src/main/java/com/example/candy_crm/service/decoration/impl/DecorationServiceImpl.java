package com.example.candy_crm.service.decoration.impl;

import com.example.candy_crm.dto.decoration.*;
import com.example.candy_crm.model.decoration.Decoration;
import com.example.candy_crm.model.decoration.DecorationTemplate;
import com.example.candy_crm.model.decoration.DecorationTemplateItem;
import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.model.operation.OperationType;
import com.example.candy_crm.model.product.Product;
import com.example.candy_crm.model.user.User;
import com.example.candy_crm.repository.decoration.DecorationRepository;
import com.example.candy_crm.repository.operation.OperationRepository;
import com.example.candy_crm.repository.product.ProductRepository;
import com.example.candy_crm.service.FileUploadService;
import com.example.candy_crm.service.decoration.DecorationService;
import com.example.candy_crm.service.decoration.DecorationTemplateService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class DecorationServiceImpl implements DecorationService {

    private final DecorationRepository decorationRepository;
    private final ProductRepository productRepository;
    private final DecorationTemplateService decorationTemplateService;
    private final OperationRepository operationRepository;

    @Autowired
    private FileUploadService fileUploadService;

    @Override
    public Page<Decoration> getAllDecorations(Pageable pageable,String search) {
        if (search == null || search.isBlank()) {
            return decorationRepository.findAll(pageable);
        }
        return decorationRepository.findByNameContainingIgnoreCase(search.trim(), pageable);
    }

    @Override
    public Decoration getById(Long id) {
        return decorationRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Украшение не найдено"));
    }

    @Override
    public Page<Operation> getOperationsForDecoration(Long id, Pageable pageable) {
        return operationRepository.findByDecorationIdOrderByCreatedAtDesc(id, pageable);
    }

    @Override
    public DecorationCreateResponse create(DecorationCreateRequest dto, User auth) throws IOException {
        List<String> errors = new ArrayList<>();

        if (dto.getName() == null || dto.getName().isBlank())
            errors.add("Название не может быть пустым");
        if (dto.getPrice() == null)
            errors.add("Цена не может быть пустой");

        if (!errors.isEmpty())
            return new DecorationCreateResponse(errors);


        Decoration decoration = new Decoration();
        decoration.setName(dto.getName());
        decoration.setDescription(dto.getDescription());
        decoration.setColor(dto.getColor());
        decoration.setBase(dto.getBase());
        decoration.setPrice(dto.getPrice());
        decoration.setQuantity(0L);
        decoration.setCreatedBy(auth);

        if (dto.getPhoto() != null && !dto.getPhoto().isEmpty()) {
            String photoPath = fileUploadService.saveFile(dto.getPhoto());
            decoration.setPhoto(photoPath);
        }

        decorationRepository.save(decoration);
        return new DecorationCreateResponse(decoration);
    }

    @Override
    public DecorationOperationCreateResponse add(Long id, DecorationOperationCreateRequest request, User user) {
        Optional<Decoration> optionalDecoration = decorationRepository.findById(id);
        if (optionalDecoration.isEmpty())
            return new DecorationOperationCreateResponse(List.of("Украшение не найдено"));

        Decoration decoration = optionalDecoration.get();


//        if (request.getAmount() == null || request.getAmount() <= 0)
//            return new DecorationOperationCreateResponse(List.of("Количество должно быть положительным"));

        Operation operation = new Operation();
        operation.setDecoration(decoration);
        operation.setAmount(1L);
        operation.setType(request.getType());
        operation.setCreatedBy(user);
        if (request.getType() == OperationType.INCOME) {
            //CRAFT
            DecorationTemplate decorationTemplate = decorationTemplateService.getById(request.getDecorationTemplateId());
            if (decorationTemplate == null)
                return new DecorationOperationCreateResponse(List.of("Шаблон не найден"));
            decoration.setQuantity(decoration.getQuantity() + 1);
            operation.setComment("Crafted");
            operation.setDecorationTemplate(decorationTemplate);
            for (DecorationTemplateItem item : decorationTemplate.getItems()) {
                Integer itemQty = item.getQty();
                Product product = productRepository.getProductById(item.getProduct().getId());
                if (product.getQuantity() < itemQty) {
                    return new DecorationOperationCreateResponse(List.of("Недостаточно деталей на складе"));
                } else {
                    product.setQuantity(product.getQuantity() - itemQty);
                    Operation productOperation = new Operation();
                    productOperation.setProduct(product);
                    productOperation.setType(OperationType.OUTCOME);
                    productOperation.setComment(String.format("Craft %s by %s template", decoration.getName(), decorationTemplate.getName()));
                    productOperation.setLocalDate(LocalDate.now());
                    productOperation.setAmount(itemQty.longValue());
                    productOperation.setCreatedBy(user);
                    product.getOperations().add(productOperation);
                    productRepository.save(product);
                }
            }
        } else if (request.getType() == OperationType.OUTCOME) {
            //SUCCESS ORDER
            if (decoration.getQuantity() < 1)
                return new DecorationOperationCreateResponse(List.of("Недостаточно украшений на складе"));
            decoration.setQuantity(decoration.getQuantity() - 1);
            operation.setComment(request.getComment());
        }
        operationRepository.save(operation);
        decorationRepository.save(decoration);

        return new DecorationOperationCreateResponse(operation);
    }

    @Override
    public DecorationCreateResponse rename(com.example.candy_crm.dto.decoration.DecorationRenameRequest request, User user) {
        List<String> errors = new ArrayList<>();

        if (request.getId() == null) errors.add("ID не указан");
        if (request.getName() == null || request.getName().isBlank()) errors.add("Название не может быть пустым");

        if (!errors.isEmpty()) return new DecorationCreateResponse(errors);

        Decoration decoration = decorationRepository.findById(request.getId())
                .orElseThrow(() -> new IllegalArgumentException("Украшение не найдено"));

        decoration.setName(request.getName().trim());
        decorationRepository.save(decoration);

        return new DecorationCreateResponse(decoration);
    }

}
