package com.example.candy_crm.controller;

import com.example.candy_crm.model.user.User;
import com.example.candy_crm.service.order.ClientService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/clients")
@RequiredArgsConstructor
public class ClientController {
    private final ClientService clientService;

    @GetMapping
    public String getPage(Model model,
                          @RequestParam(defaultValue = "0") int page,
                          @RequestParam(defaultValue = "20") int size,
                          Authentication authentication) {
        model.addAttribute("clients", clientService.getPage(PageRequest.of(page, size)));
        model.addAttribute("user", (User) authentication.getPrincipal());
        return "clients/list";
    }

    @GetMapping("/{id}")
    public String getOne(@PathVariable("id") Long id,
                         Model model,
                         Authentication authentication) {
        model.addAttribute("client", clientService.getById(id));
        model.addAttribute("user", (User) authentication.getPrincipal());
        return "clients/item";
    }

}
