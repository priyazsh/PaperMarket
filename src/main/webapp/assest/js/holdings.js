function loadHoldings() {
    const holdings = JSON.parse(localStorage.getItem('userHoldings') || '[]');
    const container = document.getElementById('holdings-container');

    if (holdings.length === 0) {
        container.innerHTML = `
            <div class="text-center py-12">
                <svg class="w-16 h-16 mx-auto text-slate-600 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"></path>
                </svg>
                <h3 class="text-xl font-semibold text-slate-100 mb-2">No Purchase Yet</h3>
                <p class="text-slate-400 mb-4">Start trading to build your portfolio</p>
                <a href="${window.contextPath || ''}/market" class="inline-block px-6 py-3 bg-emerald-500 hover:bg-emerald-600 text-white rounded-lg font-medium transition-colors">
                    Explore Market
                </a>
            </div>
        `;
    } else {
        let holdingsHTML = `
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead>
                        <tr class="border-b border-slate-800">
                            <th class="text-left text-sm font-medium text-slate-400 pb-3">Stock</th>
                            <th class="text-right text-sm font-medium text-slate-400 pb-3">Qty</th>
                            <th class="text-right text-sm font-medium text-slate-400 pb-3">Avg Price</th>
                            <th class="text-right text-sm font-medium text-slate-400 pb-3">Current Price</th>
                            <th class="text-right text-sm font-medium text-slate-400 pb-3">P&L</th>
                            <th class="text-right text-sm font-medium text-slate-400 pb-3">Value</th>
                        </tr>
                    </thead>
                    <tbody>
        `;

        holdings.forEach(holding => {
            const currentValue = holding.quantity * holding.currentPrice;
            const investedValue = holding.quantity * holding.avgPrice;
            const pnl = currentValue - investedValue;
            const pnlPercent = (pnl / investedValue) * 100;
            const isPositive = pnl >= 0;
            const pnlClass = isPositive ? 'text-emerald-400' : 'text-rose-400';
            const sign = isPositive ? '+' : '';

            holdingsHTML += `
                <tr class="border-b border-slate-800">
                    <td class="py-4">
                        <p class="text-sm font-medium text-slate-100">${holding.symbol}</p>
                        <p class="text-xs text-slate-500">${holding.name}</p>
                    </td>
                    <td class="text-right text-sm text-slate-100">${holding.quantity}</td>
                    <td class="text-right text-sm text-slate-100">₹${holding.avgPrice.toFixed(2)}</td>
                    <td class="text-right text-sm text-slate-100">₹${holding.currentPrice.toFixed(2)}</td>
                    <td class="text-right text-sm ${pnlClass}">
                        ${sign}₹${pnl.toFixed(2)}<br>
                        <span class="text-xs">(${sign}${pnlPercent.toFixed(2)}%)</span>
                    </td>
                    <td class="text-right text-sm font-medium text-slate-100">₹${currentValue.toLocaleString('en-IN', {minimumFractionDigits: 2})}</td>
                </tr>
            `;
        });

        holdingsHTML += `
                    </tbody>
                </table>
            </div>
        `;

        container.innerHTML = holdingsHTML;
    }
}

loadHoldings();
