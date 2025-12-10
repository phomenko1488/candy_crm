package com.example.candy_crm.service.finance.impl;

import com.example.candy_crm.dto.CreateResponse;
import com.example.candy_crm.dto.finance.SalaryCreateRequest;
import com.example.candy_crm.model.finance.FinanceOperation;
import com.example.candy_crm.model.finance.FinanceOperationType;
import com.example.candy_crm.model.finance.Position;
import com.example.candy_crm.model.finance.Salary;
import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.model.order.Order;
import com.example.candy_crm.model.product.Product;
import com.example.candy_crm.repository.finance.FinanceOperationRepository;
import com.example.candy_crm.service.finance.FinanceOperationService;
import lombok.RequiredArgsConstructor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class FinanceOperationServiceImpl implements FinanceOperationService {
    private final FinanceOperationRepository repository;

    @Override
    public Page<FinanceOperation> getPage(Pageable pageable) {
        return repository.findAll(pageable);
    }

    @Override
    public Page<FinanceOperation> getPageByType(FinanceOperationType type, Pageable pageable) {
        return repository.findAllByType(type, pageable);
    }

    @Override
    public Optional<FinanceOperation> getById(Long id) {
        return repository.findById(id);
    }

    @Override
    public CreateResponse<FinanceOperation> createByOrderComplete(Order order) {
        FinanceOperation operation = new FinanceOperation();
        operation.setOrder(order);
        operation.setAmount(order.getPrice());
        operation.setComment(String.format("Order %s complete", order.getId()));
        operation.setType(FinanceOperationType.INCOME);
        return new CreateResponse<>(repository.save(operation));
    }

    @Override
    public CreateResponse<FinanceOperation> createByProductBuy(Operation operation) {
        Long amount = operation.getAmount();
        Product product = operation.getProduct();
        FinanceOperation financeOperation = new FinanceOperation();
        financeOperation.setProduct(product);
        financeOperation.setType(FinanceOperationType.OUTCOME);
        String unit = product.getUnit();
        financeOperation.setComment(String.format("Product %s buy %s %s", product.getName(), amount, unit));
        financeOperation.setAmount(operation.getPrice());
        return new CreateResponse<>(repository.save(financeOperation));
    }

    @Override
    public CreateResponse<FinanceOperation> createBySalary(SalaryCreateRequest salaryCreateRequest) {
        Salary salary = new Salary();
        salary.setStartDate(salaryCreateRequest.getStartDate());
        salary.setEndDate(salaryCreateRequest.getEndDate());
        salary.setAmount(salaryCreateRequest.getAmount());
        salary.setPosition(salaryCreateRequest.getPosition());

        FinanceOperation financeOperation = new FinanceOperation();
        financeOperation.setSalary(salary);
        financeOperation.setAmount(salaryCreateRequest.getAmount());
        financeOperation.setType(FinanceOperationType.OUTCOME);
        financeOperation.setComment(String.format("Salary %s", salaryCreateRequest.getPosition().toOutput()));
        return new CreateResponse<>(repository.save(financeOperation));
    }

    // New: Get operations by type, date range, and optional position (for expenses only)
    // Updated: Mutually exclusive filtering
    public Page<FinanceOperation> getFilteredPage(FinanceOperationType type, LocalDate startDate, LocalDate endDate, Position position, Pageable pageable) {
        if (position != null && type == FinanceOperationType.OUTCOME) {
            // Position filter: all dates, only salaries by position
            return repository.findAllByTypeAndSalaryPosition(type, position, pageable);
        } else if (startDate != null || endDate != null) {
            // Date filter: ignore position, all operations in range
            return repository.findAllByTypeAndDateRange(type, startDate, endDate, pageable);
        } else {
            // No filter
            return repository.findAllByType(type, pageable);
        }
    }

    // Updated: Export only by date range (no position filter; all operations in range)
    public byte[] exportToExcel(FinanceOperationType type, LocalDate startDate, LocalDate endDate) {
        List<FinanceOperation> operations;
        if (startDate != null && endDate != null) {
            operations = repository.findAllByTypeAndDateRange(type, startDate, endDate, Pageable.unpaged()).getContent();
        } else {
            // Export all if no dates
            operations = repository.findAllByType(type, Pageable.unpaged()).getContent();
        }

        try {
            Workbook workbook = new XSSFWorkbook();
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            Sheet sheet = workbook.createSheet(type.name() + " Operations");
            Row headerRow = sheet.createRow(0);
            String[] columns = {"ID", "Type", "Amount (₽)", "Comment", "Created At", "Position", "Start Date", "End Date"};
            CellStyle headerStyle = workbook.createCellStyle();
//            headerStyle.setFillForegroundColor(IndexedColors.LIGHT_GRAY.getIndex());
//            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
                cell.setCellStyle(headerStyle);
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            int rowNum = 1;
            for (FinanceOperation op : operations) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(op.getId());
                row.createCell(1).setCellValue(op.getType().name());
                row.createCell(2).setCellValue(op.getAmount().doubleValue());
                row.createCell(3).setCellValue(op.getComment() != null ? op.getComment() : "—");
                row.createCell(4).setCellValue(op.getCreatedAt().format(formatter));
                if (op.getSalary() != null && op.getSalary().getPosition() != null) {
                    row.createCell(5).setCellValue(op.getSalary().getPosition().name());
                    row.createCell(6).setCellValue(op.getSalary().getStartDate().format(formatter));
                    row.createCell(7).setCellValue(op.getSalary().getEndDate().format(formatter));
                } else {
                    row.createCell(5).setCellValue("—");
                    row.createCell(6).setCellValue("—");
                    row.createCell(7).setCellValue("—");
                }
            }

            // Auto-size columns
            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

            workbook.write(out);
            return out.toByteArray();
        } catch (IOException e) {
            throw new RuntimeException("Error generating Excel file", e);
        }
    }
}
