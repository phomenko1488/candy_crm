package com.example.candy_crm.repository.user;

import com.example.candy_crm.model.user.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleRepository extends JpaRepository<Role,Long> {
    List<Role> findByLevelGreaterThan(Integer currentUserLevel);
}