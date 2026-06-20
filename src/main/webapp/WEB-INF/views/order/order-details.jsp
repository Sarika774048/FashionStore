<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashion.store.dto.OrderItemResponse" %>
<%@ page import="com.fashion.store.model.Order" %>
<%
    Order order = (Order) request.getAttribute("order");
    List<OrderItemResponse> items = (List<OrderItemResponse>) request.getAttribute("orderItems");
    String statusClass = "status-placed";
    if (order != null) {
        if ("Processing".equals(order.getOrderStatus())) statusClass = "status-processing";
        else if ("Delivered".equals(order.getOrderStatus())) statusClass = "status-delivered";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order #<%= order != null ? order.getOrderId() : "" %> Details – FAGISTAR</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="orders-page">

    <!-- Breadcrumb -->
    <div style="font-size:0.78rem;color:var(--gray);margin-bottom:24px;">
        <a href="${pageContext.request.contextPath}/order?action=list" style="color:var(--gray);transition:color 0.3s;" onmouseover="this.style.color='var(--gold)'" onmouseout="this.style.color='var(--gray)'">
            ← My Orders
        </a>
        &nbsp;/&nbsp;
        <span style="color:var(--gold);">Order #<%= order != null ? order.getOrderId() : "" %></span>
    </div>

    <!-- Header -->
    <div class="orders-header">
        <h1 style="font-family:var(--font-heading);font-size:2rem;font-weight:700;color:var(--white);">
            Order <em style="font-style:italic;color:var(--gold);">#<%= order != null ? order.getOrderId() : "" %></em>
        </h1>
    </div>

    <!-- Order Meta Cards -->
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:16px;margin-bottom:36px;">
        <div style="background:var(--card);border:1px solid rgba(255,255,255,0.06);border-radius:var(--radius);padding:20px;">
            <div style="font-size:0.7rem;letter-spacing:2px;text-transform:uppercase;color:var(--gray);margin-bottom:8px;">Order ID</div>
            <div style="font-size:1rem;font-weight:700;color:var(--gold);">#<%= order != null ? order.getOrderId() : "" %></div>
        </div>
        <div style="background:var(--card);border:1px solid rgba(255,255,255,0.06);border-radius:var(--radius);padding:20px;">
            <div style="font-size:0.7rem;letter-spacing:2px;text-transform:uppercase;color:var(--gray);margin-bottom:8px;">Order Date</div>
            <div style="font-size:0.95rem;color:var(--white);font-weight:500;"><%= order != null ? order.getOrderDate() : "" %></div>
        </div>
        <div style="background:var(--card);border:1px solid rgba(255,255,255,0.06);border-radius:var(--radius);padding:20px;">
            <div style="font-size:0.7rem;letter-spacing:2px;text-transform:uppercase;color:var(--gray);margin-bottom:8px;">Total Amount</div>
            <div style="font-size:1.2rem;font-weight:700;color:var(--gold);">₹<%= order != null ? order.getTotalAmount() : "" %></div>
        </div>
        <div style="background:var(--card);border:1px solid rgba(255,255,255,0.06);border-radius:var(--radius);padding:20px;">
            <div style="font-size:0.7rem;letter-spacing:2px;text-transform:uppercase;color:var(--gray);margin-bottom:8px;">Status</div>
            <span class="order-status <%= statusClass %>"><%= order != null ? order.getOrderStatus() : "" %></span>
        </div>
    </div>

    <!-- Items Table -->
    <div class="order-summary-card animate-in">
        <div class="order-summary-header">
            <div style="font-family:var(--font-heading);font-size:1.1rem;color:var(--white);">📋 Itemized Details</div>
            <div style="font-size:0.82rem;color:var(--gray);"><%= items != null ? items.size() : 0 %> item(s)</div>
        </div>

        <table class="items-table" style="width:100%;">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Brand</th>
                    <th>Color</th>
                    <th>Size</th>
                    <th>Price</th>
                    <th>Qty</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <% if (items != null) { for (OrderItemResponse item : items) { %>
                <tr>
                    <td style="color:var(--white);font-weight:500;"><%= item.getProductName() %></td>
                    <td><%= item.getBrand() %></td>
                    <td><%= item.getColor() %></td>
                    <td><%= item.getSize() %></td>
                    <td>₹<%= item.getPrice() %></td>
                    <td><%= item.getQuantity() %></td>
                    <td>₹<%= item.getSubtotal() %></td>
                </tr>
                <% } } %>
            </tbody>
        </table>

        <div style="padding:20px 28px;display:flex;justify-content:flex-end;gap:12px;align-items:center;border-top:1px solid rgba(255,255,255,0.05);">
            <span style="font-size:0.9rem;color:var(--gray);">Total:</span>
            <span style="font-size:1.4rem;font-weight:700;color:var(--gold);">₹<%= order != null ? order.getTotalAmount() : "" %></span>
        </div>
    </div>

    <!-- Actions -->
    <div style="margin-top:32px;display:flex;gap:16px;flex-wrap:wrap;">
        <a href="${pageContext.request.contextPath}/order?action=list" class="btn-outline">
            ← Back to My Orders
        </a>
        <a href="${pageContext.request.contextPath}/products" class="btn-primary">
            Continue Shopping →
        </a>
    </div>

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