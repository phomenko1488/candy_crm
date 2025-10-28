package com.example.candy_crm.controller;

import com.example.candy_crm.dto.user.UserCreateRequest;
import com.example.candy_crm.model.user.Role;
import com.example.candy_crm.model.user.User;
import com.example.candy_crm.service.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping
    public String list(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) Long roleId, // ID роли для фильтра
            @AuthenticationPrincipal User currentUser,
            Model model) {
        Integer currentLevel = currentUser.getRole().getLevel();
        Sort sort = Sort.by(Sort.Direction.DESC, "createdAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<User> usersPage;
        if (roleId != null) {
            Role role = new Role(); role.setId(roleId); // Загрузи если нужно
            usersPage = userService.getPageByRole(role, pageable, currentLevel);
        } else {
            usersPage = userService.getPage(pageable, currentLevel);
        }

        model.addAttribute("usersPage", usersPage);
        model.addAttribute("currentRoleId", roleId);
        model.addAttribute("availableRoles", userService.getAvailableRolesForCreation(currentLevel)); // Только для создания
        model.addAttribute("allRoles", userService.getAvailableRolesForCreation(currentLevel)); // Для фильтра? Адаптируй
        model.addAttribute("userCreateRequest", new UserCreateRequest());
        model.addAttribute("currentLevel", currentLevel);
        return "users/list";
    }

    @PostMapping
    public String createUser(@ModelAttribute UserCreateRequest userCreateRequest,
                             @AuthenticationPrincipal User currentUser,
                             RedirectAttributes redirectAttributes) {
        userService.create(userCreateRequest, currentUser.getRole().getLevel());
        redirectAttributes.addFlashAttribute("successMessage", "Пользователь успешно добавлен");
        return "redirect:/users";
    }

    @PostMapping("/{id}/toggle-active")
    public String toggleActive(@PathVariable Long id,
                               @AuthenticationPrincipal User currentUser,
                               RedirectAttributes redirectAttributes) {
        userService.toggleActive(id, currentUser.getRole().getLevel());
        redirectAttributes.addFlashAttribute("successMessage", "Статус пользователя изменён");
        return "redirect:/users";
    }

    @GetMapping("/{id}")
    public String item(@PathVariable Long id,
                       @AuthenticationPrincipal User currentUser,
                       Model model) {
        Optional<User> user = userService.getById(id, currentUser.getRole().getLevel());
        if (user.isPresent()) {
            model.addAttribute("user", user.get());
            return "users/item";
        } else {
            return "redirect:/users";
        }
    }
}