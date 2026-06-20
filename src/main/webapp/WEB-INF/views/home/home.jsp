<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.fashion.store.model.Product" %>
<%@ page import="com.fashion.store.model.ProductVariant" %>
<%@ page import="com.fashion.store.service.ProductVariantService" %>
<%@ page import="java.util.List" %>
<%
    List<Product> homeProducts = (List<Product>) request.getAttribute("products");
    ProductVariantService homeVariantService = new ProductVariantService();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAGISTAR – Stylist Fashion Store | Premium Men & Women Clothing</title>
    <meta name="description" content="Discover the finest fashion outfits for men and women. Shop trending styles, new arrivals and exclusive collections at FAGISTAR.">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        /* Hero 3D Scene */
        .hero-3d-float {
            position: absolute;
            top: 50%; right: 40px;
            transform: translateY(-50%);
            display: flex;
            flex-direction: column;
            gap: 16px;
            z-index: 3;
        }
        .mini-card-3d {
            width: 160px;
            background: rgba(22,22,22,0.9);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(201,168,76,0.2);
            border-radius: 12px;
            padding: 14px 16px;
            transition: all 0.3s ease;
            animation: floatCard 3s ease-in-out infinite;
        }
        .mini-card-3d:nth-child(2) { animation-delay: 1s; }
        .mini-card-3d:nth-child(3) { animation-delay: 2s; }
        .mini-card-3d:hover {
            transform: translateX(-10px) scale(1.05);
            border-color: var(--gold);
        }
        .mini-card-3d img {
            width: 100%; height: 90px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 8px;
        }
        .mini-card-title { font-size: 0.75rem; color: var(--white); font-weight: 600; margin-bottom: 3px; }
        .mini-card-price { font-size: 0.8rem; color: var(--gold); font-weight: 700; }

        /* Trending strip products */
        .trending-outfit-section {
            background: var(--dark2);
        }
        .outfit-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            min-height: 600px;
        }
        .outfit-left {
            position: relative;
            overflow: hidden;
        }
        .outfit-left img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .outfit-right {
            padding: 80px 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .outfit-right .big-text {
            font-family: var(--font-heading);
            font-size: clamp(1.8rem, 3vw, 2.8rem);
            color: var(--white);
            line-height: 1.25;
            margin-bottom: 16px;
        }
        .outfit-right .big-text em { color: var(--gold); font-style: italic; }
        .outfit-right p { color: var(--gray); line-height: 1.8; margin-bottom: 36px; }

        .trending-outfit-cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
            margin-bottom: 36px;
        }
        .tocard {
            background: var(--card);
            border: 1px solid rgba(255,255,255,0.06);
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .tocard:hover { transform: translateY(-8px); border-color: rgba(201,168,76,0.3); }
        .tocard img { width: 100%; height: 160px; object-fit: cover; }
        .tocard-info { padding: 12px; }
        .tocard-name { font-size: 0.8rem; color: var(--white); font-weight: 600; margin-bottom: 4px; }
        .tocard-price { font-size: 0.85rem; color: var(--gold); font-weight: 700; }

        /* Video Section */
        .video-section {
            position: relative;
            height: 620px;
            margin: 100px 48px;
            border-radius: 40px;
            overflow: hidden;
            border: 1px solid rgba(201,168,76,0.15);
            box-shadow: 0 40px 100px rgba(0,0,0,0.9), 0 0 50px rgba(201,168,76,0.05);
            transform: scale(0.92);
            transition: transform 0.15s cubic-bezier(0.25, 1, 0.5, 1), border-radius 0.15s cubic-bezier(0.25, 1, 0.5, 1), border-color 0.8s ease, box-shadow 0.8s ease;
            will-change: transform, border-radius;
        }
        .video-section.visible {
            border-color: rgba(201,168,76,0.4);
            box-shadow: 0 40px 100px rgba(0,0,0,0.9), 0 0 60px rgba(201,168,76,0.15);
        }
        .video-bg {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 1.5s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .video-section:hover .video-bg {
            transform: scale(1.03);
        }
        .video-overlay {
            position: absolute;
            inset: 0;
            background: rgba(10,10,10,0.65);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Brand strip */
        .brands-strip {
            padding: 48px 64px;
            display: flex;
            align-items: center;
            justify-content: space-around;
            border-top: 1px solid rgba(255,255,255,0.05);
            border-bottom: 1px solid rgba(255,255,255,0.05);
            flex-wrap: wrap;
            gap: 24px;
        }
        .brand-logo {
            font-family: var(--font-display);
            font-size: 1.4rem;
            letter-spacing: 4px;
            color: rgba(255,255,255,0.2);
            transition: color 0.3s ease;
        }
        .brand-logo:hover { color: var(--gold); }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<!-- ═══════ HERO ═══════ -->
<section class="hero">
    <div class="hero-left animate-in">
        <div class="hero-label">New Collection 2025</div>
        <h1 class="hero-title" style="font-family: var(--font-display); font-size: clamp(3.5rem, 8vw, 7.5rem); font-weight: 900; line-height: 0.9; text-transform: uppercase; margin-bottom: 24px;">
            YOUR STYLE<br>
            <em style="font-family: var(--font-heading); text-transform: none; font-size: 0.85em; color: var(--gold);">is here!</em>
        </h1>
        <p class="hero-desc">
            Elevate your wardrobe with our exclusive collection.
            Crafted for the bold, designed for the refined.
        </p>
        <div class="hero-actions" style="flex-wrap: wrap; gap: 12px; margin-bottom: 40px;">
            <a href="${pageContext.request.contextPath}/products" class="btn-primary">
                Shop All <span>→</span>
            </a>
            <a href="${pageContext.request.contextPath}/products?categoryId=1" class="btn-outline">
                Men
            </a>
            <a href="${pageContext.request.contextPath}/products?categoryId=2" class="btn-outline">
                Women
            </a>
            <a href="${pageContext.request.contextPath}/products?categoryId=3" class="btn-outline">
                Kids
            </a>
        </div>
        <div class="hero-stats">
            <div>
                <div class="hero-stat-num">70K+</div>
                <div class="hero-stat-label">Happy Customers</div>
            </div>
            <div>
                <div class="hero-stat-num">500+</div>
                <div class="hero-stat-label">Unique Styles</div>
            </div>
            <div>
                <div class="hero-stat-num">15+</div>
                <div class="hero-stat-label">Years of Style</div>
            </div>
        </div>
    </div>

    <div class="hero-right">
        <img src="${pageContext.request.contextPath}/assets/images/hero_family.jpg"
             alt="Fashion Hero" class="hero-image-main">
        <div class="hero-overlay"></div>

        <!-- Floating 3D mini-cards -->
        <div class="hero-3d-float">
            <div class="mini-card-3d">
                <img src="https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=300&q=80" alt="product">
                <div class="mini-card-title">Casual Hoodie</div>
                <div class="mini-card-price">₹2,499</div>
            </div>
            <div class="mini-card-3d">
                <img src="https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?w=300&q=80" alt="product">
                <div class="mini-card-title">Slim Jacket</div>
                <div class="mini-card-price">₹5,999</div>
            </div>
        </div>

        <div class="hero-float-card" style="left:30px;right:auto;top:30%;bottom:auto;">
            <div class="label">Trending Today</div>
            <div class="product-title">Brown Overcoat</div>
            <div class="price">₹8,499</div>
        </div>
    </div>
</section>

<!-- ═══════ TICKER ═══════ -->
<div class="ticker">
    <div class="ticker-track">
        <span class="ticker-item">TRENDING <span class="star">✦</span></span>
        <span class="ticker-item">NEW ARRIVAL <span class="star">✦</span></span>
        <span class="ticker-item">FASHION SALE <span class="star">✦</span></span>
        <span class="ticker-item">FREE SHIPPING <span class="star">✦</span></span>
        <span class="ticker-item">EXCLUSIVE DROPS <span class="star">✦</span></span>
        <span class="ticker-item">PREMIUM QUALITY <span class="star">✦</span></span>
        <span class="ticker-item">LIMITED EDITION <span class="star">✦</span></span>
        <!-- duplicate for seamless loop -->
        <span class="ticker-item">TRENDING <span class="star">✦</span></span>
        <span class="ticker-item">NEW ARRIVAL <span class="star">✦</span></span>
        <span class="ticker-item">FASHION SALE <span class="star">✦</span></span>
        <span class="ticker-item">FREE SHIPPING <span class="star">✦</span></span>
        <span class="ticker-item">EXCLUSIVE DROPS <span class="star">✦</span></span>
        <span class="ticker-item">PREMIUM QUALITY <span class="star">✦</span></span>
        <span class="ticker-item">LIMITED EDITION <span class="star">✦</span></span>
    </div>
</div>

<!-- ═══════ CATEGORIES ═══════ -->
<section class="section" style="background:var(--dark);">
    <div class="section-header">
        <div class="section-label">Browse</div>
        <h2 class="section-title">Shop by <em>Category</em></h2>
        <p class="section-desc">Curated collections for every style and every occasion.</p>
    </div>
    <div class="category-grid">
        <div class="category-card animate-in delay-1">
            <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&q=80&fit=crop"
                 alt="Men's Collection">
            <div class="cat-overlay"></div>
            <div class="cat-content">
                <div class="cat-label">For Him</div>
                <div class="cat-name">Men's</div>
                <a href="${pageContext.request.contextPath}/products?categoryId=1" class="cat-link">
                    Shop Now <span>→</span>
                </a>
            </div>
        </div>
        <div class="category-card animate-in delay-2">
            <img src="https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=600&q=80&fit=crop"
                 alt="Women's Collection">
            <div class="cat-overlay"></div>
            <div class="cat-content">
                <div class="cat-label">For Her</div>
                <div class="cat-name">Women's</div>
                <a href="${pageContext.request.contextPath}/products?categoryId=2" class="cat-link">
                    Shop Now <span>→</span>
                </a>
            </div>
        </div>
        <div class="category-card animate-in delay-3">
            <img src="https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?w=600&q=80&fit=crop"
                 alt="Kids Collection">
            <div class="cat-overlay"></div>
            <div class="cat-content">
                <div class="cat-label">For Kids</div>
                <div class="cat-name">Kids</div>
                <a href="${pageContext.request.contextPath}/products?categoryId=3" class="cat-link">
                    Shop Now <span>→</span>
                </a>
            </div>
        </div>
        <div class="category-card animate-in delay-4">
            <img src="https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=600&q=80&fit=crop"
                 alt="All Products">
            <div class="cat-overlay"></div>
            <div class="cat-content">
                <div class="cat-label">Everything</div>
                <div class="cat-name">All</div>
                <a href="${pageContext.request.contextPath}/products" class="cat-link">
                    Shop Now <span>→</span>
                </a>
            </div>
        </div>
    </div>
</section>

<div class="gold-divider"></div>

<!-- ═══════ TRENDING PRODUCTS ═══════ -->
<section class="section" style="background:var(--black);">
    <div class="section-header">
        <div class="section-label">Hot Right Now</div>
        <h2 class="section-title">Trending <em>Outfits</em></h2>
        <p class="section-desc">The best-selling styles our community can't stop wearing.</p>
    </div>
    <div class="trending-grid">
        <%
            if (homeProducts != null && !homeProducts.isEmpty()) {
                int count = 0;
                for (Product prod : homeProducts) {
                    if (count >= 4) break;
                    List<ProductVariant> vars = homeVariantService.getVariantsByProductId(prod.getProductId());
                    String pImg = "";
                    String pPrice = "View Price";
                    if (vars != null && !vars.isEmpty()) {
                        pImg = vars.get(0).getImageUrl();
                        pPrice = "₹" + vars.get(0).getPrice();
                    }
                    if (pImg == null || pImg.trim().isEmpty() || !pImg.startsWith("http")) {
                        if (prod.getCategoryId() == 1) {
                            pImg = "https://images.unsplash.com/photo-1544441893-675973e31985?w=500&q=80&fit=crop";
                        } else if (prod.getCategoryId() == 2) {
                            pImg = "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=500&q=80&fit=crop";
                        } else {
                            pImg = "https://images.unsplash.com/photo-1519457431-44ccd64a579b?w=500&q=80&fit=crop";
                        }
                    }
                    count++;
        %>
        <div class="product-card animate-in delay-<%= count %>" onclick="window.location.href='${pageContext.request.contextPath}/products?action=details&id=<%= prod.getProductId() %>'">
            <div class="product-img-wrap">
                <img src="<%= pImg %>" alt="<%= prod.getProductName() %>" loading="lazy">
                <span class="product-badge new">New</span>
                <div class="product-actions-overlay">
                    <a href="${pageContext.request.contextPath}/products?action=details&id=<%= prod.getProductId() %>" class="product-act-btn">View Details</a>
                    <span class="product-act-btn secondary">♡</span>
                </div>
            </div>
            <div class="product-info">
                <div class="product-category">
                    <%= (prod.getCategoryId() == 1) ? "Men" : (prod.getCategoryId() == 2 ? "Women" : "Kids") %> • Premium
                </div>
                <div class="product-name"><%= prod.getProductName() %></div>
                <div class="product-brand"><%= prod.getBrand() %></div>
                <div class="product-price-row">
                    <div class="product-price"><%= pPrice %></div>
                    <div class="product-rating">★★★★★ <span style="color:var(--gray)">4.9</span></div>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
            <p style="color:var(--gray);text-align:center;grid-column:1/-1;">Restocking soon!</p>
        <% } %>
    </div>
    <div style="text-align:center;margin-top:48px;">
        <a href="${pageContext.request.contextPath}/products" class="btn-primary">
            View All Products <span>→</span>
        </a>
    </div>
</section>

<div class="gold-divider"></div>

<!-- ═══════ TRENDING OUTFIT SECTION ═══════ -->
<section class="trending-outfit-section">
    <div class="outfit-grid">
        <div class="outfit-left">
            <img src="https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=900&q=80&fit=crop"
                 alt="Trending Outfit">
        </div>
        <div class="outfit-right">
            <div class="section-label" style="justify-content:flex-start;">Outfit of The Day</div>
            <h2 class="big-text">Trending <em>Outfit</em><br>Of The Day</h2>
            <p>Discover the finest fashion pieces curated by our expert stylists. Each piece tells a story of craftsmanship, elegance, and modern sophistication.</p>

            <div class="trending-outfit-cards">
                <%
                    if (homeProducts != null && homeProducts.size() > 4) {
                        int oCount = 0;
                        for (int i = 4; i < homeProducts.size() && oCount < 3; i++) {
                            Product prod = homeProducts.get(i);
                            List<ProductVariant> vars = homeVariantService.getVariantsByProductId(prod.getProductId());
                            String pImg = "";
                            String pPrice = "View Price";
                            if (vars != null && !vars.isEmpty()) {
                                pImg = vars.get(0).getImageUrl();
                                pPrice = "₹" + vars.get(0).getPrice();
                            }
                            if (pImg == null || pImg.trim().isEmpty() || !pImg.startsWith("http")) {
                                pImg = "https://images.unsplash.com/photo-1490578474895-699cd4e2cf59?w=400&q=80&fit=crop";
                            }
                            oCount++;
                %>
                <div class="tocard" onclick="window.location.href='${pageContext.request.contextPath}/products?action=details&id=<%= prod.getProductId() %>'">
                    <img src="<%= pImg %>" alt="<%= prod.getProductName() %>">
                    <div class="tocard-info">
                        <div class="tocard-name"><%= prod.getProductName() %></div>
                        <div class="tocard-price"><%= pPrice %></div>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="tocard">
                    <img src="https://images.unsplash.com/photo-1490578474895-699cd4e2cf59?w=400&q=80&fit=crop" alt="casual">
                    <div class="tocard-info">
                        <div class="tocard-name">Casual Jacket</div>
                        <div class="tocard-price">₹3,999</div>
                    </div>
                </div>
                <div class="tocard">
                    <img src="https://images.unsplash.com/photo-1434389677669-e08b4cac3105?w=400&q=80&fit=crop" alt="formal">
                    <div class="tocard-info">
                        <div class="tocard-name">Formal Shirt</div>
                        <div class="tocard-price">₹2,499</div>
                    </div>
                </div>
                <div class="tocard">
                    <img src="https://images.unsplash.com/photo-1503341455253-b2e723bb3dbb?w=400&q=80&fit=crop" alt="denim">
                    <div class="tocard-info">
                        <div class="tocard-name">Denim Jacket</div>
                        <div class="tocard-price">₹4,799</div>
                    </div>
                </div>
                <% } %>
            </div>

            <p style="font-size:1rem;color:var(--gray-light);line-height:1.7;margin-bottom:28px;">
                Best outfit makes your look more attractive. Continues to create new fashion trends to the finest product standards.
            </p>
            <a href="${pageContext.request.contextPath}/products" class="btn-primary" style="align-self:flex-start;">
                Shop This Look <span>→</span>
            </a>
        </div>
    </div>
</section>

<div class="gold-divider"></div>

<!-- ═══════ NEW ARRIVALS ═══════ -->
<section class="arrivals-section">
    <div class="arrivals-visual">
        <img src="https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=900&q=80&fit=crop"
             alt="New Arrivals">
        <div class="arrivals-visual-overlay"></div>
    </div>
    <div class="arrivals-content">
        <div class="section-label">Just In</div>
        <h2 class="section-title" style="text-align:left;">New Arrivals<br>To <em>Lifestyle</em></h2>
        <p class="section-desc" style="text-align:left;margin-left:0;">
            Explore fashion of demonstrating pleasure and proving exclusive.
            Make a statement with pieces designed to elevate your everyday look.
        </p>

        <div class="arrivals-features">
            <div class="arrivals-feature">
                <div class="arrivals-feature-icon">✦</div>
                <div class="arrivals-feature-text">
                    <h4>Premium Fabrics</h4>
                    <p>Sourced from the finest mills around the world</p>
                </div>
            </div>
            <div class="arrivals-feature">
                <div class="arrivals-feature-icon">📦</div>
                <div class="arrivals-feature-text">
                    <h4>Free Express Shipping</h4>
                    <p>On all orders above ₹2,000</p>
                </div>
            </div>
            <div class="arrivals-feature">
                <div class="arrivals-feature-icon">↩</div>
                <div class="arrivals-feature-text">
                    <h4>Easy 30-Day Returns</h4>
                    <p>Hassle-free returns on all purchases</p>
                </div>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/products" class="btn-primary" style="align-self:flex-start;">
            Add to Cart <span>→</span>
        </a>
    </div>
</section>

<div class="gold-divider"></div>

<!-- ═══════ VIDEO SECTION ═══════ -->
<div class="video-section">
    <div class="video-container-wrap" id="videoContainerWrap">
        <!-- Custom Awwwards magnetic cursor follower bubble -->
        <div class="video-cursor" id="videoCursor">Mute</div>
        
        <video id="fashionLoopVideo" class="video-bg" loop muted autoplay playsinline preload="auto">
            <source src="${pageContext.request.contextPath}/assets/images/fashion_loop.mp4" type="video/mp4">
            Your browser does not support the video tag.
        </video>
        
        <div class="video-overlay" style="background: rgba(10,10,10,0.6); display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; padding: 40px; position: absolute; inset: 0;">
            <div class="animate-in" style="display: flex; flex-direction: column; align-items: center; gap: 16px; pointer-events: auto;">
                <div class="section-label" style="margin-bottom: 0; justify-content: center;">Behind the Scenes</div>
                <h2 style="font-family: var(--font-heading); font-size: clamp(2rem, 5vw, 4rem); font-weight: 900; line-height: 1.1; letter-spacing: -0.5px; color: var(--white); text-shadow: 0 4px 20px rgba(0,0,0,0.6); text-transform: uppercase;">
                    Luxury in <em style="font-family: var(--font-heading); color: var(--gold); font-style: italic; text-transform: none;">Motion</em>
                </h2>
                <p style="color: var(--gray-light); font-size: clamp(0.9rem, 1.5vw, 1.1rem); max-width: 550px; line-height: 1.7; text-shadow: 0 2px 10px rgba(0,0,0,0.6); margin-bottom: 12px; margin-left: auto; margin-right: auto; font-weight: 300;">
                    A curated journey through fabric, silhouette, and modern craftsmanship. Elevate your daily expression with FAGISTAR couture.
                </p>
                <a href="${pageContext.request.contextPath}/products" class="btn-primary" style="backdrop-filter: blur(10px); padding: 16px 36px; font-size: 0.8rem;">
                    Explore Collection <span>→</span>
                </a>
            </div>
        </div>
        
        <!-- Floating Sound Toggle button -->
        <button class="sound-toggle muted" id="soundToggle" title="Toggle Audio">
            <span class="sound-wave-icon">
                <span class="sound-wave-bar"></span>
                <span class="sound-wave-bar"></span>
                <span class="sound-wave-bar"></span>
            </span>
            <span id="soundToggleText">Sound On</span>
        </button>
        
        <div style="position:absolute;bottom:40px;left:64px;pointer-events:none;z-index:2;">
            <div style="font-family:var(--font-display);font-size:1.2rem;letter-spacing:4px;color:var(--gold);opacity:0.8;">FAGISTAR</div>
        </div>
    </div>
</div>

<!-- ═══════ BRAND PARTNERS ═══════ -->
<div class="brands-strip">
    <span class="brand-logo">VERSACE</span>
    <span class="brand-logo">GUCCI</span>
    <span class="brand-logo">PRADA</span>
    <span class="brand-logo">ZARA</span>
    <span class="brand-logo">ARMANI</span>
    <span class="brand-logo">CALVIN</span>
</div>

<!-- ═══════ TESTIMONIALS ═══════ -->
<section class="section testimonials">
    <div class="section-header">
        <div class="section-label">What They Say</div>
        <h2 class="section-title">Customer <em>Reviews</em></h2>
    </div>
    <div class="testimonial-grid">
        <div class="testimonial-card animate-in delay-1">
            <div class="testimonial-stars">★★★★★</div>
            <p class="testimonial-text">"The quality is beyond exceptional. I've never felt so confident in an outfit. FAGISTAR truly understands modern fashion."</p>
            <div class="testimonial-author">
                <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&q=80&fit=crop&face" class="author-avatar" alt="author">
                <div>
                    <div class="author-name">Arjun Sharma</div>
                    <div class="author-role">Fashion Enthusiast</div>
                </div>
            </div>
        </div>
        <div class="testimonial-card animate-in delay-2">
            <div class="testimonial-stars">★★★★★</div>
            <p class="testimonial-text">"From packaging to the fabric quality — everything screams premium. This is my go-to brand for all occasions now."</p>
            <div class="testimonial-author">
                <img src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&q=80&fit=crop&face" class="author-avatar" alt="author">
                <div>
                    <div class="author-name">Priya Mehta</div>
                    <div class="author-role">Style Blogger</div>
                </div>
            </div>
        </div>
        <div class="testimonial-card animate-in delay-3">
            <div class="testimonial-stars">★★★★★</div>
            <p class="testimonial-text">"Ordered twice and both times exceeded my expectations. The fit is perfect, the material is divine. Highly recommend!"</p>
            <div class="testimonial-author">
                <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&q=80&fit=crop&face" class="author-avatar" alt="author">
                <div>
                    <div class="author-name">Rahul Gupta</div>
                    <div class="author-role">Verified Buyer</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ═══════ FOOTER ═══════ -->
<footer class="footer">
    <div class="footer-grid">
        <div>
            <div class="footer-logo">FAGISTAR</div>
            <p class="footer-tagline">Creating fashion that empowers. Discover your signature style with our curated, handpicked collections from the finest designers.</p>
            <div class="footer-socials">
                <a href="#" class="social-btn">f</a>
                <a href="#" class="social-btn">in</a>
                <a href="#" class="social-btn">tw</a>
                <a href="#" class="social-btn">ig</a>
            </div>
        </div>
        <div>
            <div class="footer-heading">Products</div>
            <ul class="footer-links">
                <li><a href="${pageContext.request.contextPath}/products">Categories</a></li>
                <li><a href="${pageContext.request.contextPath}/products">New Arrivals</a></li>
                <li><a href="${pageContext.request.contextPath}/products">Men</a></li>
                <li><a href="${pageContext.request.contextPath}/products">Women</a></li>
                <li><a href="${pageContext.request.contextPath}/products">Sale</a></li>
            </ul>
        </div>
        <div>
            <div class="footer-heading">Company</div>
            <ul class="footer-links">
                <li><a href="#">About</a></li>
                <li><a href="#">Menu</a></li>
                <li><a href="#">Career</a></li>
                <li><a href="#">Contact</a></li>
            </ul>
        </div>
        <div>
            <div class="footer-heading">Contact Us</div>
            <ul class="footer-links">
                <li><a href="#">+91 98765 43210</a></li>
                <li><a href="#">info@fagistar.com</a></li>
                <li><a href="#">456 Park Ave, G.Block</a></li>
                <li><a href="#">Mumbai - 400001</a></li>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">
        <span class="footer-copy">© 2025 FAGISTAR Fashion Store. All rights reserved.</span>
        <span class="footer-copy">Privacy Policy · Terms of Service</span>
    </div>
</footer>

<script>
// Intersection Observer for scroll animations
const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
            entry.target.classList.add('visible'); // Added class toggle for Awwwards animations
        }
    });
}, { threshold: 0.1 });

document.querySelectorAll('.animate-in').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(30px)';
    el.style.transition = 'opacity 0.7s ease, transform 0.7s ease';
    observer.observe(el);
});

// 3D card tilt effect
document.querySelectorAll('.product-card').forEach(card => {
    card.addEventListener('mousemove', (e) => {
        const rect = card.getBoundingClientRect();
        const x = (e.clientX - rect.left) / rect.width - 0.5;
        const y = (e.clientY - rect.top) / rect.height - 0.5;
        card.style.transform = `translateY(-12px) rotateY(${x * 10}deg) rotateX(${-y * 8}deg)`;
    });
    card.addEventListener('mouseleave', () => {
        card.style.transform = '';
    });
});

// ════════════ AWWWARDS INTERACTION LOGIC ════════════

document.addEventListener('DOMContentLoaded', () => {
    const video = document.getElementById('fashionLoopVideo');
    const container = document.getElementById('videoContainerWrap');
    const cursor = document.getElementById('videoCursor');
    const soundToggle = document.getElementById('soundToggle');
    const soundToggleText = document.getElementById('soundToggleText');
    const videoSection = document.querySelector('.video-section');

    if (!video) return;

    // --- 1. Autoplay Fail-Safe ---
    const playVideo = () => {
        video.play().then(() => {
            console.log("Autoplay succeeded.");
        }).catch(err => {
            console.warn("Autoplay blocked. Registering interaction trigger.", err);
            const forcePlay = () => {
                video.play();
                document.removeEventListener('click', forcePlay);
                document.removeEventListener('scroll', forcePlay);
                document.removeEventListener('touchstart', forcePlay);
            };
            document.addEventListener('click', forcePlay);
            document.addEventListener('scroll', forcePlay);
            document.addEventListener('touchstart', forcePlay);
        });
    };
    playVideo();

    // --- 2. Custom Magnetic Cursor follower ---
    if (container && cursor) {
        container.addEventListener('mousemove', (e) => {
            const rect = container.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            
            // Instantly move cursor wrapper to mouse position
            cursor.style.left = `${x}px`;
            cursor.style.top = `${y}px`;
        });
    }

    // --- 3. Sound Wave toggling ---
    const toggleAudio = (e) => {
        if (e) e.stopPropagation();
        
        if (video.muted) {
            video.muted = false;
            soundToggle.classList.remove('muted');
            soundToggleText.textContent = "Mute";
            if (cursor) cursor.textContent = "Mute";
        } else {
            video.muted = true;
            soundToggle.classList.add('muted');
            soundToggleText.textContent = "Sound On";
            if (cursor) cursor.textContent = "Unmute";
        }
    };

    if (soundToggle) {
        soundToggle.addEventListener('click', toggleAudio);
    }
    if (container) {
        container.addEventListener('click', toggleAudio);
    }

    // Initialize cursor text to match state
    if (cursor) {
        cursor.textContent = video.muted ? "Unmute" : "Mute";
    }

    // --- 4. Scroll-Driven Scaling & Border-Radius ---
    if (videoSection) {
        let tick = false;
        const handleScroll = () => {
            if (!tick) {
                window.requestAnimationFrame(() => {
                    const rect = videoSection.getBoundingClientRect();
                    const windowHeight = window.innerHeight;
                    
                    if (rect.top < windowHeight && rect.bottom > 0) {
                        const distance = windowHeight - rect.top;
                        // Calculate fraction (reach full size when 80% through the viewport)
                        const fraction = Math.max(0, Math.min(1, distance / (windowHeight * 0.8)));
                        
                        // Scale up from 0.92 to 1.0
                        const scale = 0.92 + (fraction * 0.08);
                        // Morph border-radius from 40px down to 8px
                        const borderRadius = Math.max(8, 40 - (fraction * 32));
                        
                        videoSection.style.transform = `scale(${scale})`;
                        videoSection.style.borderRadius = `${borderRadius}px`;
                    }
                    tick = false;
                });
                tick = true;
            }
        };
        window.addEventListener('scroll', handleScroll, { passive: true });
        handleScroll(); // Initial run
    }
});
</script>
</body>
</html>