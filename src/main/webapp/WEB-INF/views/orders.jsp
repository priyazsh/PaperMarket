<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp">
        <jsp:param name="title" value="Orders"/>
    </jsp:include>
    <link rel="stylesheet" href="css/orders.css">
</head>
<body class="bg-slate-950 min-h-screen">
    <div class="flex h-screen">
        <jsp:include page="/WEB-INF/views/common/sidebar.jsp">
            <jsp:param name="activePage" value="orders"/>
        </jsp:include>

        <main class="flex-1 overflow-auto">
            <header class="glass-card border-b border-slate-800/50 px-8 py-5 sticky top-0 z-10">
                <div class="flex items-center justify-between">
                    <div class="animate-fadeIn">
                        <h1 class="text-2xl font-bold text-slate-100">Orders</h1>
                        <p class="text-sm text-slate-400 mt-1">Track all your executed trades</p>
                    </div>
                    <div class="flex items-center space-x-4">
                        <select class="px-4 py-2.5 bg-slate-800/50 border border-slate-700/50 rounded-xl text-slate-300 text-sm focus:outline-none focus:border-emerald-500/50 transition-colors cursor-pointer">
                            <option>All Trades</option>
                            <option>Buy Orders</option>
                            <option>Sell Orders</option>
                        </select>

                        <select class="px-4 py-2.5 bg-slate-800/50 border border-slate-700/50 rounded-xl text-slate-300 text-sm focus:outline-none focus:border-emerald-500/50 transition-colors cursor-pointer">
                            <option>Last 7 Days</option>
                            <option>Last 30 Days</option>
                            <option>Last 3 Months</option>
                            <option>Last Year</option>
                        </select>

                        <button class="export-btn flex items-center space-x-2 px-4 py-2.5 bg-emerald-500/10 border border-emerald-500/30 rounded-xl text-emerald-400 text-sm font-medium hover:bg-emerald-500/20 transition-all duration-300">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"></path>
                            </svg>
                            <span>Export</span>
                        </button>
                    </div>
                </div>
            </header>

            <div class="p-8">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                    <div class="stat-card purple glass-card rounded-2xl p-6 animate-slideUp" style="animation-delay: 0.1s; opacity: 0;">
                        <div class="flex items-center justify-between mb-3">
                            <p class="text-sm text-slate-400">Total Trades</p>
                            <div class="w-10 h-10 bg-purple-500/10 rounded-xl flex items-center justify-center">
                                <svg class="w-5 h-5 text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path>
                                </svg>
                            </div>
                        </div>
                        <p class="text-3xl font-bold text-slate-100">24</p>
                        <p class="text-xs text-slate-500 mt-1">This month</p>
                    </div>
                    <div class="stat-card emerald glass-card rounded-2xl p-6 animate-slideUp" style="animation-delay: 0.2s; opacity: 0;">
                        <div class="flex items-center justify-between mb-3">
                            <p class="text-sm text-slate-400">Buy Orders</p>
                            <div class="w-10 h-10 bg-emerald-500/10 rounded-xl flex items-center justify-center">
                                <svg class="w-5 h-5 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 11l5-5m0 0l5 5m-5-5v12"></path>
                                </svg>
                            </div>
                        </div>
                        <p class="text-3xl font-bold text-emerald-400">14</p>
                        <p class="text-xs text-emerald-500/70 mt-1">58% of trades</p>
                    </div>
                    <div class="stat-card rose glass-card rounded-2xl p-6 animate-slideUp" style="animation-delay: 0.3s; opacity: 0;">
                        <div class="flex items-center justify-between mb-3">
                            <p class="text-sm text-slate-400">Sell Orders</p>
                            <div class="w-10 h-10 bg-rose-500/10 rounded-xl flex items-center justify-center">
                                <svg class="w-5 h-5 text-rose-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 13l-5 5m0 0l-5-5m5 5V6"></path>
                                </svg>
                            </div>
                        </div>
                        <p class="text-3xl font-bold text-rose-400">10</p>
                        <p class="text-xs text-rose-500/70 mt-1">42% of trades</p>
                    </div>
                    <div class="stat-card cyan glass-card rounded-2xl p-6 animate-slideUp" style="animation-delay: 0.4s; opacity: 0;">
                        <div class="flex items-center justify-between mb-3">
                            <p class="text-sm text-slate-400">Total Volume</p>
                            <div class="w-10 h-10 bg-cyan-500/10 rounded-xl flex items-center justify-center">
                                <svg class="w-5 h-5 text-cyan-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                            </div>
                        </div>
                        <p class="text-3xl font-bold text-slate-100">₹2.4L</p>
                        <p class="text-xs text-slate-500 mt-1">Traded this month</p>
                    </div>
                </div>

                <div class="glass-card rounded-2xl overflow-hidden animate-slideUp" style="animation-delay: 0.5s; opacity: 0;">
                    <div class="px-6 py-5 border-b border-slate-800/50 flex items-center justify-between">
                        <div>
                            <h2 class="text-lg font-semibold text-slate-100">Recent Trades</h2>
                            <p class="text-xs text-slate-500 mt-1">Your complete trading history</p>
                        </div>
                        <div class="flex items-center space-x-2">
                            <span class="flex items-center space-x-1 text-xs text-slate-500">
                                <span class="w-2 h-2 bg-emerald-500 rounded-full animate-pulse"></span>
                                <span>Live</span>
                            </span>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead>
                                <tr class="border-b border-slate-800/50 bg-slate-900/30">
                                    <th class="text-left px-6 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Date & Time</th>
                                    <th class="text-left px-6 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Type</th>
                                    <th class="text-left px-6 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Symbol</th>
                                    <th class="text-right px-6 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Quantity</th>
                                    <th class="text-right px-6 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Price</th>
                                    <th class="text-right px-6 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Total Value</th>
                                    <th class="text-center px-6 py-4 text-xs font-semibold text-slate-400 uppercase tracking-wider">Status</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-800/30">
                                <tr class="table-row-animate hover:bg-slate-800/30 transition-all duration-300 cursor-pointer group" style="animation-delay: 0.6s;">
                                    <td class="px-6 py-4">
                                        <div>
                                            <p class="text-sm text-slate-100 font-medium">Feb 4, 2026</p>
                                            <p class="text-xs text-slate-500">11:45 AM</p>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span class="inline-flex items-center px-3 py-1.5 rounded-lg text-xs font-semibold bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                                            <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 11l5-5m0 0l5 5m-5-5v12"></path>
                                            </svg>
                                            BUY
                                        </span>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex items-center space-x-3">
                                            <div class="w-8 h-8 bg-gradient-to-br from-blue-500 to-blue-600 rounded-lg flex items-center justify-center text-white text-xs font-bold">R</div>
                                            <div>
                                                <p class="text-sm font-medium text-slate-100 group-hover:text-emerald-400 transition-colors">RELIANCE</p>
                                                <p class="text-xs text-slate-500">Reliance Industries</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100 font-medium">10</span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100">₹2,450.00</span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100 font-semibold">₹24,500</span>
                                    </td>
                                    <td class="px-6 py-4 text-center">
                                        <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-emerald-500/10 text-emerald-400">
                                            <span class="w-1.5 h-1.5 bg-emerald-400 rounded-full mr-1.5"></span>
                                            Executed
                                        </span>
                                    </td>
                                </tr>

                                <tr class="table-row-animate hover:bg-slate-800/30 transition-all duration-300 cursor-pointer group" style="animation-delay: 0.7s;">
                                    <td class="px-6 py-4">
                                        <div>
                                            <p class="text-sm text-slate-100 font-medium">Feb 4, 2026</p>
                                            <p class="text-xs text-slate-500">09:15 AM</p>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span class="inline-flex items-center px-3 py-1.5 rounded-lg text-xs font-semibold bg-rose-500/10 text-rose-400 border border-rose-500/20">
                                            <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 13l-5 5m0 0l-5-5m5 5V6"></path>
                                            </svg>
                                            SELL
                                        </span>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex items-center space-x-3">
                                            <div class="w-8 h-8 bg-gradient-to-br from-indigo-500 to-indigo-600 rounded-lg flex items-center justify-center text-white text-xs font-bold">I</div>
                                            <div>
                                                <p class="text-sm font-medium text-slate-100 group-hover:text-emerald-400 transition-colors">INFY</p>
                                                <p class="text-xs text-slate-500">Infosys</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100 font-medium">5</span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100">₹1,620.00</span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100 font-semibold">₹8,100</span>
                                    </td>
                                    <td class="px-6 py-4 text-center">
                                        <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-emerald-500/10 text-emerald-400">
                                            <span class="w-1.5 h-1.5 bg-emerald-400 rounded-full mr-1.5"></span>
                                            Executed
                                        </span>
                                    </td>
                                </tr>

                                <tr class="table-row-animate hover:bg-slate-800/30 transition-all duration-300 cursor-pointer group" style="animation-delay: 0.8s;">
                                    <td class="px-6 py-4">
                                        <div>
                                            <p class="text-sm text-slate-100 font-medium">Feb 3, 2026</p>
                                            <p class="text-xs text-slate-500">02:30 PM</p>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span class="inline-flex items-center px-3 py-1.5 rounded-lg text-xs font-semibold bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                                            <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 11l5-5m0 0l5 5m-5-5v12"></path>
                                            </svg>
                                            BUY
                                        </span>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex items-center space-x-3">
                                            <div class="w-8 h-8 bg-gradient-to-br from-purple-500 to-purple-600 rounded-lg flex items-center justify-center text-white text-xs font-bold">T</div>
                                            <div>
                                                <p class="text-sm font-medium text-slate-100 group-hover:text-emerald-400 transition-colors">TCS</p>
                                                <p class="text-xs text-slate-500">Tata Consultancy Services</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100 font-medium">8</span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100">₹3,520.00</span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100 font-semibold">₹28,160</span>
                                    </td>
                                    <td class="px-6 py-4 text-center">
                                        <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-emerald-500/10 text-emerald-400">
                                            <span class="w-1.5 h-1.5 bg-emerald-400 rounded-full mr-1.5"></span>
                                            Executed
                                        </span>
                                    </td>
                                </tr>

                                <tr class="table-row-animate hover:bg-slate-800/30 transition-all duration-300 cursor-pointer group" style="animation-delay: 0.9s;">
                                    <td class="px-6 py-4">
                                        <div>
                                            <p class="text-sm text-slate-100 font-medium">Feb 2, 2026</p>
                                            <p class="text-xs text-slate-500">10:20 AM</p>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span class="inline-flex items-center px-3 py-1.5 rounded-lg text-xs font-semibold bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                                            <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 11l5-5m0 0l5 5m-5-5v12"></path>
                                            </svg>
                                            BUY
                                        </span>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex items-center space-x-3">
                                            <div class="w-8 h-8 bg-gradient-to-br from-blue-600 to-blue-700 rounded-lg flex items-center justify-center text-white text-xs font-bold">H</div>
                                            <div>
                                                <p class="text-sm font-medium text-slate-100 group-hover:text-emerald-400 transition-colors">HDFC</p>
                                                <p class="text-xs text-slate-500">HDFC Bank</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100 font-medium">15</span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100">₹1,680.00</span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100 font-semibold">₹25,200</span>
                                    </td>
                                    <td class="px-6 py-4 text-center">
                                        <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-emerald-500/10 text-emerald-400">
                                            <span class="w-1.5 h-1.5 bg-emerald-400 rounded-full mr-1.5"></span>
                                            Executed
                                        </span>
                                    </td>
                                </tr>

                                <tr class="table-row-animate hover:bg-slate-800/30 transition-all duration-300 cursor-pointer group" style="animation-delay: 1s;">
                                    <td class="px-6 py-4">
                                        <div>
                                            <p class="text-sm text-slate-100 font-medium">Feb 1, 2026</p>
                                            <p class="text-xs text-slate-500">01:45 PM</p>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span class="inline-flex items-center px-3 py-1.5 rounded-lg text-xs font-semibold bg-rose-500/10 text-rose-400 border border-rose-500/20">
                                            <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 13l-5 5m0 0l-5-5m5 5V6"></path>
                                            </svg>
                                            SELL
                                        </span>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex items-center space-x-3">
                                            <div class="w-8 h-8 bg-gradient-to-br from-amber-500 to-amber-600 rounded-lg flex items-center justify-center text-white text-xs font-bold">B</div>
                                            <div>
                                                <p class="text-sm font-medium text-slate-100 group-hover:text-emerald-400 transition-colors">BAJAJ</p>
                                                <p class="text-xs text-slate-500">Bajaj Finance</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100 font-medium">2</span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100">₹7,100.00</span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100 font-semibold">₹14,200</span>
                                    </td>
                                    <td class="px-6 py-4 text-center">
                                        <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-emerald-500/10 text-emerald-400">
                                            <span class="w-1.5 h-1.5 bg-emerald-400 rounded-full mr-1.5"></span>
                                            Executed
                                        </span>
                                    </td>
                                </tr>

                                <tr class="table-row-animate hover:bg-slate-800/30 transition-all duration-300 cursor-pointer group" style="animation-delay: 1.1s;">
                                    <td class="px-6 py-4">
                                        <div>
                                            <p class="text-sm text-slate-100 font-medium">Jan 31, 2026</p>
                                            <p class="text-xs text-slate-500">03:10 PM</p>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span class="inline-flex items-center px-3 py-1.5 rounded-lg text-xs font-semibold bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">
                                            <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 11l5-5m0 0l5 5m-5-5v12"></path>
                                            </svg>
                                            BUY
                                        </span>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="flex items-center space-x-3">
                                            <div class="w-8 h-8 bg-gradient-to-br from-orange-500 to-orange-600 rounded-lg flex items-center justify-center text-white text-xs font-bold">I</div>
                                            <div>
                                                <p class="text-sm font-medium text-slate-100 group-hover:text-emerald-400 transition-colors">ICICI</p>
                                                <p class="text-xs text-slate-500">ICICI Bank</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100 font-medium">12</span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100">₹920.00</span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span class="text-slate-100 font-semibold">₹11,040</span>
                                    </td>
                                    <td class="px-6 py-4 text-center">
                                        <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-emerald-500/10 text-emerald-400">
                                            <span class="w-1.5 h-1.5 bg-emerald-400 rounded-full mr-1.5"></span>
                                            Executed
                                        </span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="px-6 py-4 border-t border-slate-800/50 flex items-center justify-between">
                        <p class="text-sm text-slate-500">Showing <span class="text-slate-300 font-medium">1-6</span> of <span class="text-slate-300 font-medium">24</span> trades</p>
                        <div class="flex items-center space-x-2">
                            <button class="p-2 text-slate-400 hover:text-slate-100 hover:bg-slate-800/50 rounded-lg transition-colors disabled:opacity-50" disabled>
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
                                </svg>
                            </button>
                            <button class="w-8 h-8 bg-emerald-500/20 text-emerald-400 rounded-lg font-medium text-sm">1</button>
                            <button class="w-8 h-8 text-slate-400 hover:bg-slate-800/50 rounded-lg font-medium text-sm transition-colors">2</button>
                            <button class="w-8 h-8 text-slate-400 hover:bg-slate-800/50 rounded-lg font-medium text-sm transition-colors">3</button>
                            <button class="w-8 h-8 text-slate-400 hover:bg-slate-800/50 rounded-lg font-medium text-sm transition-colors">4</button>
                            <button class="p-2 text-slate-400 hover:text-slate-100 hover:bg-slate-800/50 rounded-lg transition-colors">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
