package com.example.candy_crm.controller;

import com.example.candy_crm.dto.CreateResponse;
import com.example.candy_crm.dto.order.OrderCreateRequest;
import com.example.candy_crm.dto.order.OrderEditRequest;
import com.example.candy_crm.model.order.Order;
import com.example.candy_crm.model.user.User;
import com.example.candy_crm.repository.decoration.DecorationRepository;
import com.example.candy_crm.repository.product.ProductRepository;
import com.example.candy_crm.service.order.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/orders")
@RequiredArgsConstructor
public class OrderController {
    private final OrderService orderService;
    private final ProductRepository productRepository;
    private final DecorationRepository decorationRepository;

    @GetMapping
    public String getOrders(Model model,
                            @RequestParam(defaultValue = "0") int page,
                            @RequestParam(defaultValue = "20") int size,
                            Authentication authentication) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Order> orders = orderService.getAllOrders(pageable);
        model.addAttribute("products", productRepository.findAll());
        model.addAttribute("decorations", decorationRepository.findAll());
        model.addAttribute("orders", orders);
        model.addAttribute("user", (User) authentication.getPrincipal());
        model.addAttribute("newOrderCreateRequest", new OrderCreateRequest());
        return "/orders/list";
    }

    @PostMapping
    public String create(@ModelAttribute OrderCreateRequest request,
                         Authentication auth,
                         RedirectAttributes redirectAttributes) {
        User user = (User) auth.getPrincipal();
        CreateResponse<Order> responseDTO = orderService.create(request, user);
        if (!responseDTO.isSuccess()) {
            redirectAttributes.addFlashAttribute("errorMessage", String.join(",", responseDTO.getErrors()));
            return "redirect:/orders";
        }
        redirectAttributes.addFlashAttribute("successMessage", "Заказ успешно создан");
        return String.format("redirect:/orders/%s", responseDTO.getResponse().getId());
    }

    @GetMapping("/{id}")
    public String getOrder(@PathVariable("id") Long id,
                           Authentication authentication,
                           Model model) {
        Order order = orderService.getOrderById(id);
        model.addAttribute("order", order);
        model.addAttribute("user", (User) authentication.getPrincipal());
        model.addAttribute("newOrderEditRequest", new OrderEditRequest());
        return "/orders/item";
    }

    @PostMapping("/edit")
    public String edit(@ModelAttribute OrderEditRequest request, RedirectAttributes redirectAttributes, Authentication auth) {
        User user = (User) auth.getPrincipal();
        CreateResponse<Order> responseDTO = orderService.edit(request, user);
        if (!responseDTO.isSuccess()) {
            redirectAttributes.addFlashAttribute("errorMessage", String.join(",", responseDTO.getErrors()));
            return String.format("redirect:/orders/%s", request.getOrderId());
        }
        redirectAttributes.addFlashAttribute("successMessage", "Статус Успешно изменен");
        return String.format("redirect:/orders/%s", responseDTO.getResponse().getId());
    }
}
