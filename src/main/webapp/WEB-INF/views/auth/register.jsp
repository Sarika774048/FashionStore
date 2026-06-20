<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account – FAGISTAR Fashion Store</title>
    <meta name="description" content="Join FAGISTAR to shop premium fashion with exclusive member benefits.">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { overflow-y: auto; }
        .auth-page { min-height: 100vh; }
        @media(min-width:1024px) { .auth-panel { overflow-y: auto; max-height: 100vh; } }
    </style>
</head>
<body>

<div id="page-loader">
    <div class="loader-logo">FAGISTAR</div>
    <div class="loader-bar"><div class="loader-bar-fill"></div></div>
</div>

<div class="auth-page">

    <!-- Visual -->
    <div class="auth-visual" style="position:sticky;top:0;height:100vh;">
        <img src="https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=1200&q=85&fit=crop"
             alt="Fashion">
        <div class="auth-visual-overlay"></div>
        <div class="auth-visual-content">
            <h2>Join the Fashion<br>Revolution.</h2>
            <p>70,000+ happy customers trust FAGISTAR for their style.</p>
        </div>
        <div style="position:absolute;top:40px;right:40px;">
            <div style="font-family:var(--font-display);font-size:1.8rem;letter-spacing:4px;color:var(--gold);opacity:0.9;">FAGISTAR</div>
        </div>
    </div>

    <!-- Form Panel -->
    <div class="auth-panel" style="overflow-y:auto;padding-top:60px;padding-bottom:60px;">
        <a href="${pageContext.request.contextPath}/" class="auth-logo">FAGI<span style="color:var(--white)">STAR</span></a>

        <h1 class="auth-title">Create Account</h1>
        <p class="auth-subtitle">Start your style journey with us today</p>

        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="alert alert-error">⚠️ <%= errorMessage %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/auth?action=register" method="post" id="regForm">

            <div class="form-group">
                <label class="form-label" for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName"
                       class="form-input" placeholder="Your Full Name" required
                       autocomplete="name">
            </div>

            <div class="form-grid-2">
                <div class="form-group">
                    <label class="form-label" for="email">Email</label>
                    <input type="email" id="email" name="email"
                           class="form-input" placeholder="you@email.com" required
                           autocomplete="email">
                </div>
                <div class="form-group">
                    <label class="form-label" for="phone">Phone</label>
                    <input type="text" id="phone" name="phone"
                           class="form-input" placeholder="+91 98765 43210" required>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <input type="password" id="password" name="password"
                       class="form-input" placeholder="Min. 8 characters" required
                       autocomplete="new-password">
            </div>

            <div class="form-group">
                <label class="form-label" for="addressLine">Street Address</label>
                <input type="text" id="addressLine" name="addressLine"
                       class="form-input" placeholder="123 Main Street" required>
            </div>

            <div class="form-grid-2">
                <div class="form-group">
                    <label class="form-label" for="city">City</label>
                    <input type="text" id="city" name="city"
                           class="form-input" placeholder="Mumbai" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="state">State</label>
                    <input type="text" id="state" name="state"
                           class="form-input" placeholder="Maharashtra" required>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="pincode">Pincode</label>
                <input type="text" id="pincode" name="pincode"
                       class="form-input" placeholder="400001" required maxlength="6">
            </div>

            <button type="submit" class="btn-auth" id="regBtn">
                Create My Account
            </button>
        </form>

        <p class="auth-link">
            Already have an account?
            <a href="${pageContext.request.contextPath}/auth?action=showLogin">Sign in →</a>
        </p>

        <div style="margin-top:32px;padding-top:20px;border-top:1px solid rgba(255,255,255,0.06);">
            <p style="font-size:0.78rem;color:var(--gray);text-align:center;">
                By creating an account you agree to our <span style="color:var(--gold);">Terms of Service</span> & <span style="color:var(--gold);">Privacy Policy</span>
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
document.getElementById('regForm').addEventListener('submit', () => {
    const btn = document.getElementById('regBtn');
    btn.textContent = 'Creating account...';
    btn.style.opacity = '0.7';
});
</script>
</body>
</html>