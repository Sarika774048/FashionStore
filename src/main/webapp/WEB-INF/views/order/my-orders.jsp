<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashion.store.model.Order" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders – FAGISTAR</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="orders-page">

    <div class="orders-header">
        <div class="section-label" style="justify-content:flex-start;margin-bottom:12px;">Purchase History</div>
        <h1 style="font-family:var(--font-heading);font-size:2.5rem;font-weight:700;color:var(--white);">My <em style="font-style:italic;color:var(--gold);">Orders</em></h1>
    </div>

    <% if (orders == null || orders.isEmpty()) { %>
        <div class="empty-state">
            <div class="empty-icon">📦</div>
            <h2 class="empty-title">No Orders Yet</h2>
            <p class="empty-desc">You haven't placed any orders yet. Start shopping to see your purchases here!</p>
            <a href="${pageContext.request.contextPath}/products" class="btn-primary">Shop Now →</a>
        </div>
    <% } else { %>

        <div class="orders-grid">
            <% int idx = 0; for (Order order : orders) {
                String statusClass = "status-placed";
                if ("Processing".equals(order.getOrderStatus())) statusClass = "status-processing";
                else if ("Delivered".equals(order.getOrderStatus())) statusClass = "status-delivered";
                idx++;
            %>
            <div class="order-row-card animate-in" style="animation-delay:<%= idx * 0.08 %>s">
                <div class="order-id-badge">#<%= order.getOrderId() %></div>

                <div>
                    <div style="font-size:0.95rem;color:var(--white);font-weight:500;margin-bottom:4px;">
                        Order placed on <%= order.getOrderDate() %>
                    </div>
                    <div class="order-date">Click View Details to see all items in this order</div>
                </div>

                <div class="order-amount">₹<%= order.getTotalAmount() %></div>

                <span class="order-status <%= statusClass %>"><%= order.getOrderStatus() %></span>

                <a href="${pageContext.request.contextPath}/order?action=details&id=<%= order.getOrderId() %>"
                   class="btn-view-order">
                    View Details →
                </a>
            </div>
            <% } %>
        </div>

    <% } %>

</div>

<footer class="footer" style="padding:40px 64px;margin-top:40px;">
    <div class="footer-bottom" style="border-top:none;padding-top:0;">
        <span class="footer-copy">© 2025 FAGISTAR Fashion Store. All rights reserved.</span>
        <a href="${pageContext.request.contextPath}/" style="font-family:var(--font-display);font-size:1.5rem;letter-spacing:3px;color:var(--gold);">FAGISTAR</a>
    </div>
</footer>

<script>
const obs = new IntersectionObserver(entries => {
    entries.forEach(e => {
        if (e.isIntersecting) { e.target.style.opacity = '1'; e.target.style.transform = 'translateX(0)'; }
    });
}, { threshold: 0.1 });
document.querySelectorAll('.animate-in').forEach((el, i) => {
    el.style.opacity = '0';
    el.style.transform = 'translateX(-20px)';
    el.style.transition = `opacity 0.5s ease ${i * 0.07}s, transform 0.5s ease ${i * 0.07}s`;
    obs.observe(el);
});
</script>
</body>
</html>