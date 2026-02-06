<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="<%= request.getContextPath() %>/">
    <title>Paper Market - Practice Stock Trading</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .gradient-text {
            background: linear-gradient(to right, #10b981, #06b6d4, #10b981);
            background-size: 200% auto;
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            animation: gradient-shift 3s ease infinite;
        }
        @keyframes gradient-shift {
            0%, 100% { background-position: 0% center; }
            50% { background-position: 100% center; }
        }
        .float {
            animation: float 6s ease-in-out infinite;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }
        .glass {
            background: rgba(15, 23, 42, 0.8);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(148, 163, 184, 0.1);
        }
        .card-hover {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }
        .fade-in-up {
            opacity: 0;
            animation: fadeInUp 0.8s ease-out forwards;
        }
        .fade-in-up-delay-1 { animation-delay: 0.1s; }
        .fade-in-up-delay-2 { animation-delay: 0.2s; }
        .fade-in-up-delay-3 { animation-delay: 0.3s; }
        .fade-in-up-delay-4 { animation-delay: 0.4s; }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes scroll {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }
        .animate-scroll {
            animation: scroll 30s linear infinite;
        }
    </style>
</head>
<body class="bg-slate-950 min-h-screen overflow-x-hidden">
    <!-- Animated Background -->
    <div class="fixed inset-0 overflow-hidden pointer-events-none">
        <div class="absolute top-0 left-1/4 w-96 h-96 bg-emerald-500/10 rounded-full blur-3xl"></div>
        <div class="absolute bottom-0 right-1/4 w-96 h-96 bg-cyan-500/10 rounded-full blur-3xl"></div>
        <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] bg-purple-500/5 rounded-full blur-3xl"></div>
    </div>

    <!-- Navigation -->
    <nav class="relative z-50 border-b border-slate-800/50">
        <div class="max-w-7xl mx-auto px-6 py-4">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-emerald-500/10 border border-emerald-500/20 rounded-xl flex items-center justify-center">
                        <svg class="w-6 h-6 text-emerald-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
                        </svg>
                    </div>
                    <span class="text-xl font-bold text-white">Paper Market</span>
                </div>
                <div class="flex items-center space-x-4">
                    <% if (session.getAttribute("user") != null) { %>
                            <a href="holdings" class="px-4 py-2 text-slate-300 hover:text-white transition-colors">Dashboard</a>
                            <a href="logout" class="px-6 py-2.5 bg-emerald-500 hover:bg-emerald-600 text-white font-medium rounded-lg transition-colors">Logout</a>
                    <% } else { %>
                            <a href="login" class="px-4 py-2 text-slate-300 hover:text-white transition-colors">Login</a>
                            <a href="register" class="px-6 py-2.5 bg-emerald-500 hover:bg-emerald-600 text-white font-medium rounded-lg transition-colors">Get Started</a>
                    <% } %>
                </div>
            </div>
        </div>
    </nav>

    <!-- Stock Ticker -->
    <div class="relative z-10 bg-slate-900/50 border-b border-slate-800/50 py-3 overflow-hidden">
        <div class="animate-scroll whitespace-nowrap inline-flex">
            <div class="inline-flex items-center">
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">RELIANCE</span>
                    <span class="text-emerald-400 font-medium">₹2,456.30</span>
                    <span class="text-emerald-400 text-sm ml-2">+1.2%</span>
                </span>
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">TCS</span>
                    <span class="text-red-400 font-medium">₹3,892.15</span>
                    <span class="text-red-400 text-sm ml-2">-0.8%</span>
                </span>
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">INFY</span>
                    <span class="text-emerald-400 font-medium">₹1,654.80</span>
                    <span class="text-emerald-400 text-sm ml-2">+2.1%</span>
                </span>
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">HDFC</span>
                    <span class="text-emerald-400 font-medium">₹1,823.45</span>
                    <span class="text-emerald-400 text-sm ml-2">+0.5%</span>
                </span>
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">ICICI</span>
                    <span class="text-red-400 font-medium">₹1,124.60</span>
                    <span class="text-red-400 text-sm ml-2">-1.3%</span>
                </span>
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">WIPRO</span>
                    <span class="text-emerald-400 font-medium">₹456.75</span>
                    <span class="text-emerald-400 text-sm ml-2">+3.2%</span>
                </span>
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">TATASTEEL</span>
                    <span class="text-emerald-400 font-medium">₹142.30</span>
                    <span class="text-emerald-400 text-sm ml-2">+1.8%</span>
                </span>
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">SBIN</span>
                    <span class="text-red-400 font-medium">₹812.90</span>
                    <span class="text-red-400 text-sm ml-2">-0.4%</span>
                </span>
            </div>
            <div class="inline-flex items-center">
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">RELIANCE</span>
                    <span class="text-emerald-400 font-medium">₹2,456.30</span>
                    <span class="text-emerald-400 text-sm ml-2">+1.2%</span>
                </span>
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">TCS</span>
                    <span class="text-red-400 font-medium">₹3,892.15</span>
                    <span class="text-red-400 text-sm ml-2">-0.8%</span>
                </span>
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">INFY</span>
                    <span class="text-emerald-400 font-medium">₹1,654.80</span>
                    <span class="text-emerald-400 text-sm ml-2">+2.1%</span>
                </span>
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">HDFC</span>
                    <span class="text-emerald-400 font-medium">₹1,823.45</span>
                    <span class="text-emerald-400 text-sm ml-2">+0.5%</span>
                </span>
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">ICICI</span>
                    <span class="text-red-400 font-medium">₹1,124.60</span>
                    <span class="text-red-400 text-sm ml-2">-1.3%</span>
                </span>
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">WIPRO</span>
                    <span class="text-emerald-400 font-medium">₹456.75</span>
                    <span class="text-emerald-400 text-sm ml-2">+3.2%</span>
                </span>
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">TATASTEEL</span>
                    <span class="text-emerald-400 font-medium">₹142.30</span>
                    <span class="text-emerald-400 text-sm ml-2">+1.8%</span>
                </span>
                <span class="inline-flex items-center mx-8">
                    <span class="text-slate-400 mr-2">SBIN</span>
                    <span class="text-red-400 font-medium">₹812.90</span>
                    <span class="text-red-400 text-sm ml-2">-0.4%</span>
                </span>
            </div>
        </div>
    </div>

    <!-- Hero Section -->
    <section class="relative z-10 px-6 py-20">
        <div class="max-w-7xl mx-auto">
            <div class="grid lg:grid-cols-2 gap-12 items-center">
                <!-- Left Content -->
                <div>
                    <div class="fade-in-up fade-in-up-delay-1">
                        <span class="inline-flex items-center px-4 py-2 bg-emerald-500/10 border border-emerald-500/20 rounded-full text-emerald-400 text-sm font-medium mb-6">
                            <span class="w-2 h-2 bg-emerald-500 rounded-full mr-2 animate-pulse"></span>
                            2,296+ Indian Stocks Available
                        </span>
                    </div>
                    
                    <h1 class="fade-in-up fade-in-up-delay-2 text-5xl lg:text-6xl font-bold text-white leading-tight mb-6">
                        Master Trading
                        <span class="gradient-text block">Without the Risk</span>
                    </h1>
                    
                    <p class="fade-in-up fade-in-up-delay-3 text-xl text-slate-400 mb-8 leading-relaxed">
                        Practice stock trading with ₹10,00,000 virtual money. Learn market strategies, build your portfolio, and gain confidence before investing real money.
                    </p>
                    
                    <div class="fade-in-up fade-in-up-delay-4 flex flex-col sm:flex-row gap-4">
                        <a href="register" class="group inline-flex items-center justify-center px-8 py-4 bg-emerald-500 hover:bg-emerald-600 text-white font-semibold rounded-xl transition-all hover:shadow-2xl hover:shadow-emerald-500/25 hover:scale-105">
                            Start Trading Free
                            <svg class="w-5 h-5 ml-2 group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"></path>
                            </svg>
                        </a>
                        <a href="market" class="inline-flex items-center justify-center px-8 py-4 glass text-white font-semibold rounded-xl hover:bg-slate-800/50 transition-all">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                            </svg>
                            Explore Market
                        </a>
                    </div>

                    <!-- Trust Badges -->
                    <div class="fade-in-up fade-in-up-delay-4 mt-12 flex items-center gap-8">
                        <div class="flex items-center gap-2">
                            <div class="flex -space-x-2">
                                <div class="w-8 h-8 bg-gradient-to-br from-blue-400 to-blue-600 rounded-full border-2 border-slate-950"></div>
                                <div class="w-8 h-8 bg-gradient-to-br from-purple-400 to-purple-600 rounded-full border-2 border-slate-950"></div>
                                <div class="w-8 h-8 bg-gradient-to-br from-emerald-400 to-emerald-600 rounded-full border-2 border-slate-950"></div>
                                <div class="w-8 h-8 bg-gradient-to-br from-orange-400 to-orange-600 rounded-full border-2 border-slate-950"></div>
                            </div>
                            <span class="text-slate-400 text-sm">10k+ traders</span>
                        </div>
                        <div class="flex items-center gap-2">
                            <div class="flex">
                                <svg class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
                                <svg class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
                                <svg class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
                                <svg class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
                                <svg class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20"><path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path></svg>
                            </div>
                            <span class="text-slate-400 text-sm">4.9/5 rating</span>
                        </div>
                    </div>
                </div>

                <!-- Right Content - Dashboard Preview -->
                <div class="relative">
                    <div class="glass rounded-2xl p-6 card-hover">
                        <div class="flex items-center justify-between mb-6">
                            <div>
                                <p class="text-slate-400 text-sm">Portfolio Value</p>
                                <p class="text-3xl font-bold text-white">₹12,45,890</p>
                            </div>
                            <div class="text-right">
                                <p class="text-emerald-400 font-semibold">+₹2,45,890</p>
                                <p class="text-emerald-400 text-sm">+24.58%</p>
                            </div>
                        </div>

                        <div class="h-48 bg-slate-800/50 rounded-xl mb-6 flex items-end justify-around px-4 pb-4">
                            <div class="w-8 bg-gradient-to-t from-emerald-600 to-emerald-400 rounded-t-lg" style="height: 40%;"></div>
                            <div class="w-8 bg-gradient-to-t from-emerald-600 to-emerald-400 rounded-t-lg" style="height: 60%;"></div>
                            <div class="w-8 bg-gradient-to-t from-red-600 to-red-400 rounded-t-lg" style="height: 30%;"></div>
                            <div class="w-8 bg-gradient-to-t from-emerald-600 to-emerald-400 rounded-t-lg" style="height: 75%;"></div>
                            <div class="w-8 bg-gradient-to-t from-emerald-600 to-emerald-400 rounded-t-lg" style="height: 85%;"></div>
                            <div class="w-8 bg-gradient-to-t from-red-600 to-red-400 rounded-t-lg" style="height: 50%;"></div>
                            <div class="w-8 bg-gradient-to-t from-emerald-600 to-emerald-400 rounded-t-lg" style="height: 95%;"></div>
                        </div>

                        <div class="space-y-3">
                            <div class="flex items-center justify-between p-3 bg-slate-800/50 rounded-lg">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 bg-blue-500/20 rounded-lg flex items-center justify-center">
                                        <span class="text-blue-400 font-bold text-sm">R</span>
                                    </div>
                                    <div>
                                        <p class="text-white font-medium">RELIANCE</p>
                                        <p class="text-slate-500 text-sm">50 shares</p>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <p class="text-white font-medium">₹1,22,815</p>
                                    <p class="text-emerald-400 text-sm">+12.4%</p>
                                </div>
                            </div>
                            <div class="flex items-center justify-between p-3 bg-slate-800/50 rounded-lg">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 bg-purple-500/20 rounded-lg flex items-center justify-center">
                                        <span class="text-purple-400 font-bold text-sm">T</span>
                                    </div>
                                    <div>
                                        <p class="text-white font-medium">TCS</p>
                                        <p class="text-slate-500 text-sm">25 shares</p>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <p class="text-white font-medium">₹97,303</p>
                                    <p class="text-emerald-400 text-sm">+8.2%</p>
                                </div>
                            </div>
                            <div class="flex items-center justify-between p-3 bg-slate-800/50 rounded-lg">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 bg-emerald-500/20 rounded-lg flex items-center justify-center">
                                        <span class="text-emerald-400 font-bold text-sm">I</span>
                                    </div>
                                    <div>
                                        <p class="text-white font-medium">INFY</p>
                                        <p class="text-slate-500 text-sm">75 shares</p>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <p class="text-white font-medium">₹1,24,110</p>
                                    <p class="text-red-400 text-sm">-2.1%</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="absolute -top-4 -right-4 glass rounded-xl p-4 float" style="animation-delay: -2s;">
                        <div class="flex items-center gap-2">
                            <div class="w-8 h-8 bg-emerald-500/20 rounded-full flex items-center justify-center">
                                <svg class="w-4 h-4 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                </svg>
                            </div>
                            <div>
                                <p class="text-white text-sm font-medium">Order Executed</p>
                                <p class="text-slate-400 text-xs">HDFC @ ₹1,823</p>
                            </div>
                        </div>
                    </div>

                    <div class="absolute -bottom-4 -left-4 glass rounded-xl p-4 float" style="animation-delay: -4s;">
                        <div class="flex items-center gap-2">
                            <div class="w-8 h-8 bg-blue-500/20 rounded-full flex items-center justify-center">
                                <svg class="w-4 h-4 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
                                </svg>
                            </div>
                            <div>
                                <p class="text-white text-sm font-medium">NIFTY 50</p>
                                <p class="text-emerald-400 text-xs">23,482 +1.2%</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="relative z-10 px-6 py-20">
        <div class="max-w-7xl mx-auto">
            <div class="text-center mb-16">
                <h2 class="text-4xl font-bold text-white mb-4">Everything You Need to Learn Trading</h2>
                <p class="text-xl text-slate-400 max-w-2xl mx-auto">Professional-grade tools and real market data to help you become a confident trader</p>
            </div>

            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                <div class="glass rounded-2xl p-8 card-hover">
                    <div class="w-14 h-14 bg-emerald-500/10 border border-emerald-500/20 rounded-xl flex items-center justify-center mb-6">
                        <svg class="w-7 h-7 text-emerald-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-3">₹10 Lakh Virtual Money</h3>
                    <p class="text-slate-400">Start with ₹10,00,000 virtual funds. Trade freely without any real financial risk.</p>
                </div>

                <div class="glass rounded-2xl p-8 card-hover">
                    <div class="w-14 h-14 bg-blue-500/10 border border-blue-500/20 rounded-xl flex items-center justify-center mb-6">
                        <svg class="w-7 h-7 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 12l3-3 3 3 4-4M8 21l4-4 4 4M3 4h18M4 4h16v12a1 1 0 01-1 1H5a1 1 0 01-1-1V4z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-3">Real-Time Market Data</h3>
                    <p class="text-slate-400">Access live prices for 2,296+ Indian stocks from NSE and BSE exchanges.</p>
                </div>

                <div class="glass rounded-2xl p-8 card-hover">
                    <div class="w-14 h-14 bg-purple-500/10 border border-purple-500/20 rounded-xl flex items-center justify-center mb-6">
                        <svg class="w-7 h-7 text-purple-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-3">Portfolio Analytics</h3>
                    <p class="text-slate-400">Track your performance with detailed P&L reports, charts, and insights.</p>
                </div>

                <div class="glass rounded-2xl p-8 card-hover">
                    <div class="w-14 h-14 bg-orange-500/10 border border-orange-500/20 rounded-xl flex items-center justify-center mb-6">
                        <svg class="w-7 h-7 text-orange-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-3">Instant Execution</h3>
                    <p class="text-slate-400">Buy and sell stocks instantly. No delays, no waiting for order fulfillment.</p>
                </div>

                <div class="glass rounded-2xl p-8 card-hover">
                    <div class="w-14 h-14 bg-pink-500/10 border border-pink-500/20 rounded-xl flex items-center justify-center mb-6">
                        <svg class="w-7 h-7 text-pink-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-3">Watchlist</h3>
                    <p class="text-slate-400">Create your personalized watchlist to track your favorite stocks.</p>
                </div>

                <div class="glass rounded-2xl p-8 card-hover">
                    <div class="w-14 h-14 bg-cyan-500/10 border border-cyan-500/20 rounded-xl flex items-center justify-center mb-6">
                        <svg class="w-7 h-7 text-cyan-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-semibold text-white mb-3">100% Safe</h3>
                    <p class="text-slate-400">Learn from mistakes without consequences. Your real money stays safe.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="relative z-10 px-6 py-20">
        <div class="max-w-4xl mx-auto">
            <div class="bg-gradient-to-r from-emerald-600 to-emerald-500 rounded-3xl p-12 text-center relative overflow-hidden">
                <div class="absolute inset-0 opacity-10">
                    <div class="absolute inset-0" style="background-image: url('data:image/svg+xml,%3Csvg width=\'60\' height=\'60\' viewBox=\'0 0 60 60\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cg fill=\'none\' fill-rule=\'evenodd\'%3E%3Cg fill=\'%23ffffff\' fill-opacity=\'0.4\'%3E%3Cpath d=\'M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z\'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');"></div>
                </div>
                
                <div class="relative">
                    <h2 class="text-4xl font-bold text-white mb-4">Ready to Start Your Trading Journey?</h2>
                    <p class="text-xl text-emerald-100 mb-8">Join thousands of traders learning to invest wisely</p>
                    <a href="register" class="inline-flex items-center px-8 py-4 bg-white text-emerald-600 font-semibold rounded-xl hover:bg-emerald-50 transition-all hover:shadow-2xl hover:scale-105">
                        Create Free Account
                        <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"></path>
                        </svg>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="relative z-10 border-t border-slate-800 px-6 py-12">
        <div class="max-w-7xl mx-auto">
            <div class="flex flex-col md:flex-row items-center justify-between gap-6">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 bg-emerald-500/10 border border-emerald-500/20 rounded-xl flex items-center justify-center">
                        <svg class="w-6 h-6 text-emerald-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
                        </svg>
                    </div>
                    <span class="text-xl font-bold text-white">Paper Market</span>
                </div>
                <p class="text-slate-500 text-sm">© 2026 Paper Market. All rights reserved. For educational purposes only.</p>
                <div class="flex items-center space-x-6">
                    <a href="#" class="text-slate-400 hover:text-white transition-colors">Terms</a>
                    <a href="#" class="text-slate-400 hover:text-white transition-colors">Privacy</a>
                    <a href="#" class="text-slate-400 hover:text-white transition-colors">Contact</a>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>
