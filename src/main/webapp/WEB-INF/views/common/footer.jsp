<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 
    Footer Component - Common footer for all pages
    Usage: <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
--%>
<footer class="py-6 text-center border-t border-slate-800/50">
    <div class="container mx-auto px-4">
        <div class="flex flex-col md:flex-row items-center justify-between space-y-4 md:space-y-0">
            <!-- Logo -->
            <div class="flex items-center space-x-2">
                <div class="w-8 h-8 bg-emerald-500/10 border border-emerald-500/20 rounded-lg flex items-center justify-center">
                    <svg class="w-4 h-4 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
                    </svg>
                </div>
                <span class="text-slate-400 text-sm font-medium">Paper Market</span>
            </div>
            
            <!-- Links -->
            <div class="flex items-center space-x-6">
                <a href="about" class="text-sm text-slate-500 hover:text-emerald-400 transition-colors">About</a>
                <a href="terms" class="text-sm text-slate-500 hover:text-emerald-400 transition-colors">Terms</a>
                <a href="privacy" class="text-sm text-slate-500 hover:text-emerald-400 transition-colors">Privacy</a>
                <a href="contact" class="text-sm text-slate-500 hover:text-emerald-400 transition-colors">Contact</a>
            </div>
            
            <!-- Copyright -->
            <p class="text-sm text-slate-500">
                &copy; 2026 Paper Market. All rights reserved.
            </p>
        </div>
        
        <!-- Disclaimer -->
        <p class="text-xs text-slate-600 mt-4 max-w-2xl mx-auto">
            Paper Market is a simulated trading platform for educational purposes only. 
            No real money is involved. Stock prices are for demonstration purposes.
        </p>
    </div>
</footer>
