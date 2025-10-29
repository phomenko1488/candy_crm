package com.example.candy_crm.controller;

import com.example.candy_crm.dto.decoration.DecorationCreateRequest;
import com.example.candy_crm.dto.decoration.DecorationCreateResponse;
import com.example.candy_crm.dto.decoration.DecorationOperationCreateRequest;
import com.example.candy_crm.dto.decoration.DecorationOperationCreateResponse;
import com.example.candy_crm.dto.decorationTemplate.DecorationTemplateCreateRequest;
import com.example.candy_crm.model.decoration.Decoration;
import com.example.candy_crm.model.decoration.DecorationTemplate;
import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.model.user.User;
import com.example.candy_crm.repository.product.ProductRepository;
import com.example.candy_crm.service.decoration.DecorationService;
import com.example.candy_crm.service.decoration.DecorationTemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/decorations")
public class DecorationController {
    private final DecorationService decorationService;
    private final DecorationTemplateService decorationTemplateService;
    private final ProductRepository productRepository;

    @Autowired
    public DecorationController(DecorationService decorationService, DecorationTemplateService decorationTemplateService, ProductRepository productRepository) {
        this.decorationService = decorationService;
        this.decorationTemplateService = decorationTemplateService;
        this.productRepository = productRepository;
    }

    @GetMapping
    public String listDecorations(Model model, @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "20") int size,
                                  Authentication authentication) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Decoration> decorationPage = decorationService.getAllDecorations(pageable);

        model.addAttribute("decorations", decorationPage.getContent());
        model.addAttribute("page", decorationPage);
        model.addAttribute("user", (User) authentication.getPrincipal());
        model.addAttribute("newDecoration", new Decoration());
        model.addAttribute("newDecorationOperation", new DecorationOperationCreateRequest());
        return "decorations/list";
    }

    @GetMapping("/{id}")
    public String viewDecoration(@PathVariable Long id, Model model,
                                 @RequestParam(defaultValue = "0") int opPage,
                                 @RequestParam(defaultValue = "20") int opSize,
                                 @RequestParam(defaultValue = "0") int tePage,
                                 @RequestParam(defaultValue = "20") int teSize,
                                 Authentication authentication) {
        Decoration decoration = decorationService.getById(id);

        Pageable operationsPageable = PageRequest.of(opPage, opSize);
        Page<Operation> operations = decorationService.getOperationsForDecoration(id, operationsPageable);

        Pageable templatesPageable = PageRequest.of(tePage, teSize);
        Page<DecorationTemplate> templates = decorationTemplateService.getTemplatesByDecoration(id, templatesPageable);
        model.addAttribute("user", (User) authentication.getPrincipal());
        model.addAttribute("decoration", decoration);
        model.addAttribute("operations", operations);
        model.addAttribute("templates", templates);
        model.addAttribute("request", new DecorationTemplateCreateRequest());
        model.addAttribute("operation", new DecorationOperationCreateRequest());
        model.addAttribute("products", productRepository.findAll());

        return "decorations/item";
    }

    @PostMapping
    public String create(@ModelAttribute DecorationCreateRequest dto, Authentication auth, RedirectAttributes redirectAttributes) {
        User user = (User) auth.getPrincipal();
        DecorationCreateResponse responseDTO = decorationService.create(dto, user);
        if (!responseDTO.isSuccess()) {
            redirectAttributes.addFlashAttribute("errorMessage", String.join(",", responseDTO.getErrors()));
            return "redirect:/decorations";
        }
        redirectAttributes.addFlashAttribute("successMessage", "Деталь успешно создана");
        return String.format("redirect:/decorations/%s", responseDTO.getDecoration().getId());
    }

    @PostMapping("/operations")
    public String createOperation(@ModelAttribute DecorationOperationCreateRequest request,
                                  Authentication auth, RedirectAttributes redirectAttributes) {
        User user = (User) auth.getPrincipal();
        DecorationOperationCreateResponse response = decorationService.add(request.getDecorationId(), request, user);
        if (!response.isSuccess()) {
            redirectAttributes.addFlashAttribute("errorMessage", String.join(",", response.getErrors()));
        } else {
            redirectAttributes.addFlashAttribute("successMessage", "Операция успешно добавлена");
        }
        return "redirect:/decorations";
    }

    @PostMapping("/{id}/craft")
    public String craftDecoration(@PathVariable("id") Long id,
                                  @ModelAttribute DecorationOperationCreateRequest request,
                                  Authentication auth,
                                  RedirectAttributes redirectAttributes) {
        User user = (User) auth.getPrincipal();
        DecorationOperationCreateResponse response = decorationService.add(id, request, user);
        if (!response.isSuccess()) {
            redirectAttributes.addFlashAttribute("errorMessage", String.join(",", response.getErrors()));
        } else {
            redirectAttributes.addFlashAttribute("successMessage", "Операция успешно добавлена");
        }
        return "redirect:/decorations";
    }
}
