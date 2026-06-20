<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.fashion.store.model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    String initials = "U";
    if (loggedInUser != null && loggedInUser.getFullName() != null && !loggedInUser.getFullName().isEmpty()) {
        String[] parts = loggedInUser.getFullName().trim().split("\\s+");
        initials = parts.length > 1
            ? String.valueOf(parts[0].charAt(0)) + String.valueOf(parts[parts.length - 1].charAt(0))
            : String.valueOf(parts[0].charAt(0));
        initials = initials.toUpperCase();
    }
%>

<!-- PAGE LOADER -->
<div id="page-loader">
    <div class="loader-logo">FAGISTAR</div>
    <div class="loader-bar"><div class="loader-bar-fill"></div></div>
</div>

<!-- NAVBAR -->
<nav class="navbar" id="mainNav">
    <a href="${pageContext.request.contextPath}/" class="nav-logo">FAGI<span>STAR</span></a>

    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/products">Shop</a></li>
        <li><a href="${pageContext.request.contextPath}/products?categoryId=1">Men</a></li>
        <li><a href="${pageContext.request.contextPath}/products?categoryId=2">Women</a></li>
        <li><a href="${pageContext.request.contextPath}/products?categoryId=3">Kids</a></li>
    </ul>

    <div class="nav-actions">
        <% if (loggedInUser != null) { %>
            <a href="${pageContext.request.contextPath}/cart" class="nav-icon-btn" title="Cart">
                🛒
                <span class="nav-badge" id="cartBadge" style="display:none;">0</span>
            </a>
            <a href="${pageContext.request.contextPath}/order?action=list" class="nav-icon-btn" title="My Orders">📦</a>
            <div class="nav-user">
                <a href="${pageContext.request.contextPath}/profile" style="display:flex;align-items:center;gap:10px;">
                    <div class="avatar"><%= initials %></div>
                    <span style="font-size:0.82rem;color:var(--gray-light)"><%= loggedInUser.getFullName().split(" ")[0] %></span>
                </a>
            </div>
            <a href="${pageContext.request.contextPath}/auth?action=logout" class="nav-icon-btn" title="Logout">🚪</a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/auth?action=showLogin" class="btn-outline" style="padding:10px 22px;font-size:0.75rem;">Login</a>
            <a href="${pageContext.request.contextPath}/auth?action=showRegister" class="nav-cta">Get Started</a>
        <% } %>
    </div>
</nav>

<script>
// Navbar scroll effect
window.addEventListener('scroll', () => {
    const nav = document.getElementById('mainNav');
    if (nav) nav.classList.toggle('scrolled', window.scrollY > 50);
});

// Page loader
window.addEventListener('load', () => {
    setTimeout(() => {
        const loader = document.getElementById('page-loader');
        if (loader) loader.classList.add('hidden');
    }, 800);
});
</script>