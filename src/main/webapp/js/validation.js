/**
 * Jade Dragon Chinese Restaurant
 * Form Validation JavaScript
 * Used by: register.jsp, contact.jsp, checkout forms
 */

document.addEventListener('DOMContentLoaded', function () {

    // ============ Registration Form Validation ============
    const registerForm = document.getElementById('registerForm');
    if (registerForm) {
        const usernameInput = registerForm.querySelector('input[name="username"]');
        const emailInput = registerForm.querySelector('input[name="email"]');
        const phoneInput = registerForm.querySelector('input[name="phone"]');
        const passwordInput = registerForm.querySelector('input[name="password"]');
        const confirmInput = registerForm.querySelector('input[name="confirmPassword"]');
        const pwMatchError = document.getElementById('pwMatchError');

        // Real-time password match validation
        if (confirmInput && passwordInput && pwMatchError) {
            function checkPasswordMatch() {
                if (confirmInput.value.length > 0 && passwordInput.value !== confirmInput.value) {
                    confirmInput.classList.add('is-invalid');
                    pwMatchError.style.display = 'block';
                } else if (confirmInput.value.length > 0) {
                    confirmInput.classList.remove('is-invalid');
                    confirmInput.classList.add('is-valid');
                    pwMatchError.style.display = 'none';
                }
            }
            passwordInput.addEventListener('input', checkPasswordMatch);
            confirmInput.addEventListener('input', checkPasswordMatch);
        }

        // Password strength indicator
        if (passwordInput) {
            passwordInput.addEventListener('input', function () {
                const val = this.value;
                let strength = 0;
                if (val.length >= 6) strength++;
                if (val.length >= 8) strength++;
                if (/[A-Z]/.test(val)) strength++;
                if (/[0-9]/.test(val)) strength++;
                if (/[^A-Za-z0-9]/.test(val)) strength++;

                const colors = ['#C41E3A', '#E67E22', '#D4A843', '#2ECC71', '#27AE60'];
                const labels = ['Weak 弱', 'Fair 一般', 'Good 好', 'Strong 强', 'Very Strong 很强'];
                const idx = Math.min(strength, 4);

                this.style.borderColor = colors[idx];
                let hint = this.parentElement.querySelector('.password-strength');
                if (!hint) {
                    hint = document.createElement('small');
                    hint.className = 'password-strength';
                    hint.style.display = 'block';
                    hint.style.marginTop = '4px';
                    this.parentElement.appendChild(hint);
                }
                hint.textContent = 'Strength: ' + labels[idx];
                hint.style.color = colors[idx];
            });
        }

        // Username real-time validation
        if (usernameInput) {
            usernameInput.addEventListener('blur', function () {
                if (this.value.length > 0 && this.value.length < 3) {
                    this.classList.add('is-invalid');
                } else if (this.value.length >= 3) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                }
            });
        }

        // Email real-time validation
        if (emailInput) {
            emailInput.addEventListener('blur', function () {
                const emailRegex = /^(?!.*\.\.)[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$/;
                if (this.value.length > 0 && !emailRegex.test(this.value)) {
                    this.classList.add('is-invalid');
                } else if (emailRegex.test(this.value)) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                }
            });
        }

        // Phone format validation
        if (phoneInput) {
            phoneInput.addEventListener('blur', function () {
                const phoneRegex = /^\+?[0-9]{7,15}$/;
                if (this.value.length > 0 && !phoneRegex.test(this.value)) {
                    this.classList.add('is-invalid');
                } else if (this.value.length > 0) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                } else {
                    this.classList.remove('is-invalid', 'is-valid');
                }
            });
        }

        // Form submit validation
        registerForm.addEventListener('submit', function (e) {
            let hasError = false;

            if (!usernameInput.value || usernameInput.value.length < 3) {
                usernameInput.classList.add('is-invalid');
                hasError = true;
            }

            const emailRegex = /^(?!.*\.\.)[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$/;
            if (!emailInput.value || !emailRegex.test(emailInput.value)) {
                emailInput.classList.add('is-invalid');
                hasError = true;
            }

            if (!passwordInput.value || passwordInput.value.length < 6) {
                passwordInput.classList.add('is-invalid');
                hasError = true;
            }

            if (passwordInput.value !== confirmInput.value) {
                confirmInput.classList.add('is-invalid');
                hasError = true;
            }

            if (phoneInput.value && !/^\+?[0-9]{7,15}$/.test(phoneInput.value)) {
                phoneInput.classList.add('is-invalid');
                hasError = true;
            }

            if (hasError) {
                e.preventDefault();
                // Scroll to first error
                const firstError = registerForm.querySelector('.is-invalid');
                if (firstError) firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        });
    }

    // ============ Contact Form Validation ============
    const contactForm = document.querySelector('form[action="ContactServlet"]');
    if (contactForm) {
        contactForm.addEventListener('submit', function (e) {
            let hasError = false;
            const nameInput = this.querySelector('input[name="name"]');
            const emailInput = this.querySelector('input[name="email"]');
            const messageInput = this.querySelector('textarea[name="message"]');

            if (!nameInput.value || nameInput.value.length < 2) {
                nameInput.classList.add('is-invalid');
                hasError = true;
            } else {
                nameInput.classList.remove('is-invalid');
            }

            const emailRegex = /^[^@]+@[^@]+\.[^@]+$/;
            if (!emailInput.value || !emailRegex.test(emailInput.value)) {
                emailInput.classList.add('is-invalid');
                hasError = true;
            } else {
                emailInput.classList.remove('is-invalid');
            }

            if (!messageInput.value || messageInput.value.length < 5) {
                messageInput.classList.add('is-invalid');
                hasError = true;
            } else {
                messageInput.classList.remove('is-invalid');
            }

            if (hasError) {
                e.preventDefault();
                const firstError = contactForm.querySelector('.is-invalid');
                if (firstError) firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        });
    }

    // ============ Bootstrap Form Validation ============
    var forms = document.querySelectorAll('.needs-validation');
    Array.prototype.slice.call(forms).forEach(function (form) {
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });

});
