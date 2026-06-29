/**
 * Jade Dragon Chinese Restaurant
 * Main JavaScript - UI interactions, cart, animations
 */

document.addEventListener('DOMContentLoaded', function () {

    // ============ Cart Form: Prevent double submission ============
    document.querySelectorAll('.add-to-cart-form').forEach(form => {
        form.addEventListener('submit', function (e) {
            const btn = this.querySelector('button[type="submit"]');
            if (btn) {
                btn.disabled = true;
                btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Adding...';
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

    // ============ Navbar scroll effect ============
    const navbar = document.querySelector('.navbar');
    if (navbar) {
        window.addEventListener('scroll', function () {
            if (window.scrollY > 50) {
                navbar.style.boxShadow = '0 4px 20px rgba(0,0,0,0.3)';
            } else {
                navbar.style.boxShadow = 'none';
            }
        });
    }

    // ============ Cart count badge animation ============
    const cartBadge = document.querySelector('.navbar .badge.rounded-pill');
    if (cartBadge && parseInt(cartBadge.textContent) > 0) {
        cartBadge.style.animation = 'pulse 0.5s ease-in-out';
        setTimeout(() => { cartBadge.style.animation = ''; }, 500);
    }

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
            if (!confirm(this.getAttribute('data-confirm'))) {
                e.preventDefault();
            }
        });
    });

    // ============ Active nav link highlighting ============
    const currentPath = window.location.pathname;
    document.querySelectorAll('.nav-link').forEach(link => {
        if (link.getAttribute('href') && currentPath.includes(link.getAttribute('href').replace(/^\//, ''))) {
            link.style.color = '#D4A843 !important';
        }
    });

});

// ============ Utility: Format currency ============
function formatCurrency(amount) {
    return 'RM ' + parseFloat(amount).toFixed(2);
}

// ============ Utility: Show toast notification ============
function showToast(message, type) {
    const toastContainer = document.createElement('div');
    toastContainer.style.cssText = 'position: fixed; top: 80px; right: 20px; z-index: 9999;';
    toastContainer.innerHTML = `
        <div class="alert alert-${type || 'success'} alert-dismissible fade show" role="alert"
             style="min-width: 280px; box-shadow: 0 4px 16px rgba(0,0,0,0.15);">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>`;
    document.body.appendChild(toastContainer);
    setTimeout(() => {
        toastContainer.remove();
    }, 4000);
}
