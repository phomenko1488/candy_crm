package com.example.candy_crm.service.user.impl;

import com.example.candy_crm.dto.user.UserCreateRequest;
import com.example.candy_crm.model.user.Role;
import com.example.candy_crm.model.user.User;
import com.example.candy_crm.repository.user.RoleRepository; // Добавь репозиторий для Role
import com.example.candy_crm.repository.user.UserRepository;
import com.example.candy_crm.service.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService, UserDetailsService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository; // Добавь: extends JpaRepository<Role, Long>
    private final PasswordEncoder passwordEncoder;

    @Override
    public Page<User> getPage(Pageable pageable, Integer currentUserLevel) {
        return userRepository.findSubordinatesByMinLevel(currentUserLevel, pageable);
    }

    @Override
    public Page<User> getPageByRole(Role role, Pageable pageable, Integer currentUserLevel) {
        // Фильтр + проверка, что роль доступна (level > current)
        if (role.getLevel() <= currentUserLevel) {
            throw new IllegalArgumentException("Доступ запрещён: роль не нижестоящая");
        }
        return userRepository.findByRole(role, pageable); // Дополнительно фильтровать в query если нужно
    }

    @Override
    public Optional<User> getById(Long id, Integer currentUserLevel) {
        Optional<User> user = userRepository.findById(id);
        if (user.isPresent() && !user.get().isSubordinateOf(new User() {{
            setRole(new Role() {{
                setLevel(currentUserLevel);
            }});
        }})) {
            return Optional.empty(); // Не показывать, если не subordinate
        }
        return user;
    }

    @Override
    public User create(UserCreateRequest request, Integer currentUserLevel) {
        Role role = roleRepository.findById(request.getRoleId())
                .orElseThrow(() -> new IllegalArgumentException("Роль не найдена"));
        if (role.getLevel() <= currentUserLevel) {
            throw new IllegalArgumentException("Доступ запрещён: нельзя создавать вышестоящих");
        }

        User user = new User();
        user.setUsername(request.getName());
        user.setActive(true);
//        user.setEmail(request.getEmail());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setRole(role);
        return userRepository.save(user);
    }

    @Override
    public User toggleActive(Long id, Integer currentUserLevel) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Пользователь не найден"));
        if (!user.isSubordinateOf(new User() {{
            setRole(new Role() {{
                setLevel(currentUserLevel);
            }});
        }})) {
            throw new IllegalArgumentException("Доступ запрещён: не subordinate");
        }
        user.setActive(!user.isActive());
        return userRepository.save(user);
    }

    @Override
    public List<Role> getAvailableRolesForCreation(Integer currentUserLevel) {
        return roleRepository.findByLevelGreaterThan(currentUserLevel);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.getUserByUsername(username);
    }
}