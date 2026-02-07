// UI Functions — modal, tabs, notifications

function switchTab(tab) {
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.classList.remove('active-tab', 'bg-emerald-500/10', 'text-emerald-500', 'border-emerald-500/20');
        btn.classList.add('text-slate-400', 'hover:text-slate-100', 'hover:bg-slate-800', 'border-slate-800');
    });
    event.target.classList.add('active-tab', 'bg-emerald-500/10', 'text-emerald-500', 'border-emerald-500/20');
    event.target.classList.remove('text-slate-400', 'hover:text-slate-100', 'hover:bg-slate-800', 'border-slate-800');
}

function openUserModal(userId) {
    const modal = document.getElementById('modal-overlay');
    modal.classList.remove('hidden');
}

function closeModal() {
    document.getElementById('modal-overlay').classList.add('hidden');
}

function logout() {
    if (confirm('Are you sure you want to logout?')) {
        const baseUrl = window.contextPath || '';
        window.location.href = `${baseUrl}/login`;
    }
}

function showNotification(message, type) {
    const notification = document.createElement('div');
    notification.className = `fixed top-4 right-4 px-6 py-4 rounded-lg shadow-lg z-50 ${type === 'success' ? 'bg-emerald-500' : 'bg-rose-500'} text-white font-medium`;
    notification.textContent = message;
    document.body.appendChild(notification);

    setTimeout(() => {
        notification.remove();
    }, 3000);
}

document.getElementById('modal-overlay').addEventListener('click', (e) => {
    if (e.target === document.getElementById('modal-overlay')) {
        closeModal();
    }
});
