var urlParams = new URLSearchParams(window.location.search);
var stockSymbol = urlParams.get('symbol') || 'RELIANCE';

var stockData = null;
var priceChart = null;
var currentTimeframe = '1m';
var watchlist = JSON.parse(localStorage.getItem('watchlist') || '[]');

function showToast(message, type) {
    if (type === undefined) type = 'success';
    var container = document.getElementById('toast-container');
    var toast = document.createElement('div');
    var colors = { success: 'bg-emerald-500', error: 'bg-red-500', warning: 'bg-amber-500', info: 'bg-blue-500' };
    var icons = {
        success: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>',
        error: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>',
        info: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>'
    };
    toast.className = 'flex items-center space-x-3 px-5 py-4 ' + colors[type] + ' text-white rounded-xl shadow-2xl toast-enter min-w-[300px]';
    toast.innerHTML = '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">' + icons[type] + '</svg><span class="font-medium">' + message + '</span>';
    container.appendChild(toast);
    setTimeout(function() { toast.classList.remove('toast-enter'); toast.classList.add('toast-exit'); setTimeout(function() { toast.remove(); }, 300); }, 3000);
}

function fetchStockData() {
    var corsProxy = 'https://corsproxy.io/?';
    var apiUrl = corsProxy + 'https://query1.finance.yahoo.com/v8/finance/chart/' + stockSymbol + '.NS?interval=1d&range=1d';
    
    fetch(apiUrl)
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            if (data.chart && data.chart.result && data.chart.result[0]) {
                var result = data.chart.result[0];
                var meta = result.meta;
                var quote = result.indicators.quote[0];

                stockData = {
                    symbol: stockSymbol,
                    name: meta.longName || meta.shortName || stockSymbol,
                    price: meta.regularMarketPrice || meta.previousClose,
                    prevClose: meta.chartPreviousClose || meta.previousClose,
                    open: (quote.open && quote.open[0]) ? quote.open[0] : meta.regularMarketPrice,
                    high: (quote.high && quote.high[0]) ? quote.high[0] : meta.regularMarketDayHigh,
                    low: (quote.low && quote.low[0]) ? quote.low[0] : meta.regularMarketDayLow,
                    volume: meta.regularMarketVolume || 0,
                    fiftyTwoWeekHigh: meta.fiftyTwoWeekHigh,
                    fiftyTwoWeekLow: meta.fiftyTwoWeekLow
                };

                updateUI();
            }
        })
        .catch(function(error) {
            console.error('Error fetching stock data:', error);
            stockData = { symbol: stockSymbol, name: stockSymbol, price: 0 };
            document.getElementById('stock-symbol').textContent = stockSymbol;
            document.getElementById('stock-name').textContent = 'Unable to load stock data';
        });
}

function updateUI() {
    if (!stockData) return;

    var change = stockData.price - stockData.prevClose;
    var changePercent = (change / stockData.prevClose) * 100;
    var isPositive = change >= 0;
    var sign = isPositive ? '+' : '';
    var colorClass = isPositive ? 'text-emerald-400' : 'text-red-400';
    var bgClass = isPositive ? 'bg-emerald-500/10' : 'bg-red-500/10';

    document.getElementById('stock-symbol').textContent = stockData.symbol;
    document.getElementById('stock-name').textContent = stockData.name;
    document.getElementById('current-price').textContent = '₹' + stockData.price.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
    document.getElementById('current-price').classList.add('pulse-price');
    setTimeout(function() { document.getElementById('current-price').classList.remove('pulse-price'); }, 300);

    document.getElementById('price-change').innerHTML = '<span class="' + colorClass + ' font-semibold">' + sign + '₹' + Math.abs(change).toFixed(2) + '</span>' +
        '<span class="' + colorClass + ' ' + bgClass + ' px-2 py-1 rounded-lg text-sm font-medium">' + sign + changePercent.toFixed(2) + '%</span>';

    document.getElementById('last-updated').textContent = new Date().toLocaleTimeString('en-IN');

    document.getElementById('stat-open').textContent = stockData.open ? '₹' + stockData.open.toLocaleString('en-IN', {minimumFractionDigits: 2}) : '--';
    document.getElementById('stat-high').textContent = stockData.high ? '₹' + stockData.high.toLocaleString('en-IN', {minimumFractionDigits: 2}) : '--';
    document.getElementById('stat-low').textContent = stockData.low ? '₹' + stockData.low.toLocaleString('en-IN', {minimumFractionDigits: 2}) : '--';
    document.getElementById('stat-prev-close').textContent = stockData.prevClose ? '₹' + stockData.prevClose.toLocaleString('en-IN', {minimumFractionDigits: 2}) : '--';
    document.getElementById('stat-52w-high').textContent = stockData.fiftyTwoWeekHigh ? '₹' + stockData.fiftyTwoWeekHigh.toLocaleString('en-IN', {minimumFractionDigits: 2}) : '--';
    document.getElementById('stat-52w-low').textContent = stockData.fiftyTwoWeekLow ? '₹' + stockData.fiftyTwoWeekLow.toLocaleString('en-IN', {minimumFractionDigits: 2}) : '--';
    document.getElementById('stat-volume').textContent = stockData.volume ? (stockData.volume / 1000000).toFixed(2) + 'M' : '--';

    updateWatchlistButton();
    document.title = `${stockData.symbol} - ₹${stockData.price.toFixed(2)} | Paper Market`;
}

function fetchChartData(timeframe) {
    var intervals = { '1d': '5m', '1w': '15m', '1m': '1d', '3m': '1d', '1y': '1wk', '5y': '1mo' };
    var ranges = { '1d': '1d', '1w': '5d', '1m': '1mo', '3m': '3mo', '1y': '1y', '5y': '5y' };

    return new Promise(function(resolve) {
        var corsProxy = 'https://corsproxy.io/?';
        var apiUrl = corsProxy + 'https://query1.finance.yahoo.com/v8/finance/chart/' + stockSymbol + '.NS?interval=' + intervals[timeframe] + '&range=' + ranges[timeframe];
        
        fetch(apiUrl)
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.chart && data.chart.result && data.chart.result[0]) {
                    var result = data.chart.result[0];
                    var timestamps = result.timestamp || [];
                    var prices = result.indicators.quote[0].close || [];

                    resolve({
                        labels: timestamps.map(function(ts) {
                            var date = new Date(ts * 1000);
                            if (timeframe === '1d') return date.toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit' });
                            if (timeframe === '1w') return date.toLocaleDateString('en-IN', { weekday: 'short', hour: '2-digit', minute: '2-digit' });
                            return date.toLocaleDateString('en-IN', { day: '2-digit', month: 'short' });
                        }),
                        data: prices.filter(function(p) { return p !== null; })
                    });
                } else {
                    resolve(null);
                }
            })
            .catch(function(error) {
                console.error('Error fetching chart data:', error);
                resolve(null);
            });
    });
}

function initChart(timeframe) {
    if (timeframe === undefined) timeframe = '1m';
    document.getElementById('chart-loading').classList.remove('hidden');
    document.getElementById('chart-container').classList.add('hidden');

    fetchChartData(timeframe).then(function(chartData) {
        if (chartData && chartData.data.length > 0) {
            document.getElementById('chart-loading').classList.add('hidden');
            document.getElementById('chart-container').classList.remove('hidden');

            if (priceChart) priceChart.destroy();

            var isPositive = chartData.data[chartData.data.length - 1] >= chartData.data[0];
            var lineColor = isPositive ? '#10b981' : '#ef4444';
            var bgColor = isPositive ? 'rgba(16, 185, 129, 0.1)' : 'rgba(239, 68, 68, 0.1)';

            var ctx = document.getElementById('price-chart').getContext('2d');
            priceChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: chartData.labels,
                    datasets: [{
                        label: stockSymbol,
                        data: chartData.data,
                        borderColor: lineColor,
                        backgroundColor: bgColor,
                        tension: 0.4,
                        fill: true,
                        borderWidth: 2,
                        pointRadius: 0,
                        pointHoverRadius: 6,
                        pointHoverBackgroundColor: lineColor
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: { duration: 750, easing: 'easeOutQuart' },
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            mode: 'index',
                            intersect: false,
                            backgroundColor: 'rgba(15, 23, 42, 0.95)',
                            titleColor: '#f1f5f9',
                            bodyColor: '#cbd5e1',
                            borderColor: '#334155',
                            borderWidth: 1,
                            padding: 12,
                            cornerRadius: 8,
                            callbacks: {
                                label: function(ctx) { return '₹' + ctx.parsed.y.toLocaleString('en-IN', {minimumFractionDigits: 2}); }
                            }
                        }
                    },
                    scales: {
                        x: {
                            grid: { color: 'rgba(51, 65, 85, 0.3)' },
                            ticks: { color: '#64748b', maxTicksLimit: 8 }
                        },
                        y: {
                            grid: { color: 'rgba(51, 65, 85, 0.3)' },
                            ticks: {
                                color: '#64748b',
                                callback: function(value) { return '₹' + value.toLocaleString('en-IN'); }
                            }
                        }
                    },
                    interaction: { mode: 'nearest', axis: 'x', intersect: false }
                }
            });
        }
    });
}

function changeTimeframe(tf) {
    currentTimeframe = tf;
    document.querySelectorAll('.timeframe-btn').forEach(function(btn) {
        btn.classList.remove('active');
        if (btn.dataset.tf === tf) btn.classList.add('active');
    });
    initChart(tf);
}

function toggleWatchlist() {
    var index = watchlist.indexOf(stockSymbol);
    if (index > -1) {
        watchlist.splice(index, 1);
        showToast(stockSymbol + ' removed from watchlist', 'info');
    } else {
        watchlist.push(stockSymbol);
        showToast(stockSymbol + ' added to watchlist', 'success');
    }
    localStorage.setItem('watchlist', JSON.stringify(watchlist));
    updateWatchlistButton();
}

function updateWatchlistButton() {
    var icon = document.getElementById('watchlist-icon');
    var inWatchlist = watchlist.includes(stockSymbol);
    icon.classList.toggle('text-yellow-500', inWatchlist);
    icon.classList.toggle('fill-yellow-500', inWatchlist);
    icon.classList.toggle('text-slate-500', !inWatchlist);
    icon.setAttribute('fill', inWatchlist ? 'currentColor' : 'none');
}

var currentTradeType = 'buy';

function openTradeModal(type) {
    if (type === undefined) type = 'buy';
    currentTradeType = type;
    var modal = document.getElementById('trade-modal');

    document.getElementById('modal-title').textContent = (type === 'buy' ? 'Buy' : 'Sell') + ' ' + stockSymbol;
    document.getElementById('modal-subtitle').textContent = (stockData && stockData.name) ? stockData.name : stockSymbol;
    document.getElementById('modal-price').textContent = stockData ? '₹' + stockData.price.toLocaleString('en-IN', {minimumFractionDigits: 2}) : '--';

    if (stockData) {
        var change = stockData.price - stockData.prevClose;
        var changePercent = (change / stockData.prevClose) * 100;
        var isPositive = change >= 0;
        var sign = isPositive ? '+' : '';
        document.getElementById('modal-change').textContent = sign + change.toFixed(2) + ' (' + sign + changePercent.toFixed(2) + '%)';
        document.getElementById('modal-change').className = 'block text-sm ' + (isPositive ? 'text-emerald-400' : 'text-red-400');
    }

    document.getElementById('quantity-input').value = 1;
    setTradeType(type);
    updateOrderValue();
    modal.classList.remove('hidden');
    document.body.style.overflow = 'hidden';
}

function closeTradeModal() {
    document.getElementById('trade-modal').classList.add('hidden');
    document.body.style.overflow = '';
}

function setTradeType(type) {
    currentTradeType = type;
    var buyBtn = document.getElementById('btn-buy-toggle');
    var sellBtn = document.getElementById('btn-sell-toggle');
    var placeBtn = document.getElementById('btn-place-order');

    if (type === 'buy') {
        buyBtn.className = 'flex-1 py-3 rounded-lg font-semibold transition-all bg-emerald-500 text-white';
        sellBtn.className = 'flex-1 py-3 rounded-lg font-semibold transition-all text-slate-400 hover:text-white';
        placeBtn.className = 'w-full py-4 btn-primary text-white font-semibold rounded-xl flex items-center justify-center space-x-2';
        placeBtn.innerHTML = '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg><span>Place Buy Order</span>';
    } else {
        sellBtn.className = 'flex-1 py-3 rounded-lg font-semibold transition-all bg-red-500 text-white';
        buyBtn.className = 'flex-1 py-3 rounded-lg font-semibold transition-all text-slate-400 hover:text-white';
        placeBtn.className = 'w-full py-4 btn-danger text-white font-semibold rounded-xl flex items-center justify-center space-x-2';
        placeBtn.innerHTML = '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg><span>Place Sell Order</span>';
    }
    document.getElementById('modal-title').textContent = (type === 'buy' ? 'Buy' : 'Sell') + ' ' + stockSymbol;
}

function adjustQuantity(delta) {
    var input = document.getElementById('quantity-input');
    input.value = Math.max(1, parseInt(input.value) + delta);
    updateOrderValue();
}

function setQuantity(qty) {
    document.getElementById('quantity-input').value = qty;
    updateOrderValue();
}

function updateOrderValue() {
    if (!stockData) return;
    var qty = parseInt(document.getElementById('quantity-input').value) || 1;
    var total = stockData.price * qty;
    document.getElementById('summary-price').textContent = '₹' + stockData.price.toLocaleString('en-IN', {minimumFractionDigits: 2});
    document.getElementById('summary-qty').textContent = qty;
    document.getElementById('summary-total').textContent = '₹' + total.toLocaleString('en-IN', {minimumFractionDigits: 2});
}

function placeOrder() {
    if (!stockData) return;
    var qty = parseInt(document.getElementById('quantity-input').value) || 1;
    var total = stockData.price * qty;
    closeTradeModal();
    showToast((currentTradeType === 'buy' ? 'Bought' : 'Sold') + ' ' + qty + ' shares of ' + stockSymbol + ' for ₹' + total.toLocaleString('en-IN', {minimumFractionDigits: 2}), 'success');
}

document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') closeTradeModal();
    if (e.key === 'b' && !document.getElementById('trade-modal').classList.contains('hidden') === false) openTradeModal('buy');
    if (e.key === 's' && !document.getElementById('trade-modal').classList.contains('hidden') === false) openTradeModal('sell');
});

fetchStockData();
initChart('1m');
setInterval(fetchStockData, 30000);
