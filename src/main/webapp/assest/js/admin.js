let users = JSON.parse(localStorage.getItem('adminUsers') || '[]');
let currentTab = 'all';
let filteredUsers = [];

if (users.length === 0) {
    users = [
        {
            id: 1,
            name: 'John Doe',
            email: 'john.doe@example.com',
            phone: '+91 98765 43210',
            registeredOn: new Date().toISOString(),
            status: 'pending',
            pan: 'ABCDE1234F',
            aadhaar: '**** **** 5678'
        },
        {
            id: 2,
            name: 'Jane Smith',
            email: 'jane.smith@example.com',
            phone: '+91 87654 32109',
            registeredOn: new Date(Date.now() - 86400000).toISOString(),
            status: 'pending',
            pan: 'FGHIJ5678K',
            aadhaar: '**** **** 9012'
        },
        {
            id: 3,
            name: 'Robert Johnson',
            email: 'robert.j@example.com',
            phone: '+91 76543 21098',
            registeredOn: new Date(Date.now() - 172800000).toISOString(),
            status: 'pending',
            pan: 'KLMNO9012P',
            aadhaar: '**** **** 3456'
        }
    ];
    saveUsers();
}

function saveUsers() {
    localStorage.setItem('adminUsers', JSON.stringify(users));
    updateUI();
}

function switchTab(tab) {
    currentTab = tab;
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.classList.remove('active-tab', 'bg-emerald-500/10', 'text-emerald-500', 'border-emerald-500/20');
        btn.classList.add('text-slate-400', 'hover:text-slate-100', 'hover:bg-slate-800', 'border-slate-800');
    });
    event.target.classList.add('active-tab', 'bg-emerald-500/10', 'text-emerald-500', 'border-emerald-500/20');
    event.target.classList.remove('text-slate-400', 'hover:text-slate-100', 'hover:bg-slate-800', 'border-slate-800');
    filterUsers();
}

function filterUsers() {
    const searchTerm = document.getElementById('search-input').value.toLowerCase();
    const filterStatus = document.getElementById('filter-select').value;

    filteredUsers = users.filter(user => {
        const matchesSearch = !searchTerm || 
            user.name.toLowerCase().includes(searchTerm) ||
            user.email.toLowerCase().includes(searchTerm) ||
            user.phone.includes(searchTerm);

        const matchesStatus = filterStatus === 'all' || user.status === filterStatus;

        return matchesSearch && matchesStatus;
    });

    if (currentTab === 'pending') {
        filteredUsers = filteredUsers.filter(u => u.status === 'pending');
    } else if (currentTab === 'approved') {
        filteredUsers = filteredUsers.filter(u => u.status === 'approved');
    } else if (currentTab === 'rejected') {
        filteredUsers = filteredUsers.filter(u => u.status === 'rejected');
    }

    renderUsersList();
}

function approveUser(userId) {
    const user = users.find(u => u.id === userId);
    if (user && confirm(`Approve account for ${user.name}?`)) {
        user.status = 'approved';
        user.approvedOn = new Date().toISOString();
        saveUsers();
        showNotification(`${user.name}'s account has been approved`, 'success');
    }
}

function rejectUser(userId) {
    const user = users.find(u => u.id === userId);
    const reason = prompt(`Reject account for ${user.name}?\n\nPlease provide a reason:`);
    if (reason) {
        user.status = 'rejected';
        user.rejectedOn = new Date().toISOString();
        user.rejectionReason = reason;
        saveUsers();
        showNotification(`${user.name}'s account has been rejected`, 'error');
    }
}

function openUserModal(userId) {
    const user = users.find(u => u.id === userId);
    if (!user) return;

    const modal = document.getElementById('modal-overlay');
    const content = document.getElementById('modal-content');
    const regDate = new Date(user.registeredOn);

    let statusHtml = '';
    if (user.status === 'approved') {
        const appDate = new Date(user.approvedOn);
        statusHtml = `
            <div class="mb-4 p-3 bg-emerald-500/10 border border-emerald-500/20 rounded-lg">
                <p class="text-xs text-emerald-500 mb-1">Status</p>
                <p class="text-sm font-medium text-emerald-400">✓ Approved on ${appDate.toLocaleDateString('en-IN')}</p>
            </div>
        `;
    } else if (user.status === 'rejected') {
        const rejDate = new Date(user.rejectedOn);
        statusHtml = `
            <div class="mb-4 p-3 bg-rose-500/10 border border-rose-500/20 rounded-lg">
                <p class="text-xs text-rose-500 mb-1">Status</p>
                <p class="text-sm font-medium text-rose-400">✗ Rejected on ${rejDate.toLocaleDateString('en-IN')}</p>
                <p class="text-xs text-slate-400 mt-2">Reason: ${user.rejectionReason || 'Not provided'}</p>
            </div>
        `;
    } else {
        statusHtml = `
            <div class="mb-4 p-3 bg-amber-500/10 border border-amber-500/20 rounded-lg">
                <p class="text-xs text-amber-500 mb-1">Status</p>
                <p class="text-sm font-medium text-amber-400">⏱ Pending Review</p>
            </div>
        `;
    }

    content.innerHTML = `
        <div class="space-y-6">
            <div class="flex items-center space-x-4">
                <div class="w-16 h-16 bg-gradient-to-br from-emerald-500 to-cyan-500 rounded-full flex items-center justify-center flex-shrink-0">
                    <span class="text-2xl font-bold text-white">${user.name.charAt(0)}</span>
                </div>
                <div>
                    <h3 class="text-xl font-bold text-slate-100">${user.name}</h3>
                    <p class="text-sm text-slate-400">${user.email}</p>
                </div>
            </div>

            ${statusHtml}

            <div class="grid grid-cols-2 gap-4">
                <div class="p-3 bg-slate-950 rounded-lg">
                    <p class="text-xs text-slate-500 mb-2">Phone</p>
                    <p class="text-sm font-medium text-slate-300">${user.phone}</p>
                </div>
                <div class="p-3 bg-slate-950 rounded-lg">
                    <p class="text-xs text-slate-500 mb-2">Registered</p>
                    <p class="text-sm font-medium text-slate-300">${regDate.toLocaleDateString('en-IN')}</p>
                </div>
                <div class="p-3 bg-slate-950 rounded-lg">
                    <p class="text-xs text-slate-500 mb-2">PAN Number</p>
                    <p class="text-sm font-medium text-slate-300 font-mono">${user.pan}</p>
                </div>
                <div class="p-3 bg-slate-950 rounded-lg">
                    <p class="text-xs text-slate-500 mb-2">Aadhaar</p>
                    <p class="text-sm font-medium text-slate-300 font-mono">${user.aadhaar}</p>
                </div>
            </div>

            <div class="pt-4 border-t border-slate-800">
                ${user.status === 'pending' ? `
                    <div class="flex space-x-3">
                        <button onclick="approveUser(${user.id}); closeModal();" class="flex-1 px-4 py-2 bg-emerald-500 hover:bg-emerald-600 text-white font-semibold rounded-lg transition-colors">
                            Approve Account
                        </button>
                        <button onclick="rejectUser(${user.id}); closeModal();" class="flex-1 px-4 py-2 bg-rose-500 hover:bg-rose-600 text-white font-semibold rounded-lg transition-colors">
                            Reject Account
                        </button>
                    </div>
                ` : `
                    <p class="text-sm text-slate-400 text-center py-2">Account has been ${user.status}</p>
                `}
            </div>
        </div>
    `;

    modal.classList.remove('hidden');
}

function closeModal() {
    document.getElementById('modal-overlay').classList.add('hidden');
}

function renderUsersList() {
    const usersList = document.getElementById('users-list');

    if (filteredUsers.length === 0) {
        usersList.innerHTML = `
            <div class="text-center py-16">
                <svg class="w-16 h-16 mx-auto text-slate-600 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
                <h3 class="text-xl font-semibold text-slate-100 mb-2">No Users Found</h3>
                <p class="text-slate-400">Try adjusting your search or filters</p>
            </div>
        `;
        return;
    }

    usersList.innerHTML = filteredUsers.map(user => {
        const regDate = new Date(user.registeredOn);
        const days = Math.floor((Date.now() - new Date(user.registeredOn)) / 86400000);

        let statusColor = 'amber';
        let statusText = 'Pending';
        let statusIcon = '⏱';

        if (user.status === 'approved') {
            statusColor = 'emerald';
            statusText = 'Approved';
            statusIcon = '✓';
        } else if (user.status === 'rejected') {
            statusColor = 'rose';
            statusText = 'Rejected';
            statusIcon = '✗';
        }

        return `
            <div onclick="openUserModal(${user.id})" class="cursor-pointer bg-slate-900 border border-slate-800 hover:border-${statusColor}-500/30 rounded-xl p-6 transition-all hover:shadow-lg hover:shadow-${statusColor}-500/10">
                <div class="flex items-start justify-between">
                    <div class="flex items-start space-x-4 flex-1">
                        <div class="w-12 h-12 bg-${statusColor}-500/10 border border-${statusColor}-500/20 rounded-full flex items-center justify-center flex-shrink-0">
                            <span class="text-lg font-bold text-${statusColor}-500">${user.name.charAt(0)}</span>
                        </div>
                        <div class="flex-1">
                            <h3 class="text-lg font-semibold text-slate-100">${user.name}</h3>
                            <p class="text-sm text-slate-400">${user.email}</p>
                            <p class="text-xs text-slate-500 mt-2">
                                Registered ${days} day${days !== 1 ? 's' : ''} ago
                            </p>
                        </div>
                    </div>
                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-${statusColor}-500/10 text-${statusColor}-500 border border-${statusColor}-500/20 whitespace-nowrap">
                        ${statusIcon} ${statusText}
                    </span>
                </div>
            </div>
        `;
    }).join('');
}

function updateStatistics() {
    const total = users.length;
    const pending = users.filter(u => u.status === 'pending').length;
    const approved = users.filter(u => u.status === 'approved').length;
    const rejected = users.filter(u => u.status === 'rejected').length;

    document.getElementById('total-users').textContent = total;
    document.getElementById('stat-pending').textContent = pending;
    document.getElementById('stat-approved').textContent = approved;
    document.getElementById('stat-rejected').textContent = rejected;
}

function updateUI() {
    updateStatistics();
    filterUsers();
}

function refreshData() {
    showNotification('Data refreshed', 'success');
    updateUI();
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

updateUI();
