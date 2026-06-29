/**
 * Jade Dragon Restaurant
 * Form Validation JavaScript
 * Used by: register.jsp, contact.jsp, checkout forms
 */

document.addEventListener('DOMContentLoaded', function () {

    // ============ Registration Form Validation ============
    const registerForm = document.getElementById('registerForm');
    if (registerForm) {
        const usernameInput = registerForm.querySelector('input[name="username"]');
        const emailInput    = registerForm.querySelector('input[name="email"]');
        const phoneInput    = registerForm.querySelector('input[name="phone"]');
        const passwordInput = registerForm.querySelector('input[name="password"]');
        const confirmInput  = registerForm.querySelector('input[name="confirmPassword"]');
        const pwMatchMsg    = document.getElementById('pwMatchError');

        // Real-time password match checking
        if (confirmInput && passwordInput && pwMatchMsg) {
            function checkPasswordMatch() {
                if (confirmInput.value.length > 0 && passwordInput.value !== confirmInput.value) {
                    confirmInput.classList.add('is-invalid');
                    confirmInput.classList.remove('is-valid');
                    pwMatchMsg.style.display = 'block';
                } else if (confirmInput.value.length > 0) {
                    confirmInput.classList.remove('is-invalid');
                    confirmInput.classList.add('is-valid');
                    pwMatchMsg.style.display = 'none';
                }
            }
            passwordInput.addEventListener('input', checkPasswordMatch);
            confirmInput.addEventListener('input', checkPasswordMatch);
        }

        // Username blur validation
        if (usernameInput) {
            usernameInput.addEventListener('blur', function () {
                if (this.value.length > 0 && this.value.length < 3) {
                    this.classList.add('is-invalid');
                    this.classList.remove('is-valid');
                } else if (this.value.length >= 3) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                }
            });
        }

        // Email blur validation
        if (emailInput) {
            emailInput.addEventListener('blur', function () {
                const re = /^(?!.*\.\.)[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$/;
                if (this.value.length > 0 && !re.test(this.value)) {
                    this.classList.add('is-invalid');
                    this.classList.remove('is-valid');
                } else if (re.test(this.value)) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                }
            });
        }

        // Phone format validation (optional field)
        if (phoneInput) {
            phoneInput.addEventListener('blur', function () {
                const re = /^\+?[0-9]{7,15}$/;
                if (this.value.length > 0 && !re.test(this.value)) {
                    this.classList.add('is-invalid');
                    this.classList.remove('is-valid');
                } else if (this.value.length > 0) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                } else {
                    this.classList.remove('is-invalid', 'is-valid');
                }
            });
        }

        // Full form submit validation
        registerForm.addEventListener('submit', function (e) {
            let hasError = false;

            if (!usernameInput.value || usernameInput.value.length < 3) {
                usernameInput.classList.add('is-invalid');
                hasError = true;
            }

            const emailRe = /^(?!.*\.\.)[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$/;
            if (!emailInput.value || !emailRe.test(emailInput.value)) {
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
            const nameInput    = this.querySelector('input[name="name"]');
            const emailInput   = this.querySelector('input[name="email"]');
            const messageInput = this.querySelector('textarea[name="message"]');

            if (!nameInput.value || nameInput.value.length < 2) {
                nameInput.classList.add('is-invalid');
                hasError = true;
            } else {
                nameInput.classList.remove('is-invalid');
            }

            const emailRe = /^[^@]+@[^@]+\.[^@]+$/;
            if (!emailInput.value || !emailRe.test(emailInput.value)) {
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
