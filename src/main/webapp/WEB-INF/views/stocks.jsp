<%@page import="in.cs.pojo.Stocks"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="/WEB-INF/views/common/head.jsp">
	<jsp:param name="title" value="Stocks Management - Admin" />
</jsp:include>
</head>
<body class="bg-slate-950 min-h-screen">
	<div class="flex h-screen">
		<!-- Sidebar -->
		<aside
			class="w-64 bg-slate-900 border-r border-slate-800 flex flex-col">
			<!-- Logo -->
			<div class="p-6 border-b border-slate-800">
				<div class="flex items-center space-x-3">
					<div
						class="w-10 h-10 bg-emerald-500/10 border border-emerald-500/20 rounded-lg flex items-center justify-center">
						<svg class="w-6 h-6 text-emerald-500" fill="none"
							stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round"
								stroke-linejoin="round" stroke-width="2"
								d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                        </svg>
					</div>
					<div>
						<span class="text-xl font-bold text-slate-100">Paper Market</span>
						<p class="text-xs text-amber-500 font-medium">ADMIN PANEL</p>
					</div>
				</div>
			</div>

			<!-- Navigation -->
			<nav class="flex-1 p-4 space-y-1">
				<a href="${pageContext.request.contextPath}/admin"
					class="flex items-center space-x-3 px-4 py-3 text-slate-400 hover:text-slate-100 hover:bg-slate-800 rounded-lg transition-colors">
					<svg class="w-5 h-5" fill="none" stroke="currentColor"
						viewBox="0 0 24 24">
                        <path stroke-linecap="round"
							stroke-linejoin="round" stroke-width="2"
							d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
                    </svg> <span>Users</span>
				</a> <a href="${pageContext.request.contextPath}/admin/stocks"
					class="flex items-center space-x-3 px-4 py-3 bg-emerald-500/10 text-emerald-500 border border-emerald-500/20 rounded-lg font-medium">
					<svg class="w-5 h-5" fill="none" stroke="currentColor"
						viewBox="0 0 24 24">
                        <path stroke-linecap="round"
							stroke-linejoin="round" stroke-width="2"
							d="M3 3v18h18M7 14l3-3 3 3 5-6"></path>
                    </svg> <span>Stocks</span>
				</a>
			</nav>

			<!-- Admin Profile -->
			<div class="p-4 border-t border-slate-800">
				<div
					class="flex items-center space-x-3 px-4 py-3 bg-slate-800 rounded-lg">
					<div
						class="w-10 h-10 bg-amber-500 rounded-full flex items-center justify-center">
						<span class="text-sm font-bold text-white">AD</span>
					</div>
					<div class="flex-1">
						<p class="text-sm font-medium text-slate-100">Admin</p>
						<p class="text-xs text-slate-500">admin@papermarket.com</p>
					</div>
				</div>
				<a href="${pageContext.request.contextPath}/logout"
					class="w-full mt-3 px-4 py-2 bg-slate-950 hover:bg-slate-800 text-slate-400 hover:text-slate-100 text-sm rounded-lg transition-colors flex items-center justify-center">
					<svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor"
						viewBox="0 0 24 24">
                        <path stroke-linecap="round"
							stroke-linejoin="round" stroke-width="2"
							d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                    </svg> Logout
				</a>
			</div>
		</aside>

		<main class="flex-1 overflow-auto">
			<header class="bg-slate-900 border-b border-slate-800 px-8 py-6">
				<div>
					<h1 class="text-2xl font-bold text-slate-100">Stocks
						Management</h1>
					<p class="text-sm text-slate-400 mt-1">Add and manage stock
						listings</p>
				</div>
			</header>

			<div class="p-8">
				<div class="bg-slate-900 border border-slate-800 rounded-2xl p-6">
					<!-- Header with Add Button -->
					<div class="flex items-center justify-between mb-6">
						<div>
							<h2 class="text-lg font-semibold text-slate-100">All Stocks</h2>
							<p class="text-xs text-slate-400 mt-1">Manage your stock
								listings</p>
						</div>
						<button onclick="openModal()"
							class="px-6 py-2.5 bg-emerald-500 hover:bg-emerald-600 text-white font-semibold rounded-lg transition-colors flex items-center space-x-2">
							<svg class="w-5 h-5" fill="none" stroke="currentColor"
								viewBox="0 0 24 24">
                                <path stroke-linecap="round"
									stroke-linejoin="round" stroke-width="2"
									d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                            </svg>
							<span>Add Stock</span>
						</button>
					</div>

					<%
					String success = (String) request.getAttribute("success");
					String error=(String)request.getAttribute("error");
					if (success != null) {
					%>
					<script>
                         alert("<%=success%>");
					</script>
					<%
					}  if(error!=null){
					%>
					<script>
                         alert("<%=error%>
						");
					</script>
					<%} %>

					<!-- Stocks List -->
					<div
						class="bg-slate-950 border border-slate-800 rounded-lg overflow-hidden">
						<!-- Table Header -->
						<div
							class="grid grid-cols-12 gap-4 px-6 py-3 bg-slate-900 border-b border-slate-800">
							<div
								class="col-span-2 text-xs font-semibold text-slate-400 uppercase">Symbol</div>
							<div
								class="col-span-5 text-xs font-semibold text-slate-400 uppercase">Name</div>
							<div
								class="col-span-3 text-xs font-semibold text-slate-400 uppercase">Volume</div>
							<div
								class="col-span-2 text-xs font-semibold text-slate-400 uppercase text-right">Actions</div>
						</div>

						<%String delete=(String)request.getAttribute("delete");
								if(delete!=null){
								%>
						<script>
						alert("<%=delete%>");
						</script>

						<%} %>
						<!-- Table Body -->
						<ul>
							<!-- Static item - loop here later -->
							<%
							List<Stocks> stock = (List<Stocks>) request.getAttribute("list");
							if (stock != null && !stock.isEmpty()) {

								for (Stocks s : stock) {
							%>

							<li
								class="grid grid-cols-12 gap-4 px-6 py-4 border-b border-slate-800 hover:bg-slate-900/50 transition-colors items-center">
								<div class="col-span-2">
									<span class="font-mono text-sm font-bold text-emerald-400">
										<%=s.getSymbol()%>
									</span>
								</div>
								<div class="col-span-5">
									<span class="text-sm text-slate-300"> <%=s.getName()%>
									</span>
								</div>
								<div class="col-span-3">
									<span class="text-sm text-slate-400"> <%=s.getVolume()%>
									</span>
								</div>
								<div class="col-span-2 text-right">

									<form
										action="${pageContext.request.contextPath}/admin/stocks/delete"
										method="post" class="inline">
										<input type="hidden" name="stockSymbol"
											value="<%=s.getSymbol()%>" />
										<button type="submit"
											class="px-3 py-1.5 bg-rose-500 hover:bg-rose-600 text-white text-xs font-semibold rounded-lg transition-colors inline-flex items-center space-x-1">
											<svg class="w-3.5 h-3.5" fill="none" stroke="currentColor"
												viewBox="0 0 24 24">
                                                <path
													stroke-linecap="round" stroke-linejoin="round"
													stroke-width="2"
													d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                            </svg>
											<span>Delete</span>
										</button>
									</form>
								</div>
							</li>
							<%
							}
							} else {
							%>
							<p class="text-slate-400 text-center mt-10">No users found</p>
							<%
							}
							%>




						</ul>
					</div>
				</div>
			</div>
		</main>
	</div>

	<!-- Add Stock Modal -->
	<div id="addStockModal"
		class="hidden fixed inset-0 bg-black/70 backdrop-blur-sm z-50 flex items-center justify-center">
		<div
			class="bg-slate-900 border border-slate-800 rounded-2xl p-6 w-full max-w-md mx-4">
			<div class="flex items-center justify-between mb-6">
				<h3 class="text-xl font-bold text-slate-100">Add New Stock</h3>
				<button onclick="closeModal()"
					class="text-slate-400 hover:text-slate-100 transition-colors">
					<svg class="w-6 h-6" fill="none" stroke="currentColor"
						viewBox="0 0 24 24">
                        <path stroke-linecap="round"
							stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
				</button>
			</div>

			<form action="${pageContext.request.contextPath}/admin/stocks/add"
				method="post" class="space-y-4">
				<div>
					<label class="block text-sm font-medium text-slate-300 mb-2">Symbol
						*</label> <input type="text" name="symbol" placeholder="e.g., RELIANCE"
						class="w-full px-4 py-2.5 bg-slate-950 border border-slate-800 rounded-lg text-slate-100 placeholder-slate-500 focus:outline-none focus:border-emerald-500"
						required>
				</div>
				<div>
					<label class="block text-sm font-medium text-slate-300 mb-2">Name
						*</label> <input type="text" name="name"
						placeholder="e.g., Reliance Industries"
						class="w-full px-4 py-2.5 bg-slate-950 border border-slate-800 rounded-lg text-slate-100 placeholder-slate-500 focus:outline-none focus:border-emerald-500"
						required>
				</div>
				<div>
					<label class="block text-sm font-medium text-slate-300 mb-2">Volume
						*</label> <input type="number" name="volume" placeholder="e.g., 2450000"
						min="0"
						class="w-full px-4 py-2.5 bg-slate-950 border border-slate-800 rounded-lg text-slate-100 placeholder-slate-500 focus:outline-none focus:border-emerald-500"
						required>
				</div>

				<div class="flex space-x-3 pt-4">
					<button type="button" onclick="closeModal()"
						class="flex-1 px-6 py-2.5 bg-slate-950 hover:bg-slate-800 text-slate-300 font-semibold rounded-lg transition-colors">
						Cancel</button>
					<button type="submit"
						class="flex-1 px-6 py-2.5 bg-emerald-500 hover:bg-emerald-600 text-white font-semibold rounded-lg transition-colors">
						Add Stock</button>
				</div>
			</form>
		</div>
	</div>

	<script>
		function openModal() {
			document.getElementById('addStockModal').classList.remove('hidden');
		}

		function closeModal() {
			document.getElementById('addStockModal').classList.add('hidden');
		}

		// Close modal on backdrop click
		document.getElementById('addStockModal').addEventListener('click',
				function(e) {
					if (e.target === this) {
						closeModal();
					}
				});

		// Close modal on Escape key
		document.addEventListener('keydown', function(e) {
			if (e.key === 'Escape') {
				closeModal();
			}
		});
	</script>
</body>
</html>
