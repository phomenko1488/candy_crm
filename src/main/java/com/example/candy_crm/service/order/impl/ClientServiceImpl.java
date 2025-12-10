package com.example.candy_crm.service.order.impl;  // Или в service.order.impl

import com.example.candy_crm.dto.CreateResponse;
import com.example.candy_crm.dto.order.ClientCreateRequest;
import com.example.candy_crm.model.order.Client;
import com.example.candy_crm.repository.order.ClientRepository;  // Assume exists
import com.example.candy_crm.service.order.ClientService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ClientServiceImpl implements ClientService {
    private final ClientRepository repository;

    @Override
    public CreateResponse<Client> create(ClientCreateRequest request) {
        List<String> errors = new ArrayList<>();

        if (request.getName() == null || request.getName().trim().isEmpty()) {
            errors.add("Имя клиента обязательно");
        }
        if (request.getPhone() == null || request.getPhone().trim().isEmpty()) {
            errors.add("Телефон обязателен");
        }
        // Добавь другие валидации (e.g., phone format via regex)

        if (!errors.isEmpty()) {
            return new CreateResponse<>(errors);
        }

        Client client = new Client();
        client.setInst(request.getInst() != null ? request.getInst().trim() : null);
        client.setName(request.getName().trim());
        client.setPhone(request.getPhone().trim());
        client.setAddress(request.getAddress() != null ? request.getAddress().trim() : null);

        // Check duplicate by phone/name if needed: if (repository.existsByPhone(request.getPhone())) errors.add("Клиент существует");

        if (!errors.isEmpty()) {
            return new CreateResponse<>(errors);
        }

        return new CreateResponse<>(repository.save(client));
    }

    @Override
    public Page<Client> getPage(Pageable pageable) {
        return repository.findAll(pageable);
    }

    @Override
    public Client getById(Long id) {
        return repository.findById(id).orElseThrow(() -> new RuntimeException("Client not found: " + id));
    }
}