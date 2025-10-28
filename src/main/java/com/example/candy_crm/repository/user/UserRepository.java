package com.example.candy_crm.repository.user;

import com.example.candy_crm.model.user.Role;
import com.example.candy_crm.model.user.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User getUserByUsername(String username);

    Page<User> findByRole(Role role, Pageable pageable);

    @Query("SELECT u FROM User u WHERE u.role.level > :minLevel")
    Page<User> findSubordinatesByMinLevel(@Param("minLevel") Integer minLevel, Pageable pageable);
}