package com.example.candy_crm.service.decoration;

import com.example.candy_crm.dto.decoration.*;
import com.example.candy_crm.model.decoration.Decoration;
import com.example.candy_crm.model.operation.Operation;
import com.example.candy_crm.model.user.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.io.IOException;

public interface DecorationService {
    Page<Decoration> getAllDecorations(Pageable pageable,String search);

    Decoration getById(Long id);

    Page<Operation> getOperationsForDecoration(Long id, Pageable pageable);

    DecorationCreateResponse create(DecorationCreateRequest dto, User auth) throws IOException;

    DecorationOperationCreateResponse add(Long id, DecorationOperationCreateRequest request, User user);

    DecorationCreateResponse rename(DecorationRenameRequest request, User user);

}
