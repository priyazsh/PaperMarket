<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp">
        <jsp:param name="title" value="Holdings"/>
    </jsp:include>
</head>
<body class="bg-slate-950 min-h-screen">
    <div class="flex h-screen">
        <jsp:include page="/WEB-INF/views/common/sidebar.jsp">
            <jsp:param name="activePage" value="holdings"/>
        </jsp:include>

        <main class="flex-1 overflow-auto">
            <header class="bg-slate-900 border-b border-slate-800 px-8 py-4">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-100">Holdings</h1>
                        <p class="text-sm text-slate-400 mt-1">Your investment holdings</p>
                    </div>
                    <div class="flex items-center space-x-4">
                        <div class="flex items-center space-x-2 px-4 py-2 bg-emerald-500/10 border border-emerald-500/20 rounded-lg">
                            <div class="w-2 h-2 bg-emerald-500 rounded-full animate-pulse"></div>
                            <span class="text-sm font-medium text-emerald-500">Market Open</span>
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
                        <div class="text-2xl font-bold text-slate-100">₹10.01k</div>
                    </div>

                    <div class="bg-slate-900 border border-slate-800 rounded-xl p-6">
                        <div class="flex items-center justify-between mb-2">
                            <span class="text-sm text-slate-400">Current</span>
                        </div>
                        <div class="text-2xl font-bold text-slate-100">₹10.34k</div>
                    </div>

                    <div class="bg-slate-900 border border-slate-800 rounded-xl p-6">
                        <div class="flex items-center justify-between mb-2">
                            <span class="text-sm text-slate-400">Total P&L</span>
                        </div>
                        <div class="text-2xl font-bold text-emerald-400">₹331.14</div>
                        <div class="text-sm text-emerald-400 mt-1">3.3%</div>
                    </div>
                </div>

                <div class="bg-slate-900 border border-slate-800 rounded-xl p-6 mb-8">
                    <h2 class="text-lg font-semibold text-slate-100 mb-4">My Holdings</h2>
                    <div id="holdings-container"></div>
                </div>
            </div>
        </main>
    </div>

    <script src="js/holdings.js"></script>
</body>
</html>
