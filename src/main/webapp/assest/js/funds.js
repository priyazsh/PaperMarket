function showToast(message, type = 'success') {
    const container = document.getElementById('toast-container');
    const toast = document.createElement('div');
    const colors = {
        success: 'bg-emerald-500',
        error: 'bg-red-500',
        warning: 'bg-amber-500',
        info: 'bg-blue-500'
    };
    const icons = {
        success: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>',
        error: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>',
        warning: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path>',
        info: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>'
    };

    toast.className = `flex items-center space-x-3 px-5 py-4 ${colors[type]} text-white rounded-xl shadow-2xl toast-enter min-w-[320px]`;
    toast.innerHTML = `
        <svg class="w-6 h-6 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">${icons[type]}</svg>
        <span class="font-medium">${message}</span>
    `;

    container.appendChild(toast);

    setTimeout(() => {
        toast.classList.remove('toast-enter');
        toast.classList.add('toast-exit');
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}

let fundsData = JSON.parse(localStorage.getItem('fundsData') || '{"balance": 0, "totalDeposits": 0, "totalWithdrawals": 0, "transactions": []}');
let userHoldings = JSON.parse(localStorage.getItem('userHoldings') || '[]');

function calculateInvested() {
    return userHoldings.reduce((total, holding) => total + (holding.buyPrice * holding.quantity), 0);
}

function animateNumber(element, targetValue, prefix = '₹', duration = 500) {
    const start = parseFloat(element.textContent.replace(/[₹,]/g, '')) || 0;
    const startTime = performance.now();

    function update(currentTime) {
        const elapsed = currentTime - startTime;
        const progress = Math.min(elapsed / duration, 1);
        const easeProgress = 1 - Math.pow(1 - progress, 3);
        const current = start + (targetValue - start) * easeProgress;
        element.textContent = prefix + current.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});

        if (progress < 1) {
            requestAnimationFrame(update);
        }
    }

    requestAnimationFrame(update);
}

function updateDisplay(animate = false) {
    const invested = calculateInvested();
    const balance = fundsData.balance;
    const deposits = fundsData.totalDeposits;
    const withdrawals = fundsData.totalWithdrawals || 0;

    if (animate) {
        animateNumber(document.getElementById('available-balance'), balance);
        animateNumber(document.getElementById('invested-amount'), invested);
        animateNumber(document.getElementById('total-deposits'), deposits);
        animateNumber(document.getElementById('total-withdrawals'), withdrawals);
    } else {
        document.getElementById('available-balance').textContent = '₹' + balance.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        document.getElementById('invested-amount').textContent = '₹' + invested.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        document.getElementById('total-deposits').textContent = '₹' + deposits.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        document.getElementById('total-withdrawals').textContent = '₹' + withdrawals.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
    }

    document.getElementById('active-positions').textContent = userHoldings.length;
    document.getElementById('total-trades').textContent = fundsData.transactions.filter(t => t.type === 'trade').length || 0;
    document.getElementById('transaction-count').textContent = fundsData.transactions.length + ' transactions';

    renderTransactions();
}

function setAmount(type, amount) {
    if (amount === 'all') {
        document.getElementById(type + '-amount').value = fundsData.balance;
    } else {
        document.getElementById(type + '-amount').value = amount;
    }
    document.getElementById(type + '-amount').focus();
}

function addFunds() {
    const amount = parseFloat(document.getElementById('add-amount').value);

    if (!amount || amount <= 0) {
        showToast('Please enter a valid amount', 'error');
        return;
    }

    fundsData.balance += amount;
    fundsData.totalDeposits += amount;
    fundsData.transactions.unshift({
        date: new Date().toISOString(),
        type: 'deposit',
        description: 'Added funds to account',
        amount: amount,
        balance: fundsData.balance
    });

    localStorage.setItem('fundsData', JSON.stringify(fundsData));
    document.getElementById('add-amount').value = '';
    updateDisplay(true);

    showToast(`₹${amount.toLocaleString('en-IN')} added successfully!`, 'success');
    createConfetti();
}

function withdrawFunds() {
    const amount = parseFloat(document.getElementById('withdraw-amount').value);

    if (!amount || amount <= 0) {
        showToast('Please enter a valid amount', 'error');
        return;
    }

    if (amount > fundsData.balance) {
        showToast('Insufficient balance', 'error');
        return;
    }

    fundsData.balance -= amount;
    fundsData.totalWithdrawals = (fundsData.totalWithdrawals || 0) + amount;
    fundsData.transactions.unshift({
        date: new Date().toISOString(),
        type: 'withdrawal',
        description: 'Withdrawn from account',
        amount: amount,
        balance: fundsData.balance
    });

    localStorage.setItem('fundsData', JSON.stringify(fundsData));
    document.getElementById('withdraw-amount').value = '';
    updateDisplay(true);

    showToast(`₹${amount.toLocaleString('en-IN')} withdrawn successfully!`, 'info');
}

function clearHistory() {
    if (confirm('Are you sure you want to clear all transaction history?')) {
        fundsData.transactions = [];
        localStorage.setItem('fundsData', JSON.stringify(fundsData));
        updateDisplay();
        showToast('Transaction history cleared', 'info');
    }
}

function createConfetti() {
    const colors = ['#10b981', '#3b82f6', '#f59e0b', '#ec4899', '#8b5cf6'];
    for (let i = 0; i < 30; i++) {
        const confetti = document.createElement('div');
        confetti.className = 'confetti';
        confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
        confetti.style.left = Math.random() * 100 + 'vw';
        confetti.style.top = '50vh';
        confetti.style.animationDelay = Math.random() * 0.5 + 's';
        document.body.appendChild(confetti);
        setTimeout(() => confetti.remove(), 1500);
    }
}

function renderTransactions() {
    const tbody = document.getElementById('transactions-tbody');

    if (fundsData.transactions.length === 0) {
        tbody.innerHTML = `
            <tr>
                <td colspan="5" class="px-6 py-16 text-center">
                    <div class="w-20 h-20 mx-auto mb-4 bg-slate-800 rounded-full flex items-center justify-center">
                        <svg class="w-10 h-10 text-slate-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-slate-100 mb-2">No transactions yet</h3>
                    <p class="text-slate-400 mb-4">Add funds to start paper trading</p>
                    <button onclick="document.getElementById('add-amount').focus()" class="px-6 py-2 bg-emerald-500/10 text-emerald-500 rounded-lg hover:bg-emerald-500/20 transition-colors">
                        Add Your First Funds
                    </button>
                </td>
            </tr>
        `;
        return;
    }

    tbody.innerHTML = fundsData.transactions.map((txn, idx) => {
        const date = new Date(txn.date);
        const isDeposit = txn.type === 'deposit';
        const colorClass = isDeposit ? 'text-emerald-400' : 'text-rose-400';
        const bgClass = isDeposit ? 'bg-emerald-500/10 text-emerald-400' : 'bg-rose-500/10 text-rose-400';
        const sign = isDeposit ? '+' : '-';
        const icon = isDeposit 
            ? '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>'
            : '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path>';

        return `
            <tr class="border-b border-slate-800 hover:bg-slate-800/50 transition-all" style="animation: slideUp 0.3s ease-out ${idx * 0.05}s both">
                <td class="py-4 px-6">
                    <div class="text-sm text-slate-300">
                        ${date.toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' })}
                    </div>
                    <div class="text-xs text-slate-500">${date.toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit' })}</div>
                </td>
                <td class="py-4 px-6">
                    <span class="inline-flex items-center space-x-1.5 px-3 py-1 rounded-full text-xs font-medium ${bgClass}">
                        <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">${icon}</svg>
                        <span>${isDeposit ? 'Deposit' : 'Withdrawal'}</span>
                    </span>
                </td>
                <td class="py-4 px-6 text-sm text-slate-400">
                    ${txn.description || (isDeposit ? 'Added funds' : 'Withdrawn funds')}
                </td>
                <td class="py-4 px-6 text-right">
                    <span class="font-semibold ${colorClass}">
                        ${sign}₹${txn.amount.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2})}
                    </span>
                </td>
                <td class="py-4 px-6 text-right text-slate-300 font-medium">
                    ₹${txn.balance.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2})}
                </td>
            </tr>
        `;
    }).join('');
}

updateDisplay();
