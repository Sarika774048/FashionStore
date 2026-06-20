<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashion.store.dto.CartResponse" %>
<%@ page import="com.fashion.store.service.ProductVariantService" %>
<%@ page import="com.fashion.store.model.ProductVariant" %>
<%@ page import="java.math.BigDecimal" %>
<%
    List<CartResponse> items = (List<CartResponse>) request.getAttribute("cartItems");
    BigDecimal cartTotal = (BigDecimal) request.getAttribute("cartTotal");
    if (cartTotal == null) cartTotal = BigDecimal.ZERO;
    ProductVariantService cartVariantService = new ProductVariantService();

    // Fallback fashion images for cart items
    String[] cartImages = {
        "https://images.unsplash.com/photo-1544441893-675973e31985?w=200&q=80&fit=crop",
        "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=200&q=80&fit=crop",
        "https://images.unsplash.com/photo-1552374196-1ab2a1c593e8?w=200&q=80&fit=crop",
        "https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=200&q=80&fit=crop",
        "https://images.unsplash.com/photo-1503341455253-b2e723bb3dbb?w=200&q=80&fit=crop"
    };
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart – FAGISTAR</title>
    <meta name="description" content="Review your FAGISTAR cart and proceed to checkout.">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<!-- Page Title -->
<div class="page-hero" style="padding:160px 64px 60px;">
    <div class="section-label">Your Selections</div>
    <h1 class="page-hero-title">Shopping <em>Cart</em></h1>
</div>

<% if (items == null || items.isEmpty()) { %>

    <!-- Empty cart -->
    <div class="empty-state" style="padding:80px 40px 120px;">
        <div class="empty-icon">🛒</div>
        <h2 class="empty-title">Your Cart is Empty</h2>
        <p class="empty-desc">Looks like you haven't added anything yet. Let's change that!</p>
        <a href="${pageContext.request.contextPath}/products" class="btn-primary">Start Shopping →</a>
    </div>

<% } else { %>

<div class="cart-layout">

    <!-- ── Items Panel ── -->
    <div class="cart-items-panel animate-in">
        <div class="cart-panel-header">
            <span class="cart-panel-title">Cart Items</span>
            <span style="font-size:0.82rem;color:var(--gray);"><%= items.size() %> item<%= items.size() != 1 ? "s" : "" %></span>
        </div>

        <%
            int ci = 0;
            for (CartResponse item : items) {
                ProductVariant var = cartVariantService.getVariantById(item.getVariantId());
                String itemImg = (var != null) ? var.getImageUrl() : null;
                if (itemImg == null || itemImg.trim().isEmpty() || !itemImg.startsWith("http")) {
                    itemImg = cartImages[ci % cartImages.length];
                }
        %>
        <div class="cart-item-row">
            <img src="<%= itemImg %>"
                 class="cart-item-img" alt="<%= item.getProductName() %>">

            <div>
                <div class="cart-item-name"><%= item.getProductName() %></div>
                <div class="cart-item-meta">
                    <%= item.getBrand() %> &nbsp;·&nbsp;
                    Size: <strong style="color:var(--gold)"><%= item.getSize() %></strong> &nbsp;·&nbsp;
                    Color: <strong style="color:var(--gold)"><%= item.getColor() %></strong>
                </div>
                <div style="margin-top:8px;font-size:0.9rem;color:var(--gold);font-weight:600;">₹<%= item.getPrice() %> each</div>
            </div>

            <div class="cart-qty-form">
                <form action="${pageContext.request.contextPath}/update-cart" method="post"
                      style="display:flex;align-items:center;gap:8px;">
                    <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                    <input type="number" name="quantity" value="<%= item.getQuantity() %>"
                           min="1" class="cart-qty-input">
                    <button type="submit" class="btn-sm">Update</button>
                </form>
            </div>

            <div style="text-align:right;">
                <div class="cart-item-price">₹<%= item.getSubtotal() %></div>
                <a href="${pageContext.request.contextPath}/remove-cart-item?cartItemId=<%= item.getCartItemId() %>"
                   class="btn-remove" title="Remove">🗑</a>
            </div>
        </div>
        <% ci++; } %>
    </div>

    <!-- ── Summary Panel ── -->
    <div class="cart-summary animate-in delay-2">
        <div class="summary-title">Order Summary</div>

        <div class="summary-line">
            <span>Subtotal (<%= items.size() %> items)</span>
            <span>₹<%= cartTotal %></span>
        </div>
        <div class="summary-line">
            <span>Shipping</span>
            <span style="color:var(--green);">Free</span>
        </div>
        <div class="summary-line">
            <span>Discount</span>
            <span>₹0</span>
        </div>
        <div class="summary-line total">
            <span>Grand Total</span>
            <span>₹<%= cartTotal %></span>
        </div>

        <a href="${pageContext.request.contextPath}/order?action=checkout" class="btn-checkout">
            Proceed to Checkout →
        </a>
        <a href="${pageContext.request.contextPath}/products" class="btn-continue">
            ← Continue Shopping
        </a>

        <!-- Trust badges -->
        <div style="margin-top:24px;padding-top:20px;border-top:1px solid rgba(255,255,255,0.06);">
            <div style="font-size:0.75rem;color:var(--gray);text-align:center;margin-bottom:12px;letter-spacing:1px;text-transform:uppercase;">Secure Checkout</div>
            <div style="display:flex;justify-content:center;gap:12px;font-size:0.78rem;color:var(--gray);">
                <span>🔒 SSL Secure</span>
                <span>💳 Safe Payment</span>
                <span>📦 Fast Delivery</span>
            </div>
        </div>
    </div>

</div>

<% } %>

<footer class="footer" style="padding:40px 64px;margin-top:40px;">
    <div class="footer-bottom" style="border-top:none;padding-top:0;">
        <span class="footer-copy">© 2025 FAGISTAR Fashion Store. All rights reserved.</span>
        <a href="${pageContext.request.contextPath}/" style="font-family:var(--font-display);font-size:1.5rem;letter-spacing:3px;color:var(--gold);">FAGISTAR</a>
    </div>
</footer>

<script>
const obs = new IntersectionObserver(entries => {
    entries.forEach(e => {
        if (e.isIntersecting) {
            e.target.style.opacity = '1';
            e.target.style.transform = 'translateY(0)';
        }
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