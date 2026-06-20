<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login – FAGISTAR Fashion Store</title>
    <meta name="description" content="Sign in to your FAGISTAR account to shop premium fashion.">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body style="overflow:hidden;">

<!-- Page Loader -->
<div id="page-loader">
    <div class="loader-logo">FAGISTAR</div>
    <div class="loader-bar"><div class="loader-bar-fill"></div></div>
</div>

<div class="auth-page">

    <!-- ── Visual Side ── -->
    <div class="auth-visual">
        <img src="https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=1200&q=85&fit=crop"
             alt="Fashion">
        <div class="auth-visual-overlay"></div>
        <div class="auth-visual-content">
            <h2>Style is a way<br>to say who you are.</h2>
            <p>Discover exclusive fashion curated just for you.</p>
        </div>
        <!-- floating cards -->
        <div style="position:absolute;top:40px;right:40px;text-align:right;">
            <div style="font-family:var(--font-display);font-size:1.8rem;letter-spacing:4px;color:var(--gold);opacity:0.9;">FAGISTAR</div>
        </div>
    </div>

    <!-- ── Auth Panel ── -->
    <div class="auth-panel">
        <a href="${pageContext.request.contextPath}/" class="auth-logo">FAGI<span style="color:var(--white)">STAR</span></a>

        <h1 class="auth-title">Welcome Back</h1>
        <p class="auth-subtitle">Sign in to continue shopping premium fashion</p>

        <!-- Error message -->
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="alert alert-error">⚠️ <%= errorMessage %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/auth?action=login" method="post" id="loginForm">

            <div class="form-group">
                <label class="form-label" for="email">Email Address</label>
                <input type="email" id="email" name="email"
                       class="form-input" placeholder="you@example.com" required
                       autocomplete="email">
            </div>

            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <input type="password" id="password" name="password"
                       class="form-input" placeholder="••••••••" required
                       autocomplete="current-password">
            </div>

            <button type="submit" class="btn-auth" id="loginBtn">
                Sign In
            </button>
        </form>

        <p class="auth-link">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/auth?action=showRegister">Create one free →</a>
        </p>

        <div style="margin-top:40px;padding-top:24px;border-top:1px solid rgba(255,255,255,0.06);">
            <p style="font-size:0.78rem;color:var(--gray);text-align:center;">
                By signing in you agree to our <span style="color:var(--gold);">Terms of Service</span> & <span style="color:var(--gold);">Privacy Policy</span>
            </p>
        </div>
    </div>
</div>

<script>
window.addEventListener('load', () => {
    setTimeout(() => {
        const loader = document.getElementById('page-loader');
        if (loader) loader.classList.add('hidden');
    }, 700);
});

document.getElementById('loginForm').addEventListener('submit', function() {
    const btn = document.getElementById('loginBtn');
    btn.textContent = 'Signing in...';
    btn.style.opacity = '0.7';
});
</script>
</body>
</html>