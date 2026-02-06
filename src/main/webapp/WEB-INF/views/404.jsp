        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

        <!DOCTYPE html>
        <html lang="en">
        <head>
            <jsp:include page="/WEB-INF/views/common/head.jsp">
                <jsp:param name="title" value="404 - Page Not Found"/>
            </jsp:include>
            <link rel="stylesheet" href="css/404.css">
        </head>
        <body class="bg-slate-950 min-h-screen flex items-center justify-center p-4 overflow-hidden relative">
            <div class="fixed inset-0 overflow-hidden pointer-events-none">
                <div class="floating-shape w-[500px] h-[500px] bg-emerald-500 -top-48 -left-48 animate-float"></div>
                <div class="floating-shape w-[400px] h-[400px] bg-rose-500 bottom-0 right-0" style="animation: float 5s ease-in-out infinite; animation-delay: -2s;"></div>
                <div class="floating-shape w-[300px] h-[300px] bg-cyan-500 top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2" style="animation: float 6s ease-in-out infinite;"></div>
            </div>

            <div class="fixed inset-0 opacity-[0.02] pointer-events-none" style="background-image: url('data:image/svg+xml,%3Csvg width=&quot;60&quot; height=&quot;60&quot; viewBox=&quot;0 0 60 60&quot; xmlns=&quot;http://www.w3.org/2000/svg&quot;%3E%3Cg fill=&quot;none&quot; fill-rule=&quot;evenodd&quot;%3E%3Cg fill=&quot;%23ffffff&quot; fill-opacity=&quot;1&quot;%3E%3Cpath d=&quot;M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z&quot;/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');"></div>

            <div class="text-center relative z-10 max-w-2xl mx-auto">
                <div class="mb-8 animate-slideUp" style="animation-delay: 0.1s; opacity: 0;">
                    <div class="inline-block animate-float animate-pulse-glow">
                        <svg class="w-40 h-40 mx-auto" viewBox="0 0 160 160" fill="none">
                            <circle cx="80" cy="80" r="70" fill="rgba(16, 185, 129, 0.1)" stroke="rgba(16, 185, 129, 0.2)" stroke-width="2"/>
                            <path class="chart-line" d="M30 50 L50 60 L70 45 L90 80 L110 100 L130 120" stroke="url(#gradient)" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
                            <path d="M125 115 L130 120 L135 115" stroke="#f43f5e" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                            <circle cx="115" cy="40" r="15" fill="rgba(244, 63, 94, 0.2)" stroke="rgba(244, 63, 94, 0.3)" stroke-width="2"/>
                            <path d="M110 35 L120 45 M120 35 L110 45" stroke="#f43f5e" stroke-width="2.5" stroke-linecap="round"/>
                            <defs>
                                <linearGradient id="gradient" x1="30" y1="50" x2="130" y2="120">
                                    <stop offset="0%" stop-color="#10b981"/>
                                    <stop offset="100%" stop-color="#f43f5e"/>
                                </linearGradient>
                            </defs>
                        </svg>
                    </div>
                </div>

                <div class="animate-slideUp" style="animation-delay: 0.2s; opacity: 0;">
                    <h1 class="text-8xl md:text-9xl font-black bg-gradient-to-r from-emerald-400 via-cyan-400 to-emerald-400 bg-clip-text text-transparent mb-4">404</h1>
                </div>

                <div class="animate-slideUp" style="animation-delay: 0.3s; opacity: 0;">
                    <h2 class="text-2xl md:text-3xl font-bold text-slate-100 mb-4">Market Not Found</h2>
                    <p class="text-slate-400 text-lg mb-2">Looks like this trade didn't execute.</p>
                    <p class="text-slate-500 mb-8">The page you're looking for has been delisted or doesn't exist.</p>
                </div>

                <div class="animate-slideUp mb-8" style="animation-delay: 0.4s; opacity: 0;">
                    <div class="inline-block bg-slate-900/80 backdrop-blur-xl border border-slate-800 rounded-xl p-4 text-left max-w-md mx-auto">
                        <div class="flex items-center space-x-2 mb-3">
                            <div class="w-3 h-3 rounded-full bg-rose-500"></div>
                            <div class="w-3 h-3 rounded-full bg-amber-500"></div>
                            <div class="w-3 h-3 rounded-full bg-emerald-500"></div>
                        </div>
                        <div class="font-mono text-sm">
                            <p class="text-slate-500">$ curl papermarket.com<span class="text-slate-400">/this-page</span></p>
                            <p class="text-rose-400 mt-1">Error: 404 NOT_FOUND</p>
                            <p class="text-slate-500 mt-1">$ <span class="cursor-blink text-emerald-400">█</span></p>
                        </div>
                    </div>
                </div>

                <div class="flex flex-col sm:flex-row items-center justify-center gap-4 animate-slideUp" style="animation-delay: 0.5s; opacity: 0;">
                    <a href="market" class="glass-btn px-8 py-4 rounded-xl text-emerald-400 font-semibold inline-flex items-center space-x-2">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 12l3-3 3 3 4-4M8 21l4-4 4 4M3 4h18M4 4h16v12a1 1 0 01-1 1H5a1 1 0 01-1-1V4z"></path>
                        </svg>
                        <span>Go to Market</span>
                    </a>
                    <a href="holdings" class="px-8 py-4 rounded-xl text-slate-300 font-semibold hover:text-emerald-400 transition-colors inline-flex items-center space-x-2">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                        </svg>
                        <span>View Holdings</span>
                    </a>
                </div>

                <div class="mt-12 pt-8 border-t border-slate-800/50 animate-slideUp" style="animation-delay: 0.6s; opacity: 0;">
                    <p class="text-slate-500 text-sm mb-4">Or try these popular destinations:</p>
                    <div class="flex flex-wrap items-center justify-center gap-4">
                        <a href="funds" class="text-sm text-slate-400 hover:text-emerald-400 transition-colors">Funds</a>
                        <span class="text-slate-700">•</span>
                        <a href="orders" class="text-sm text-slate-400 hover:text-emerald-400 transition-colors">Orders</a>
                        <span class="text-slate-700">•</span>
                        <a href="login" class="text-sm text-slate-400 hover:text-emerald-400 transition-colors">Login</a>
                        <span class="text-slate-700">•</span>
                        <a href="register" class="text-sm text-slate-400 hover:text-emerald-400 transition-colors">Register</a>
                    </div>
                </div>
            </div>
        </body>
        </html>
