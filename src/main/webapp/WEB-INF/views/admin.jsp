<%@page import="in.cs.EnumClass.userStatus"%>
<%@page import="in.cs.pojo.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="/WEB-INF/views/common/head.jsp">
	<jsp:param name="title" value="Admin Panel" />
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
					class="flex items-center space-x-3 px-4 py-3 bg-emerald-500/10 text-emerald-500 border border-emerald-500/20 rounded-lg font-medium">
					<svg class="w-5 h-5" fill="none" stroke="currentColor"
						viewBox="0 0 24 24">
                        <path stroke-linecap="round"
							stroke-linejoin="round" stroke-width="2"
							d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
                    </svg> <span>Users</span>
				</a> <a href="${pageContext.request.contextPath}/admin/stocks"
					class="flex items-center space-x-3 px-4 py-3 text-slate-400 hover:text-slate-100 hover:bg-slate-800 rounded-lg transition-colors">
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

		<!-- Main Content -->
		<main class="flex-1 overflow-auto">
			<!-- Header -->
			<header class="bg-slate-900 border-b border-slate-800 px-8 py-6">
				<div class="flex items-center justify-between mb-6">
					<div>
						<h1 class="text-2xl font-bold text-slate-100">Account
							Management</h1>
						<p class="text-sm text-slate-400 mt-1">Review and approve user
							registrations</p>
					</div>
				</div>

				<!-- Stats Grid -->
				<div class="grid grid-cols-4 gap-4">
					<div class="bg-slate-950 border border-slate-800 rounded-lg p-4">
						<p class="text-xs text-slate-500 mb-1">Total Users</p>
						<p class="text-2xl font-bold text-slate-100">${totalUsers}</p>
					</div>
					<div class="bg-slate-950 border border-amber-500/20 rounded-lg p-4">
						<p class="text-xs text-amber-500 mb-1">Pending</p>
						<p class="text-2xl font-bold text-amber-500">${pendingUsers}</p>
					</div>
					<div
						class="bg-slate-950 border border-emerald-500/20 rounded-lg p-4">
						<p class="text-xs text-emerald-500 mb-1">Approved</p>
						<p class="text-2xl font-bold text-emerald-500">${approvedUsers}</p>
					</div>
					<div class="bg-slate-950 border border-rose-500/20 rounded-lg p-4">
						<p class="text-xs text-rose-500 mb-1">Rejected</p>
						<p class="text-2xl font-bold text-rose-500">${cancleUsers}</p>
					</div>
				</div>
			</header>

			<!-- Content -->
			<div class="p-8">

				<!-- Tabs -->
				<div class="flex space-x-4 mb-6">
					<a
						href="${pageContext.request.contextPath}/userApproval?status=all"
						class="px-6 py-3 bg-emerald-500/10 text-emerald-500 rounded-lg">
						All Users </a> <a
						href="${pageContext.request.contextPath}/userApproval?status=pending"
						class="px-6 py-3 text-slate-400 hover:bg-slate-800 rounded-lg">
						Pending </a> <a
						href="${pageContext.request.contextPath}/userApproval?status=approved"
						class="px-6 py-3 text-slate-400 hover:bg-slate-800 rounded-lg">
						Approved </a> <a
						href="${pageContext.request.contextPath}/userApproval?status=rejected"
						class="px-6 py-3 text-slate-400 hover:bg-slate-800 rounded-lg">
						Rejected </a>
				</div>

				<!-- Users List -->
				<div id="users-list" class="space-y-4">
					<!-- Sample static user card (replace with JSTL c:forEach over users list from controller) -->
					<%
					List<User> users = (List<User>) request.getAttribute("users");

					if (users != null && !users.isEmpty()) {
						for (User u : users) {
					%>

					<div onclick="openUserModal(<%=u.getId()%>)"
						class="cursor-pointer bg-slate-900 border border-slate-800 hover:border-amber-500/30
            rounded-xl p-6 transition-all hover:shadow-lg hover:shadow-amber-500/10 mb-4">

						<div class="flex items-start justify-between">
							<div class="flex items-start space-x-4 flex-1">

								<!-- Avatar -->
								<div
									class="w-12 h-12 bg-amber-500/10 border border-amber-500/20
                        rounded-full flex items-center justify-center">
									<span class="text-lg font-bold text-amber-500"> <%=u.getName().charAt(0)%>
									</span>
								</div>

								<!-- User Info -->
								<div class="flex-1">
									<h3 class="text-lg font-semibold text-slate-100">
										<%=u.getName()%>
									</h3>
									<p class="text-sm text-slate-400">
										<%=u.getEmail()%>
									</p>

									<ul class="mt-1 text-xs text-slate-500">
										<li>Phone: <%=u.getPhone()%></li>
										<li>PAN: <%=u.getPanCard()%></li>
										<li>Registered: <%=u.getCreatedAt()%></li>
									</ul>
								</div>
							</div>

							<!-- Actions -->
							<div class="flex items-center space-x-3">

								<span
									class="px-3 py-1 rounded-full text-xs font-medium
                         bg-amber-500/10 text-amber-500 border border-amber-500/20">
									⏱ <%=u.getStatus()%>
								</span>
								<%
								if (u.getStatus() == userStatus.PENDING) {
								%>
								<form action="updateStatus" method="post">
									<input type="hidden" name="userId" value="<%=u.getId()%>" /> <input
										type="hidden" name="email" value="<%=u.getEmail()%>" />
									<button type="submit" name="status" value="APPROVED"
										class="px-4 py-1.5 bg-emerald-500 text-white text-xs rounded-lg">
										Approve</button>

									<button type="submit" name="status" value="CANCLED"
										class="px-4 py-1.5 bg-rose-500 text-white text-xs rounded-lg">
										Reject</button>
								</form>

								<%
								}
								%>

							</div>
						</div>
					</div>

					<%
					}
					} else {
					%>

					<p class="text-slate-400 text-center mt-10">No users found</p>

					<%
					}
					%>

				</div>
			</div>
		</main>
	</div>

</body>
</html>
