/**
 * Jade Dragon Restaurant
 * Main JavaScript - UI interactions, cart, animations
 */

document.addEventListener('DOMContentLoaded', function () {

    // ============ Navbar scroll effect ============
    const navbar = document.querySelector('.navbar');
    if (navbar) {
        window.addEventListener('scroll', function () {
            if (window.scrollY > 50) {
                navbar.style.boxShadow = '0 4px 24px rgba(0,0,0,0.35)';
            } else {
                navbar.style.boxShadow = '';
            }
        });
    }

    // ============ Cart count badge pulse animation ============
    const cartBadge = document.getElementById('cartBadge');
    if (cartBadge && parseInt(cartBadge.textContent) > 0) {
        cartBadge.classList.add('pulse');
        setTimeout(() => { cartBadge.classList.remove('pulse'); }, 500);
    }

    // ============ Cart Form: Prevent double submission ============
    document.querySelectorAll('.add-to-cart-form').forEach(form => {
        form.addEventListener('submit', function (e) {
            const btn = this.querySelector('button[type="submit"]');
            if (btn && !btn.disabled) {
                btn.disabled = true;
                const originalHTML = btn.innerHTML;
                btn.innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>Adding...';
                setTimeout(() => {
                    btn.disabled = false;
                    btn.innerHTML = originalHTML;
                }, 2000);
            }
        });
    });

    // ============ Smooth scroll for anchor links ============
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                e.preventDefault();
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });

    // ============ Alert auto-dismiss ============
    document.querySelectorAll('.alert-dismissible').forEach(alert => {
        setTimeout(() => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }, 4000);
    });

    // ============ Quantity input validation ============
    document.querySelectorAll('input[type="number"]').forEach(input => {
        input.addEventListener('change', function () {
            const val = parseInt(this.value);
            const min = parseInt(this.getAttribute('min')) || 1;
            const max = parseInt(this.getAttribute('max')) || 10;
            if (isNaN(val) || val < min) this.value = min;
            if (val > max) this.value = max;
        });
    });

    // ============ Confirm delete actions ============
    document.querySelectorAll('[data-confirm]').forEach(el => {
        el.addEventListener('click', function (e) {
            if (!confirm(this.getAttribute('data-confirm') || 'Are you sure?')) {
                e.preventDefault();
            }
        });
    });

    // ============ Back to top button ============
    const backToTopBtn = document.getElementById('backToTop');
    if (backToTopBtn) {
        window.addEventListener('scroll', function () {
            if (window.scrollY > 400) {
                backToTopBtn.classList.add('visible');
            } else {
                backToTopBtn.classList.remove('visible');
            }
        });
        backToTopBtn.addEventListener('click', function () {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    }

    // ============ Active nav link highlighting ============
    const currentPath = window.location.pathname;
    document.querySelectorAll('.navbar .nav-link').forEach(link => {
        const href = link.getAttribute('href');
        if (href && href !== '#' && currentPath.includes(href.replace(/^\//, '').split('?')[0])) {
            link.classList.add('active');
        }
    });

    // ============ Cart quantity +/- buttons ============
    document.querySelectorAll('.qty-btn').forEach(btn => {
        btn.addEventListener('click', function () {
            const input = document.querySelector(this.dataset.target);
            if (!input) return;
            let val = parseInt(input.value) || 1;
            if (this.dataset.action === 'increase') {
                val = Math.min(val + 1, parseInt(input.max) || 10);
            } else {
                val = Math.max(val - 1, parseInt(input.min) || 1);
            }
            input.value = val;
        });
    });

});

// ============ Utility: Format currency ============
function formatCurrency(amount) {
    return 'RM ' + parseFloat(amount).toFixed(2);
}

// ============ Utility: Show toast notification ============
function showToast(message, type) {
    const container = document.createElement('div');
    container.className = 'toast-container';
    container.innerHTML = `
        <div class="custom-toast alert-${type || 'success'}">
            <i class="bi bi-${type === 'danger' ? 'exclamation-triangle' : type === 'warning' ? 'exclamation-circle' : 'check-circle'}"></i>
            ${message}
        </div>`;
    document.body.appendChild(container);
    setTimeout(() => container.remove(), 4000);
}
