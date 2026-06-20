-- Disable foreign key checks for clean truncation
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE product_variants;
TRUNCATE TABLE products;
SET FOREIGN_KEY_CHECKS = 1;

-- Seed Products
-- Men (category_id = 1)
INSERT INTO products (product_id, category_id, product_name, brand, description) VALUES
(1, 1, 'Slim Fit Shirt', 'Levis', 'Premium cotton shirt for a clean, sharp look.'),
(2, 1, 'Casual Jeans', 'Levis', 'Comfortable blue denim jeans perfect for daily wear.'),
(5, 1, 'Classic Leather Jacket', 'Zara', 'Timeless black leather jacket made with premium cowhide.'),
(6, 1, 'Modern Crewneck Sweater', 'H&M', 'Soft knit crewneck sweater in charcoal grey.'),
(7, 1, 'Sporty Running Shoes', 'Nike', 'Lightweight, breathable running shoes with active cushioning.'),
(8, 1, 'Tailored Slim Fit Suit', 'Armani', 'Premium two-piece Italian wool suit for formal refinement.'),
(9, 1, 'Casual Denim Shirt', 'Levis', 'Light-washed blue denim shirt with a relaxed fit.'),
(10, 1, 'Chino Trousers', 'Dockers', 'Smart-casual slim fit khaki pants.');

-- Women (category_id = 2)
INSERT INTO products (product_id, category_id, product_name, brand, description) VALUES
(3, 2, 'Floral Top', 'Zara', 'Vibrant summer floral top with a breezy aesthetic.'),
(4, 2, 'Maxi Dress', 'H&M', 'Elegant flowy maxi dress ideal for evening outings.'),
(11, 2, 'Classic Trench Coat', 'Burberry', 'Elegantly styled double-breasted coat in signature beige.'),
(12, 2, 'High-Waisted Skinny Jeans', 'Zara', 'Stretch blue denim jeans with a flattering high-rise fit.'),
(13, 2, 'Wool Knit Cardigan', 'H&M', 'Cozy oversized open-front knit cardigan in cream beige.'),
(14, 2, 'Leather Crossbody Bag', 'Prada', 'Compact designer leather handbag with gold chain strap.'),
(15, 2, 'Pleated Midi Skirt', 'Zara', 'Flowy pastel green pleated midi skirt for a modern look.'),
(16, 2, 'Ankle Leather Boots', 'Gucci', 'Premium black leather boots with a steady block heel.');

-- Kids (category_id = 3)
INSERT INTO products (product_id, category_id, product_name, brand, description) VALUES
(17, 3, 'Kids Organic Cotton Tee', 'H&M', 'Fun, colorful organic cotton t-shirt for daily comfort.'),
(18, 3, 'Kids Denim Overalls', 'Levis', 'Classic durable denim dungarees designed for active play.'),
(19, 3, 'Toddler Winter Puffer', 'H&M', 'Warm insulated puffer jacket in a bright, cheerful yellow.'),
(20, 3, 'Kids Canvas Sneakers', 'Converse', 'Classic high-top canvas sneakers with durable rubber soles.'),
(21, 3, 'Girls Floral Summer Dress', 'Zara', 'Lightweight printed cotton sundress with a ruffled hem.'),
(22, 3, 'Kids Jogger Pants', 'Nike', 'Soft fleece-lined jogger sweatpants with an elastic waist.');

-- Seed Product Variants
INSERT INTO product_variants (variant_id, product_id, size, color, price, stock_quantity, image_url) VALUES
-- Slim Fit Shirt (ID 1)
(1, 1, 'M', 'Black', 999.00, 20, 'https://images.unsplash.com/photo-1622470953794-aa9c70b0fb9d?w=500&q=80&fit=crop'),
(2, 1, 'L', 'Black', 999.00, 15, 'https://images.unsplash.com/photo-1622470953794-aa9c70b0fb9d?w=500&q=80&fit=crop'),
-- Casual Jeans (ID 2)
(3, 2, '32', 'Blue', 1499.00, 5, 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=500&q=80&fit=crop'),
-- Floral Top (ID 3)
(4, 3, 'S', 'Pink', 799.00, 25, 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=500&q=80&fit=crop'),
-- Maxi Dress (ID 4)
(5, 4, 'M', 'Red', 1999.00, 12, 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=500&q=80&fit=crop'),
-- Classic Leather Jacket (ID 5)
(6, 5, 'M', 'Black', 3499.00, 10, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500&q=80&fit=crop'),
(7, 5, 'L', 'Black', 3499.00, 8, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500&q=80&fit=crop'),
-- Modern Crewneck Sweater (ID 6)
(8, 6, 'M', 'Grey', 1299.00, 18, 'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=500&q=80&fit=crop'),
(9, 6, 'L', 'Grey', 1299.00, 12, 'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=500&q=80&fit=crop'),
-- Sporty Running Shoes (ID 7)
(10, 7, '10', 'Red', 2999.00, 15, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&q=80&fit=crop'),
-- Tailored Slim Fit Suit (ID 8)
(11, 8, 'M', 'Blue', 8999.00, 5, 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=500&q=80&fit=crop'),
-- Casual Denim Shirt (ID 9)
(12, 9, 'M', 'Blue', 1199.00, 20, 'https://images.unsplash.com/photo-1588359348347-9bc6cbbb689e?w=500&q=80&fit=crop'),
-- Chino Trousers (ID 10)
(13, 10, '32', 'Khaki', 1599.00, 14, 'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=500&q=80&fit=crop'),
-- Classic Trench Coat (ID 11)
(14, 11, 'M', 'Beige', 4999.00, 8, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=500&q=80&fit=crop'),
-- High-Waisted Skinny Jeans (ID 12)
(15, 12, '28', 'Blue', 1899.00, 15, 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=500&q=80&fit=crop'),
-- Wool Knit Cardigan (ID 13)
(16, 13, 'S', 'Beige', 2299.00, 10, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=500&q=80&fit=crop'),
-- Leather Crossbody Bag (ID 14)
(17, 14, 'OS', 'Black', 5999.00, 6, 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=500&q=80&fit=crop'),
-- Pleated Midi Skirt (ID 15)
(18, 15, 'M', 'Green', 1499.00, 12, 'https://images.unsplash.com/photo-1583496661160-fb48862c4a4e?w=500&q=80&fit=crop'),
-- Ankle Leather Boots (ID 16)
(19, 16, '7', 'Black', 4500.00, 7, 'https://images.unsplash.com/photo-1560343090-f0409e92791a?w=500&q=80&fit=crop'),
-- Kids Organic Cotton Tee (ID 17)
(20, 17, '6Y', 'Yellow', 499.00, 30, 'https://images.unsplash.com/photo-1519457431-44ccd64a579b?w=500&q=80&fit=crop'),
-- Kids Denim Overalls (ID 18)
(21, 18, '5Y', 'Blue', 1299.00, 15, 'https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?w=500&q=80&fit=crop'),
-- Toddler Winter Puffer (ID 19)
(22, 19, '4Y', 'Yellow', 1999.00, 10, 'https://images.unsplash.com/photo-1540479859555-17af45c78a62?w=500&q=80&fit=crop'),
-- Kids Canvas Sneakers (ID 20)
(23, 20, '12K', 'Red', 999.00, 20, 'https://images.unsplash.com/photo-1514989940723-e8e51635b782?w=500&q=80&fit=crop'),
-- Girls Floral Summer Dress (ID 21)
(24, 21, '6Y', 'Pink', 1199.00, 18, 'https://images.unsplash.com/photo-1503919545889-aef636e10ad4?w=500&q=80&fit=crop'),
-- Kids Jogger Pants (ID 22)
(25, 22, '7Y', 'Grey', 799.00, 22, 'https://images.unsplash.com/photo-1551854838-212c50b4c184?w=500&q=80&fit=crop');
