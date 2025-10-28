package com.example.candy_crm.controller;

import com.example.candy_crm.dto.CreateResponse;
import com.example.candy_crm.dto.finance.SalaryCreateRequest;
import com.example.candy_crm.model.finance.FinanceOperation;
import com.example.candy_crm.model.finance.FinanceOperationType;
import com.example.candy_crm.service.finance.FinanceOperationService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequestMapping("/finance-operations")
@RequiredArgsConstructor
public class FinanceController {

    private final FinanceOperationService financeOperationService;

    @GetMapping
    public String list(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) FinanceOperationType type,
            Model model) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createdAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<FinanceOperation> operationsPage;
        if (type != null) {
            operationsPage = financeOperationService.getPageByType(type, pageable);
        } else {
            operationsPage = financeOperationService.getPage(pageable);
        }

        model.addAttribute("operationsPage", operationsPage);
        model.addAttribute("currentType", type);
        model.addAttribute("types", FinanceOperationType.values());
        model.addAttribute("salaryCreateRequest", new SalaryCreateRequest());
        return "/finances/list";
    }

    @PostMapping("/salary")
    public String createSalary(@ModelAttribute SalaryCreateRequest salaryCreateRequest,
                               RedirectAttributes redirectAttributes) {
        CreateResponse<FinanceOperation> response = financeOperationService.createBySalary(salaryCreateRequest);
        redirectAttributes.addFlashAttribute("successMessage","ЗП Успешно добавлена");
        // Предполагаем, что создание всегда успешно, так как нет ошибок в impl
        return "redirect:/finance-operations";
    }

    @GetMapping("/{id}")
    public String item(@PathVariable Long id, Model model) {
        Optional<FinanceOperation> operationOpt = financeOperationService.getById(id);
        if (operationOpt.isPresent()) {
            model.addAttribute("operation", operationOpt.get());
            return "/finances/item";
        } else {
            // Простая обработка 404: редирект на список
            return "redirect:/finance-operations";
        }
    }
}