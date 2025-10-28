package com.example.candy_crm.service.user;

import com.example.candy_crm.dto.user.UserCreateRequest;
import com.example.candy_crm.model.user.Role;
import com.example.candy_crm.model.user.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface UserService {
    Page<User> getPage(Pageable pageable, Integer currentUserLevel); // Фильтр по subordinates

    Page<User> getPageByRole(Role role, Pageable pageable, Integer currentUserLevel);

    Optional<User> getById(Long id, Integer currentUserLevel); // Проверка доступа

    User create(UserCreateRequest request, Integer currentUserLevel); // Только нижестоящие роли

    User toggleActive(Long id, Integer currentUserLevel); // Только для subordinates

    List<Role> getAvailableRolesForCreation(Integer currentUserLevel); // Роли с level > current
}
