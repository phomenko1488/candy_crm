package com.example.candy_crm.controller;

import com.example.candy_crm.model.user.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
@Log4j2
public class IndexController {

    @GetMapping("/")
    public String getIndexPage(Authentication authentication, Model model) {
        User user = (User) authentication.getPrincipal(); // Прямо из auth, т.к. User implements UserDetails
        log.info("User {} logged in", user.getUsername());
        model.addAttribute("user", user);
        return "index";
    }
}