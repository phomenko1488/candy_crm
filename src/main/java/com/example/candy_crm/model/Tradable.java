package com.example.candy_crm.model;


import java.math.BigDecimal;
public interface Tradable {
    Long getId();
    BigDecimal getPrice();
    String getName();
    String getDescription();

}
