<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="/WEB-INF/views/common/head.jsp">
	<jsp:param name="title" value="Holdings" />
</jsp:include>
<link rel="stylesheet" href="css/market.css">
</head>
<body class="bg-slate-950 min-h-screen">
	<jsp:include page="/WEB-INF/views/common/toast.jsp" />

	<!-- Trade Modal -->
	<div id="trade-modal" class="fixed inset-0 z-50 hidden">
		<div class="absolute inset-0 bg-black/60 backdrop-blur-sm"
			onclick="closeTradeModal()"></div>
		<div class="absolute inset-0 flex items-center justify-center p-4">
			<div
				class="glass border border-slate-700 rounded-2xl w-full max-w-md animate-slideUp shadow-2xl">
				<div
					class="flex items-center justify-between p-6 border-b border-slate-700">
					<div>
						<h3 id="modal-title" class="text-xl font-bold text-white">Buy
							RELIANCE</h3>
						<p id="modal-subtitle" class="text-sm text-slate-400">Reliance
							Industries</p>
					</div>
					<button onclick="closeTradeModal()"
						class="w-10 h-10 flex items-center justify-center rounded-full bg-slate-800 hover:bg-slate-700 transition-colors">
						<svg class="w-5 h-5 text-slate-400" fill="none"
							stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round"
								stroke-linejoin="round" stroke-width="2"
								d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
					</button>
				</div>

				<div class="p-6 pb-0">
					<div class="flex bg-slate-800 rounded-xl p-1">
						<button id="btn-buy-toggle" onclick="setTradeType('buy')"
							class="flex-1 py-3 rounded-lg font-semibold transition-all bg-emerald-500 text-white">Buy</button>
						<button id="btn-sell-toggle" onclick="setTradeType('sell')"
							class="flex-1 py-3 rounded-lg font-semibold transition-all text-slate-400 hover:text-white">Sell</button>
					</div>
				</div>

				<div class="p-6 space-y-5">
					<div
						class="flex items-center justify-between p-4 bg-slate-800/50 rounded-xl">
						<span class="text-slate-400">Current Price</span>
						<div class="text-right">
							<span id="modal-price" class="text-2xl font-bold text-white">₹0.00</span>
							<span id="modal-change" class="block text-sm text-emerald-400">+0.00
								(0.00%)</span>
						</div>
					</div>

					<div>
						<label class="block text-sm font-medium text-slate-300 mb-2">Quantity</label>
						<div class="flex items-center space-x-3">
							<button onclick="adjustQuantity(-1)"
								class="w-12 h-12 flex items-center justify-center bg-slate-800 hover:bg-slate-700 rounded-xl transition-colors">
								<svg class="w-5 h-5 text-white" fill="none"
									stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round"
										stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path>
                                </svg>
							</button>
							<input type="number" id="quantity-input" value="1" min="1"
								class="flex-1 h-12 px-4 bg-slate-800 border border-slate-700 rounded-xl text-white text-center text-lg font-semibold focus:outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
								oninput="updateOrderValue()">
							<button onclick="adjustQuantity(1)"
								class="w-12 h-12 flex items-center justify-center bg-slate-800 hover:bg-slate-700 rounded-xl transition-colors">
								<svg class="w-5 h-5 text-white" fill="none"
									stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round"
										stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                </svg>
							</button>
						</div>
						<div class="flex gap-2 mt-3">
							<button onclick="setQuantity(1)"
								class="flex-1 py-2 bg-slate-800 hover:bg-slate-700 rounded-lg text-sm text-slate-300 transition-colors">1</button>
							<button onclick="setQuantity(5)"
								class="flex-1 py-2 bg-slate-800 hover:bg-slate-700 rounded-lg text-sm text-slate-300 transition-colors">5</button>
							<button onclick="setQuantity(10)"
								class="flex-1 py-2 bg-slate-800 hover:bg-slate-700 rounded-lg text-sm text-slate-300 transition-colors">10</button>
							<button onclick="setQuantity(25)"
								class="flex-1 py-2 bg-slate-800 hover:bg-slate-700 rounded-lg text-sm text-slate-300 transition-colors">25</button>
							<button onclick="setQuantity(50)"
								class="flex-1 py-2 bg-slate-800 hover:bg-slate-700 rounded-lg text-sm text-slate-300 transition-colors">50</button>
						</div>
					</div>

					<div class="p-4 bg-slate-800/50 rounded-xl space-y-3">
						<div class="flex justify-between text-sm">
							<span class="text-slate-400">Price per share</span> <span
								id="summary-price" class="text-white">₹0.00</span>
						</div>
						<div class="flex justify-between text-sm">
							<span class="text-slate-400">Quantity</span> <span
								id="summary-qty" class="text-white">1</span>
						</div>
						<div class="border-t border-slate-700 pt-3 flex justify-between">
							<span class="text-slate-300 font-medium">Total Value</span> <span
								id="summary-total" class="text-xl font-bold text-white">₹0.00</span>
						</div>
					</div>
				</div>

				<div class="p-6 pt-0">
					<button id="btn-place-order" onclick="placeOrder()"
						class="w-full py-4 btn-primary text-white font-semibold rounded-xl flex items-center justify-center space-x-2">
						<svg class="w-5 h-5" fill="none" stroke="currentColor"
							viewBox="0 0 24 24">
                            <path stroke-linecap="round"
								stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
						<span>Place Buy Order</span>
					</button>
					<p class="text-center text-xs text-slate-500 mt-3">This is a
						simulated trade for educational purposes</p>
				</div>
			</div>
		</div>
	</div>

	<div class="flex h-screen">
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp">
			<jsp:param name="activePage" value="holdings" />
		</jsp:include>

		<main class="flex-1 overflow-auto">
			<header class="bg-slate-900 border-b border-slate-800 px-8 py-4">
				<div class="flex items-center justify-between">
					<div>
						<h1 class="text-2xl font-bold text-slate-100">Holdings</h1>
						<p class="text-sm text-slate-400 mt-1">Your investment
							holdings</p>
					</div>
					<div class="flex items-center space-x-4">
						<div
							class="flex items-center space-x-2 px-4 py-2 bg-emerald-500/10 border border-emerald-500/20 rounded-lg">
							<div class="w-2 h-2 bg-emerald-500 rounded-full animate-pulse"></div>
							<span class="text-sm font-medium text-emerald-500">Market
								Open</span>
						</div>
						<div class="text-sm text-slate-400">
							<div>Feb 4, 2026</div>
							<div class="text-xs text-slate-500">09:30 AM</div>
						</div>
					</div>
				</div>
			</header>

			<div class="p-8">
				<div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
					<div class="bg-slate-900 border border-slate-800 rounded-xl p-6">
						<div class="flex items-center justify-between mb-2">
							<span class="text-sm text-slate-400">Invested</span>
						</div>
						<div class="text-2xl font-bold text-slate-100"
							id="totalInvestedDisplay">₹0.00</div>
					</div>

					<div class="bg-slate-900 border border-slate-800 rounded-xl p-6">
						<div class="flex items-center justify-between mb-2">
							<span class="text-sm text-slate-400">Current</span>
						</div>
						<div class="text-2xl font-bold text-slate-100"
							id="totalCurrentDisplay">₹0.00</div>
					</div>

					<div class="bg-slate-900 border border-slate-800 rounded-xl p-6">
						<div class="flex items-center justify-between mb-2">
							<span class="text-sm text-slate-400">Total P&L</span>
						</div>
						<div class="text-2xl font-bold text-emerald-400"
							id="totalPnlDisplay">₹0.00</div>
						<div class="text-sm text-emerald-400 mt-1"
							id="totalPnlPercentDisplay">0.00%</div>
					</div>
				</div>

				<div
					class="bg-slate-900 border border-slate-800 rounded-xl p-6 mb-8">
					<h2 class="text-lg font-semibold text-slate-100 mb-6">My
						Holdings</h2>
					<div class="overflow-x-auto">
						<table class="w-full text-sm">
							<thead>
								<tr class="border-b border-slate-700 bg-slate-800/50">
									<th
										class="px-6 py-3 text-left text-xs font-semibold text-slate-300 uppercase tracking-wider">Stock</th>
									<th
										class="px-6 py-3 text-right text-xs font-semibold text-slate-300 uppercase tracking-wider">Quantity</th>
									<th
										class="px-6 py-3 text-right text-xs font-semibold text-slate-300 uppercase tracking-wider">Avg
										Price</th>
									<th
										class="px-6 py-3 text-right text-xs font-semibold text-slate-300 uppercase tracking-wider">Live
										Price</th>
									<th
										class="px-6 py-3 text-right text-xs font-semibold text-slate-300 uppercase tracking-wider">Invested</th>
									<th
										class="px-6 py-3 text-right text-xs font-semibold text-slate-300 uppercase tracking-wider">Current
										Value</th>
									<th
										class="px-6 py-3 text-right text-xs font-semibold text-slate-300 uppercase tracking-wider">P&L</th>
									<th
										class="px-6 py-3 text-right text-xs font-semibold text-slate-300 uppercase tracking-wider">Action</th>
								</tr>
							</thead>
							<tbody>
								<%@ page import="in.cs.daoimpl.StocksDaoImpl"%>
								<%@ page import="in.cs.dao.StocksDao"%>
								<%@ page import="in.cs.pojo.UserHolding"%>
								<%@ page import="java.util.List"%>
								<%
								double totalInvestment = 0;
								double totalCurrent = 0;

								List<UserHolding> holdings = (List<UserHolding>) request.getAttribute("list");
								StocksDao std = new StocksDaoImpl();

								if (holdings != null && !holdings.isEmpty()) {
									for (UserHolding h : holdings) {
										double qty = h.getQty();
										double basePrice = h.getPrice();
										double livePrice = std.getLivePrice(h.getStock().getSymbol());
										double invested = qty * basePrice;
										double current = qty * livePrice;

										totalInvestment += invested;
										totalCurrent += current;

										double pnl = current - invested;
										double pnlPercent = (pnl / invested) * 100;
										String pnlClass = pnl >= 0 ? "text-emerald-400" : "text-red-400";
										String symbol = h.getStock().getSymbol();
										String name = h.getStock().getName();
								%>
								<tr
									class="border-b border-slate-800 hover:bg-slate-800/50 transition-colors group">
									<td class="px-6 py-4 text-slate-100 font-medium"><%=symbol%></td>
									<td class="px-6 py-4 text-slate-300 text-right"><%=String.format("%.2f", qty)%></td>
									<td class="px-6 py-4 text-slate-300 text-right">₹<%=String.format("%.2f", basePrice)%></td>
									<td class="px-6 py-4 text-slate-300 text-right">₹<%=String.format("%.2f", livePrice)%></td>
									<td class="px-6 py-4 text-slate-300 text-right">₹<%=String.format("%.2f", invested)%></td>
									<td class="px-6 py-4 text-slate-300 text-right">₹<%=String.format("%.2f", current)%></td>
									<td class="px-6 py-4 text-right font-medium <%=pnlClass%>">
										₹<%=String.format("%.2f", pnl)%> <span class="text-xs">(<%=String.format("%.2f", pnlPercent)%>%)
									</span>
									</td>
									<td class="px-6 py-4 text-right">
										<div
											class="flex items-center justify-end space-x-2 opacity-0 group-hover:opacity-100 transition-opacity">
											<button
												onclick="openTradeModal('<%=symbol%>', '<%=name.replace("'", "\\'")%>', <%=livePrice%>, <%=pnl%>, <%=pnlPercent%>, 'buy')"
												class="px-3 py-1.5 bg-emerald-500 hover:bg-emerald-600 text-white text-xs font-semibold rounded-lg transition-all hover:scale-105">Buy</button>
											<button
												onclick="openTradeModal('<%=symbol%>', '<%=name.replace("'", "\\'")%>', <%=livePrice%>, <%=pnl%>, <%=pnlPercent%>, 'sell')"
												class="px-3 py-1.5 bg-slate-700 hover:bg-red-500 text-slate-300 hover:text-white text-xs font-semibold rounded-lg transition-all hover:scale-105">Sell</button>
										</div>
									</td>
								</tr>
								<%
								}
								} else {
								%>
								<tr>
									<td colspan="8" class="px-6 py-8 text-center text-slate-400">
										<p class="text-sm">No holdings yet. Start investing to see
											your portfolio here.</p>
									</td>
								</tr>
								<%
								}
								%>

								<%
								double totalPnl = totalCurrent - totalInvestment;

								double totalPnlPercent = 0;
								if (totalInvestment != 0) {
									totalPnlPercent = (totalPnl / totalInvestment) * 100;
								}

								String totalPnlClass = totalPnl >= 0 ? "text-emerald-400" : "text-red-400";
								%>

								<!-- Pass totals to JavaScript -->
								<script>
                                    var serverTotalInvestment = <%=totalInvestment%>;
                                    var serverTotalCurrent = <%=totalCurrent%>;
                                    var serverTotalPnl = <%=totalPnl%>;
                                    var serverTotalPnlPercent = <%=totalPnlPercent%>;
                                </script>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</main>
	</div>

	<script>
        var basePath = (typeof contextPath !== 'undefined' && contextPath !== null) ? contextPath : (window.contextPath || '');
        var currentTradeStock = null;
        var currentTradeType = 'buy';

        // Format currency
        function formatCurrency(value) {
            return '₹' + value.toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        }

        // Update totals display using server values
        function updateTotalsDisplay() {
            var totalInvested = typeof serverTotalInvestment !== 'undefined' ? serverTotalInvestment : 0;
            var totalCurrent = typeof serverTotalCurrent !== 'undefined' ? serverTotalCurrent : 0;
            var totalPnl = typeof serverTotalPnl !== 'undefined' ? serverTotalPnl : (totalCurrent - totalInvested);
            var totalPnlPercent = typeof serverTotalPnlPercent !== 'undefined' ? serverTotalPnlPercent : (totalInvested > 0 ? (totalPnl / totalInvested) * 100 : 0);
            
            var pnlColor = totalPnl >= 0 ? 'text-emerald-400' : 'text-red-400';
            var bgColor = totalPnl >= 0 ? 'bg-emerald-500/10' : 'bg-red-500/10';

            document.getElementById('totalInvestedDisplay').textContent = formatCurrency(totalInvested);
            document.getElementById('totalCurrentDisplay').textContent = formatCurrency(totalCurrent);
            document.getElementById('totalPnlDisplay').textContent = formatCurrency(totalPnl);
            document.getElementById('totalPnlDisplay').className = 'text-2xl font-bold ' + pnlColor;
            document.getElementById('totalPnlPercentDisplay').textContent = totalPnlPercent.toFixed(2) + '%';
            document.getElementById('totalPnlPercentDisplay').className = 'text-sm ' + pnlColor + ' mt-1';
        }

        // Initialize when DOM is ready
        document.addEventListener('DOMContentLoaded', function() {
            updateTotalsDisplay();
        });

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
                placeBtn.innerHTML = '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg><span>Place Buy Order</span>';
            } else {
                sellBtn.className = 'flex-1 py-3 rounded-lg font-semibold transition-all bg-red-500 text-white';
                buyBtn.className = 'flex-1 py-3 rounded-lg font-semibold transition-all text-slate-400 hover:text-white';
                placeBtn.className = 'w-full py-4 btn-danger text-white font-semibold rounded-xl flex items-center justify-center space-x-2';
                placeBtn.innerHTML = '<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg><span>Place Sell Order</span>';
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

            fetch(basePath + '/trade/' + currentTradeType, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'symbol=' + encodeURIComponent(currentTradeStock.symbol) +
                      '&quantity=' + encodeURIComponent(qty)
            })
            .then(response => response.text())
            .then(data => {
                closeTradeModal();
                showToast(data, 'success');
            })
            .catch(error => {
                showToast("Trade failed", 'error');
            });
        }

        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeTradeModal();
            }
        });
    </script>
</body>
</html>
