-- ShopKenyaZone Database Schema

-- Categories Table
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    image VARCHAR(255),
    parent_id INT DEFAULT NULL,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- Products Table
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    sale_price DECIMAL(10,2) DEFAULT NULL,
    stock INT DEFAULT 0,
    category_id INT NOT NULL,
    images JSON,
    status ENUM('active', 'inactive', 'out_of_stock') DEFAULT 'active',
    featured TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Users Table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(50),
    password VARCHAR(255) NOT NULL,
    role ENUM('customer', 'admin') DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Addresses Table
CREATE TABLE addresses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    name VARCHAR(255),
    phone VARCHAR(50),
    county VARCHAR(100),
    town VARCHAR(100),
    address TEXT,
    is_default TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Orders Table
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    shipping_fee DECIMAL(10,2) DEFAULT 0,
    payment_method VARCHAR(50),
    payment_status ENUM('pending', 'paid', 'failed') DEFAULT 'pending',
    order_status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    shipping_county VARCHAR(100),
    shipping_town VARCHAR(100),
    shipping_address TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Order Items Table
CREATE TABLE order_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Banners Table
CREATE TABLE banners (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    image VARCHAR(255) NOT NULL,
    link VARCHAR(255),
    position ENUM('main', 'secondary', 'popup') DEFAULT 'main',
    status ENUM('active', 'inactive') DEFAULT 'active',
    sort_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Settings Table
CREATE TABLE settings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    setting_key VARCHAR(100) UNIQUE NOT NULL,
    setting_value TEXT
);

-- Insert sample categories
INSERT INTO categories (name, slug, image) VALUES
('Phones & Accessories', 'phones-accessories', 'https://img.kilimall.com/c/common/category-icon/100000760.jpg'),
('Computers & Accessories', 'computers-accessories', 'https://img.kilimall.com/c/common/category-icon/100000492.jpg'),
('Electronics', 'electronics', 'https://img.kilimall.com/c/common/category-icon/100000784.jpg'),
('Fashion', 'fashion', 'https://img.kilimall.com/c/common/category-icon/100000493.jpg'),
('Home & Kitchen', 'home-kitchen', 'https://img.kilimall.com/c/common/category-icon/100000494.jpg'),
('Beauty & Personal Care', 'beauty-personal-care', 'https://img.kilimall.com/c/common/category-icon/100000495.png'),
('Appliances', 'appliances', 'https://img.kilimall.com/c/common/category-icon/100000668.png'),
('Women Shoes', 'women-shoes', 'https://img.kilimall.com/c/common/category-icon/100000495.png'),
('Bags', 'bags', 'https://img.kilimall.com/c/common/category-icon/100000010.jpg'),
('Watches & Jewellery', 'watches-jewellery', 'https://img.kilimall.com/c/common/category-icon/100001862.png'),
('Kids & Baby', 'kids-baby', 'https://img.kilimall.com/c/common/category-icon/100000985.jpg'),
('Others', 'others', 'https://img.kilimall.com/c/common/category-icon/100000785.png');

-- Insert sample products
INSERT INTO products (name, slug, description, price, sale_price, stock, category_id, images, featured) VALUES
('Smartphone X12 Pro - 6GB RAM, 128GB Storage', 'smartphone-x12-pro', 'Latest smartphone with excellent camera and long battery life', 15999, 12999, 50, 1, '["https://img.kilimall.com/c/common/category-icon/100000760.jpg"]', 1),
('Wireless Bluetooth Headphones', 'bluetooth-headphones', 'High quality wireless headphones with noise cancellation', 2999, 1999, 100, 1, '["https://img.kilimall.com/c/common/category-icon/100001640.jpg"]', 1),
('Laptop 15 inch - 8GB RAM', 'laptop-15-inch', 'Powerful laptop for work and gaming', 45999, 39999, 30, 2, '["https://img.kilimall.com/c/common/category-icon/100000492.jpg"]', 1),
('Men Canvas Shoes - Black', 'men-canvas-shoes-black', 'Comfortable casual shoes for men', 1499, 999, 200, 4, '["https://img.kilimall.com/c/common/category-icon/100000495.png"]', 1),
('Women Handbag - Khaki', 'women-handbag-khaki', 'Large capacity shoulder bag', 899, 599, 80, 9, '["https://img.kilimall.com/c/common/category-icon/100000615.png"]', 1),
('Smart Watch Series 5', 'smart-watch-series-5', 'Fitness tracker with heart rate monitor', 4999, 3499, 120, 1, '["https://img.kilimall.com/c/common/category-icon/100000676.jpg"]', 1),
('55 inch Smart TV', '55-inch-smart-tv', '4K Ultra HD Smart TV with Android', 34999, 29999, 25, 3, '["https://img.kilimall.com/c/common/category-icon/100000785.png"]', 1),
(' Blender 2 in 1', 'blender-2-in-1', 'Professional kitchen blender', 2999, 2199, 60, 5, '["https://img.kilimall.com/c/common/category-icon/100001631.jpg"]', 1);

-- Insert sample banners
INSERT INTO banners (title, image, link, position, sort_order) VALUES
('Flash Sale', 'https://img.kilimall.com/c/public/banner-image/100016308.jpg', '', 'main', 1),
('New Arrivals', 'https://img.kilimall.com/c/public/banner-image/100016051.jpg', '', 'main', 2),
('Big Deals', 'https://img.kilimall.com/c/public/banner-image/100016205.jpg', '', 'main', 3),
('Free Shipping', 'https://img.kilimall.com/c/public/banner-image/100016232.jpg', '', 'main', 4),
('Best Brands', 'https://img.kilimall.com/c/public/banner-image/100016309.jpg', '', 'main', 5);

-- Insert settings
INSERT INTO settings (setting_key, setting_value) VALUES
('site_name', 'ShopKenyaZone'),
('site_email', 'support@shopkenyazone.co.ke'),
('site_phone', '+254700000000'),
('shipping_fee', '250'),
('mpesa_shortcode', '123456'),
('mpesa_passkey', 'your_passkey_here');