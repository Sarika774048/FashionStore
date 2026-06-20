<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashion.store.model.Product" %>
<%@ page import="com.fashion.store.model.ProductVariant" %>
<%@ page import="com.fashion.store.model.User" %>
<%
    Product product = (Product) request.getAttribute("product");
    List<ProductVariant> variants = (List<ProductVariant>) request.getAttribute("variants");
    User loggedInUser = (User) session.getAttribute("loggedInUser");

    // Image gallery for this product
    String primaryImg = null;
    if (variants != null && !variants.isEmpty()) {
        primaryImg = variants.get(0).getImageUrl();
    }

    String[] gallery = {
        (primaryImg != null && primaryImg.startsWith("http")) ? primaryImg : "https://images.unsplash.com/photo-1544441893-675973e31985?w=800&q=80&fit=crop",
        "https://images.unsplash.com/photo-1552374196-1ab2a1c593e8?w=800&q=80&fit=crop",
        "https://images.unsplash.com/photo-1490578474895-699cd4e2cf59?w=800&q=80&fit=crop",
        "https://images.unsplash.com/photo-1503341455253-b2e723bb3dbb?w=800&q=80&fit=crop"
    };
    int imgIdx = 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product != null ? product.getProductName() : "Product" %> – FAGISTAR</title>
    <meta name="description" content="<%= product != null ? product.getDescription() : "" %>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .thumb-strip {
            display: flex;
            gap: 10px;
        }
        .thumb {
            width: 80px; height: 80px;
            border-radius: 10px;
            object-fit: cover;
            cursor: pointer;
            border: 2px solid transparent;
            transition: all 0.3s ease;
            opacity: 0.6;
        }
        .thumb:hover, .thumb.active {
            border-color: var(--gold);
            opacity: 1;
        }
        .detail-main-img {
            cursor: zoom-in;
        }
        .breadcrumb {
            padding: 100px 80px 0;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.78rem;
            color: var(--gray);
        }
        .breadcrumb a { color: var(--gray); transition: color 0.3s; }
        .breadcrumb a:hover { color: var(--gold); }
        .breadcrumb span { color: var(--gold-dark); }

        .size-selector {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 16px;
        }
        .size-pill {
            padding: 8px 18px;
            border: 1px solid rgba(255,255,255,0.15);
            border-radius: 20px;
            font-size: 0.8rem;
            color: var(--white);
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .size-pill:hover { border-color: var(--gold); color: var(--gold); }
        .size-pill.selected { background: var(--gold); color: var(--black); border-color: var(--gold); }

        .color-dot {
            width: 30px; height: 30px;
            border-radius: 50%;
            border: 2px solid transparent;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .color-dot:hover, .color-dot.selected {
            border-color: var(--gold);
            transform: scale(1.2);
        }

        .trust-badges {
            display: flex;
            gap: 20px;
            margin-top: 24px;
            padding-top: 24px;
            border-top: 1px solid rgba(255,255,255,0.06);
            flex-wrap: wrap;
        }
        .trust-badge {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.78rem;
            color: var(--gray);
        }
        .trust-badge span { color: var(--gold); font-size: 1rem; }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<!-- Breadcrumb -->
<div class="breadcrumb">
    <a href="${pageContext.request.contextPath}/">Home</a> /
    <a href="${pageContext.request.contextPath}/products">Products</a> /
    <span><%= product != null ? product.getProductName() : "" %></span>
</div>

<!-- Product Detail Layout -->
<div class="detail-layout">

    <!-- ── Left: Gallery ── -->
    <div class="detail-img-gallery animate-in">
        <img id="mainProductImg"
             src="<%= gallery[imgIdx] %>"
             alt="<%= product != null ? product.getProductName() : "" %>"
             class="detail-main-img">

        <div class="thumb-strip">
            <% for (int t = 0; t < gallery.length; t++) { %>
            <img src="<%= gallery[t] %>"
                 class="thumb <%= t == 0 ? "active" : "" %>"
                 onclick="switchImage(this, '<%= gallery[t] %>')"
                 alt="thumb">
            <% } %>
        </div>
    </div>

    <!-- ── Right: Info ── -->
    <div class="detail-info animate-in delay-2">
        <div class="product-category"><%= product != null ? product.getBrand() : "" %> • Premium Collection</div>
        <h1 class="product-name"><%= product != null ? product.getProductName() : "" %></h1>
        <div class="product-brand">
            ★★★★★ <span style="color:var(--gray);font-size:0.82rem;">(128 reviews)</span>
        </div>

        <p class="product-desc">
            <%= product != null ? product.getDescription() : "" %>
        </p>

        <!-- Variants -->
        <% if (variants == null || variants.isEmpty()) { %>
            <div style="padding:20px;background:var(--card);border-radius:var(--radius);color:var(--gray);font-size:0.9rem;">
                Currently out of stock. Check back soon!
            </div>
        <% } else { %>
            <div class="variants-section">
                <div class="variants-label">Choose Your Variant</div>

                <% for (ProductVariant variant : variants) { %>
                <div class="variant-card">
                    <div class="variant-row">
                        <div class="variant-chips">
                            <span class="variant-chip">📏 <%= variant.getSize() %></span>
                            <span class="variant-chip">🎨 <%= variant.getColor() %></span>
                        </div>
                        <div class="variant-price">₹<%= variant.getPrice() %></div>
                    </div>

                    <% if (variant.getStockQuantity() > 0) { %>
                        <div class="variant-stock">✓ In Stock (<%= variant.getStockQuantity() %> available)</div>
                        <% if (loggedInUser != null) { %>
                            <form action="${pageContext.request.contextPath}/add-to-cart" method="post" class="add-to-cart-form" style="margin-top:12px;">
                                <input type="hidden" name="variantId" value="<%= variant.getVariantId() %>">
                                <input type="number" id="qty-<%= variant.getVariantId() %>"
                                       name="quantity" value="1" min="1"
                                       max="<%= variant.getStockQuantity() %>"
                                       class="qty-input">
                                <button type="submit" class="btn-add-cart">
                                    🛒 Add to Cart
                                </button>
                            </form>
                        <% } else { %>
                            <div style="margin-top:12px;">
                                <a href="${pageContext.request.contextPath}/auth?action=showLogin" class="btn-add-cart" style="text-decoration:none;display:flex;align-items:center;justify-content:center;gap:8px;">
                                    🔐 Login to Add to Cart
                                </a>
                            </div>
                        <% } %>
                    <% } else { %>
                        <div style="margin-top:10px;">
                            <button class="btn-add-cart" disabled style="opacity:0.4;cursor:not-allowed;">
                                Out of Stock
                            </button>
                        </div>
                    <% } %>
                </div>
                <% } %>
            </div>
        <% } %>

        <!-- Trust Badges -->
        <div class="trust-badges">
            <div class="trust-badge"><span>🚚</span> Free Delivery</div>
            <div class="trust-badge"><span>↩</span> 30-Day Returns</div>
            <div class="trust-badge"><span>🔒</span> Secure Payment</div>
            <div class="trust-badge"><span>✦</span> Premium Quality</div>
        </div>

        <!-- Back link -->
        <div style="margin-top:32px;">
            <a href="${pageContext.request.contextPath}/products" class="btn-outline">
                ← Back to Products
            </a>
        </div>
    </div>
</div>

<footer class="footer" style="padding:40px 64px;">
    <div class="footer-bottom" style="border-top:none;padding-top:0;">
        <span class="footer-copy">© 2025 FAGISTAR Fashion Store. All rights reserved.</span>
        <a href="${pageContext.request.contextPath}/" style="font-family:var(--font-display);font-size:1.5rem;letter-spacing:3px;color:var(--gold);">FAGISTAR</a>
    </div>
</footer>

<script>
function switchImage(thumb, src) {
    document.getElementById('mainProductImg').src = src;
    document.querySelectorAll('.thumb').forEach(t => t.classList.remove('active'));
    thumb.classList.add('active');
}

// Scroll animate
const obs = new IntersectionObserver((entries) => {
    entries.forEach(e => {
        if (e.isIntersecting) {
            e.target.style.opacity = '1';
            e.target.style.transform = 'translateY(0)';
        }
    });
}, { threshold: 0.1 });
document.querySelectorAll('.animate-in').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(30px)';
    el.style.transition = 'opacity 0.7s ease, transform 0.7s ease';
    obs.observe(el);
});

// Image zoom on hover
const mainImg = document.getElementById('mainProductImg');
if (mainImg) {
    mainImg.addEventListener('mousemove', (e) => {
        const rect = mainImg.getBoundingClientRect();
        const x = ((e.clientX - rect.left) / rect.width) * 100;
        const y = ((e.clientY - rect.top) / rect.height) * 100;
        mainImg.style.transformOrigin = `${x}% ${y}%`;
        mainImg.style.transform = 'scale(1.5)';
    });
    mainImg.addEventListener('mouseleave', () => {
        mainImg.style.transform = 'scale(1)';
        mainImg.style.transformOrigin = 'center';
    });
}
</script>
</body>
</html>