<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="<%= request.getContextPath() %>/">
    <title>Register - Paper Market</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
        }
        @keyframes pulse-glow {
            0%, 100% { box-shadow: 0 0 20px rgba(16, 185, 129, 0.2); }
            50% { box-shadow: 0 0 40px rgba(16, 185, 129, 0.4); }
        }
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .animate-float { animation: float 6s ease-in-out infinite; }
        .animate-float-delay { animation: float 6s ease-in-out infinite; animation-delay: -3s; }
        .animate-pulse-glow { animation: pulse-glow 3s ease-in-out infinite; }
        .animate-slideUp { animation: slideUp 0.6s ease-out forwards; }
        .animate-fadeIn { animation: fadeIn 0.8s ease-out forwards; }
        .glass-card {
            background: rgba(15, 23, 42, 0.8);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(148, 163, 184, 0.1);
        }
        .input-glow:focus {
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1), 0 0 20px rgba(16, 185, 129, 0.1);
        }
        .btn-shine {
            position: relative;
            overflow: hidden;
        }
        .btn-shine::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(to right, transparent, rgba(255,255,255,0.1), transparent);
            transform: rotate(45deg);
            animation: shine 3s infinite;
        }
        @keyframes shine {
            0% { left: -50%; }
            100% { left: 150%; }
        }
        .floating-shape {
            position: absolute;
            border-radius: 50%;
            filter: blur(60px);
            opacity: 0.3;
        }
        .photo-upload-area {
            transition: all 0.3s ease;
        }
        .photo-upload-area:hover {
            border-color: rgba(16, 185, 129, 0.5);
            background: rgba(16, 185, 129, 0.05);
        }
        .photo-upload-area.has-image {
            border-color: rgba(16, 185, 129, 0.5);
        }
        .password-strength {
            height: 4px;
            border-radius: 2px;
            transition: all 0.3s ease;
        }
    </style>
</head>
<body class="bg-slate-950 min-h-screen flex items-center justify-center p-4 overflow-x-hidden relative">
    <!-- Animated Background -->
    <div class="fixed inset-0 overflow-hidden pointer-events-none">
        <div class="floating-shape w-96 h-96 bg-emerald-500 -top-20 -left-48 animate-float"></div>
        <div class="floating-shape w-80 h-80 bg-cyan-500 bottom-0 right-0 animate-float-delay"></div>
        <div class="floating-shape w-64 h-64 bg-purple-500 top-1/3 right-1/4 animate-float"></div>
    </div>

    <!-- Grid Pattern Overlay -->
    <div class="fixed inset-0 opacity-[0.02] pointer-events-none" style="background-image: url('data:image/svg+xml,%3Csvg width=&quot;60&quot; height=&quot;60&quot; viewBox=&quot;0 0 60 60&quot; xmlns=&quot;http://www.w3.org/2000/svg&quot;%3E%3Cg fill=&quot;none&quot; fill-rule=&quot;evenodd&quot;%3E%3Cg fill=&quot;%23ffffff&quot; fill-opacity=&quot;1&quot;%3E%3Cpath d=&quot;M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z&quot;/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');"></div>

    <!-- Register Container -->
    <div class="w-full max-w-2xl my-8 relative z-10">
        <!-- Logo & Title -->
        <div class="text-center mb-8 animate-slideUp" style="animation-delay: 0.1s; opacity: 0;">
            <a href="./" class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-emerald-500/20 to-cyan-500/20 border border-emerald-500/30 rounded-2xl mb-4 animate-pulse-glow">
                <svg class="w-10 h-10 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
                </svg>
            </a>
            <h1 class="text-4xl font-bold bg-gradient-to-r from-slate-100 via-emerald-200 to-slate-100 bg-clip-text text-transparent mb-2">Paper Market</h1>
            <p class="text-slate-400">Start your paper trading journey today</p>
        </div>

        <!-- Flash Messages -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="mb-4 p-4 bg-red-500/10 border border-red-500/20 rounded-xl text-red-400 text-sm animate-slideUp">
                <div class="flex items-center space-x-2">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <span>${error}</span>
                </div>
            </div>
        <% } %>

        <!-- Register Card -->
        <div class="glass-card rounded-2xl p-8 shadow-2xl animate-slideUp" style="animation-delay: 0.2s; opacity: 0;">
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-xl font-semibold text-slate-100">Create your account</h2>
            </div>
            
            <!-- Register Form -->
            <form action="register" method="POST" enctype="multipart/form-data" class="space-y-5" id="registerForm">
                <!-- CSRF Token (if using Spring Security) -->
                <% if (request.getAttribute("_csrf") != null) { %>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <% } %>
                
                <!-- Full Name Field -->
                <div>
                    <label for="fullName" class="block text-sm font-medium text-slate-300 mb-2">Full Name *</label>
                    <input 
                        type="text" 
                        id="fullName" 
                        name="name"
                        required
                        class="w-full px-4 py-3.5 bg-slate-950/50 border border-slate-700 rounded-xl text-slate-100 placeholder-slate-500 focus:outline-none focus:border-emerald-500 input-glow transition-all duration-300" 
                        placeholder="John Doe"
                        value="${param.fullName}"
                    >
                </div>

                <!-- Email Field + OTP -->
                <div>
                    <label for="email" class="block text-sm font-medium text-slate-300 mb-2">Email Address *</label>
                    <div class="flex flex-col sm:flex-row gap-3">
                        <input 
                            type="email" 
                            id="email" 
                            name="email"
                            required
                            class="w-full px-4 py-3.5 bg-slate-950/50 border border-slate-700 rounded-xl text-slate-100 placeholder-slate-500 focus:outline-none focus:border-emerald-500 input-glow transition-all duration-300" 
                            placeholder="you@example.com"
                            value="${param.email}"
                        >
                        <button 
                            type="button" 
                            id="sendOtpBtn"
                            class="btn-shine px-5 py-3.5 bg-slate-800/60 hover:bg-slate-700/60 border border-slate-600 rounded-xl text-slate-100 text-sm font-semibold transition-all duration-300 whitespace-nowrap"
                        >
                            Send OTP
                        </button>
                    </div>
                    <p id="otpHint" class="text-xs text-slate-500 mt-2 hidden">OTP sent. Please check your inbox.</p>
                </div>

                <!-- OTP Box (Hidden until Send OTP) -->
                <div id="otpBox" class="hidden">
                    <label for="otp" class="block text-sm font-medium text-slate-300 mb-2">Enter OTP *</label>
                    <input 
                        type="text" 
                        id="otp" 
                        name="otp"
                        inputmode="numeric"
                        pattern="[0-9]{4,6}"
                        maxlength="6"
                        class="w-full px-4 py-3.5 bg-slate-950/50 border border-slate-700 rounded-xl text-slate-100 placeholder-slate-500 focus:outline-none focus:border-emerald-500 input-glow transition-all duration-300 tracking-widest"
                        placeholder="Enter 4-6 digit OTP"
                    >
                </div>

                <!-- Phone Number Field -->
                <div>
                    <label for="phone" class="block text-sm font-medium text-slate-300 mb-2">Phone Number *</label>
                    <div class="relative">
                        <span class="absolute left-4 top-1/2 -translate-y-1/2 text-slate-500">+91</span>
                        <input 
                            type="tel" 
                            id="phone" 
                            name="phone"
                            required
                            pattern="[0-9]{10}"
                            class="w-full pl-14 pr-4 py-3.5 bg-slate-950/50 border border-slate-700 rounded-xl text-slate-100 placeholder-slate-500 focus:outline-none focus:border-emerald-500 input-glow transition-all duration-300" 
                            placeholder="9876543210"
                            value="${param.phone}"
                        >
                    </div>
                    <p class="text-xs text-slate-500 mt-1.5">Enter 10-digit mobile number</p>
                </div>

                <!-- Password Field -->
                <div>
                    <label for="password" class="block text-sm font-medium text-slate-300 mb-2">Password *</label>
                    <div class="relative">
                        <input 
                            type="password" 
                            id="password" 
                            name="password"
                            required
                            minlength="8"
                            oninput="checkPasswordStrength(this.value)"
                            class="w-full px-4 py-3.5 bg-slate-950/50 border border-slate-700 rounded-xl text-slate-100 placeholder-slate-500 focus:outline-none focus:border-emerald-500 input-glow transition-all duration-300" 
                            placeholder="••••••••"
                        >
                        <button type="button" onclick="togglePassword('password')" class="absolute right-4 top-1/2 -translate-y-1/2 text-slate-500 hover:text-slate-300 transition-colors">
                            <svg class="w-5 h-5 eye-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                            </svg>
                        </button>
                    </div>
                    <!-- Password Strength Indicator -->
                    <div class="mt-2">
                        <div class="flex space-x-1">
                            <div id="strength-1" class="password-strength flex-1 bg-slate-700"></div>
                            <div id="strength-2" class="password-strength flex-1 bg-slate-700"></div>
                            <div id="strength-3" class="password-strength flex-1 bg-slate-700"></div>
                            <div id="strength-4" class="password-strength flex-1 bg-slate-700"></div>
                        </div>
                        <p id="strength-text" class="text-xs text-slate-500 mt-1.5">Minimum 8 characters</p>
                    </div>
                </div>

                <!-- Confirm Password Field -->
                <div>
                    <label for="confirmPassword" class="block text-sm font-medium text-slate-300 mb-2">Confirm Password *</label>
                    <div class="relative">
                        <input 
                            type="password" 
                            id="confirmPassword" 
                            name="confirmPassword"
                            required
                            minlength="8"
                            class="w-full px-4 py-3.5 bg-slate-950/50 border border-slate-700 rounded-xl text-slate-100 placeholder-slate-500 focus:outline-none focus:border-emerald-500 input-glow transition-all duration-300" 
                            placeholder="••••••••"
                        >
                        <button type="button" onclick="togglePassword('confirmPassword')" class="absolute right-4 top-1/2 -translate-y-1/2 text-slate-500 hover:text-slate-300 transition-colors">
                            <svg class="w-5 h-5 eye-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                            </svg>
                        </button>
                    </div>
                </div>

                <!-- PAN Card Number -->
                <div>
                    <label for="panCard" class="block text-sm font-medium text-slate-300 mb-2">PAN Card Number *</label>
                    <input 
                        type="text" 
                        id="panCard" 
                        name="panCard"
                        required
                        pattern="[A-Z]{5}[0-9]{4}[A-Z]{1}"
                        maxlength="10"
                        oninput="this.value = this.value.toUpperCase()"
                        class="w-full px-4 py-3.5 bg-slate-950/50 border border-slate-700 rounded-xl text-slate-100 placeholder-slate-500 uppercase focus:outline-none focus:border-emerald-500 input-glow transition-all duration-300 tracking-wider font-mono" 
                        placeholder="ABCDE1234F"
                        value="${param.panCard}"
                    >
                    <p class="text-xs text-slate-500 mt-1.5">Format: ABCDE1234F</p>
                </div>

                <!-- Photo Upload -->
                <div>
                    <label class="block text-sm font-medium text-slate-300 mb-2">Profile Photo *</label>
                    <div class="flex items-center space-x-4">
                        <div id="photoPreview" class="photo-upload-area w-24 h-24 bg-slate-950/50 border-2 border-dashed border-slate-600 rounded-2xl flex items-center justify-center overflow-hidden flex-shrink-0 cursor-pointer" onclick="document.getElementById('photo').click()">
                            <svg id="photoPlaceholder" class="w-10 h-10 text-slate-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                            </svg>
                        </div>
                        <div class="flex-1">
                            <label for="photo" class="cursor-pointer inline-block">
                                <div class="px-5 py-3 bg-slate-800/50 hover:bg-slate-700/50 border border-slate-600 rounded-xl text-slate-100 text-sm font-medium transition-all duration-300 inline-flex items-center space-x-2 hover:scale-[1.02] active:scale-[0.98]">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                    </svg>
                                    <span id="photoLabel">Choose Photo</span>
                                </div>
                            </label>
                            <input 
                                type="file" 
                                id="photo" 
                                name="photo"
                                required
                                accept="image/*"
                                class="hidden"
                                onchange="handlePhotoUpload(event)"
                            >
                            <p class="text-xs text-slate-500 mt-2">JPG, PNG - Max 2MB</p>
                        </div>
                    </div>
                </div>

                <!-- Terms & Conditions -->
                <div class="pt-2">
                    <label class="flex items-start cursor-pointer group">
                        <input type="checkbox" name="terms" required class="w-5 h-5 mt-0.5 rounded-md border-slate-600 bg-slate-950 text-emerald-500 focus:ring-emerald-500 focus:ring-offset-0 cursor-pointer">
                        <span class="ml-3 text-sm text-slate-400 group-hover:text-slate-300 transition-colors">
                            I agree to the <a href="#" class="text-emerald-400 hover:text-emerald-300 font-medium">Terms of Service</a> and 
                            <a href="#" class="text-emerald-400 hover:text-emerald-300 font-medium">Privacy Policy</a>
                        </span>
                    </label>
                </div>

                <!-- Sign Up Button -->
                <button 
                    type="submit" 
                    class="btn-shine w-full bg-gradient-to-r from-emerald-500 to-emerald-600 hover:from-emerald-600 hover:to-emerald-700 text-white font-semibold py-3.5 px-4 rounded-xl transition-all duration-300 shadow-lg shadow-emerald-500/25 hover:shadow-emerald-500/40 hover:scale-[1.02] active:scale-[0.98]"
                >
                    Create Account
                </button>
            </form>

            <!-- Sign In Link -->
            <p class="text-center text-sm text-slate-400 mt-6">
                Already have an account? 
                <a href="login" class="text-emerald-400 hover:text-emerald-300 font-semibold transition-colors">Sign in</a>
            </p>
        </div>

        <!-- Security Badge -->
        <div class="text-center mt-6 animate-fadeIn" style="animation-delay: 0.5s; opacity: 0;">
            <div class="inline-flex items-center space-x-2 text-slate-500 text-xs">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                </svg>
                <span>Your data is protected with bank-grade security</span>
            </div>
        </div>
    </div>

    <script>
        function handlePhotoUpload(event) {
            const file = event.target.files[0];
            if (file) {
                if (file.size > 2 * 1024 * 1024) {
                    alert('File size must be less than 2MB');
                    event.target.value = '';
                    return;
                }
                if (!file.type.startsWith('image/')) {
                    alert('Please upload an image file');
                    event.target.value = '';
                    return;
                }
                const reader = new FileReader();
                reader.onload = function(e) {
                    const preview = document.getElementById('photoPreview');
                    const placeholder = document.getElementById('photoPlaceholder');
                    if (placeholder) placeholder.style.display = 'none';
                    preview.innerHTML = '<img src="' + e.target.result + '" alt="Preview" class="w-full h-full object-cover">';
                    preview.classList.add('has-image');
                };
                reader.readAsDataURL(file);
                document.getElementById('photoLabel').innerHTML = '<svg class="w-4 h-4 mr-1 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>' + file.name.substring(0, 15) + (file.name.length > 15 ? '...' : '');
            }
        }

        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            const eyeIcon = input.parentElement.querySelector('.eye-icon');
            if (input.type === 'password') {
                input.type = 'text';
                eyeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21"></path>';
            } else {
                input.type = 'password';
                eyeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>';
            }
        }

        function checkPasswordStrength(password) {
            const strength1 = document.getElementById('strength-1');
            const strength2 = document.getElementById('strength-2');
            const strength3 = document.getElementById('strength-3');
            const strength4 = document.getElementById('strength-4');
            const strengthText = document.getElementById('strength-text');
            
            let score = 0;
            if (password.length >= 8) score++;
            if (password.match(/[a-z]/) && password.match(/[A-Z]/)) score++;
            if (password.match(/\d/)) score++;
            if (password.match(/[^a-zA-Z\d]/)) score++;
            
            const colors = ['bg-slate-700', 'bg-rose-500', 'bg-amber-500', 'bg-emerald-400', 'bg-emerald-500'];
            const texts = ['Minimum 8 characters', 'Weak password', 'Fair password', 'Good password', 'Strong password'];
            const textColors = ['text-slate-500', 'text-rose-400', 'text-amber-400', 'text-emerald-400', 'text-emerald-400'];
            
            [strength1, strength2, strength3, strength4].forEach((el, i) => {
                el.className = 'password-strength flex-1 ' + (i < score ? colors[score] : 'bg-slate-700');
            });
            
            strengthText.textContent = texts[score];
            strengthText.className = 'text-xs mt-1.5 ' + textColors[score];
        }

        const emailInput = document.getElementById('email');
        const sendOtpBtn = document.getElementById('sendOtpBtn');
        const otpBox = document.getElementById('otpBox');
        const otpHint = document.getElementById('otpHint');

        function isValidEmail(email) {
            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
        }

        sendOtpBtn.addEventListener('click', function() {
            const email = emailInput.value.trim();
            if (!isValidEmail(email)) {
                alert('Please enter a valid email address before sending OTP.');
                emailInput.focus();
                return;
            }
            otpBox.classList.remove('hidden');
            otpHint.classList.remove('hidden');
            const otpInput = document.getElementById('otp');
            if (otpInput) otpInput.focus();
        });

        // Form validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return false;
            }
            
            const panCard = document.getElementById('panCard').value.toUpperCase();
            const panRegex = /^[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
            if (!panRegex.test(panCard)) {
                e.preventDefault();
                alert('Invalid PAN card format. Please use format: ABCDE1234F');
                return false;
            }
            
            const phone = document.getElementById('phone').value;
            if (phone.length !== 10) {
                e.preventDefault();
                alert('Please enter a valid 10-digit phone number');
                return false;
            }
        });
    </script>
</body>
</html>
