package com.example.candy_crm.controller;

import com.example.candy_crm.dto.decorationTemplate.DecorationTemplateCreateRequest;
import com.example.candy_crm.model.decoration.DecorationTemplate;
import com.example.candy_crm.model.user.User;
import com.example.candy_crm.service.decoration.DecorationTemplateService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/decorations-templates")
public class DecorationTemplateController {

    private final DecorationTemplateService templateService;


    @PostMapping
    public String createTemplate(@ModelAttribute DecorationTemplateCreateRequest request,
                                 Authentication authentication) {
        templateService.createTemplate(request, authentication.getName());
        return "redirect:/decorations/" + request.getDecorationId();
    }

    @GetMapping("/{id}")
    public String viewTemplate(@PathVariable Long id, Model model,Authentication authentication) {
        DecorationTemplate template = templateService.getById(id);
        model.addAttribute("template", template);
        model.addAttribute("user", (User) authentication.getPrincipal());
        return "/decoration-templates/view";
    }
}
