<%@page import="in.cs.pojo.WalletTransaction"%>
<%@page import="java.util.List"%>
<%@page import="in.cs.pojo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp">
        <jsp:param name="title" value="Funds"/>
    </jsp:include>
    <link rel="stylesheet" href="css/funds.css">
</head>
<body class="bg-slate-950 min-h-screen">
    <div class="flex h-screen">
        <jsp:include page="/WEB-INF/views/common/sidebar.jsp">
            <jsp:param name="activePage" value="funds"/>
        </jsp:include>

        <main class="flex-1 overflow-auto">
            <header class="bg-slate-900/80 backdrop-blur-lg border-b border-slate-800 px-8 py-4 sticky top-0 z-30">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-100">Funds</h1>
                        <p class="text-sm text-slate-400 mt-1">Manage your virtual trading balance</p>
                    </div>
                    <div class="flex items-center space-x-3">
                        <div class="px-4 py-2 bg-slate-800 rounded-xl flex items-center space-x-2">
                            <div class="w-2 h-2 bg-emerald-500 rounded-full animate-pulse"></div>
                            <span class="text-sm text-slate-300">Paper Trading Mode</span>
                        </div>
                    </div>
                </div>
            </header>

<%
User user=(User)session.getAttribute("loggedUser"); 
long balance=0;
if(user!=null){
	balance=user.getBalance();
}
%>
            <div class="p-8">
                <!-- Balance Card -->
                <div class="balance-card rounded-3xl p-8 mb-8 shadow-2xl animate-slideUp relative">
                    <div class="relative z-10">
                        <div class="flex items-start justify-between">
                            <div>
                                <p class="text-emerald-100 text-sm font-medium mb-2 flex items-center space-x-2">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                    </svg>
                                    <span>Available Balance</span>
                                </p>
                                <h2 class="text-5xl font-bold text-white mb-1">
                                
                                     ₹ <%=balance%>
                                </h2>
                                <p class="text-emerald-200 text-sm">Ready to invest</p>
                            </div>
                            <div class="w-20 h-20 bg-white/10 rounded-2xl flex items-center justify-center backdrop-blur-sm border border-white/20">
                                <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Forms Grid -->
                <div class="grid grid-cols-2 gap-8">
                    <!-- Add Funds Form -->
                    <div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 hover-lift animate-slideUp" style="animation-delay: 0.1s">
                        <div class="flex items-center space-x-4 mb-6">
                            <div class="w-14 h-14 bg-gradient-to-br from-emerald-400 to-emerald-600 rounded-xl flex items-center justify-center shadow-lg shadow-emerald-500/20">
                                <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                                </svg>
                            </div>
                            <div>
                                <h3 class="text-xl font-bold text-slate-100">Add Funds</h3>
                                <p class="text-sm text-slate-400">Deposit virtual money to your account</p>
                            </div>
                        </div>

                        <form onsubmit="startDeposit(event)" action="/wallet/create-order" method="POST" class="space-y-5">
                            <div>
                                <label class="block text-sm font-medium text-slate-300 mb-2">Amount</label>
                                <div class="relative">
                                    <span class="absolute left-4 top-4 text-slate-400 text-lg font-medium">₹</span>
                                    <input 
                                        type="number" 
                                        name="amount"
                                       
                                        id="add-amount"
                                        placeholder="0.00" 
                                        class="w-full pl-10 pr-4 py-4 bg-slate-800/50 border border-slate-700 rounded-xl text-slate-100 text-lg font-semibold placeholder-slate-500 focus:outline-none focus:border-emerald-500 focus:ring-2 focus:ring-emerald-500/20 transition-all"
                                        min="0"
                                        step="0.01"
                                        required
                                    >
                                </div>
                            </div>

                            <div class="grid grid-cols-5 gap-2">
                                <button type="button" class="quick-btn px-3 py-2.5 bg-slate-800 hover:bg-emerald-500/20 hover:border-emerald-500/30 text-slate-300 hover:text-emerald-400 text-sm font-medium rounded-lg border border-slate-700 transition-all" onclick="document.getElementById('add-amount').value='1000'">₹1K</button>
                                <button type="button" class="quick-btn px-3 py-2.5 bg-slate-800 hover:bg-emerald-500/20 hover:border-emerald-500/30 text-slate-300 hover:text-emerald-400 text-sm font-medium rounded-lg border border-slate-700 transition-all" onclick="document.getElementById('add-amount').value='5000'">₹5K</button>
                                <button type="button" class="quick-btn px-3 py-2.5 bg-slate-800 hover:bg-emerald-500/20 hover:border-emerald-500/30 text-slate-300 hover:text-emerald-400 text-sm font-medium rounded-lg border border-slate-700 transition-all" onclick="document.getElementById('add-amount').value='10000'">₹10K</button>
                                <button type="button" class="quick-btn px-3 py-2.5 bg-slate-800 hover:bg-emerald-500/20 hover:border-emerald-500/30 text-slate-300 hover:text-emerald-400 text-sm font-medium rounded-lg border border-slate-700 transition-all" onclick="document.getElementById('add-amount').value='50000'">₹50K</button>
                                <button type="button" class="quick-btn px-3 py-2.5 bg-slate-800 hover:bg-emerald-500/20 hover:border-emerald-500/30 text-slate-300 hover:text-emerald-400 text-sm font-medium rounded-lg border border-slate-700 transition-all" onclick="document.getElementById('add-amount').value='100000'">₹1L</button>
                            </div>

                            <button 
                                type="submit"
                                class="w-full px-6 py-4 btn-primary text-white font-semibold rounded-xl flex items-center justify-center space-x-2"
                            >
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                                </svg>
                                <span>Add Funds</span>
                            </button>
                        </form>
                    </div>

                    <!-- Withdraw Funds Form -->
                    <div class="bg-slate-900 border border-slate-800 rounded-2xl p-6 hover-lift animate-slideUp" style="animation-delay: 0.2s">
                        <div class="flex items-center space-x-4 mb-6">
                            <div class="w-14 h-14 bg-gradient-to-br from-rose-400 to-rose-600 rounded-xl flex items-center justify-center shadow-lg shadow-rose-500/20">
                                <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path>
                                </svg>
                            </div>
                            <div>
                                <h3 class="text-xl font-bold text-slate-100">Withdraw Funds</h3>
                                <p class="text-sm text-slate-400">Remove money from your account</p>
                            </div>
                        </div>

                        <form action="withdraw" method="POST" class="space-y-5">
                            <div>
                                <label class="block text-sm font-medium text-slate-300 mb-2">Amount</label>
                                <div class="relative">
                                    <span class="absolute left-4 top-4 text-slate-400 text-lg font-medium">₹</span>
                                    <input 
                                        type="number" 
                                        id="withdraw-amount"
                                        name="amount"
                                        placeholder="0.00" 
                                        class="w-full pl-10 pr-4 py-4 bg-slate-800/50 border border-slate-700 rounded-xl text-slate-100 text-lg font-semibold placeholder-slate-500 focus:outline-none focus:border-rose-500 focus:ring-2 focus:ring-rose-500/20 transition-all"
                                        min="1"
                                        step="1"
                                        required
                                    >
                                </div>
                            </div>

                            <div class="grid grid-cols-5 gap-2">
                                <button type="button" class="quick-btn px-3 py-2.5 bg-slate-800 hover:bg-rose-500/20 hover:border-rose-500/30 text-slate-300 hover:text-rose-400 text-sm font-medium rounded-lg border border-slate-700 transition-all" onclick="document.getElementById('withdraw-amount').value='1000'">₹1K</button>
                                <button type="button" class="quick-btn px-3 py-2.5 bg-slate-800 hover:bg-rose-500/20 hover:border-rose-500/30 text-slate-300 hover:text-rose-400 text-sm font-medium rounded-lg border border-slate-700 transition-all" onclick="document.getElementById('withdraw-amount').value='5000'">₹5K</button>
                                <button type="button" class="quick-btn px-3 py-2.5 bg-slate-800 hover:bg-rose-500/20 hover:border-rose-500/30 text-slate-300 hover:text-rose-400 text-sm font-medium rounded-lg border border-slate-700 transition-all" onclick="document.getElementById('withdraw-amount').value='10000'">₹10K</button>
                                <button type="button" class="quick-btn px-3 py-2.5 bg-slate-800 hover:bg-rose-500/20 hover:border-rose-500/30 text-slate-300 hover:text-rose-400 text-sm font-medium rounded-lg border border-slate-700 transition-all" onclick="document.getElementById('withdraw-amount').value='50000'">₹50K</button>
                                <button type="button" class="quick-btn px-3 py-2.5 bg-slate-800 hover:bg-rose-500/20 hover:border-rose-500/30 text-slate-300 hover:text-rose-400 text-sm font-medium rounded-lg border border-slate-700 transition-all" onclick="setMaxWithdraw()">All</button>
                            </div>

                            <button 
                                type="submit"
                                class="w-full px-6 py-4 btn-danger text-white font-semibold rounded-xl flex items-center justify-center space-x-2"
                            >
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 12H4"></path>
                                </svg>
                                <span>Withdraw Funds</span>
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Transaction History Table -->
                <div class="mt-8 bg-slate-900 border border-slate-800 rounded-2xl overflow-hidden animate-slideUp" style="animation-delay: 0.3s">
                    <div class="p-6 border-b border-slate-800 flex items-center justify-between">
                        <div class="flex items-center space-x-3">
                            <div class="w-10 h-10 bg-slate-800 rounded-lg flex items-center justify-center">
                                <svg class="w-5 h-5 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                            </div>
                            <div>
                                <h3 class="text-lg font-semibold text-slate-100"n>Transaction History</h3>
                                <p class="text-sm text-slate-400" id="transactio-count">0 transactions</p>
                            </div>
                        </div>
                        
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead>
                                <tr class="border-b border-slate-800 bg-slate-800/30">
                                    <th class="text-left py-4 px-6 text-xs font-semibold text-slate-400 uppercase tracking-wider">Date & Time</th>
                                    <th class="text-left py-4 px-6 text-xs font-semibold text-slate-400 uppercase tracking-wider">Type</th>
                                    <th class="text-left py-4 px-6 text-xs font-semibold text-slate-400 uppercase tracking-wider">Description</th>
                                    <th class="text-right py-4 px-6 text-xs font-semibold text-slate-400 uppercase tracking-wider">Amount</th>
                                    <th class="text-right py-4 px-6 text-xs font-semibold text-slate-400 uppercase tracking-wider">Balance</th>
                                </tr>
                            </thead>
                            <tbody id="transactions-tbody">

<%
List<WalletTransaction> transactions =
        (List<WalletTransaction>) request.getAttribute("list");

    if (transactions == null || transactions.isEmpty()) {
%>

    
    <tr>
        <td colspan="5" class="px-6 py-16 text-center">
            <h3 class="text-xl font-semibold text-slate-100 mb-2">
                No transactions yet
            </h3>
            <p class="text-slate-400">
                Add funds to start paper trading
            </p>
        </td>
    </tr>

<%
} else {
        for (WalletTransaction txn : transactions) {
%>

    
    <tr class="border-b border-slate-800 text-slate-100">

        <td class="text-left py-4 px-6">
           <%=txn.getDatetime() %>
           
        </td>

        <td class="text-left py-4 px-6">
           <%=txn.getType() %>
        </td>

        <td class="text-left py-4 px-6">
           <%=txn.getDescription() %>
        </td>

        <td class="text-right py-4 px-6">
           <%=txn.getAmmount() %>
        </td>

        <td class="text-right py-4 px-6">
          <%=txn.getBalance() %>
        </td>

    </tr>

<%
        }
    }
%>

</tbody>

                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

   <script>
        function setMaxWithdraw() {
            var balance = <%= request.getAttribute("availableBalance") != null ? request.getAttribute("availableBalance") : 0.0 %>;
            document.getElementById('withdraw-amount').value = balance.toFixed(2);
        }
</script>
       
<script>
function startDeposit(event) {
    event.preventDefault(); 

    let amount = document.getElementById("add-amount").value;

    if (!amount || amount <= 0) {
        alert("Please enter valid amount");
        return;
    }

    
    fetch("<%=request.getContextPath()%>/create-order?amount=" + amount, {
        method: "POST"
    })
    .then(response => response.json())
    .then(order => {

        
        var options = {
            key: "rzp_test_RugB55jp26V8wq",
            amount: order.amount,
            currency: "INR",
            order_id: order.id,

            handler: function (response) {
              
                verifyPayment(response, amount);
            }
        };

        var rzp = new Razorpay(options);
        rzp.open();
    })
    .catch(error => {
        console.error(error);
        alert("Order creation failed");
    });
}

function verifyPayment(response, amount) {

    fetch("<%=request.getContextPath()%>/verify", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body:
            "razorpay_order_id=" + response.razorpay_order_id +
            "&razorpay_payment_id=" + response.razorpay_payment_id +
            "&razorpay_signature=" + response.razorpay_signature +
            "&amount=" + amount
    })
    .then(() => {
        alert("Deposit successful");
         location.reload();  	
        
    })
    .catch(error => {
        console.error(error);
        alert("Payment verification failed");
    });
}
</script>




 
