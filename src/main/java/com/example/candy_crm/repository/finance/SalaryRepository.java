package com.example.candy_crm.repository.finance;

import com.example.candy_crm.model.finance.FinanceOperation;
import com.example.candy_crm.model.finance.Salary;
import com.example.candy_crm.repository.user.UserRepository;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;

@Repository
public interface SalaryRepository extends JpaRepository<Salary,Long> {
}