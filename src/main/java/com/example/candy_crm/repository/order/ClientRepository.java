package com.example.candy_crm.repository.order;

import com.example.candy_crm.model.order.Client;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClientRepository extends JpaRepository<Client, Long> {

}
