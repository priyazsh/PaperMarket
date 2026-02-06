<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 
    Toast Notifications Component
    Usage: <jsp:include page="/WEB-INF/views/common/toast.jsp"/>
    
    Set flash attributes in controller:
    redirectAttributes.addFlashAttribute("successMessage", "Operation successful!");
    redirectAttributes.addFlashAttribute("errorMessage", "Something went wrong!");
--%>

<!-- Toast Container -->
<div id="toast-container" class="fixed top-4 right-4 z-50 flex flex-col space-y-2">
    <% if (request.getAttribute("successMessage") != null) { %>
        <div class="toast toast-success flex items-center space-x-3 px-4 py-3 bg-slate-900/95 backdrop-blur-xl border border-emerald-500/30 rounded-xl shadow-lg animate-slideIn" data-auto-dismiss="5000">
            <div class="w-8 h-8 bg-emerald-500/20 rounded-lg flex items-center justify-center flex-shrink-0">
                <svg class="w-5 h-5 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                </svg>
            </div>
            <p class="text-slate-100 text-sm font-medium">${successMessage}</p>
            <button onclick="this.parentElement.remove()" class="text-slate-500 hover:text-slate-300 transition-colors ml-2">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </button>
        </div>
    <% } %>
    
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="toast toast-error flex items-center space-x-3 px-4 py-3 bg-slate-900/95 backdrop-blur-xl border border-rose-500/30 rounded-xl shadow-lg animate-slideIn" data-auto-dismiss="5000">
            <div class="w-8 h-8 bg-rose-500/20 rounded-lg flex items-center justify-center flex-shrink-0">
                <svg class="w-5 h-5 text-rose-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </div>
            <p class="text-slate-100 text-sm font-medium">${errorMessage}</p>
            <button onclick="this.parentElement.remove()" class="text-slate-500 hover:text-slate-300 transition-colors ml-2">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </button>
        </div>
    <% } %>
    
    <% if (request.getAttribute("warningMessage") != null) { %>
        <div class="toast toast-warning flex items-center space-x-3 px-4 py-3 bg-slate-900/95 backdrop-blur-xl border border-amber-500/30 rounded-xl shadow-lg animate-slideIn" data-auto-dismiss="5000">
            <div class="w-8 h-8 bg-amber-500/20 rounded-lg flex items-center justify-center flex-shrink-0">
                <svg class="w-5 h-5 text-amber-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path>
                </svg>
            </div>
            <p class="text-slate-100 text-sm font-medium">${warningMessage}</p>
            <button onclick="this.parentElement.remove()" class="text-slate-500 hover:text-slate-300 transition-colors ml-2">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </button>
        </div>
    <% } %>
</div>

<style>
    @keyframes slideIn {
        from { transform: translateX(100%); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }
    @keyframes slideOut {
        from { transform: translateX(0); opacity: 1; }
        to { transform: translateX(100%); opacity: 0; }
    }
    .animate-slideIn {
        animation: slideIn 0.3s ease-out forwards;
    }
    .animate-slideOut {
        animation: slideOut 0.3s ease-out forwards;
    }
</style>

<script>
    // Auto-dismiss toasts
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('[data-auto-dismiss]').forEach(function(toast) {
            const timeout = parseInt(toast.dataset.autoDismiss);
            setTimeout(function() {
                toast.classList.remove('animate-slideIn');
                toast.classList.add('animate-slideOut');
                setTimeout(function() {
                    toast.remove();
                }, 300);
            }, timeout);
        });
    });
    
    // Global toast function for AJAX responses
    function showToast(message, type = 'success') {
        const container = document.getElementById('toast-container');
        const colors = {
            success: { border: 'emerald', icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>' },
            error: { border: 'rose', icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>' },
            warning: { border: 'amber', icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path>' }
        };
        const config = colors[type] || colors.success;
        
        const toast = document.createElement('div');
        toast.className = 'toast flex items-center space-x-3 px-4 py-3 bg-slate-900/95 backdrop-blur-xl border border-' + config.border + '-500/30 rounded-xl shadow-lg animate-slideIn';
        toast.innerHTML = `
            <div class="w-8 h-8 bg-${config.border}-500/20 rounded-lg flex items-center justify-center flex-shrink-0">
                <svg class="w-5 h-5 text-${config.border}-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">${config.icon}</svg>
            </div>
            <p class="text-slate-100 text-sm font-medium">${message}</p>
            <button onclick="this.parentElement.remove()" class="text-slate-500 hover:text-slate-300 transition-colors ml-2">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </button>
        `;
        container.appendChild(toast);
        
        setTimeout(() => {
            toast.classList.remove('animate-slideIn');
            toast.classList.add('animate-slideOut');
            setTimeout(() => toast.remove(), 300);
        }, 5000);
    }
</script>
