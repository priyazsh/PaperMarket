function showToast(message, type) {
    if (type === undefined) type = 'success';
    var container = document.getElementById('toast-container');
    var toast = document.createElement('div');
    var colors = {
        success: 'bg-emerald-500',
        error: 'bg-red-500',
        warning: 'bg-amber-500',
        info: 'bg-blue-500'
    };
    var icons = {
        success: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>',
        error: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>',
        warning: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path>',
        info: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>'
    };

    toast.className = 'flex items-center space-x-3 px-4 py-3 ' + colors[type] + ' text-white rounded-xl shadow-lg min-w-[300px]';
    toast.innerHTML = '<svg class="w-5 h-5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">' + icons[type] + '</svg>' +
        '<span class="font-medium">' + message + '</span>';

    container.appendChild(toast);
    setTimeout(function() { toast.remove(); }, 3000);
}

var currentTradeStock = null;
var currentTradeType = 'buy';

function openTradeModal(symbol, name, price, change, changePercent, type) {
    if (type === undefined) type = 'buy';
    currentTradeStock = { symbol: symbol, name: name, price: price, change: change, changePercent: changePercent };
    currentTradeType = type;

    var modal = document.getElementById('trade-modal');
    var isPositive = change >= 0;
    var sign = isPositive ? '+' : '';
    var colorClass = isPositive ? 'text-emerald-400' : 'text-red-400';

    document.getElementById('modal-title').textContent = (type === 'buy' ? 'Buy' : 'Sell') + ' ' + symbol;
    document.getElementById('modal-subtitle').textContent = name;
    document.getElementById('modal-price').textContent = '₹' + price.toLocaleString('en-IN', {minimumFractionDigits: 2});
    document.getElementById('modal-change').textContent = sign + change.toFixed(2) + ' (' + sign + changePercent.toFixed(2) + '%)';
    document.getElementById('modal-change').className = 'block text-sm ' + colorClass;

    document.getElementById('quantity-input').value = 1;
    setTradeType(type);
    updateOrderValue();

    modal.classList.remove('hidden');
    document.body.style.overflow = 'hidden';
}

function closeTradeModal() {
    document.getElementById('trade-modal').classList.add('hidden');
    document.body.style.overflow = '';
    currentTradeStock = null;
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
        placeBtn.innerHTML = '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">' +
                '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>' +
            '</svg>' +
            '<span>Place Buy Order</span>';
    } else {
        sellBtn.className = 'flex-1 py-3 rounded-lg font-semibold transition-all bg-red-500 text-white';
        buyBtn.className = 'flex-1 py-3 rounded-lg font-semibold transition-all text-slate-400 hover:text-white';
        placeBtn.className = 'w-full py-4 btn-danger text-white font-semibold rounded-xl flex items-center justify-center space-x-2';
        placeBtn.innerHTML = '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">' +
                '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>' +
            '</svg>' +
            '<span>Place Sell Order</span>';
    }

    if (currentTradeStock) {
        document.getElementById('modal-title').textContent = (type === 'buy' ? 'Buy' : 'Sell') + ' ' + currentTradeStock.symbol;
    }
}

function adjustQuantity(delta) {
    var input = document.getElementById('quantity-input');
    var newVal = Math.max(1, parseInt(input.value) + delta);
    input.value = newVal;
    updateOrderValue();
}

function setQuantity(qty) {
    document.getElementById('quantity-input').value = qty;
    updateOrderValue();
}

function updateOrderValue() {
    if (!currentTradeStock) return;
    var qty = parseInt(document.getElementById('quantity-input').value) || 1;
    var total = currentTradeStock.price * qty;

    document.getElementById('summary-price').textContent = '₹' + currentTradeStock.price.toLocaleString('en-IN', {minimumFractionDigits: 2});
    document.getElementById('summary-qty').textContent = qty;
    document.getElementById('summary-total').textContent = '₹' + total.toLocaleString('en-IN', {minimumFractionDigits: 2});
}

function placeOrder() {
    if (!currentTradeStock) return;
    var qty = parseInt(document.getElementById('quantity-input').value) || 1;
    var total = currentTradeStock.price * qty;

    closeTradeModal();
    showToast((currentTradeType === 'buy' ? 'Bought' : 'Sold') + ' ' + qty + ' shares of ' + currentTradeStock.symbol + ' for ₹' + total.toLocaleString('en-IN', {minimumFractionDigits: 2}), 'success');
}

function fetchMarketData(symbol, elementId, displayName) {
    var corsProxy = 'https://corsproxy.io/?';
    var apiUrl = 'https://query1.finance.yahoo.com/v8/finance/chart/' + symbol + '?interval=1d&range=1d';
    
    fetch(corsProxy + apiUrl)
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            if (data.chart && data.chart.result && data.chart.result[0]) {
                var meta = data.chart.result[0].meta;
                var currentPrice = meta.regularMarketPrice || meta.previousClose;
                var previousClose = meta.chartPreviousClose || meta.previousClose;
                var change = currentPrice - previousClose;
                var changePercent = (change / previousClose) * 100;

                var isPositive = change >= 0;
                var colorClass = isPositive ? 'text-emerald-400' : 'text-red-400';
                var bgClass = isPositive ? 'bg-emerald-500/10' : 'bg-red-500/10';
                var sign = isPositive ? '+' : '';

                document.getElementById(elementId).innerHTML = '<p class="text-sm text-slate-400 mb-1">' + displayName + '</p>' +
                    '<p class="text-2xl font-bold text-white">' + currentPrice.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + '</p>' +
                    '<div class="flex items-center mt-1">' +
                        '<span class="text-sm ' + colorClass + ' font-medium">' + sign + change.toFixed(2) + '</span>' +
                        '<span class="ml-2 text-xs ' + colorClass + ' ' + bgClass + ' px-2 py-0.5 rounded-full">' + sign + changePercent.toFixed(2) + '%</span>' +
                    '</div>';
                document.getElementById(elementId).className = 'p-4 bg-slate-800/50 rounded-xl animate-fadeIn';
            }
        })
        .catch(function(error) {
            document.getElementById(elementId).innerHTML = '<p class="text-sm text-slate-400 mb-1">' + displayName + '</p>' +
                '<p class="text-2xl font-bold text-slate-500">--</p>' +
                '<p class="text-sm text-slate-500">Unable to load</p>';
            document.getElementById(elementId).className = 'p-4 bg-slate-800/50 rounded-xl';
        });
}

function loadMarketData() {
    fetchMarketData('^NSEI', 'nifty-data', 'NIFTY 50');
    fetchMarketData('^BSESN', 'sensex-data', 'SENSEX');
    fetchMarketData('^NSEBANK', 'banknifty-data', 'BANK NIFTY');
    fetchMarketData('^CNXIT', 'niftyit-data', 'NIFTY IT');
}

loadMarketData();
setInterval(loadMarketData, 60000);

var allStocks = [];
var watchlist = JSON.parse(localStorage.getItem('watchlist') || '[]');
var currentFilter = 'all';
var currentPage = 1;
var ITEMS_PER_PAGE = 10;
var basePath = (typeof contextPath !== 'undefined' && contextPath !== null) ? contextPath : (window.contextPath || '');

function normalizeVolume(value) {
    if (value === null || value === undefined) return 0;
    if (typeof value === 'number') return value;
    var cleaned = String(value).replace(/,/g, '').trim();
    var parsed = parseFloat(cleaned);
    return isNaN(parsed) ? 0 : parsed;
}

function hydrateStocksFromServer() {
    if (!window.serverStocks || !Array.isArray(window.serverStocks) || window.serverStocks.length === 0) {
        return false;
    }

    allStocks = window.serverStocks.map(function(stock) {
        return {
            symbol: stock.symbol || '',
            name: stock.name || '',
            volume: normalizeVolume(stock.volume),
            ltp: 0,
            change: 0,
            changePercent: 0
        };
    });

    renderStocks();
    fetchLivePrices();
    return true;
}

function loadStocksFromJSON() {
    if (hydrateStocksFromServer()) return;
    fetch(basePath + '/stocks.json')
        .then(function(response) {
            if (!response.ok) throw new Error('Failed to load');
            return response.json();
        })
        .then(function(data) {
            allStocks = data.map(function(stock) {
                return {
                    symbol: stock.symbol,
                    name: stock.name,
                    volume: normalizeVolume(stock.volume),
                    ltp: 0,
                    change: 0,
                    changePercent: 0
                };
            });
            renderStocks();
            fetchLivePrices();
        })
        .catch(function(error) {
            console.error('Error loading stocks:', error);
            showToast('Failed to load stocks', 'error');
        });
}

function fetchLivePrices() {
    var visibleStocks = allStocks.slice(0, 50);
    var corsProxy = 'https://corsproxy.io/?';
    var index = 0;

    function fetchNext() {
        if (index >= visibleStocks.length) {
            renderStocks();
            return;
        }
        var stock = visibleStocks[index];
        var apiUrl = 'https://query1.finance.yahoo.com/v8/finance/chart/' + stock.symbol + '.NS?interval=1d&range=1d';
        
        fetch(corsProxy + apiUrl)
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.chart && data.chart.result && data.chart.result[0]) {
                    var meta = data.chart.result[0].meta;
                    var currentPrice = meta.regularMarketPrice || meta.previousClose;
                    var previousClose = meta.chartPreviousClose || meta.previousClose;
                    stock.ltp = currentPrice || 0;
                    stock.change = currentPrice - previousClose || 0;
                    stock.changePercent = previousClose ? ((currentPrice - previousClose) / previousClose) * 100 : 0;
                }
            })
            .catch(function(e) {})
            .finally(function() {
                index++;
                fetchNext();
            });
    }
    fetchNext();
}

function toggleWatchlist(symbol, event) {
    if (event) event.stopPropagation();
    var index = watchlist.indexOf(symbol);
    if (index > -1) {
        watchlist.splice(index, 1);
        showToast(symbol + ' removed from watchlist', 'info');
    } else {
        watchlist.push(symbol);
        showToast(symbol + ' added to watchlist', 'success');
    }
    localStorage.setItem('watchlist', JSON.stringify(watchlist));
    renderStocks();
}

function renderStocks() {
    var filteredStocks = allStocks.slice();

    if (currentFilter === 'watchlist') {
        filteredStocks = filteredStocks.filter(function(s) { return watchlist.includes(s.symbol); });
    } else if (currentFilter === 'gainers') {
        filteredStocks = filteredStocks.filter(function(s) { return s.change > 0; }).sort(function(a, b) { return b.changePercent - a.changePercent; });
    } else if (currentFilter === 'losers') {
        filteredStocks = filteredStocks.filter(function(s) { return s.change < 0; }).sort(function(a, b) { return a.changePercent - b.changePercent; });
    }

    var searchTerm = document.getElementById('search-input').value.toLowerCase();
    if (searchTerm) {
        filteredStocks = filteredStocks.filter(function(s) {
            return s.symbol.toLowerCase().includes(searchTerm) ||
                s.name.toLowerCase().includes(searchTerm);
        });
    }

    document.getElementById('stock-count').textContent = filteredStocks.length + ' stocks';
    var tbody = document.getElementById('stocks-tbody');

    if (filteredStocks.length === 0) {
        tbody.innerHTML = '<tr>' +
                '<td colspan="7" class="px-6 py-16 text-center">' +
                    '<div class="w-20 h-20 mx-auto mb-4 bg-slate-800 rounded-full flex items-center justify-center">' +
                        '<svg class="w-10 h-10 text-slate-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">' +
                            '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>' +
                        '</svg>' +
                    '</div>' +
                    '<h3 class="text-xl font-semibold text-slate-100 mb-2">No stocks found</h3>' +
                    '<p class="text-slate-400">Try adjusting your search or filter</p>' +
                '</td>' +
            '</tr>';
        document.getElementById('pagination-container').innerHTML = '';
        return;
    }

    var totalPages = Math.ceil(filteredStocks.length / ITEMS_PER_PAGE);
    var startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
    var endIndex = Math.min(startIndex + ITEMS_PER_PAGE, filteredStocks.length);
    var pageStocks = filteredStocks.slice(startIndex, endIndex);

    tbody.innerHTML = pageStocks.map(function(stock, idx) {
        var isPositive = stock.change >= 0;
        var colorClass = isPositive ? 'text-emerald-400' : 'text-red-400';
        var bgClass = isPositive ? 'bg-emerald-500/10' : 'bg-red-500/10';
        var sign = isPositive ? '+' : '';
        var inWatchlist = watchlist.includes(stock.symbol);

        return '<tr class="hover:bg-slate-800/50 transition-all group animate-slideIn cursor-pointer" style="animation-delay: ' + (idx * 30) + 'ms" onclick="window.location.href=\'' + basePath + '/chart?symbol=' + stock.symbol + '\'">' +
                '<td class="px-6 py-4">' +
                    '<div class="flex items-center space-x-3">' +
                        '<button onclick="toggleWatchlist(\'' + stock.symbol + '\', event); event.stopPropagation();" class="hover:scale-125 transition-transform">' +
                            '<svg class="w-5 h-5 ' + (inWatchlist ? 'text-yellow-500 fill-yellow-500' : 'text-slate-600 hover:text-yellow-500') + '" fill="' + (inWatchlist ? 'currentColor' : 'none') + '" stroke="currentColor" viewBox="0 0 24 24">' +
                                '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"></path>' +
                            '</svg>' +
                        '</button>' +
                        '<div class="w-10 h-10 bg-slate-800 rounded-xl flex items-center justify-center">' +
                            '<span class="text-sm font-bold text-slate-300">' + stock.symbol.charAt(0) + '</span>' +
                        '</div>' +
                        '<span class="font-semibold text-white">' + stock.symbol + '</span>' +
                    '</div>' +
                '</td>' +
                '<td class="px-6 py-4">' +
                    '<span class="text-sm text-slate-400">' + stock.name + '</span>' +
                '</td>' +
                '<td class="px-6 py-4 text-right">' +
                    '<span class="text-white font-semibold">' + (stock.ltp ? '₹' + stock.ltp.toLocaleString('en-IN', {minimumFractionDigits: 2}) : '--') + '</span>' +
                '</td>' +
                '<td class="px-6 py-4 text-right">' +
                    '<span class="' + colorClass + ' font-medium">' + (stock.ltp ? sign + stock.change.toFixed(2) : '--') + '</span>' +
                '</td>' +
                '<td class="px-6 py-4 text-right">' +
                    (stock.ltp ? '<span class="' + colorClass + ' ' + bgClass + ' px-2 py-1 rounded-lg text-sm font-medium">' + sign + stock.changePercent.toFixed(2) + '%</span>' : '--') +
                '</td>' +
                '<td class="px-6 py-4 text-right">' +
                    '<span class="text-slate-400 text-sm">' + (stock.volume ? (stock.volume / 1000000).toFixed(2) + 'M' : '--') + '</span>' +
                '</td>' +
                '<td class="px-6 py-4 text-right">' +
                    '<div class="flex items-center justify-end space-x-2 opacity-0 group-hover:opacity-100 transition-opacity">' +
                        '<button onclick="event.stopPropagation(); openTradeModal(\'' + stock.symbol + '\', \'' + stock.name.replace(/'/g, "\\'") + '\', ' + (stock.ltp || 0) + ', ' + (stock.change || 0) + ', ' + (stock.changePercent || 0) + ', \'buy\')" class="px-4 py-2 bg-emerald-500 hover:bg-emerald-600 text-white text-sm font-semibold rounded-lg transition-all hover:scale-105">Buy</button>' +
                        '<button onclick="event.stopPropagation(); openTradeModal(\'' + stock.symbol + '\', \'' + stock.name.replace(/'/g, "\\'") + '\', ' + (stock.ltp || 0) + ', ' + (stock.change || 0) + ', ' + (stock.changePercent || 0) + ', \'sell\')" class="px-4 py-2 bg-slate-700 hover:bg-red-500 text-slate-300 hover:text-white text-sm font-semibold rounded-lg transition-all hover:scale-105">Sell</button>' +
                    '</div>' +
                '</td>' +
            '</tr>';
    }).join('');

    if (totalPages > 1) {
        document.getElementById('pagination-container').innerHTML = '<div class="flex items-center justify-between px-6 py-4 border-t border-slate-800 bg-slate-800/30">' +
                '<span class="text-sm text-slate-400">Showing ' + (startIndex + 1) + '-' + endIndex + ' of ' + filteredStocks.length + '</span>' +
                '<div class="flex items-center gap-2">' +
                    '<button onclick="goToPage(1)" ' + (currentPage === 1 ? 'disabled' : '') + ' class="p-2 bg-slate-800 hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed text-slate-300 rounded-lg transition-colors">' +
                        '<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 19l-7-7 7-7m8 14l-7-7 7-7"></path></svg>' +
                    '</button>' +
                    '<button onclick="goToPage(' + (currentPage - 1) + ')" ' + (currentPage === 1 ? 'disabled' : '') + ' class="p-2 bg-slate-800 hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed text-slate-300 rounded-lg transition-colors">' +
                        '<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path></svg>' +
                    '</button>' +
                    '<span class="px-4 py-2 text-slate-300 text-sm font-medium">' + currentPage + ' / ' + totalPages + '</span>' +
                    '<button onclick="goToPage(' + (currentPage + 1) + ')" ' + (currentPage === totalPages ? 'disabled' : '') + ' class="p-2 bg-slate-800 hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed text-slate-300 rounded-lg transition-colors">' +
                        '<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>' +
                    '</button>' +
                    '<button onclick="goToPage(' + totalPages + ')" ' + (currentPage === totalPages ? 'disabled' : '') + ' class="p-2 bg-slate-800 hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed text-slate-300 rounded-lg transition-colors">' +
                        '<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 5l7 7-7 7M5 5l7 7-7 7"></path></svg>' +
                    '</button>' +
                '</div>' +
            '</div>';
    } else {
        document.getElementById('pagination-container').innerHTML = '';
    }
}

function goToPage(page) {
    var totalStocks = allStocks.length;
    var totalPages = Math.ceil(totalStocks / ITEMS_PER_PAGE);
    if (page >= 1 && page <= totalPages) {
        currentPage = page;
        renderStocks();
    }
}

['all', 'watchlist', 'gainers', 'losers'].forEach(function(filter) {
    document.getElementById('btn-' + filter).addEventListener('click', function() {
        currentFilter = filter;
        currentPage = 1;
        updateFilterButtons();
        renderStocks();
    });
});

function updateFilterButtons() {
    var configs = {
        all: { active: 'px-5 py-2.5 bg-emerald-500/10 text-emerald-500 border border-emerald-500/20 rounded-xl font-medium text-sm transition-all', inactive: 'px-5 py-2.5 text-slate-400 hover:text-white hover:bg-slate-800 border border-slate-700 rounded-xl text-sm transition-all' },
        watchlist: { active: 'px-5 py-2.5 bg-yellow-500/10 text-yellow-500 border border-yellow-500/20 rounded-xl font-medium text-sm transition-all flex items-center space-x-2', inactive: 'px-5 py-2.5 text-slate-400 hover:text-white hover:bg-slate-800 border border-slate-700 rounded-xl text-sm transition-all flex items-center space-x-2' },
        gainers: { active: 'px-5 py-2.5 bg-emerald-500/10 text-emerald-500 border border-emerald-500/20 rounded-xl font-medium text-sm transition-all flex items-center space-x-2', inactive: 'px-5 py-2.5 text-slate-400 hover:text-emerald-400 hover:bg-emerald-500/10 border border-slate-700 hover:border-emerald-500/20 rounded-xl text-sm transition-all flex items-center space-x-2' },
        losers: { active: 'px-5 py-2.5 bg-red-500/10 text-red-500 border border-red-500/20 rounded-xl font-medium text-sm transition-all flex items-center space-x-2', inactive: 'px-5 py-2.5 text-slate-400 hover:text-red-400 hover:bg-red-500/10 border border-slate-700 hover:border-red-500/20 rounded-xl text-sm transition-all flex items-center space-x-2' }
    };

    Object.keys(configs).forEach(function(key) {
        var btn = document.getElementById('btn-' + key);
        btn.className = key === currentFilter ? configs[key].active : configs[key].inactive;
    });
}

document.getElementById('search-input').addEventListener('input', function() {
    currentPage = 1;
    renderStocks();
});

document.addEventListener('click', function(e) {
    var container = document.querySelector('.relative.w-96');
    if (container && !container.contains(e.target)) {
        document.getElementById('search-results').classList.add('hidden');
    }
});

document.addEventListener('keydown', function(e) {
    if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
        e.preventDefault();
        document.getElementById('search-input').focus();
    }
    if (e.key === 'Escape') {
        closeTradeModal();
    }
});

loadStocksFromJSON();

var niftyChart = null;
var sensexChart = null;

function fetchChartData(symbol) {
    return new Promise(function(resolve) {
        var corsProxy = 'https://corsproxy.io/?';
        fetch(corsProxy + 'https://query1.finance.yahoo.com/v8/finance/chart/' + symbol + '?interval=1wk&range=1y')
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.chart && data.chart.result && data.chart.result[0]) {
                    var result = data.chart.result[0];
                    resolve({
                        labels: result.timestamp.map(function(ts) { return new Date(ts * 1000).toLocaleDateString('en-IN', { month: 'short', year: '2-digit' }); }),
                        data: result.indicators.quote[0].close
                    });
                } else {
                    resolve(null);
                }
            })
            .catch(function(error) {
                resolve(null);
            });
    });
}

function initCharts() {
    if (niftyChart) niftyChart.destroy();
    if (sensexChart) sensexChart.destroy();

    var chartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        animation: { duration: 1000, easing: 'easeOutQuart' },
        plugins: {
            legend: { display: false },
            tooltip: {
                mode: 'index',
                intersect: false,
                backgroundColor: 'rgba(15, 23, 42, 0.9)',
                titleColor: '#f1f5f9',
                bodyColor: '#cbd5e1',
                borderColor: '#334155',
                borderWidth: 1,
                padding: 12,
                cornerRadius: 8
            }
        },
        scales: {
            x: { grid: { color: 'rgba(51, 65, 85, 0.3)' }, ticks: { color: '#64748b', maxTicksLimit: 8 } },
            y: { grid: { color: 'rgba(51, 65, 85, 0.3)' }, ticks: { color: '#64748b' } }
        },
        interaction: { mode: 'nearest', axis: 'x', intersect: false }
    };

    fetchChartData('^NSEI').then(function(niftyData) {
        if (niftyData) {
            var niftyOptions = JSON.parse(JSON.stringify(chartOptions));
            niftyOptions.scales.y.min = 21000;
            niftyOptions.scales.y.max = 27000;
            niftyChart = new Chart(document.getElementById('nifty-chart').getContext('2d'), {
                type: 'line',
                data: {
                    labels: niftyData.labels,
                    datasets: [{
                        label: 'NIFTY 50',
                        data: niftyData.data,
                        borderColor: '#10b981',
                        backgroundColor: 'rgba(16, 185, 129, 0.1)',
                        tension: 0.4,
                        fill: true,
                        borderWidth: 2,
                        pointRadius: 0,
                        pointHoverRadius: 6,
                        pointHoverBackgroundColor: '#10b981'
                    }]
                },
                options: niftyOptions
            });
        }

        return fetchChartData('^BSESN');
    }).then(function(sensexData) {
        if (sensexData) {
            var sensexOptions = JSON.parse(JSON.stringify(chartOptions));
            sensexOptions.scales.y.min = 72000;
            sensexOptions.scales.y.max = 86000;
            sensexChart = new Chart(document.getElementById('sensex-chart').getContext('2d'), {
                type: 'line',
                data: {
                    labels: sensexData.labels,
                    datasets: [{
                        label: 'SENSEX',
                        data: sensexData.data,
                        borderColor: '#3b82f6',
                        backgroundColor: 'rgba(59, 130, 246, 0.1)',
                        tension: 0.4,
                        fill: true,
                        borderWidth: 2,
                        pointRadius: 0,
                        pointHoverRadius: 6,
                        pointHoverBackgroundColor: '#3b82f6'
                    }]
                },
                options: sensexOptions
            });
        }
    });
}

window.addEventListener('load', initCharts);