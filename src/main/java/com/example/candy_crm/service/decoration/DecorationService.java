package com.example.candy_crm.service.decoration;

import com.example.candy_crm.dto.decoration.DecorationCreateRequest;
import com.example.candy_crm.dto.decoration.DecorationCreateResponse;
import com.example.candy_crm.dto.decoration.DecorationOperationCreateRequest;
import com.example.candy_crm.dto.decoration.DecorationOperationCreateResponse;
import com.example.candy_crm.model.decoration.Decoration;
import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.model.user.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface DecorationService {
    Page<Decoration> getAllDecorations(Pageable pageable);

    Decoration getById(Long id);

    Page<Operation> getOperationsForDecoration(Long id, Pageable pageable);

    DecorationCreateResponse create(DecorationCreateRequest dto, User auth);

    DecorationOperationCreateResponse add(Long id, DecorationOperationCreateRequest request, User user);

}
