<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashion.store.dto.OrderItemResponse" %>
<%@ page import="com.fashion.store.model.Order" %>
<%
    Order order = (Order) request.getAttribute("order");
    List<OrderItemResponse> items = (List<OrderItemResponse>) request.getAttribute("orderItems");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placed Successfully – FAGISTAR</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        @keyframes checkmark {
            0%   { stroke-dashoffset: 100; }
            100% { stroke-dashoffset: 0; }
        }
        .confetti-container {
            position: fixed;
            top: 0; left: 0; right: 0;
            pointer-events: none;
            z-index: 100;
            overflow: hidden;
            height: 100vh;
        }
        .confetti-piece {
            position: absolute;
            width: 8px; height: 8px;
            animation: confettiFall linear forwards;
        }
        @keyframes confettiFall {
            0%   { transform: translateY(-20px) rotate(0deg); opacity: 1; }
            100% { transform: translateY(100vh) rotate(720deg); opacity: 0; }
        }
    </style>
</head>
<body>

<div id="page-loader">
    <div class="loader-logo">FAGISTAR</div>
    <div class="loader-bar"><div class="loader-bar-fill"></div></div>
</div>

<!-- Confetti -->
<div class="confetti-container" id="confettiContainer"></div>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<div class="success-page">
    <div class="success-container">

        <!-- Success Icon -->
        <div class="success-icon" style="background:rgba(39,174,96,0.12);border:2px solid rgba(39,174,96,0.4);">
            ✅
        </div>

        <h1 class="success-title">Order Placed Successfully!</h1>
        <p class="success-subtitle">
            Thank you for shopping with FAGISTAR. Your order is confirmed and being processed.
        </p>

        <!-- Order Summary Card -->
        <div class="order-summary-card animate-in">
            <div class="order-summary-header">
                <div>
                    <div style="font-size:0.7rem;letter-spacing:2px;text-transform:uppercase;color:var(--gold);margin-bottom:4px;">Order Confirmation</div>
                    <div class="order-summary-meta">Order ID: <strong>#<%= order != null ? order.getOrderId() : "" %></strong></div>
                </div>
                <div style="text-align:right;">
                    <div class="order-summary-meta">Date: <strong><%= order != null ? order.getOrderDate() : "" %></strong></div>
                    <div style="margin-top:6px;">
                        <span class="order-status status-placed"><%= order != null ? order.getOrderStatus() : "" %></span>
                    </div>
                </div>
            </div>

            <table class="items-table">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Brand</th>
                        <th>Color</th>
                        <th>Size</th>
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
                        <td><%= item.getQuantity() %></td>
                        <td>₹<%= item.getSubtotal() %></td>
                    </tr>
                    <% } } %>
                </tbody>
            </table>

            <div style="padding:20px 28px;display:flex;justify-content:flex-end;align-items:center;gap:12px;border-top:1px solid rgba(255,255,255,0.05);">
                <span style="font-size:0.9rem;color:var(--gray);">Total Paid:</span>
                <span style="font-size:1.5rem;font-weight:700;color:var(--gold);">₹<%= order != null ? order.getTotalAmount() : "" %></span>
            </div>
        </div>

        <!-- What's Next -->
        <div style="background:var(--card);border:1px solid rgba(255,255,255,0.06);border-radius:var(--radius);padding:28px;margin-bottom:32px;">
            <div style="font-size:0.75rem;letter-spacing:2px;text-transform:uppercase;color:var(--gold);margin-bottom:16px;">What Happens Next</div>
            <div style="display:flex;flex-direction:column;gap:16px;">
                <div style="display:flex;align-items:center;gap:14px;">
                    <div style="width:36px;height:36px;background:rgba(201,168,76,0.1);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:1.1rem;flex-shrink:0;">📧</div>
                    <div style="font-size:0.88rem;color:var(--gray-light);">A confirmation will be sent to your email shortly</div>
                </div>
                <div style="display:flex;align-items:center;gap:14px;">
                    <div style="width:36px;height:36px;background:rgba(201,168,76,0.1);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:1.1rem;flex-shrink:0;">📦</div>
                    <div style="font-size:0.88rem;color:var(--gray-light);">Your items are being packed and will ship within 24–48 hours</div>
                </div>
                <div style="display:flex;align-items:center;gap:14px;">
                    <div style="width:36px;height:36px;background:rgba(201,168,76,0.1);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:1.1rem;flex-shrink:0;">🚚</div>
                    <div style="font-size:0.88rem;color:var(--gray-light);">Track your delivery through My Orders section</div>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div style="display:flex;gap:16px;flex-wrap:wrap;justify-content:center;">
            <a href="${pageContext.request.contextPath}/order?action=list" class="btn-primary">
                📦 View My Orders
            </a>
            <a href="${pageContext.request.contextPath}/products" class="btn-outline">
                Continue Shopping →
            </a>
        </div>

    </div>
</div>

<script>
// Page loader
window.addEventListener('load', () => {
    setTimeout(() => {
        const loader = document.getElementById('page-loader');
        if (loader) loader.classList.add('hidden');
    }, 700);
});

// Confetti
function createConfetti() {
    const container = document.getElementById('confettiContainer');
    const colors = ['#c9a84c', '#e8c96e', '#ffffff', '#9b7c30', '#f5f0e8'];
    for (let i = 0; i < 60; i++) {
        const el = document.createElement('div');
        el.className = 'confetti-piece';
        el.style.left = Math.random() * 100 + 'vw';
        el.style.background = colors[Math.floor(Math.random() * colors.length)];
        el.style.borderRadius = Math.random() > 0.5 ? '50%' : '2px';
        el.style.animationDuration = (Math.random() * 2 + 1.5) + 's';
        el.style.animationDelay = (Math.random() * 1.5) + 's';
        el.style.width = (Math.random() * 8 + 4) + 'px';
        el.style.height = (Math.random() * 8 + 4) + 'px';
        container.appendChild(el);
    }
    setTimeout(() => container.innerHTML = '', 5000);
}
createConfetti();

// Animate in
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
</script>
</body>
</html>