<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="/WEB-INF/views/common/head.jsp">
	<jsp:param name="title" value="Market - Paper Market" />
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
							<span id="modal-price" class="text-2xl font-bold text-white">₹2,480.00</span>
							<span id="modal-change" class="block text-sm text-emerald-400">+30.00
								(1.22%)</span>
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
								id="summary-price" class="text-white">₹2,480.00</span>
						</div>
						<div class="flex justify-between text-sm">
							<span class="text-slate-400">Quantity</span> <span
								id="summary-qty" class="text-white">1</span>
						</div>
						<div class="border-t border-slate-700 pt-3 flex justify-between">
							<span class="text-slate-300 font-medium">Total Value</span> <span
								id="summary-total" class="text-xl font-bold text-white">₹2,480.00</span>
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
			<jsp:param name="activePage" value="market" />
		</jsp:include>

		<main class="flex-1 overflow-auto">
			<header
				class="bg-slate-900/80 backdrop-blur-lg border-b border-slate-800 px-8 py-4 sticky top-0 z-30">
				<div class="flex items-center justify-between">
					<div>
						<h1 class="text-2xl font-bold text-slate-100">Market</h1>
						<p class="text-sm text-slate-400 mt-1">Browse and trade 2,296+
							Indian stocks</p>
					</div>
					<div class="flex items-center space-x-4">
						<div class="relative w-96">
							<input id="search-input" type="text"
								placeholder="Search stocks (Ctrl+K)"
								class="w-full px-4 py-2.5 pl-11 bg-slate-800 border border-slate-700 rounded-xl text-slate-100 placeholder-slate-500 focus:outline-none focus:border-emerald-500 focus:ring-2 focus:ring-emerald-500/20 transition-all"
								autocomplete="off">
							<svg class="w-5 h-5 text-slate-500 absolute left-4 top-3"
								fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round"
									stroke-linejoin="round" stroke-width="2"
									d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                            </svg>
							<div id="search-results"
								class="absolute top-full left-0 right-0 bg-slate-800 border border-slate-700 rounded-xl mt-2 max-h-96 overflow-y-auto z-50 hidden shadow-2xl"></div>
						</div>

						<div
							class="flex items-center space-x-2 px-4 py-2.5 bg-emerald-500/10 border border-emerald-500/20 rounded-xl">
							<div class="relative w-2 h-2">
								<div
									class="absolute inset-0 bg-emerald-500 rounded-full animate-ping"></div>
								<div class="relative w-2 h-2 bg-emerald-500 rounded-full"></div>
							</div>
							<span class="text-sm font-medium text-emerald-500">Market
								Open</span>
						</div>
					</div>
				</div>
			</header>

			<div class="p-8">
				<div
					class="bg-slate-900 border border-slate-800 rounded-2xl p-6 mb-8 hover-lift">
					<div class="flex items-center justify-between mb-6">
						<h2 class="text-lg font-semibold text-slate-100">Market
							Overview</h2>
						<div class="flex items-center space-x-2 text-xs text-slate-500">
							<div class="relative w-2 h-2">
								<div
									class="absolute inset-0 bg-emerald-500 rounded-full animate-ping opacity-75"></div>
								<div class="relative w-2 h-2 bg-emerald-500 rounded-full"></div>
							</div>
							<span>Live Data</span>
						</div>
					</div>
					<div class="grid grid-cols-1 md:grid-cols-4 gap-6">
						<div id="nifty-data" class="p-4 bg-slate-800/50 rounded-xl">
							<div class="skeleton h-4 w-16 mb-2 rounded"></div>
							<div class="skeleton h-7 w-28 mb-1 rounded"></div>
							<div class="skeleton h-4 w-20 rounded"></div>
						</div>
						<div id="sensex-data" class="p-4 bg-slate-800/50 rounded-xl">
							<div class="skeleton h-4 w-16 mb-2 rounded"></div>
							<div class="skeleton h-7 w-28 mb-1 rounded"></div>
							<div class="skeleton h-4 w-20 rounded"></div>
						</div>
						<div id="banknifty-data" class="p-4 bg-slate-800/50 rounded-xl">
							<div class="skeleton h-4 w-20 mb-2 rounded"></div>
							<div class="skeleton h-7 w-28 mb-1 rounded"></div>
							<div class="skeleton h-4 w-20 rounded"></div>
						</div>
						<div id="niftyit-data" class="p-4 bg-slate-800/50 rounded-xl">
							<div class="skeleton h-4 w-16 mb-2 rounded"></div>
							<div class="skeleton h-7 w-28 mb-1 rounded"></div>
							<div class="skeleton h-4 w-20 rounded"></div>
						</div>
					</div>
				</div>

				<div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
					<div
						class="bg-slate-900 border border-slate-800 rounded-2xl p-6 hover-lift">
						<div class="flex items-center justify-between mb-4">
							<h3 class="text-lg font-semibold text-slate-100">NIFTY 50</h3>
							<span
								class="text-xs text-slate-500 bg-slate-800 px-2 py-1 rounded">1Y</span>
						</div>
						<div style="position: relative; width: 100%; height: 250px;">
							<canvas id="nifty-chart"></canvas>
						</div>
					</div>

					<div
						class="bg-slate-900 border border-slate-800 rounded-2xl p-6 hover-lift">
						<div class="flex items-center justify-between mb-4">
							<h3 class="text-lg font-semibold text-slate-100">SENSEX</h3>
							<span
								class="text-xs text-slate-500 bg-slate-800 px-2 py-1 rounded">1Y</span>
						</div>
						<div style="position: relative; width: 100%; height: 250px;">
							<canvas id="sensex-chart"></canvas>
						</div>
					</div>
				</div>

				<div class="flex items-center justify-between mb-6">
					<div class="flex items-center space-x-3">
						<button id="btn-all"
							class="px-5 py-2.5 bg-emerald-500/10 text-emerald-500 border border-emerald-500/20 rounded-xl font-medium text-sm transition-all hover:bg-emerald-500/20">All
							Stocks</button>
						<button id="btn-watchlist"
							class="px-5 py-2.5 text-slate-400 hover:text-white hover:bg-slate-800 border border-slate-700 rounded-xl text-sm transition-all flex items-center space-x-2">
							<svg class="w-4 h-4" fill="none" stroke="currentColor"
								viewBox="0 0 24 24">
                                <path stroke-linecap="round"
									stroke-linejoin="round" stroke-width="2"
									d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"></path>
                            </svg>
							<span>Watchlist</span>
						</button>
						<button id="btn-gainers"
							class="px-5 py-2.5 text-slate-400 hover:text-emerald-400 hover:bg-emerald-500/10 border border-slate-700 hover:border-emerald-500/20 rounded-xl text-sm transition-all flex items-center space-x-2">
							<svg class="w-4 h-4" fill="none" stroke="currentColor"
								viewBox="0 0 24 24">
                                <path stroke-linecap="round"
									stroke-linejoin="round" stroke-width="2"
									d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
                            </svg>
							<span>Top Gainers</span>
						</button>
						<button id="btn-losers"
							class="px-5 py-2.5 text-slate-400 hover:text-red-400 hover:bg-red-500/10 border border-slate-700 hover:border-red-500/20 rounded-xl text-sm transition-all flex items-center space-x-2">
							<svg class="w-4 h-4" fill="none" stroke="currentColor"
								viewBox="0 0 24 24">
                                <path stroke-linecap="round"
									stroke-linejoin="round" stroke-width="2"
									d="M13 17h8m0 0v-8m0 8l-8-8-4 4-6-6"></path>
                            </svg>
							<span>Top Losers</span>
						</button>
					</div>
					<div id="stock-count" class="text-sm text-slate-500"></div>
				</div>

				<div
					class="bg-slate-900 border border-slate-800 rounded-2xl overflow-hidden">
					<table class="w-full">
						<thead>
							<tr class="border-b border-slate-800 bg-slate-800/30">
								<th
									class="text-left px-6 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Symbol</th>
								<th
									class="text-left px-6 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Company</th>
								<th
									class="text-right px-6 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">LTP</th>
								<th
									class="text-right px-6 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Change</th>
								<th
									class="text-right px-6 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">%
									Change</th>
								<th
									class="text-right px-6 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Volume</th>
								<th
									class="text-right px-6 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Action</th>
							</tr>
						</thead>
						<tbody id="stocks-tbody" class="divide-y divide-slate-800">
							<tr>
								<td colspan="7" class="px-6 py-4"><div
										class="skeleton h-10 w-full rounded"></div></td>
							</tr>
							<tr>
								<td colspan="7" class="px-6 py-4"><div
										class="skeleton h-10 w-full rounded"></div></td>
							</tr>
							<tr>
								<td colspan="7" class="px-6 py-4"><div
										class="skeleton h-10 w-full rounded"></div></td>
							</tr>
							<tr>
								<td colspan="7" class="px-6 py-4"><div
										class="skeleton h-10 w-full rounded"></div></td>
							</tr>
							<tr>
								<td colspan="7" class="px-6 py-4"><div
										class="skeleton h-10 w-full rounded"></div></td>
							</tr>
						</tbody>
					</table>
					<div id="pagination-container"></div>
				</div>
			</div>

			<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
			<script src="js/market.js"></script>
</body>
</html>
