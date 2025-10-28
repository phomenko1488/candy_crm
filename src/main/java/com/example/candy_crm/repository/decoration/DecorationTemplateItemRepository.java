package com.example.candy_crm.repository.decoration;

import com.example.candy_crm.model.decoration.DecorationTemplateItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DecorationTemplateItemRepository extends JpaRepository<DecorationTemplateItem,Long> {
}
