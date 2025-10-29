package com.example.candy_crm.controller;

import com.example.candy_crm.dto.finance.SalaryCreateRequest;
import com.example.candy_crm.model.finance.FinanceOperation;
import com.example.candy_crm.model.finance.FinanceOperationType;
import com.example.candy_crm.model.user.User;
import com.example.candy_crm.service.finance.FinanceOperationService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/finance")
@RequiredArgsConstructor
public class FinanceController {

    private final FinanceOperationService financeOperationService;

    @GetMapping("/income")
    public String incomeList(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            Authentication authentication,
            Model model) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createdAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<FinanceOperation> operationsPage = financeOperationService.getPageByType(FinanceOperationType.INCOME, pageable);

        model.addAttribute("operationsPage", operationsPage);
        model.addAttribute("user", (User) authentication.getPrincipal());
        model.addAttribute("operationType", "Доходы");
        model.addAttribute("pageTitle", "Доходы");
        return "/finances/list";
    }

    @GetMapping("/expense")
    public String expenseList(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            Authentication authentication,
            Model model) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createdAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<FinanceOperation> operationsPage = financeOperationService.getPageByType(FinanceOperationType.OUTCOME, pageable);
        model.addAttribute("user", (User) authentication.getPrincipal());
        model.addAttribute("operationsPage", operationsPage);
        model.addAttribute("operationType", "Расходы и зарплаты");
        model.addAttribute("pageTitle", "Расходы и зарплаты");
        model.addAttribute("showSalaryForm", true);
        model.addAttribute("salaryCreateRequest", new SalaryCreateRequest());
        return "/finances/list";
    }

    @PostMapping("/expense/salary")
    public String createSalary(@ModelAttribute SalaryCreateRequest salaryCreateRequest,
                               RedirectAttributes redirectAttributes) {
        financeOperationService.createBySalary(salaryCreateRequest);
        redirectAttributes.addFlashAttribute("successMessage", "Зарплата успешно добавлена");
        return "redirect:/finance/expense";
    }

    @GetMapping("/income/{id}")
    public String incomeItem(@PathVariable Long id, Model model) {
        Optional<FinanceOperation> operation = financeOperationService.getById(id);
        if (operation.isPresent() && operation.get().getType() == FinanceOperationType.INCOME) {
            model.addAttribute("operation", operation.get());
            return "/finances/item";
        }
        return "redirect:/finance/income";
    }

    @GetMapping("/expense/{id}")
    public String expenseItem(@PathVariable Long id, Model model) {
        Optional<FinanceOperation> operation = financeOperationService.getById(id);
        if (operation.isPresent() && operation.get().getType() == FinanceOperationType.OUTCOME) {
            model.addAttribute("operation", operation.get());
            return "/finances/item";
        }
        return "redirect:/finance/expense";
    }
}