package com.example.candy_crm.controller;

import com.example.candy_crm.dto.product.ProductCreateRequest;
import com.example.candy_crm.dto.product.ProductOperationCreateRequest;
import com.example.candy_crm.dto.product.ProductOperationCreateResponse;
import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.model.product.Product;
import com.example.candy_crm.dto.product.ProductCreateResponse;
import com.example.candy_crm.model.user.User;
import com.example.candy_crm.service.product.ProductService;
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
@RequestMapping("/products")
public class ProductController {
    private final ProductService productService;

    @Autowired
    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public String listProducts(
            Model model,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            Authentication authentication
    ) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Product> productPage = productService.getAllProducts(pageable);
        model.addAttribute("user", (User) authentication.getPrincipal());
        model.addAttribute("products", productPage.getContent());
        model.addAttribute("page", productPage);
        model.addAttribute("newProduct", new Product());
        model.addAttribute("newProductOperation", new ProductOperationCreateRequest());
        return "products/list";
    }

    @GetMapping("/{id}")
    public String viewProduct(
            @PathVariable Long id,
            Model model,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(required = false) Boolean successfullyCreated,
            Authentication authentication
    ) {
        Product product = productService.getById(id);
        Pageable pageable = PageRequest.of(page, size);
        Page<Operation> operations = productService.getOperationsForProduct(id, pageable);

        model.addAttribute("user",(User) authentication.getPrincipal());
        model.addAttribute("product", product);
        model.addAttribute("operations", operations);
        if (successfullyCreated != null)
            model.addAttribute("created", true);
        return "products/item";
    }

    @PostMapping
    public String create(@ModelAttribute ProductCreateRequest dto,
                         Authentication auth,
                         RedirectAttributes redirectAttributes) {
        User user = (User) auth.getPrincipal();
        ProductCreateResponse responseDTO = productService.create(dto, user);
        if (!responseDTO.isSuccess()) {
            redirectAttributes.addFlashAttribute("errorMessage", String.join(",", responseDTO.getErrors()));
            return "redirect:/products";
        }
        redirectAttributes.addFlashAttribute("successMessage", "Деталь успешно создана");
        return String.format("redirect:/products/%s", responseDTO.getProduct().getId());
    }

    @PostMapping("/operations")
    public String createOperation(@ModelAttribute ProductOperationCreateRequest request,
                                  Authentication auth,
                                  RedirectAttributes redirectAttributes) {
        User user = (User) auth.getPrincipal();
        ProductOperationCreateResponse response = productService.add(request.getProductId(), request, user);
        if (!response.isSuccess()) {
            redirectAttributes.addFlashAttribute("errorMessage", String.join(",", response.getErrors()));
        } else {
            redirectAttributes.addFlashAttribute("successMessage", "Операция успешно добавлена");
        }
        return "redirect:/products";
    }

}
