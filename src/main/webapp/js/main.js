// ============================================
// AYURVEDA CARE - Main JavaScript
// ============================================

document.addEventListener('DOMContentLoaded', function() {
    
    // Mobile Navigation Toggle
    const navToggle = document.getElementById('navToggle');
    const navMenu = document.getElementById('navMenu');
    
    if (navToggle && navMenu) {
        navToggle.addEventListener('click', function() {
            navMenu.classList.toggle('active');
            const icon = navToggle.querySelector('i');
            if (navMenu.classList.contains('active')) {
                icon.classList.remove('fa-bars');
                icon.classList.add('fa-times');
            } else {
                icon.classList.remove('fa-times');
                icon.classList.add('fa-bars');
            }
        });
        
        // Close menu when clicking outside
        document.addEventListener('click', function(e) {
            if (!navToggle.contains(e.target) && !navMenu.contains(e.target)) {
                navMenu.classList.remove('active');
                const icon = navToggle.querySelector('i');
                icon.classList.remove('fa-times');
                icon.classList.add('fa-bars');
            }
        });
    }
    
    // Navbar scroll effect
    const navbar = document.querySelector('.navbar');
    if (navbar) {
        window.addEventListener('scroll', function() {
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
    }
    
    // Auto-dismiss alerts
    const alerts = document.querySelectorAll('.alert[data-auto-dismiss]');
    alerts.forEach(function(alert) {
        const timeout = parseInt(alert.dataset.autoDismiss) || 5000;
        setTimeout(function() {
            alert.style.opacity = '0';
            alert.style.transform = 'translateY(-10px)';
            setTimeout(function() {
                alert.remove();
            }, 300);
        }, timeout);
    });
    
    // Form validation
    const forms = document.querySelectorAll('form[data-validate]');
    forms.forEach(function(form) {
        form.addEventListener('submit', function(e) {
            let isValid = true;
            const requiredFields = form.querySelectorAll('[required]');
            
            requiredFields.forEach(function(field) {
                if (!field.value.trim()) {
                    isValid = false;
                    field.classList.add('error');
                    
                    // Show error message
                    let errorMsg = field.parentElement.querySelector('.form-error');
                    if (!errorMsg) {
                        errorMsg = document.createElement('div');
                        errorMsg.className = 'form-error';
                        field.parentElement.appendChild(errorMsg);
                    }
                    errorMsg.textContent = 'This field is required';
                } else {
                    field.classList.remove('error');
                    const errorMsg = field.parentElement.querySelector('.form-error');
                    if (errorMsg) errorMsg.remove();
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                // Scroll to first error
                const firstError = form.querySelector('.error');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    firstError.focus();
                }
            }
        });
    });
    
    // File input preview
    const fileInputs = document.querySelectorAll('input[type="file"][data-preview]');
    fileInputs.forEach(function(input) {
        input.addEventListener('change', function() {
            const previewId = input.dataset.preview;
            const preview = document.getElementById(previewId);
            
            if (preview && input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    if (preview.tagName === 'IMG') {
                        preview.src = e.target.result;
                    } else {
                        preview.style.backgroundImage = `url(${e.target.result})`;
                    }
                };
                reader.readAsDataURL(input.files[0]);
            }
        });
    });
    
    // Tab functionality
    const tabButtons = document.querySelectorAll('[data-tab]');
    tabButtons.forEach(function(button) {
        button.addEventListener('click', function() {
            const tabGroup = button.closest('.tabs');
            const tabId = button.dataset.tab;
            
            // Update buttons
            tabGroup.querySelectorAll('[data-tab]').forEach(function(btn) {
                btn.classList.remove('active');
            });
            button.classList.add('active');
            
            // Update panels
            const panels = tabGroup.parentElement.querySelectorAll('.tab-panel');
            panels.forEach(function(panel) {
                panel.classList.remove('active');
                if (panel.id === tabId) {
                    panel.classList.add('active');
                }
            });
        });
    });
    
    // Modal functionality
    window.openModal = function(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.classList.add('active');
            document.body.style.overflow = 'hidden';
        }
    };
    
    window.closeModal = function(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.classList.remove('active');
            document.body.style.overflow = '';
        }
    };
    
    // Close modal on backdrop click
    document.querySelectorAll('.modal').forEach(function(modal) {
        modal.addEventListener('click', function(e) {
            if (e.target === modal) {
                closeModal(modal.id);
            }
        });
    });
    
    // Close modal on escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            const activeModal = document.querySelector('.modal.active');
            if (activeModal) {
                closeModal(activeModal.id);
            }
        }
    });
    
    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
        anchor.addEventListener('click', function(e) {
            const targetId = this.getAttribute('href');
            if (targetId !== '#') {
                e.preventDefault();
                const target = document.querySelector(targetId);
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            }
        });
    });
    
    // Character counter for textareas
    const textareasWithCounter = document.querySelectorAll('textarea[data-max-length]');
    textareasWithCounter.forEach(function(textarea) {
        const maxLength = parseInt(textarea.dataset.maxLength);
        const counter = document.createElement('div');
        counter.className = 'char-counter';
        counter.textContent = `0 / ${maxLength}`;
        textarea.parentElement.appendChild(counter);
        
        textarea.addEventListener('input', function() {
            const length = textarea.value.length;
            counter.textContent = `${length} / ${maxLength}`;
            
            if (length > maxLength) {
                counter.classList.add('error');
            } else {
                counter.classList.remove('error');
            }
        });
    });
    
    // Rating input
    const ratingInputs = document.querySelectorAll('.rating-input');
    ratingInputs.forEach(function(container) {
        const input = container.querySelector('input');
        const stars = container.querySelectorAll('i');
        
        stars.forEach(function(star, index) {
            star.addEventListener('click', function() {
                input.value = index + 1;
                updateStars(stars, index + 1);
            });
            
            star.addEventListener('mouseenter', function() {
                updateStars(stars, index + 1);
            });
        });
        
        container.addEventListener('mouseleave', function() {
            updateStars(stars, parseInt(input.value) || 0);
        });
        
        function updateStars(stars, rating) {
            stars.forEach(function(s, i) {
                if (i < rating) {
                    s.classList.remove('far');
                    s.classList.add('fas');
                } else {
                    s.classList.remove('fas');
                    s.classList.add('far');
                }
            });
        }
    });
    
    // Tooltip functionality
    const tooltips = document.querySelectorAll('[data-tooltip]');
    tooltips.forEach(function(element) {
        const tooltip = document.createElement('div');
        tooltip.className = 'tooltip';
        tooltip.textContent = element.dataset.tooltip;
        element.appendChild(tooltip);
        element.style.position = 'relative';
    });
    
    // Confirm action
    window.confirmAction = function(message, callback) {
        if (confirm(message)) {
            callback();
        }
    };
    
    // Format currency
    window.formatCurrency = function(amount) {
        return new Intl.NumberFormat('en-IN', {
            style: 'currency',
            currency: 'INR',
            minimumFractionDigits: 0
        }).format(amount);
    };
    
    // Format date
    window.formatDate = function(dateString) {
        const date = new Date(dateString);
        return new Intl.DateTimeFormat('en-IN', {
            day: 'numeric',
            month: 'short',
            year: 'numeric'
        }).format(date);
    };
    
});

// Loading state for buttons
function setLoading(button, isLoading) {
    if (isLoading) {
        button.disabled = true;
        button.dataset.originalText = button.innerHTML;
        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
    } else {
        button.disabled = false;
        button.innerHTML = button.dataset.originalText;
    }
}

