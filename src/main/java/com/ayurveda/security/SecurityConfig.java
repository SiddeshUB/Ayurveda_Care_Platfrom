package com.ayurveda.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import java.nio.charset.StandardCharsets;
import jakarta.servlet.http.HttpServletResponse;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final CustomUserDetailsService userDetailsService;
    private final CustomAuthenticationSuccessHandler successHandler;

    @Autowired
    public SecurityConfig(CustomUserDetailsService userDetailsService, 
                          CustomAuthenticationSuccessHandler successHandler) {
        this.userDetailsService = userDetailsService;
        this.successHandler = successHandler;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    // Admin Security Configuration
    @Bean
    @Order(1)
    public SecurityFilterChain adminFilterChain(HttpSecurity http) throws Exception {
        http
            .securityMatcher("/admin/**")
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/admin/login", "/admin/register").permitAll()
                .requestMatchers("/admin/**").hasRole("ADMIN")
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/admin/login")
                .loginProcessingUrl("/admin/login")
                .defaultSuccessUrl("/admin/dashboard", true)
                .failureUrl("/admin/login?error=true")
                .usernameParameter("email")
                .passwordParameter("password")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/admin/logout")
                .logoutSuccessUrl("/admin/login?logout=true")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll()
            )
            .exceptionHandling(ex -> ex
                .accessDeniedHandler((request, response, accessDeniedException) -> {
                    response.sendRedirect(request.getContextPath() + "/admin/login?error=access_denied");
                })
            );

        return http.build();
    }

    // Doctor Security Configuration
    @Bean
    @Order(2)
    public SecurityFilterChain doctorFilterChain(HttpSecurity http) throws Exception {
        http
            .securityMatcher("/doctor/**")
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/doctor/login", "/doctor/register", "/doctor/forgot-password", "/doctor/reset-password").permitAll()
                .requestMatchers("/doctor/**").hasRole("DOCTOR")
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/doctor/login")
                .loginProcessingUrl("/doctor/login")
                .defaultSuccessUrl("/doctor/dashboard", true)
                .failureUrl("/doctor/login?error=true")
                .usernameParameter("email")
                .passwordParameter("password")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/doctor/logout")
                .logoutSuccessUrl("/doctor/login?logout=true")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll()
            )
            .exceptionHandling(ex -> ex
                .accessDeniedHandler((request, response, accessDeniedException) -> {
                    response.sendRedirect(request.getContextPath() + "/doctor/login?error=access_denied");
                })
            );

        return http.build();
    }

    // Vendor Security Configuration (Session-based - no Spring Security auth)
    @Bean
    @Order(3)
    public SecurityFilterChain vendorFilterChain(HttpSecurity http) throws Exception {
        http
            .securityMatcher("/vendor/**")
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/vendor/login", "/vendor/register").permitAll()
                .requestMatchers("/vendor/**").permitAll() // Using session-based auth in controller
                .anyRequest().permitAll()
            );

        return http.build();
    }

    // User Security Configuration
    @Bean
    @Order(4)
    public SecurityFilterChain userFilterChain(HttpSecurity http) throws Exception {
        http
            .securityMatcher("/user/**")
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/user/register", "/user/login", "/user/forgot-password", "/user/reset-password").permitAll()
                .requestMatchers("/user/**").hasRole("USER")
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/user/login")
                .loginProcessingUrl("/user/login")
                .successHandler(successHandler) // Custom handler sets userId in session
                .failureUrl("/user/login?error=true")
                .usernameParameter("email")
                .passwordParameter("password")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/user/logout")
                .logoutSuccessUrl("/user/login?logout=true")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll()
            )
            .exceptionHandling(ex -> ex
                .accessDeniedHandler((request, response, accessDeniedException) -> {
                    response.sendRedirect(request.getContextPath() + "/user/login?error=access_denied");
                })
            );

        return http.build();
    }

    // Hospital Security Configuration
    @Bean
    @Order(5)
    public SecurityFilterChain hospitalFilterChain(HttpSecurity http) throws Exception {
        http
            .securityMatcher(request -> {
                String path = request.getRequestURI();
                // Exclude vendor, admin, doctor, and user routes (handled by other filter chains)
                // Also exclude static resources - they should be handled by resource handlers
                if (path == null) return false;
                if (path.startsWith("/vendor/") || 
                    path.startsWith("/admin/") || 
                    path.startsWith("/doctor/") || 
                    path.startsWith("/user/") ||
                    path.startsWith("/css/") ||
                    path.startsWith("/js/") ||
                    path.startsWith("/images/") ||
                    path.startsWith("/uploads/") ||
                    path.startsWith("/webjars/")) {
                    return false;
                }
                return true;
            })
            .csrf(csrf -> csrf.disable())
            // Disable request cache to prevent redirect loops
            .requestCache(cache -> cache.disable())
            .authorizeHttpRequests(auth -> auth
                // Permit WEB-INF paths for JSP rendering (internal forwards only, not direct HTTP access)
                .requestMatchers("/WEB-INF/**", "/META-INF/**").permitAll()
                // Public pages - viewing only
                .requestMatchers("/", "/home", "/about", "/contact", "/services", "/access-denied").permitAll()
                .requestMatchers("/hospital/register", "/hospital/register/**").permitAll()
                .requestMatchers("/hospital/login").permitAll()
                .requestMatchers("/hospital/profile/**").permitAll()
                .requestMatchers("/hospitals", "/hospitals/**").permitAll()
                .requestMatchers("/search/**").permitAll()
                .requestMatchers("/doctor/register", "/doctor/login").permitAll()
                .requestMatchers("/doctors", "/doctor/profile/**").permitAll()
                .requestMatchers("/package/details/**").permitAll()
                .requestMatchers("/room/details/**").permitAll()
                .requestMatchers("/product/details/**").permitAll()
                .requestMatchers("/products", "/products/**").permitAll()
                .requestMatchers("/shop", "/shop/**").permitAll()
                .requestMatchers("/user/register", "/user/login").permitAll()
                .requestMatchers("/consultation/book/**").permitAll()
                // Vendor routes - permit all (vendor uses session-based auth)
                .requestMatchers("/vendor/**").permitAll()
                
                // Booking/action pages - require USER login
                .requestMatchers("/booking/enquiry/**").hasRole("USER") // Requires user authentication
                .requestMatchers("/booking/confirmation/**").permitAll()
                .requestMatchers("/room/booking/**").hasRole("USER") // Requires user authentication
                .requestMatchers("/room/booking/confirmation/**").permitAll()
                
                // Static resources
                .requestMatchers("/css/**", "/js/**", "/images/**", "/uploads/**").permitAll()
                .requestMatchers("/webjars/**").permitAll()
                
                // Dashboard requires hospital authentication
                .requestMatchers("/dashboard/**").hasRole("HOSPITAL")
                
                // User dashboard
                .requestMatchers("/user/dashboard/**").hasRole("USER")
                
                // API endpoints
                .requestMatchers("/api/public/**").permitAll()
                .requestMatchers("/api/**").hasAnyRole("HOSPITAL", "USER")
                
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/hospital/login")
                .loginProcessingUrl("/hospital/login")
                .defaultSuccessUrl("/dashboard", true)
                .failureUrl("/hospital/login?error=true")
                .usernameParameter("email")
                .passwordParameter("password")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/hospital/logout")
                .logoutSuccessUrl("/hospital/login?logout=true")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll()
            )
            .exceptionHandling(ex -> ex
                .authenticationEntryPoint((request, response, authException) -> {
                    // Handle unauthenticated users - redirect to login
                    // Note: This should only be called for routes that require authentication
                    // Public routes (permitAll) should not trigger this entry point
                    String contextPath = request.getContextPath();
                    String requestURI = request.getRequestURI();
                    
                    // Safety check: if this is a public route, don't redirect
                    // This should not happen, but if it does, allow the request to proceed
                    if (requestURI != null) {
                        String path = requestURI.startsWith(contextPath) ? 
                            requestURI.substring(contextPath.length()) : requestURI;
                        
                        if (path.equals("/") || path.equals("/home") ||
                            path.startsWith("/products") || path.startsWith("/shop") ||
                            path.startsWith("/hospitals") || path.startsWith("/doctors") ||
                            path.startsWith("/about") || path.startsWith("/contact") ||
                            path.startsWith("/services") || path.startsWith("/hospital/profile") ||
                            path.startsWith("/doctor/profile") || path.startsWith("/user/login") ||
                            path.startsWith("/user/register") || path.startsWith("/hospital/login") ||
                            path.startsWith("/hospital/register") || path.startsWith("/doctor/login") ||
                            path.startsWith("/doctor/register") || path.startsWith("/vendor/") ||
                            path.startsWith("/css/") || path.startsWith("/js/") ||
                            path.startsWith("/images/") || path.startsWith("/uploads/") ||
                            path.startsWith("/webjars/") || path.startsWith("/api/public/")) {
                            // This is a public route - should not redirect
                            // The authenticationEntryPoint shouldn't be called for permitAll routes
                            // If it is called, it means there's a configuration issue
                            // Clear the response and allow the request to proceed by not redirecting
                            response.reset();
                            response.setStatus(HttpServletResponse.SC_OK);
                            // Try to forward the request to the controller
                            try {
                                request.getRequestDispatcher(requestURI).forward(request, response);
                            } catch (Exception e) {
                                // If forward fails, just return - the request should still proceed
                                // because permitAll should allow it
                            }
                            return;
                        }
                    }
                    
                    String redirectUrl = contextPath + "/user/login";
                    
                    if (requestURI != null && (requestURI.contains("/booking/") || requestURI.contains("/room/booking/"))) {
                        String fullUrl = requestURI + (request.getQueryString() != null ? "?" + request.getQueryString() : "");
                        redirectUrl = contextPath + "/user/login?error=Please login as a user to book&redirectUrl=" +
                            java.net.URLEncoder.encode(fullUrl, StandardCharsets.UTF_8);
                    }
                    
                    response.sendRedirect(redirectUrl);
                })
                .accessDeniedHandler((request, response, accessDeniedException) -> {
                    // Handle authenticated users with wrong role - redirect to appropriate login
                    String contextPath = request.getContextPath();
                    String requestURI = request.getRequestURI();
                    String redirectUrl = contextPath + "/access-denied";
                    
                    if (requestURI != null && (requestURI.contains("/booking/") || requestURI.contains("/room/booking/"))) {
                        redirectUrl = contextPath + "/user/login?error=Please login as a user (not hospital/doctor) to make bookings";
                    }
                    
                    response.sendRedirect(redirectUrl);
                })
            );

        return http.build();
    }
}
