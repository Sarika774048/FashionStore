<%@ page import="java.util.List" %>
<%@ page import="com.fashion.store.model.Product" %>
<%@ page import="com.fashion.store.model.ProductVariant" %>
<%@ page import="com.fashion.store.service.ProductVariantService" %>
<%@ page import="com.fashion.store.model.User" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    String categoryName = (String) request.getAttribute("categoryName");
    if (categoryName == null) categoryName = "All";
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    ProductVariantService variantService = new ProductVariantService();

    // Fashion image pool from Unsplash (keyed by product index mod length)
    String[] menImages = {
        "https://images.unsplash.com/photo-1544441893-675973e31985?w=500&q=80&fit=crop",
        "https://images.unsplash.com/photo-1552374196-1ab2a1c593e8?w=500&q=80&fit=crop",
        "https://images.unsplash.com/photo-1490578474895-699cd4e2cf59?w=500&q=80&fit=crop",
        "https://images.unsplash.com/photo-1503341455253-b2e723bb3dbb?w=500&q=80&fit=crop",
        "https://images.unsplash.com/photo-1617137968427-85924c800a22?w=500&q=80&fit=crop",
        "https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=500&q=80&fit=crop",
        "https://images.unsplash.com/photo-1622470953794-aa9c70b0fb9d?w=500&q=80&fit=crop",
        "https://images.unsplash.com/photo-1434389677669-e08b4cac3105?w=500&q=80&fit=crop"
    };
    String[] womenImages = {
        "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=500&q=80&fit=crop",
        "https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=500&q=80&fit=crop",
        "https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=500&q=80&fit=crop",
        "https://images.unsplash.com/photo-1485518882345-15568b007407?w=500&q=80&fit=crop",
        "https://images.unsplash.com/photo-1487222477894-8943e31ef7b2?w=500&q=80&fit=crop",
        "https://images.unsplash.com/photo-1475180098004-ca77a66827be?w=500&q=80&fit=crop",
        "https://images.unsplash.com/photo-1552173979-02e9d7f5e7c4?w=500&q=80&fit=crop",
        "https://images.unsplash.com/photo-1559582930-28df6c87b5d1?w=500&q=80&fit=crop"
    };
    String[] badges = {"New", "Sale", "New", "", "New", "", "Sale", ""};
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= categoryName %> Products – FAGISTAR Fashion Store</title>
    <meta name="description" content="Browse our curated <%= categoryName %> collection of premium fashion at FAGISTAR.">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<!-- Page Hero -->
<div class="page-hero">
    <div class="section-label">Our Collection</div>
    <h1 class="page-hero-title">
        <em><%= categoryName %></em> Products
    </h1>
    <p style="color:var(--gray);margin-top:12px;font-size:0.95rem;">
        Discover <%= products != null ? products.size() : 0 %> curated fashion pieces
    </p>
</div>

<!-- Filters Bar -->
<div class="filters-bar">
    <div class="filter-tags">
        <a href="${pageContext.request.contextPath}/products" class="filter-tag <%= "All".equals(categoryName) ? "active" : "" %>">All</a>
        <a href="${pageContext.request.contextPath}/products?categoryId=1" class="filter-tag">Men</a>
        <a href="${pageContext.request.contextPath}/products?categoryId=2" class="filter-tag">Women</a>
        <a href="${pageContext.request.contextPath}/products?categoryId=3" class="filter-tag">Kids</a>
    </div>
    <div style="font-size:0.82rem;color:var(--gray);">
        <%= products != null ? products.size() : 0 %> items found
    </div>
</div>

<!-- Products Grid -->
<% if (products == null || products.isEmpty()) { %>
    <div class="empty-state" style="padding:100px 40px;">
        <div class="empty-icon">👗</div>
        <h2 class="empty-title">No Products Found</h2>
        <p class="empty-desc">We're restocking this section. Check back soon!</p>
        <a href="${pageContext.request.contextPath}/products" class="btn-primary">Browse All Products</a>
    </div>
<% } else { %>
<div class="products-layout">
    <%
        int idx = 0;
        for (Product product : products) {
            List<ProductVariant> vars = variantService.getVariantsByProductId(product.getProductId());
            String imgUrl = null;
            String priceDisplay = "View Price →";
            if (vars != null && !vars.isEmpty()) {
                ProductVariant firstVariant = vars.get(0);
                imgUrl = firstVariant.getImageUrl();
                priceDisplay = "₹" + firstVariant.getPrice();
            }
            if (imgUrl == null || imgUrl.trim().isEmpty() || !imgUrl.startsWith("http")) {
                if (product.getCategoryId() == 1) {
                    imgUrl = menImages[idx % menImages.length];
                } else if (product.getCategoryId() == 2) {
                    imgUrl = womenImages[idx % womenImages.length];
                } else {
                    imgUrl = "https://images.unsplash.com/photo-1519457431-44ccd64a579b?w=500&q=80&fit=crop";
                }
            }
            String badge = badges[idx % badges.length];
            idx++;
    %>
    <div class="product-card animate-in" style="animation-delay:<%= (idx * 0.08) %>s" onclick="window.location.href='${pageContext.request.contextPath}/products?action=details&id=<%= product.getProductId() %>'">
        <div class="product-img-wrap">
            <img src="<%= imgUrl %>" alt="<%= product.getProductName() %>" loading="lazy">
            <% if (!badge.isEmpty()) { %>
                <span class="product-badge <%= "Sale".equals(badge) ? "sale" : "new" %>"><%= badge %></span>
            <% } %>
            <div class="product-actions-overlay">
                <a href="${pageContext.request.contextPath}/products?action=details&id=<%= product.getProductId() %>"
                   class="product-act-btn">View Details</a>
                <% if (loggedInUser != null) { %>
                    <a href="${pageContext.request.contextPath}/products?action=details&id=<%= product.getProductId() %>"
                       class="product-act-btn secondary">🛒</a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/auth?action=showLogin"
                       class="product-act-btn secondary">♡</a>
                <% } %>
            </div>
        </div>
        <div class="product-info">
            <div class="product-category"><%= product.getBrand() %></div>
            <div class="product-name"><%= product.getProductName() %></div>
            <div class="product-brand">FAGISTAR</div>
            <div class="product-price-row">
                <div class="product-price"><%= priceDisplay %></div>
                <div class="product-rating">★★★★★</div>
            </div>
        </div>
    </div>
    <% } %>
</div>
<% } %>

<!-- Footer -->
<footer class="footer">
    <div class="footer-bottom" style="border-top:none;padding-top:0;">
        <span class="footer-copy">© 2025 FAGISTAR Fashion Store. All rights reserved.</span>
        <a href="${pageContext.request.contextPath}/" style="font-family:var(--font-display);font-size:1.5rem;letter-spacing:3px;color:var(--gold);">FAGISTAR</a>
    </div>
</footer>

<script>
// Scroll animation
const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, { threshold: 0.08 });

document.querySelectorAll('.animate-in').forEach((el, i) => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(30px)';
    el.style.transition = `opacity 0.6s ease ${i * 0.06}s, transform 0.6s ease ${i * 0.06}s`;
    observer.observe(el);
});

// 3D tilt
document.querySelectorAll('.product-card').forEach(card => {
    card.addEventListener('mousemove', (e) => {
        const rect = card.getBoundingClientRect();
        const x = (e.clientX - rect.left) / rect.width - 0.5;
        const y = (e.clientY - rect.top) / rect.height - 0.5;
        card.style.transform = `translateY(-12px) rotateY(${x * 10}deg) rotateX(${-y * 8}deg)`;
    });
    card.addEventListener('mouseleave', () => { card.style.transform = ''; });
});
</script>
</body>
</html>