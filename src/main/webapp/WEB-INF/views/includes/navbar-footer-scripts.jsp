<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
    // Mobile menu toggle
    const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
    const navLinks = document.querySelector('.nav-links');
    
    if (mobileMenuBtn && navLinks) {
        mobileMenuBtn.addEventListener('click', () => {
            navLinks.classList.toggle('active');
            mobileMenuBtn.innerHTML = navLinks.classList.contains('active') ? 
                '<i class="fas fa-times"></i>' : '<i class="fas fa-bars"></i>';
        });
        
        // Close menu when clicking outside
        document.addEventListener('click', function(e) {
            if (!mobileMenuBtn.contains(e.target) && !navLinks.contains(e.target)) {
                navLinks.classList.remove('active');
                mobileMenuBtn.innerHTML = '<i class="fas fa-bars"></i>';
            }
        });
    }
    
    // User dropdown toggle for mobile
    const userMenuToggle = document.getElementById('userMenuToggle');
    const userDropdown = document.getElementById('userDropdown');
    if (userMenuToggle && userDropdown) {
        userMenuToggle.addEventListener('click', (e) => {
            e.preventDefault();
            userDropdown.style.display = userDropdown.style.display === 'block' ? 'none' : 'block';
        });
    }
    
    // Navbar scroll effect
    window.addEventListener('scroll', () => {
        const navbar = document.querySelector('.navbar');
        if (navbar) {
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        }
    });
    
    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;
            
            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                window.scrollTo({
                    top: targetElement.offsetTop - 80,
                    behavior: 'smooth'
                });
                
                // Close mobile menu if open
                if (navLinks && navLinks.classList.contains('active')) {
                    navLinks.classList.remove('active');
                    if (mobileMenuBtn) mobileMenuBtn.innerHTML = '<i class="fas fa-bars"></i>';
                }
            }
        });
    });
</script>

