package com.example.candy_crm.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Log4j2
public class AuthController {
    @GetMapping("/login")
    public String getLoginPage(HttpServletRequest request, Model model) {
        // Обработка ?error=true (failureUrl)
        String error = request.getParameter("error");
        if ("true".equals(error)) {
            model.addAttribute("errorMessage", "Неверный логин или пароль");
            log.warn("Login failure from query param");
        }

        // Обработка ?logout=true
        String logout = request.getParameter("logout");
        if ("true".equals(logout)) {
            model.addAttribute("logoutMessage", "Вы успешно вышли из системы");
            log.info("Logout success");
        }

        // Fallback: session exception (редко, но на всякий)
//        Object sessionError = request.getSession().getAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
//        if (sessionError != null) {
//            model.addAttribute("errorMessage", sessionError.getMessage() != null ? sessionError.getMessage() : "Ошибка аутентификации");
//            request.getSession().removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
//            log.error("Session auth exception: {}", sessionError.getMessage());
//        }

        return "login";
    }
}
