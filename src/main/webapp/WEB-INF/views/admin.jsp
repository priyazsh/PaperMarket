<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp">
        <jsp:param name="title" value="Admin Panel"/>
    </jsp:include>
</head>
<body class="bg-slate-950 min-h-screen">
    <div class="flex h-screen">
        <!-- Sidebar -->
        <aside class="w-64 bg-slate-900 border-r border-slate-800 flex flex-col">
            <!-- Logo -->
            <div class="p-6 border-b border-slate-800">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-emerald-500/10 border border-emerald-500/20 rounded-lg flex items-center justify-center">
                        <svg class="w-6 h-6 text-emerald-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
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
                <a href="${pageContext.request.contextPath}/admin?status=pending" class="flex items-center space-x-3 px-4 py-3 bg-emerald-500/10 text-emerald-500 border border-emerald-500/20 rounded-lg font-medium">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <span>Pending Approvals</span>
                    <span class="ml-auto bg-amber-500 text-white text-xs font-bold px-2 py-0.5 rounded-full">${pendingCount}</span>
                </a>

                <a href="${pageContext.request.contextPath}/admin?status=approved" class="flex items-center space-x-3 px-4 py-3 text-slate-400 hover:text-slate-100 hover:bg-slate-800 rounded-lg transition-colors">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <span>Approved Accounts</span>
                </a>

                <a href="${pageContext.request.contextPath}/admin?status=rejected" class="flex items-center space-x-3 px-4 py-3 text-slate-400 hover:text-slate-100 hover:bg-slate-800 rounded-lg transition-colors">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <span>Rejected Accounts</span>
                </a>
            </nav>

            <!-- Admin Profile -->
            <div class="p-4 border-t border-slate-800">
                <div class="flex items-center space-x-3 px-4 py-3 bg-slate-800 rounded-lg">
                    <div class="w-10 h-10 bg-amber-500 rounded-full flex items-center justify-center">
                        <span class="text-sm font-bold text-white">AD</span>
                    </div>
                    <div class="flex-1">
                        <p class="text-sm font-medium text-slate-100">Admin</p>
                        <p class="text-xs text-slate-500">admin@papermarket.com</p>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="w-full mt-3 px-4 py-2 bg-slate-950 hover:bg-slate-800 text-slate-400 hover:text-slate-100 text-sm rounded-lg transition-colors flex items-center justify-center">
                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                    </svg>
                    Logout
                </a>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 overflow-auto">
            <!-- Header -->
            <header class="bg-slate-900 border-b border-slate-800 px-8 py-6">
                <div class="flex items-center justify-between mb-6">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-100">Account Management</h1>
                        <p class="text-sm text-slate-400 mt-1">Review and approve user registrations</p>
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
                        <p class="text-2xl font-bold text-amber-500">${pendingCount}</p>
                    </div>
                    <div class="bg-slate-950 border border-emerald-500/20 rounded-lg p-4">
                        <p class="text-xs text-emerald-500 mb-1">Approved</p>
                        <p class="text-2xl font-bold text-emerald-500">${approvedCount}</p>
                    </div>
                    <div class="bg-slate-950 border border-rose-500/20 rounded-lg p-4">
                        <p class="text-xs text-rose-500 mb-1">Rejected</p>
                        <p class="text-2xl font-bold text-rose-500">${rejectedCount}</p>
                    </div>
                </div>
            </header>

            <!-- Content -->
            <div class="p-8">
                <!-- Search and Filters -->
                <form action="${pageContext.request.contextPath}/admin" method="get" class="bg-slate-900 border border-slate-800 rounded-xl p-6 mb-8">
                    <div class="flex flex-col md:flex-row gap-4">
                        <div class="flex-1">
                            <label class="block text-sm font-medium text-slate-300 mb-2">Search Users</label>
                            <input 
                                type="text" 
                                name="search"
                                id="search-input"
                                placeholder="Search by name, email, phone..." 
                                value="${param.search}"
                                class="w-full px-4 py-2.5 bg-slate-950 border border-slate-800 rounded-lg text-slate-100 placeholder-slate-500 focus:outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 transition-colors"
                            >
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-300 mb-2">Filter by Status</label>
                            <select 
                                name="status"
                                id="filter-select"
                                class="w-full px-4 py-2.5 bg-slate-950 border border-slate-800 rounded-lg text-slate-100 focus:outline-none focus:border-emerald-500 transition-colors"
                            >
                                <option value="all">All Users</option>
                                <option value="pending">Pending Only</option>
                                <option value="approved">Approved Only</option>
                                <option value="rejected">Rejected Only</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-slate-300 mb-2">Sort By</label>
                            <select 
                                name="sort"
                                id="sort-select"
                                class="w-full px-4 py-2.5 bg-slate-950 border border-slate-800 rounded-lg text-slate-100 focus:outline-none focus:border-emerald-500 transition-colors"
                            >
                                <option value="date-desc">Newest First</option>
                                <option value="date-asc">Oldest First</option>
                                <option value="name-asc">Name A-Z</option>
                                <option value="name-desc">Name Z-A</option>
                            </select>
                        </div>
                        <div class="flex items-end">
                            <button type="submit" class="w-full px-6 py-2.5 bg-emerald-500 hover:bg-emerald-600 text-white font-semibold rounded-lg transition-colors flex items-center justify-center">
                                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                                </svg>
                                Search
                            </button>
                        </div>
                    </div>
                </form>

                <!-- Tabs -->
                <div class="flex space-x-4 mb-6">
                    <a href="${pageContext.request.contextPath}/admin?status=all" class="px-6 py-3 bg-emerald-500/10 text-emerald-500 border border-emerald-500/20 rounded-lg font-medium transition-colors">
                        All Users
                    </a>
                    <a href="${pageContext.request.contextPath}/admin?status=pending" class="px-6 py-3 text-slate-400 hover:text-slate-100 hover:bg-slate-800 border border-slate-800 rounded-lg font-medium transition-colors">
                        Pending
                    </a>
                    <a href="${pageContext.request.contextPath}/admin?status=approved" class="px-6 py-3 text-slate-400 hover:text-slate-100 hover:bg-slate-800 border border-slate-800 rounded-lg font-medium transition-colors">
                        Approved
                    </a>
                    <a href="${pageContext.request.contextPath}/admin?status=rejected" class="px-6 py-3 text-slate-400 hover:text-slate-100 hover:bg-slate-800 border border-slate-800 rounded-lg font-medium transition-colors">
                        Rejected
                    </a>
                </div>

                <!-- Users List -->
                <div id="users-list" class="space-y-4">
                    <!-- Sample static user card (replace with JSTL c:forEach over users list from controller) -->
                    <div class="bg-slate-900 border border-slate-800 hover:border-amber-500/30 rounded-xl p-6 transition-all hover:shadow-lg hover:shadow-amber-500/10">
                        <div class="flex items-start justify-between">
                            <div class="flex items-start space-x-4 flex-1">
                                <div class="w-12 h-12 bg-amber-500/10 border border-amber-500/20 rounded-full flex items-center justify-center flex-shrink-0">
                                    <span class="text-lg font-bold text-amber-500">J</span>
                                </div>
                                <div class="flex-1">
                                    <h3 class="text-lg font-semibold text-slate-100">John Doe</h3>
                                    <p class="text-sm text-slate-400">john.doe@example.com</p>
                                    <ul class="mt-1 space-y-0.5 list-none text-xs text-slate-500">
                                        <li>Phone: +91 98765 43210</li>
                                        <li>PAN: ABCDE1234F</li>
                                        <li>Registered: 05/02/2026</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="flex items-center space-x-3">
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-amber-500/10 text-amber-500 border border-amber-500/20 whitespace-nowrap">
                                    ⏱ Pending
                                </span>
                                <form action="${pageContext.request.contextPath}/admin/approve" method="post" class="inline">
                                    <input type="hidden" name="userId" value="1" />
                                    <button type="submit" class="px-4 py-1.5 bg-emerald-500 hover:bg-emerald-600 text-white text-xs font-semibold rounded-lg transition-colors">
                                        Approve
                                    </button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin/reject" method="post" class="inline">
                                    <input type="hidden" name="userId" value="1" />
                                    <button type="submit" class="px-4 py-1.5 bg-rose-500 hover:bg-rose-600 text-white text-xs font-semibold rounded-lg transition-colors">
                                        Reject
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Empty state (show when no users match) -->
                    <!--
                    <div class="text-center py-16">
                        <svg class="w-16 h-16 mx-auto text-slate-600 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <h3 class="text-xl font-semibold text-slate-100 mb-2">No Users Found</h3>
                        <p class="text-slate-400">Try adjusting your search or filters</p>
                    </div>
                    -->
                </div>
            </div>
        </main>

        <!-- User Details Modal -->
        <div id="modal-overlay" class="hidden fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-4">
            <div class="bg-slate-900 border border-slate-800 rounded-xl max-w-2xl w-full max-h-96 overflow-y-auto">
                <div class="sticky top-0 bg-slate-900 border-b border-slate-800 px-6 py-4 flex items-center justify-between">
                    <h2 class="text-xl font-bold text-slate-100">User Details</h2>
                    <button onclick="closeModal()" class="text-slate-400 hover:text-slate-100">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>
                <div id="modal-content" class="p-6">
                    <div class="space-y-6">
                        <div class="flex items-center space-x-4">
                            <div class="w-16 h-16 bg-gradient-to-br from-emerald-500 to-cyan-500 rounded-full flex items-center justify-center flex-shrink-0">
                                <span class="text-2xl font-bold text-white">J</span>
                            </div>
                            <div>
                                <h3 class="text-xl font-bold text-slate-100">John Doe</h3>
                                <p class="text-sm text-slate-400">john.doe@example.com</p>
                            </div>
                        </div>

                        <div class="mb-4 p-3 bg-amber-500/10 border border-amber-500/20 rounded-lg">
                            <p class="text-xs text-amber-500 mb-1">Status</p>
                            <p class="text-sm font-medium text-amber-400">⏱ Pending Review</p>
                        </div>

                        <ul class="grid grid-cols-2 gap-4 list-none">
                            <li class="p-3 bg-slate-950 rounded-lg">
                                <p class="text-xs text-slate-500 mb-2">Phone</p>
                                <p class="text-sm font-medium text-slate-300">+91 98765 43210</p>
                            </li>
                            <li class="p-3 bg-slate-950 rounded-lg">
                                <p class="text-xs text-slate-500 mb-2">Registered</p>
                                <p class="text-sm font-medium text-slate-300">05/02/2026</p>
                            </li>
                            <li class="p-3 bg-slate-950 rounded-lg">
                                <p class="text-xs text-slate-500 mb-2">PAN Number</p>
                                <p class="text-sm font-medium text-slate-300 font-mono">ABCDE1234F</p>
                            </li>
                            <li class="p-3 bg-slate-950 rounded-lg">
                                <p class="text-xs text-slate-500 mb-2">Aadhaar</p>
                                <p class="text-sm font-medium text-slate-300 font-mono">**** **** 5678</p>
                            </li>
                        </ul>

                        <div class="pt-4 border-t border-slate-800">
                            <div class="flex space-x-3">
                                <form action="${pageContext.request.contextPath}/admin/approve" method="post" class="flex-1">
                                    <input type="hidden" name="userId" value="1" />
                                    <button type="submit" class="w-full px-4 py-2 bg-emerald-500 hover:bg-emerald-600 text-white font-semibold rounded-lg transition-colors">
                                        Approve Account
                                    </button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin/reject" method="post" class="flex-1">
                                    <input type="hidden" name="userId" value="1" />
                                    <button type="submit" class="w-full px-4 py-2 bg-rose-500 hover:bg-rose-600 text-white font-semibold rounded-lg transition-colors">
                                        Reject Account
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
