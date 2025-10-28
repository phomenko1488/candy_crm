package com.example.candy_crm.config;

import com.example.candy_crm.service.user.impl.UserServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final UserServiceImpl userServiceImpl; // 👈 Твой сервис

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable()) // для тестов
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/css/**", "/js/**", "/login").permitAll()
                        // Склад товаров - доступен всем авторизованным
                        .requestMatchers("/warehouse/**").authenticated()
                        // Склад украшений - доступен конструкторам и выше
                        .requestMatchers("/jewelry/*","/jewelry/**").authenticated()
                        .requestMatchers("/jewelry-items/*","/jewelry-items/**").authenticated()
                        // Заказы - доступны всем авторизованным
                        .requestMatchers("/orders/*","/orders/**").authenticated()
                        // Пользователи - доступны менеджерам и выше
                        .requestMatchers("/users/*","/users/**").authenticated()
                        // Финансы - доступны директору и выше
                        .requestMatchers("/finance/*","/finance/**").authenticated()
                        .anyRequest().authenticated()
                )
                .userDetailsService(userServiceImpl)
                .formLogin(form -> form
                        .loginPage("/login")
                        .defaultSuccessUrl("/", true)
                        .failureUrl("/login?error=true")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutSuccessUrl("/login?logout=true")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                );

        return http.build();
    }

    @Bean
    public AuthenticationManager authenticationManager(PasswordEncoder passwordEncoder) {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider(userServiceImpl);
        provider.setUserDetailsService(userServiceImpl); // 👈 И здесь
        provider.setPasswordEncoder(passwordEncoder);
        return new ProviderManager(provider);
    }
}
