<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp">
        <jsp:param name="title" value="Stock Detail"/>
    </jsp:include>
    <link rel="stylesheet" href="css/chart.css">
</head>
<body class="bg-slate-950 min-h-screen">
    <div id="toast-container" class="fixed top-4 right-4 z-[100] space-y-3"></div>

    <div id="trade-modal" class="fixed inset-0 z-50 hidden">
        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="closeTradeModal()"></div>
        <div class="absolute inset-0 flex items-center justify-center p-4">
            <div class="bg-slate-900 border border-slate-700 rounded-2xl w-full max-w-md animate-slideUp shadow-2xl">
                <div class="flex items-center justify-between p-6 border-b border-slate-700">
                    <div>
                        <h3 id="modal-title" class="text-xl font-bold text-white">Buy RELIANCE</h3>
                        <p id="modal-subtitle" class="text-sm text-slate-400">Reliance Industries</p>
                    </div>
                    <button onclick="closeTradeModal()" class="w-10 h-10 flex items-center justify-center rounded-full bg-slate-800 hover:bg-slate-700 transition-colors">
                        <svg class="w-5 h-5 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>
                <div class="p-6 pb-0">
                    <div class="flex bg-slate-800 rounded-xl p-1">
                        <button id="btn-buy-toggle" onclick="setTradeType('buy')" class="flex-1 py-3 rounded-lg font-semibold transition-all bg-emerald-500 text-white">Buy</button>
                        <button id="btn-sell-toggle" onclick="setTradeType('sell')" class="flex-1 py-3 rounded-lg font-semibold transition-all text-slate-400 hover:text-white">Sell</button>
                    </div>
                </div>
                <div class="p-6 space-y-5">
                    <div class="flex items-center justify-between p-4 bg-slate-800/50 rounded-xl">
                        <span class="text-slate-400">Current Price</span>
                        <div class="text-right">
                            <span id="modal-price" class="text-2xl font-bold text-white">₹0.00</span>
                            <span id="modal-change" class="block text-sm text-emerald-400"></span>
                        </div>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-300 mb-2">Quantity</label>
                        <div class="flex items-center space-x-3">
                            <button onclick="adjustQuantity(-1)" class="w-12 h-12 flex items-center justify-center bg-slate-800 hover:bg-slate-700 rounded-xl transition-colors">
                                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path></svg>
                            </button>
                            <input type="number" id="quantity-input" value="1" min="1" class="flex-1 h-12 px-4 bg-slate-800 border border-slate-700 rounded-xl text-white text-center text-lg font-semibold focus:outline-none focus:border-emerald-500" oninput="updateOrderValue()">
                            <button onclick="adjustQuantity(1)" class="w-12 h-12 flex items-center justify-center bg-slate-800 hover:bg-slate-700 rounded-xl transition-colors">
                                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
                            </button>
                        </div>
                        <div class="flex gap-2 mt-3">
                            <button onclick="setQuantity(1)" class="flex-1 py-2 bg-slate-800 hover:bg-slate-700 rounded-lg text-sm text-slate-300 transition-colors">1</button>
                            <button onclick="setQuantity(5)" class="flex-1 py-2 bg-slate-800 hover:bg-slate-700 rounded-lg text-sm text-slate-300 transition-colors">5</button>
                            <button onclick="setQuantity(10)" class="flex-1 py-2 bg-slate-800 hover:bg-slate-700 rounded-lg text-sm text-slate-300 transition-colors">10</button>
                            <button onclick="setQuantity(25)" class="flex-1 py-2 bg-slate-800 hover:bg-slate-700 rounded-lg text-sm text-slate-300 transition-colors">25</button>
                            <button onclick="setQuantity(50)" class="flex-1 py-2 bg-slate-800 hover:bg-slate-700 rounded-lg text-sm text-slate-300 transition-colors">50</button>
                        </div>
                    </div>
                    <div class="p-4 bg-slate-800/50 rounded-xl space-y-3">
                        <div class="flex justify-between text-sm">
                            <span class="text-slate-400">Price per share</span>
                            <span id="summary-price" class="text-white">₹0.00</span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-slate-400">Quantity</span>
                            <span id="summary-qty" class="text-white">1</span>
                        </div>
                        <div class="border-t border-slate-700 pt-3 flex justify-between">
                            <span class="text-slate-300 font-medium">Total Value</span>
                            <span id="summary-total" class="text-xl font-bold text-white">₹0.00</span>
                        </div>
                    </div>
                </div>
                <div class="p-6 pt-0">
                    <button id="btn-place-order" onclick="placeOrder()" class="w-full py-4 btn-primary text-white font-semibold rounded-xl flex items-center justify-center space-x-2">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>
                        <span>Place Buy Order</span>
                    </button>
                    <p class="text-center text-xs text-slate-500 mt-3">Simulated trade for educational purposes</p>
                </div>
            </div>
        </div>
    </div>

    <div class="flex h-screen">
        <jsp:include page="/WEB-INF/views/common/sidebar.jsp">
            <jsp:param name="activePage" value="market"/>
        </jsp:include>

        <main class="flex-1 overflow-auto">
            <header class="bg-slate-900/80 backdrop-blur-lg border-b border-slate-800 px-8 py-4 sticky top-0 z-30">
                <div class="flex items-center justify-between">
                    <div class="flex items-center space-x-4">
                        <a href="market" class="w-10 h-10 flex items-center justify-center bg-slate-800 hover:bg-slate-700 rounded-xl transition-colors">
                            <svg class="w-5 h-5 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
                            </svg>
                        </a>
                        <div>
                            <div class="flex items-center space-x-3">
                                <h1 id="stock-symbol" class="text-2xl font-bold text-slate-100">Loading...</h1>
                                <button id="watchlist-btn" onclick="toggleWatchlist()" class="p-2 rounded-lg hover:bg-slate-800 transition-colors">
                                    <svg id="watchlist-icon" class="w-6 h-6 text-slate-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"></path>
                                    </svg>
                                </button>
                            </div>
                            <p id="stock-name" class="text-sm text-slate-400">Loading stock data...</p>
                        </div>
                    </div>
                    <div class="flex items-center space-x-3">
                        <button onclick="openTradeModal('buy')" class="px-6 py-2.5 btn-primary text-white font-semibold rounded-xl flex items-center space-x-2">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path></svg>
                            <span>Buy</span>
                        </button>
                        <button onclick="openTradeModal('sell')" class="px-6 py-2.5 bg-slate-800 hover:bg-red-500 text-slate-300 hover:text-white font-semibold rounded-xl transition-all flex items-center space-x-2">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path></svg>
                            <span>Sell</span>
                        </button>
                    </div>
                </div>
            </header>

            <div class="p-8">
                <div class="mb-8 animate-slideUp">
                    <div class="flex items-end space-x-4 mb-2">
                        <h2 id="current-price" class="text-5xl font-bold text-white">--</h2>
                        <div id="price-change" class="flex items-center space-x-2 pb-2">
                            <span class="skeleton w-24 h-6 rounded"></span>
                        </div>
                    </div>
                    <p class="text-slate-500 text-sm">NSE · Last updated: <span id="last-updated">--</span></p>
                </div>

                <div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 mb-8 hover-lift animate-slideUp" style="animation-delay: 0.1s">
                    <div class="flex items-center justify-between mb-6">
                        <h3 class="text-lg font-semibold text-slate-100">Price Chart</h3>
                        <div class="flex items-center space-x-2">
                            <button onclick="changeTimeframe('1d')" data-tf="1d" class="timeframe-btn px-4 py-2 text-sm font-medium text-slate-400 hover:text-white border border-slate-700 rounded-lg transition-all">1D</button>
                            <button onclick="changeTimeframe('1w')" data-tf="1w" class="timeframe-btn px-4 py-2 text-sm font-medium text-slate-400 hover:text-white border border-slate-700 rounded-lg transition-all">1W</button>
                            <button onclick="changeTimeframe('1m')" data-tf="1m" class="timeframe-btn px-4 py-2 text-sm font-medium text-slate-400 hover:text-white border border-slate-700 rounded-lg transition-all active">1M</button>
                            <button onclick="changeTimeframe('3m')" data-tf="3m" class="timeframe-btn px-4 py-2 text-sm font-medium text-slate-400 hover:text-white border border-slate-700 rounded-lg transition-all">3M</button>
                            <button onclick="changeTimeframe('1y')" data-tf="1y" class="timeframe-btn px-4 py-2 text-sm font-medium text-slate-400 hover:text-white border border-slate-700 rounded-lg transition-all">1Y</button>
                            <button onclick="changeTimeframe('5y')" data-tf="5y" class="timeframe-btn px-4 py-2 text-sm font-medium text-slate-400 hover:text-white border border-slate-700 rounded-lg transition-all">5Y</button>
                        </div>
                    </div>

                    <div id="chart-loading" class="h-[400px] flex items-center justify-center">
                        <div class="text-center">
                            <div class="w-12 h-12 border-4 border-emerald-500/30 border-t-emerald-500 rounded-full animate-spin mx-auto mb-4"></div>
                            <p class="text-slate-400">Loading chart data...</p>
                        </div>
                    </div>
                    <div id="chart-container" class="hidden" style="position: relative; height: 400px;">
                        <canvas id="price-chart"></canvas>
                    </div>
                </div>

                <div class="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
                    <div class="stat-card border border-slate-800 rounded-xl p-5 hover-lift animate-slideUp" style="animation-delay: 0.2s">
                        <p class="text-slate-400 text-sm mb-1">Open</p>
                        <p id="stat-open" class="text-xl font-bold text-white">--</p>
                    </div>
                    <div class="stat-card border border-slate-800 rounded-xl p-5 hover-lift animate-slideUp" style="animation-delay: 0.25s">
                        <p class="text-slate-400 text-sm mb-1">High</p>
                        <p id="stat-high" class="text-xl font-bold text-emerald-400">--</p>
                    </div>
                    <div class="stat-card border border-slate-800 rounded-xl p-5 hover-lift animate-slideUp" style="animation-delay: 0.3s">
                        <p class="text-slate-400 text-sm mb-1">Low</p>
                        <p id="stat-low" class="text-xl font-bold text-red-400">--</p>
                    </div>
                    <div class="stat-card border border-slate-800 rounded-xl p-5 hover-lift animate-slideUp" style="animation-delay: 0.35s">
                        <p class="text-slate-400 text-sm mb-1">Prev Close</p>
                        <p id="stat-prev-close" class="text-xl font-bold text-white">--</p>
                    </div>
                    <div class="stat-card border border-slate-800 rounded-xl p-5 hover-lift animate-slideUp" style="animation-delay: 0.4s">
                        <p class="text-slate-400 text-sm mb-1">52W High</p>
                        <p id="stat-52w-high" class="text-xl font-bold text-emerald-400">--</p>
                    </div>
                    <div class="stat-card border border-slate-800 rounded-xl p-5 hover-lift animate-slideUp" style="animation-delay: 0.45s">
                        <p class="text-slate-400 text-sm mb-1">52W Low</p>
                        <p id="stat-52w-low" class="text-xl font-bold text-red-400">--</p>
                    </div>
                    <div class="stat-card border border-slate-800 rounded-xl p-5 hover-lift animate-slideUp" style="animation-delay: 0.5s">
                        <p class="text-slate-400 text-sm mb-1">Volume</p>
                        <p id="stat-volume" class="text-xl font-bold text-white">--</p>
                    </div>
                    <div class="stat-card border border-slate-800 rounded-xl p-5 hover-lift animate-slideUp" style="animation-delay: 0.55s">
                        <p class="text-slate-400 text-sm mb-1">Market Cap</p>
                        <p id="stat-market-cap" class="text-xl font-bold text-white">--</p>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 hover-lift animate-slideUp" style="animation-delay: 0.6s">
                        <h3 class="text-lg font-semibold text-slate-100 mb-4">About</h3>
                        <div class="space-y-3">
                            <div class="flex justify-between py-2 border-b border-slate-800">
                                <span class="text-slate-400">Exchange</span>
                                <span class="text-white font-medium">NSE</span>
                            </div>
                            <div class="flex justify-between py-2 border-b border-slate-800">
                                <span class="text-slate-400">Currency</span>
                                <span class="text-white font-medium">INR</span>
                            </div>
                            <div class="flex justify-between py-2 border-b border-slate-800">
                                <span class="text-slate-400">Sector</span>
                                <span id="stat-sector" class="text-white font-medium">--</span>
                            </div>
                            <div class="flex justify-between py-2">
                                <span class="text-slate-400">Industry</span>
                                <span id="stat-industry" class="text-white font-medium">--</span>
                            </div>
                        </div>
                    </div>

                    <div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 hover-lift animate-slideUp" style="animation-delay: 0.65s">
                        <h3 class="text-lg font-semibold text-slate-100 mb-4">Key Metrics</h3>
                        <div class="space-y-3">
                            <div class="flex justify-between py-2 border-b border-slate-800">
                                <span class="text-slate-400">P/E Ratio</span>
                                <span id="stat-pe" class="text-white font-medium">--</span>
                            </div>
                            <div class="flex justify-between py-2 border-b border-slate-800">
                                <span class="text-slate-400">EPS</span>
                                <span id="stat-eps" class="text-white font-medium">--</span>
                            </div>
                            <div class="flex justify-between py-2 border-b border-slate-800">
                                <span class="text-slate-400">Dividend Yield</span>
                                <span id="stat-dividend" class="text-white font-medium">--</span>
                            </div>
                            <div class="flex justify-between py-2">
                                <span class="text-slate-400">Beta</span>
                                <span id="stat-beta" class="text-white font-medium">--</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        const urlParams = new URLSearchParams(window.location.search);
        const stockSymbol = urlParams.get('symbol') || 'RELIANCE';

        let stockData = null;
        let priceChart = null;
        let currentTimeframe = '1m';
        let watchlist = JSON.parse(localStorage.getItem('watchlist') || '[]');

        function showToast(message, type = 'success') {
            const container = document.getElementById('toast-container');
            const toast = document.createElement('div');
            const colors = { success: 'bg-emerald-500', error: 'bg-red-500', warning: 'bg-amber-500', info: 'bg-blue-500' };
            const icons = {
                success: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>',
                error: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>',
                info: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>'
            };
            toast.className = `flex items-center space-x-3 px-5 py-4 ${colors[type]} text-white rounded-xl shadow-2xl toast-enter min-w-[300px]`;
            toast.innerHTML = `<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">${icons[type]}</svg><span class="font-medium">${message}</span>`;
            container.appendChild(toast);
            setTimeout(() => { toast.classList.remove('toast-enter'); toast.classList.add('toast-exit'); setTimeout(() => toast.remove(), 300); }, 3000);
        }

        async function fetchStockData() {
            try {
                const corsProxy = 'https://corsproxy.io/?';
                const apiUrl = `https://query1.finance.yahoo.com/v8/finance/chart/${stockSymbol}.NS?interval=1d&range=1d`;
                const response = await fetch(corsProxy + apiUrl);
                const data = await response.json();

                if (data.chart?.result?.[0]) {
                    const result = data.chart.result[0];
                    const meta = result.meta;
                    const quote = result.indicators.quote[0];

                    stockData = {
                        symbol: stockSymbol,
                        name: meta.longName || meta.shortName || stockSymbol,
                        price: meta.regularMarketPrice || meta.previousClose,
                        prevClose: meta.chartPreviousClose || meta.previousClose,
                        open: quote.open?.[0] || meta.regularMarketPrice,
                        high: quote.high?.[0] || meta.regularMarketDayHigh,
                        low: quote.low?.[0] || meta.regularMarketDayLow,
                        volume: meta.regularMarketVolume || 0,
                        fiftyTwoWeekHigh: meta.fiftyTwoWeekHigh,
                        fiftyTwoWeekLow: meta.fiftyTwoWeekLow
                    };

                    updateUI();
                }
            } catch (error) {
                console.error('Error fetching stock data:', error);
                stockData = { symbol: stockSymbol, name: stockSymbol, price: 0 };
                document.getElementById('stock-symbol').textContent = stockSymbol;
                document.getElementById('stock-name').textContent = 'Unable to load stock data';
            }
        }

        function updateUI() {
            if (!stockData) return;

            const change = stockData.price - stockData.prevClose;
            const changePercent = (change / stockData.prevClose) * 100;
            const isPositive = change >= 0;
            const sign = isPositive ? '+' : '';
            const colorClass = isPositive ? 'text-emerald-400' : 'text-red-400';
            const bgClass = isPositive ? 'bg-emerald-500/10' : 'bg-red-500/10';

            document.getElementById('stock-symbol').textContent = stockData.symbol;
            document.getElementById('stock-name').textContent = stockData.name;
            document.getElementById('current-price').textContent = '₹' + stockData.price.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
            document.getElementById('current-price').classList.add('pulse-price');
            setTimeout(() => document.getElementById('current-price').classList.remove('pulse-price'), 300);

            document.getElementById('price-change').innerHTML = `
                <span class="${colorClass} font-semibold">${sign}₹${Math.abs(change).toFixed(2)}</span>
                <span class="${colorClass} ${bgClass} px-2 py-1 rounded-lg text-sm font-medium">${sign}${changePercent.toFixed(2)}%</span>
            `;

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

        async function fetchChartData(timeframe) {
            const intervals = { '1d': '5m', '1w': '15m', '1m': '1d', '3m': '1d', '1y': '1wk', '5y': '1mo' };
            const ranges = { '1d': '1d', '1w': '5d', '1m': '1mo', '3m': '3mo', '1y': '1y', '5y': '5y' };

            try {
                const corsProxy = 'https://corsproxy.io/?';
                const apiUrl = `https://query1.finance.yahoo.com/v8/finance/chart/${stockSymbol}.NS?interval=${intervals[timeframe]}&range=${ranges[timeframe]}`;
                const response = await fetch(corsProxy + apiUrl);
                const data = await response.json();

                if (data.chart?.result?.[0]) {
                    const result = data.chart.result[0];
                    const timestamps = result.timestamp || [];
                    const prices = result.indicators.quote[0].close || [];

                    return {
                        labels: timestamps.map(ts => {
                            const date = new Date(ts * 1000);
                            if (timeframe === '1d') return date.toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit' });
                            if (timeframe === '1w') return date.toLocaleDateString('en-IN', { weekday: 'short', hour: '2-digit', minute: '2-digit' });
                            return date.toLocaleDateString('en-IN', { day: '2-digit', month: 'short' });
                        }),
                        data: prices.filter(p => p !== null)
                    };
                }
                return null;
            } catch (error) {
                console.error('Error fetching chart data:', error);
                return null;
            }
        }

        async function initChart(timeframe = '1m') {
            document.getElementById('chart-loading').classList.remove('hidden');
            document.getElementById('chart-container').classList.add('hidden');

            const chartData = await fetchChartData(timeframe);

            if (chartData && chartData.data.length > 0) {
                document.getElementById('chart-loading').classList.add('hidden');
                document.getElementById('chart-container').classList.remove('hidden');

                if (priceChart) priceChart.destroy();

                const isPositive = chartData.data[chartData.data.length - 1] >= chartData.data[0];
                const lineColor = isPositive ? '#10b981' : '#ef4444';
                const bgColor = isPositive ? 'rgba(16, 185, 129, 0.1)' : 'rgba(239, 68, 68, 0.1)';

                const ctx = document.getElementById('price-chart').getContext('2d');
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
                                    label: (ctx) => '₹' + ctx.parsed.y.toLocaleString('en-IN', {minimumFractionDigits: 2})
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
                                    callback: (value) => '₹' + value.toLocaleString('en-IN')
                                }
                            }
                        },
                        interaction: { mode: 'nearest', axis: 'x', intersect: false }
                    }
                });
            }
        }

        function changeTimeframe(tf) {
            currentTimeframe = tf;
            document.querySelectorAll('.timeframe-btn').forEach(btn => {
                btn.classList.remove('active');
                if (btn.dataset.tf === tf) btn.classList.add('active');
            });
            initChart(tf);
        }

        function toggleWatchlist() {
            const index = watchlist.indexOf(stockSymbol);
            if (index > -1) {
                watchlist.splice(index, 1);
                showToast(`${stockSymbol} removed from watchlist`, 'info');
            } else {
                watchlist.push(stockSymbol);
                showToast(`${stockSymbol} added to watchlist`, 'success');
            }
            localStorage.setItem('watchlist', JSON.stringify(watchlist));
            updateWatchlistButton();
        }

        function updateWatchlistButton() {
            const icon = document.getElementById('watchlist-icon');
            const inWatchlist = watchlist.includes(stockSymbol);
            icon.classList.toggle('text-yellow-500', inWatchlist);
            icon.classList.toggle('fill-yellow-500', inWatchlist);
            icon.classList.toggle('text-slate-500', !inWatchlist);
            icon.setAttribute('fill', inWatchlist ? 'currentColor' : 'none');
        }

        let currentTradeType = 'buy';

        function openTradeModal(type = 'buy') {
            currentTradeType = type;
            const modal = document.getElementById('trade-modal');

            document.getElementById('modal-title').textContent = `${type === 'buy' ? 'Buy' : 'Sell'} ${stockSymbol}`;
            document.getElementById('modal-subtitle').textContent = stockData?.name || stockSymbol;
            document.getElementById('modal-price').textContent = stockData ? '₹' + stockData.price.toLocaleString('en-IN', {minimumFractionDigits: 2}) : '--';

            if (stockData) {
                const change = stockData.price - stockData.prevClose;
                const changePercent = (change / stockData.prevClose) * 100;
                const isPositive = change >= 0;
                const sign = isPositive ? '+' : '';
                document.getElementById('modal-change').textContent = `${sign}${change.toFixed(2)} (${sign}${changePercent.toFixed(2)}%)`;
                document.getElementById('modal-change').className = `block text-sm ${isPositive ? 'text-emerald-400' : 'text-red-400'}`;
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
            const buyBtn = document.getElementById('btn-buy-toggle');
            const sellBtn = document.getElementById('btn-sell-toggle');
            const placeBtn = document.getElementById('btn-place-order');

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
            document.getElementById('modal-title').textContent = `${type === 'buy' ? 'Buy' : 'Sell'} ${stockSymbol}`;
        }

        function adjustQuantity(delta) {
            const input = document.getElementById('quantity-input');
            input.value = Math.max(1, parseInt(input.value) + delta);
            updateOrderValue();
        }

        function setQuantity(qty) {
            document.getElementById('quantity-input').value = qty;
            updateOrderValue();
        }

        function updateOrderValue() {
            if (!stockData) return;
            const qty = parseInt(document.getElementById('quantity-input').value) || 1;
            const total = stockData.price * qty;
            document.getElementById('summary-price').textContent = '₹' + stockData.price.toLocaleString('en-IN', {minimumFractionDigits: 2});
            document.getElementById('summary-qty').textContent = qty;
            document.getElementById('summary-total').textContent = '₹' + total.toLocaleString('en-IN', {minimumFractionDigits: 2});
        }

        function placeOrder() {
            if (!stockData) return;
            const qty = parseInt(document.getElementById('quantity-input').value) || 1;
            const total = stockData.price * qty;
            closeTradeModal();
            showToast(`${currentTradeType === 'buy' ? 'Bought' : 'Sold'} ${qty} shares of ${stockSymbol} for ₹${total.toLocaleString('en-IN', {minimumFractionDigits: 2})}`, 'success');
        }

        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') closeTradeModal();
            if (e.key === 'b' && !document.getElementById('trade-modal').classList.contains('hidden') === false) openTradeModal('buy');
            if (e.key === 's' && !document.getElementById('trade-modal').classList.contains('hidden') === false) openTradeModal('sell');
        });

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="js/chart.js"></script>
</body>
</html>
