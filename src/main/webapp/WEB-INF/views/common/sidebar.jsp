<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 
    Sidebar Component - Navigation sidebar for dashboard pages
    Usage: <jsp:include page="/WEB-INF/views/common/sidebar.jsp">
               <jsp:param name="activePage" value="holdings|market|funds|orders"/>
           </jsp:include>
--%>
<aside class="w-64 bg-slate-900/80 backdrop-blur-xl border-r border-slate-800/50 flex flex-col relative overflow-hidden">
    <!-- Ambient Glow -->
    <div class="sidebar-glow"></div>
    
    <!-- Logo -->
    <div class="p-6 border-b border-slate-800/50">
        <a href="./" class="flex items-center space-x-3">
            <div class="w-11 h-11 bg-gradient-to-br from-emerald-500/20 to-cyan-500/20 border border-emerald-500/30 rounded-xl flex items-center justify-center shadow-lg shadow-emerald-500/10">
                <svg class="w-6 h-6 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
                </svg>
            </div>
            <span class="text-xl font-bold bg-gradient-to-r from-slate-100 to-slate-300 bg-clip-text text-transparent">Paper Market</span>
        </a>
    </div>

    <!-- Navigation -->
    <nav class="flex-1 p-4 space-y-1">
        <a href="holdings" class="nav-item ${param.activePage == 'holdings' ? 'active' : ''} flex items-center space-x-3 px-4 py-3 ${param.activePage == 'holdings' ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 font-medium' : 'text-slate-400 hover:text-slate-100 hover:bg-slate-800/50'} rounded-xl transition-all duration-300">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
            </svg>
            <span>Holdings</span>
        </a>

        <a href="market" class="nav-item ${param.activePage == 'market' ? 'active' : ''} flex items-center space-x-3 px-4 py-3 ${param.activePage == 'market' ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 font-medium' : 'text-slate-400 hover:text-slate-100 hover:bg-slate-800/50'} rounded-xl transition-all duration-300">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 12l3-3 3 3 4-4M8 21l4-4 4 4M3 4h18M4 4h16v12a1 1 0 01-1 1H5a1 1 0 01-1-1V4z"></path>
            </svg>
            <span>Market</span>
        </a>

        <a href="funds" class="nav-item ${param.activePage == 'funds' ? 'active' : ''} flex items-center space-x-3 px-4 py-3 ${param.activePage == 'funds' ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 font-medium' : 'text-slate-400 hover:text-slate-100 hover:bg-slate-800/50'} rounded-xl transition-all duration-300">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"></path>
            </svg>
            <span>Funds</span>
        </a>

        <a href="orders" class="nav-item ${param.activePage == 'orders' ? 'active' : ''} flex items-center space-x-3 px-4 py-3 ${param.activePage == 'orders' ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 font-medium' : 'text-slate-400 hover:text-slate-100 hover:bg-slate-800/50'} rounded-xl transition-all duration-300">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path>
            </svg>
            <span>Orders</span>
        </a>
    </nav>

    <!-- User Profile -->
    <div class="p-4 border-t border-slate-800/50">
        <% if (session.getAttribute("user") != null) { %>
                <div class="flex items-center space-x-3 px-4 py-3 hover:bg-slate-800/50 rounded-xl cursor-pointer transition-all duration-300 group">
                    <div class="w-10 h-10 bg-gradient-to-br from-emerald-500 to-cyan-500 rounded-full flex items-center justify-center shadow-lg">
                        <span class="text-sm font-bold text-white">${sessionScope.user.initials}</span>
                    </div>
                    <div class="flex-1">
                        <p class="text-sm font-medium text-slate-100">${sessionScope.user.fullName}</p>
                        <p class="text-xs text-slate-500">${sessionScope.user.email}</p>
                    </div>
                    <a href="logout" class="text-slate-500 hover:text-rose-400 transition-colors" title="Logout">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                        </svg>
                    </a>
                </div>
        <% } else { %>
                <a href="login" class="flex items-center justify-center space-x-2 px-4 py-3 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 rounded-xl hover:bg-emerald-500/20 transition-all duration-300">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"></path>
                    </svg>
                    <span class="font-medium">Sign In</span>
                </a>
        <% } %>
    </div>
</aside>

<style>
    .sidebar-glow {
        position: absolute;
        width: 200px;
        height: 200px;
        background: radial-gradient(circle, rgba(16, 185, 129, 0.1) 0%, transparent 70%);
        pointer-events: none;
        top: -20px;
        left: -20px;
    }
    .nav-item {
        position: relative;
        transition: all 0.3s ease;
    }
    .nav-item.active::before {
        content: '';
        position: absolute;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        width: 3px;
        height: 60%;
        background: rgb(16, 185, 129);
        border-radius: 0 4px 4px 0;
    }
</style>
