<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashion.store.dto.CartResponse" %>
<%@ page import="com.fashion.store.service.ProductVariantService" %>
<%@ page import="com.fashion.store.model.ProductVariant" %>
<%@ page import="com.fashion.store.model.User" %>
<%@ page import="java.math.BigDecimal" %>
<%
    List<CartResponse> items = (List<CartResponse>) request.getAttribute("cartItems");
    BigDecimal totalAmount = (BigDecimal) request.getAttribute("totalAmount");
    User user = (User) request.getAttribute("user");
    String errorMessage = (String) request.getAttribute("errorMessage");
    ProductVariantService checkoutVariantService = new ProductVariantService();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout – FAGISTAR</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="page-hero" style="padding:160px 64px 60px;">
    <div class="section-label">Almost There</div>
    <h1 class="page-hero-title">Checkout <em>Details</em></h1>
</div>

<% if (errorMessage != null) { %>
    <div style="margin:0 64px 20px;">
        <div class="alert alert-error">⚠️ <%= errorMessage %></div>
    </div>
<% } %>

<div class="checkout-layout">

    <!-- ── Order Summary Panel ── -->
    <div class="animate-in">
        <div class="checkout-panel">
            <div class="checkout-panel-header">
                <div class="checkout-panel-title">
                    <span class="icon">📋</span> Order Summary
                </div>
            </div>

            <% if (items != null) {
                String[] imgs = {
                    "https://images.unsplash.com/photo-1544441893-675973e31985?w=80&q=80",
                    "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=80&q=80",
                    "https://images.unsplash.com/photo-1552374196-1ab2a1c593e8?w=80&q=80",
                    "https://images.unsplash.com/photo-1503341455253-b2e723bb3dbb?w=80&q=80"
                };
                int ci = 0;
                for (CartResponse item : items) {
                    ProductVariant var = checkoutVariantService.getVariantById(item.getVariantId());
                    String itemImg = (var != null) ? var.getImageUrl() : null;
                    if (itemImg == null || itemImg.trim().isEmpty() || !itemImg.startsWith("http")) {
                        itemImg = imgs[ci % imgs.length];
                    }
                %>
                <div class="checkout-order-row">
                    <div style="display:flex;align-items:center;gap:14px;">
                        <img src="<%= itemImg %>"
                             style="width:56px;height:56px;object-fit:cover;border-radius:8px;" alt="">
                        <div>
                            <div class="checkout-item-info"><%= item.getProductName() %></div>
                            <div class="checkout-item-meta">
                                <%= item.getColor() %> · <%= item.getSize() %> · Qty: <%= item.getQuantity() %>
                            </div>
                        </div>
                    </div>
                    <div class="checkout-item-price">₹<%= item.getSubtotal() %></div>
                </div>
            <% ci++; } } %>

            <div class="checkout-order-row" style="border-top:1px solid rgba(255,255,255,0.08);margin-top:8px;">
                <div style="font-size:0.9rem;color:var(--gray-light);">Shipping</div>
                <div style="color:var(--green);font-weight:600;font-size:0.9rem;">FREE</div>
            </div>
            <div class="checkout-order-row">
                <div style="font-size:1rem;font-weight:700;color:var(--white);">Total Amount</div>
                <div style="font-size:1.3rem;font-weight:700;color:var(--gold);">₹<%= totalAmount %></div>
            </div>
        </div>
    </div>

    <!-- ── Shipping Panel ── -->
    <div class="animate-in delay-2">
        <div class="shipping-panel">
            <div class="shipping-panel-header">
                <div class="checkout-panel-title">
                    <span class="icon">🚚</span> Shipping Information
                </div>
            </div>
            <div class="shipping-panel-body">

                <form action="${pageContext.request.contextPath}/order?action=placeOrder" method="post" id="checkoutForm">

                    <div class="form-group">
                        <label class="form-label">Recipient Name</label>
                        <input type="text" value="<%= user != null ? user.getFullName() : "" %>"
                               readonly class="readonly-field" placeholder="Name">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Phone Number</label>
                        <input type="text" value="<%= user != null ? user.getPhone() : "" %>"
                               readonly class="readonly-field" placeholder="Phone">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Delivery Address</label>
                        <textarea readonly rows="3" class="readonly-field"
                                  style="resize:none;width:100%;"><%= user != null ?
                                  user.getAddressLine() + ", " + user.getCity() + ", " +
                                  user.getState() + " – " + user.getPincode() : "" %></textarea>
                    </div>

                    <p class="shipping-note">
                        ✏️ Need to update your address?
                        <a href="${pageContext.request.contextPath}/profile">Edit Profile →</a>
                    </p>

                    <!-- Payment mode (aesthetic only) -->
                    <div class="form-group">
                        <label class="form-label">Payment Mode</label>
                        <div style="padding:14px 18px;background:rgba(201,168,76,0.06);border:1px solid rgba(201,168,76,0.2);border-radius:10px;display:flex;align-items:center;gap:12px;font-size:0.9rem;color:var(--gold);">
                            💵 Cash on Delivery
                        </div>
                    </div>

                    <!-- Total reminder -->
                    <div style="background:rgba(201,168,76,0.05);border:1px solid rgba(201,168,76,0.15);border-radius:12px;padding:16px 20px;margin-bottom:20px;display:flex;justify-content:space-between;align-items:center;">
                        <span style="font-size:0.88rem;color:var(--gray-light);">Total to Pay</span>
                        <span style="font-size:1.4rem;font-weight:700;color:var(--gold);">₹<%= totalAmount %></span>
                    </div>

                    <button type="submit" class="btn-checkout" id="placeBtn">
                        ✓ Confirm &amp; Place Order
                    </button>
                </form>

                <div style="margin-top:16px;text-align:center;">
                    <div style="display:flex;justify-content:center;gap:16px;font-size:0.78rem;color:var(--gray);">
                        <span>🔒 Secure</span>
                        <span>📦 Fast Delivery</span>
                        <span>↩ Easy Returns</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<footer class="footer" style="padding:40px 64px;margin-top:40px;">
    <div class="footer-bottom" style="border-top:none;padding-top:0;">
        <span class="footer-copy">© 2025 FAGISTAR. All rights reserved.</span>
        <a href="${pageContext.request.contextPath}/" style="font-family:var(--font-display);font-size:1.5rem;letter-spacing:3px;color:var(--gold);">FAGISTAR</a>
    </div>
</footer>

<script>
const obs = new IntersectionObserver(entries => {
    entries.forEach(e => {
        if (e.isIntersecting) { e.target.style.opacity = '1'; e.target.style.transform = 'translateY(0)'; }
    });
}, { threshold: 0.1 });
document.querySelectorAll('.animate-in').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(20px)';
    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    obs.observe(el);
});
document.getElementById('checkoutForm')?.addEventListener('submit', () => {
    const btn = document.getElementById('placeBtn');
    btn.textContent = '⏳ Placing Order...';
    btn.style.opacity = '0.7';
});
</script>
</body>
</html>