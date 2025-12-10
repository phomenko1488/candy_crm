package com.example.candy_crm.service.order;

import com.example.candy_crm.dto.CreateResponse;
import com.example.candy_crm.dto.order.ClientCreateRequest;
import com.example.candy_crm.model.order.Client;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ClientService {
    CreateResponse<Client> create(ClientCreateRequest request);

    Page<Client> getPage(Pageable pageable);

    Client getById(Long id);
}
