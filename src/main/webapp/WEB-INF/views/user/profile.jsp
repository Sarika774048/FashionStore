<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.fashion.store.model.User" %>
<%
    User user = (User) request.getAttribute("user");
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");
    String initials = "U";
    if (user != null && user.getFullName() != null && !user.getFullName().isEmpty()) {
        String[] parts = user.getFullName().trim().split("\\s+");
        initials = parts.length > 1
            ? String.valueOf(parts[0].charAt(0)) + String.valueOf(parts[parts.length - 1].charAt(0))
            : String.valueOf(parts[0].charAt(0));
        initials = initials.toUpperCase();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile – FAGISTAR</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="profile-layout">

    <!-- ── Sidebar ── -->
    <div class="profile-sidebar animate-in">
        <div class="profile-avatar-wrap"><%= initials %></div>
        <div class="profile-name"><%= user != null ? user.getFullName() : "" %></div>
        <div class="profile-email"><%= user != null ? user.getEmail() : "" %></div>

        <div class="profile-sidebar-links">
            <a href="${pageContext.request.contextPath}/profile" class="profile-sidebar-link active">
                👤 Profile Settings
            </a>
            <a href="${pageContext.request.contextPath}/order?action=list" class="profile-sidebar-link">
                📦 My Orders
            </a>
            <a href="${pageContext.request.contextPath}/cart" class="profile-sidebar-link">
                🛒 My Cart
            </a>
            <a href="${pageContext.request.contextPath}/auth?action=logout" class="profile-sidebar-link" style="color:var(--red);margin-top:16px;">
                🚪 Logout
            </a>
        </div>
    </div>

    <!-- ── Form Panel ── -->
    <div class="profile-form-panel animate-in delay-2">
        <div class="profile-form-header">
            <div class="profile-form-title">Profile Settings</div>
        </div>
        <div class="profile-form-body">

            <% if (errorMessage != null) { %>
                <div class="alert alert-error">⚠️ <%= errorMessage %></div>
            <% } %>
            <% if (successMessage != null) { %>
                <div class="alert alert-success">✅ <%= successMessage %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/profile" method="post">

                <div class="form-group">
                    <label class="form-label">Email Address (Cannot be changed)</label>
                    <input type="text" value="<%= user != null ? user.getEmail() : "" %>"
                           disabled class="form-input" style="opacity:0.5;cursor:not-allowed;">
                </div>

                <div class="form-group">
                    <label class="form-label" for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName"
                           value="<%= user != null ? user.getFullName() : "" %>"
                           class="form-input" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="phone">Phone Number</label>
                    <input type="text" id="phone" name="phone"
                           value="<%= user != null ? user.getPhone() : "" %>"
                           class="form-input" required>
                </div>

                <div style="font-size:0.75rem;letter-spacing:2px;text-transform:uppercase;color:var(--gold);margin:24px 0 16px;">Delivery Address</div>

                <div class="form-group">
                    <label class="form-label" for="addressLine">Street Address</label>
                    <input type="text" id="addressLine" name="addressLine"
                           value="<%= user != null && user.getAddressLine() != null ? user.getAddressLine() : "" %>"
                           class="form-input" required>
                </div>

                <div class="form-grid-2">
                    <div class="form-group">
                        <label class="form-label" for="city">City</label>
                        <input type="text" id="city" name="city"
                               value="<%= user != null && user.getCity() != null ? user.getCity() : "" %>"
                               class="form-input" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="state">State</label>
                        <input type="text" id="state" name="state"
                               value="<%= user != null && user.getState() != null ? user.getState() : "" %>"
                               class="form-input" required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="pincode">Pincode</label>
                    <input type="text" id="pincode" name="pincode"
                           value="<%= user != null && user.getPincode() != null ? user.getPincode() : "" %>"
                           class="form-input" required maxlength="6">
                </div>

                <button type="submit" class="btn-auth" style="margin-top:8px;">
                    Save Changes →
                </button>
            </form>
        </div>
    </div>

</div>

<footer class="footer" style="padding:40px 64px;margin-top:20px;">
    <div class="footer-bottom" style="border-top:none;padding-top:0;">
        <span class="footer-copy">© 2025 FAGISTAR Fashion Store. All rights reserved.</span>
        <a href="${pageContext.request.contextPath}/" style="font-family:var(--font-display);font-size:1.5rem;letter-spacing:3px;color:var(--gold);">FAGISTAR</a>
    </div>
</footer>

<script>
const obs = new IntersectionObserver(entries => {
    entries.forEach(e => {
        if (e.isIntersecting) { e.target.style.opacity='1'; e.target.style.transform='translateY(0)'; }
    });
}, { threshold: 0.1 });
document.querySelectorAll('.animate-in').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(20px)';
    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    obs.observe(el);
});
</script>
</body>
</html>