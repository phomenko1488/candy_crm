package com.example.candy_crm.controller;

import com.example.candy_crm.dto.finance.SalaryCreateRequest;
import com.example.candy_crm.model.finance.FinanceOperation;
import com.example.candy_crm.model.finance.FinanceOperationType;
import com.example.candy_crm.model.finance.Position;
import com.example.candy_crm.model.user.User;
import com.example.candy_crm.service.finance.FinanceOperationService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate,
            Authentication authentication,
            Model model) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createdAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        LocalDate startDateInst = parseDate(startDate);
        LocalDate endDateInst = parseDate(endDate);

        Page<FinanceOperation> operationsPage = financeOperationService.getFilteredPage(
                FinanceOperationType.INCOME, startDateInst, endDateInst, null, pageable);

        String filterMode = (startDate != null && endDate != null) ? "date" : null;

        model.addAttribute("operationsPage", operationsPage);
        model.addAttribute("user", (User) authentication.getPrincipal());
        model.addAttribute("operationType", "Доходы");
        model.addAttribute("pageTitle", "Доходы");
        model.addAttribute("startDateStr", startDate);
        model.addAttribute("endDateStr", endDate);
        model.addAttribute("filterMode", filterMode);
        return "/finances/list";
    }

    // Updated: expenseList (mutually exclusive: position or date)
    @GetMapping("/expense")
    public String expenseList(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate,
            @RequestParam(required = false) Position position,
            Authentication authentication,
            Model model) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createdAt");
        Pageable pageable = PageRequest.of(page, size, sort);

        LocalDate startDateInst = parseDate(startDate);
        LocalDate endDateInst = parseDate(endDate);
//        Position position = (positionStr != null && !positionStr.isEmpty()) ? Position.valueOf(positionStr) : null;

        Page<FinanceOperation> operationsPage = financeOperationService.getFilteredPage(
                FinanceOperationType.OUTCOME, startDateInst, endDateInst, position, pageable);

        String filterMode = null;
        if (position != null) {
            filterMode = "position";
        } else if (startDateInst != null || endDateInst != null) {
            filterMode = "date";
        }

        model.addAttribute("user", (User) authentication.getPrincipal());
        model.addAttribute("operationsPage", operationsPage);
        model.addAttribute("operationType", "Расходы и зарплаты");
        model.addAttribute("pageTitle", "Расходы и зарплаты");
        model.addAttribute("showSalaryForm", true);
        model.addAttribute("salaryCreateRequest", new SalaryCreateRequest());
        model.addAttribute("startDateStr", startDate);
        model.addAttribute("endDateStr", endDate);
        model.addAttribute("position", position);
        model.addAttribute("filterMode", filterMode);
        model.addAttribute("positions", Position.values());
        return "/finances/list";
    }

    @PostMapping("/expense/salary")
    public String createSalary(@ModelAttribute SalaryCreateRequest salaryCreateRequest,
                               RedirectAttributes redirectAttributes) {
        financeOperationService.createBySalary(salaryCreateRequest);
        redirectAttributes.addFlashAttribute("successMessage", "Зарплата успешно добавлена");
        return "redirect:/finance/expense";
    }

    // Existing item methods unchanged...
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

    @GetMapping(value = "/income/export", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    public ResponseEntity<byte[]> exportIncome(@RequestParam(required = false) String startDateStr,
                                               @RequestParam(required = false) String endDateStr) {
        LocalDate startDate = parseDate(startDateStr);
        LocalDate endDate = parseDate(endDateStr);
        byte[] excelBytes = financeOperationService.exportToExcel(FinanceOperationType.INCOME, startDate, endDate);
        return buildExcelResponse("income_operations.xlsx", excelBytes);
    }

    // Updated: Export expense (only date, ignore position)
    @GetMapping(value = "/expense/export", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
    public ResponseEntity<byte[]> exportExpense(@RequestParam(required = false) String startDateStr,
                                                @RequestParam(required = false) String endDateStr) {
        LocalDate startDate = parseDate(startDateStr);
        LocalDate endDate = parseDate(endDateStr);
        byte[] excelBytes = financeOperationService.exportToExcel(FinanceOperationType.OUTCOME, startDate, endDate);
        return buildExcelResponse("expense_operations.xlsx", excelBytes);
    }

    // Helper method for date parsing
    private LocalDate parseDate(String dateStr) {
        if (dateStr == null || dateStr.isEmpty()) return null;
        return LocalDate.parse(dateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }

    // Helper for Excel response
    private ResponseEntity<byte[]> buildExcelResponse(String filename, byte[] content) {
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"")
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .body(content);
    }
}