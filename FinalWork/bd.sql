CREATE DATABASE dns_shop;
\c dns_shop;


CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_category_id INTEGER REFERENCES categories(category_id)
);


CREATE TABLE brands (
    brand_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    website VARCHAR(255)
);


CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    category_id INTEGER NOT NULL REFERENCES categories(category_id),
    brand_id INTEGER NOT NULL REFERENCES brands(brand_id),
    specifications JSONB,
    sku VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT
);


CREATE TABLE product_suppliers (
    product_supplier_id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    supplier_id INTEGER NOT NULL REFERENCES suppliers(supplier_id),
    supply_price DECIMAL(10, 2) NOT NULL CHECK (supply_price >= 0),
    delivery_days INTEGER NOT NULL CHECK (delivery_days > 0),
    UNIQUE(product_id, supplier_id)
);


CREATE TABLE warehouses (
    warehouse_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    phone VARCHAR(20)
);


CREATE TABLE stock (
    stock_id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    warehouse_id INTEGER NOT NULL REFERENCES warehouses(warehouse_id),
    quantity INTEGER NOT NULL CHECK (quantity >= 0) DEFAULT 0,
    last_restocked TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(product_id, warehouse_id)
);


CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    salary DECIMAL(10, 2) NOT NULL CHECK (salary >= 0),
    hire_date DATE NOT NULL
);


CREATE TABLE payment_methods (
    payment_method_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);


CREATE TABLE order_statuses (
    status_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);


CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
    employee_id INTEGER REFERENCES employees(employee_id),
    status_id INTEGER NOT NULL REFERENCES order_statuses(status_id),
    payment_method_id INTEGER NOT NULL REFERENCES payment_methods(payment_method_id),
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    shipped_date TIMESTAMP,
    shipping_address TEXT NOT NULL
);


CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(order_id),
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0),
    subtotal DECIMAL(10, 2) GENERATED ALWAYS AS (quantity * unit_price) STORED
);


CREATE TABLE promotions (
    promotion_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    discount_percent DECIMAL(5, 2) NOT NULL CHECK (discount_percent BETWEEN 0 AND 100),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    CHECK (end_date >= start_date)
);


CREATE TABLE product_promotions (
    product_promotion_id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    promotion_id INTEGER NOT NULL REFERENCES promotions(promotion_id),
    UNIQUE(product_id, promotion_id)
);


CREATE TABLE product_reviews (
    review_id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(product_id, customer_id)
);


CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_brand ON products(brand_id);
CREATE INDEX idx_stock_product ON stock(product_id);
CREATE INDEX idx_stock_warehouse ON stock(warehouse_id);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_status ON orders(status_id);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);
CREATE INDEX idx_product_reviews_product ON product_reviews(product_id);
CREATE INDEX idx_product_reviews_customer ON product_reviews(customer_id);

--наполнение--
INSERT INTO categories (name, description, parent_category_id) VALUES
('Компьютерная техника', 'Компьютеры и комплектующие', NULL),
('Ноутбуки', 'Портативные компьютеры', 1),
('Игровые ноутбуки', 'Ноутбуки для игр', 2),
('Ультрабуки', 'Тонкие и легкие ноутбуки', 2),
('Компьютеры', 'Стационарные компьютеры', 1),
('Мониторы', 'Мониторы и дисплеи', 1),
('Комплектующие', 'Комплектующие для ПК', 1),
('Процессоры', 'Центральные процессоры', 7),
('Видеокарты', 'Графические процессоры', 7),
('Периферия', 'Периферийные устройства', NULL),
('Клавиатуры', 'Клавиатуры для ПК', 10),
('Мыши', 'Компьютерные мыши', 10),
('Наушники', 'Аудио гарнитуры', 10);


INSERT INTO brands (name, country, website) VALUES
('ASUS', 'Тайвань', 'https://www.asus.com'),
('Lenovo', 'Китай', 'https://www.lenovo.com'),
('Apple', 'США', 'https://www.apple.com'),
('Samsung', 'Южная Корея', 'https://www.samsung.com'),
('HP', 'США', 'https://www.hp.com'),
('Dell', 'США', 'https://www.dell.com'),
('Acer', 'Тайвань', 'https://www.acer.com'),
('MSI', 'Тайвань', 'https://www.msi.com'),
('Intel', 'США', 'https://www.intel.com'),
('AMD', 'США', 'https://www.amd.com'),
('NVIDIA', 'США', 'https://www.nvidia.com'),
('Logitech', 'Швейцария', 'https://www.logitech.com'),
('Razer', 'США', 'https://www.razer.com');


INSERT INTO products (name, description, price, category_id, brand_id, specifications, sku) VALUES
('ASUS ROG Strix G15', 'Игровой ноутбук с процессором Intel i7 и видеокартой RTX 3060', 129999.99, 3, 1, '{"processor": "Intel i7-11800H", "ram": "16GB", "storage": "512GB SSD", "gpu": "RTX 3060"}', 'ASUS-G15-001'),
('Lenovo ThinkPad X1', 'Ультрабук для бизнеса с процессором Intel i5', 89999.99, 4, 2, '{"processor": "Intel i5-1135G7", "ram": "8GB", "storage": "256GB SSD"}', 'LEN-X1-002'),
('Apple MacBook Pro 16"', 'Профессиональный ноутбук с чипом M1 Pro', 199999.99, 4, 3, '{"processor": "Apple M1 Pro", "ram": "16GB", "storage": "512GB SSD"}', 'APP-MBP16-003'),
('Samsung Odyssey G7', 'Игровой монитор 32" 240Hz', 49999.99, 6, 4, '{"size": "32\"", "resolution": "2560x1440", "refresh_rate": "240Hz"}', 'SAM-G7-004'),
('Intel Core i9-12900K', 'Процессор 16 ядерный', 39999.99, 8, 9, '{"cores": 16, "threads": 24, "frequency": "3.2GHz"}', 'INT-I9-005'),
('AMD Ryzen 9 5950X', 'Процессор 16 ядерный', 37999.99, 8, 10, '{"cores": 16, "threads": 32, "frequency": "3.4GHz"}', 'AMD-R9-006'),
('NVIDIA RTX 4090', 'Видеокарта 24GB GDDR6X', 159999.99, 9, 11, '{"memory": "24GB", "type": "GDDR6X", "interface": "PCIe 4.0"}', 'NVD-4090-007'),
('Logitech G Pro X', 'Механическая игровая клавиатура', 8999.99, 11, 12, '{"type": "mechanical", "switches": "GX Blue", "backlight": "RGB"}', 'LOG-GPX-008'),
('Razer DeathAdder V2', 'Игровая мышь', 4999.99, 12, 13, '{"dpi": 20000, "buttons": 8, "weight": "82g"}', 'RAZ-DAV2-009'),
('ASUS TUF Gaming Monitor', 'Игровой монитор 27" 165Hz', 29999.99, 6, 1, '{"size": "27\"", "resolution": "1920x1080", "refresh_rate": "165Hz"}', 'ASUS-TUF-010');


INSERT INTO suppliers (name, contact_person, phone, email, address) VALUES
('ООО ТехноПоставка', 'Иванов Иван', '+7-495-123-45-67', 'info@technosupply.ru', 'Москва, ул. Ленина, 1'),
('ЗАО КомпьютерМаркет', 'Петров Петр', '+7-495-765-43-21', 'sales@compmarket.ru', 'Москва, пр. Мира, 15'),
('ООО ДистрибьюторСервис', 'Сидоров Алексей', '+7-495-555-44-33', 'distrib@service.ru', 'Санкт-Петербург, Невский пр., 100'),
('ИП Электроника', 'Смирнова Ольга', '+7-812-333-22-11', 'electronics@ip.ru', 'Санкт-Петербург, ул. Садовая, 50');


INSERT INTO product_suppliers (product_id, supplier_id, supply_price, delivery_days) VALUES
(1, 1, 110000.00, 7),
(2, 2, 75000.00, 5),
(3, 1, 170000.00, 14),
(4, 3, 42000.00, 10),
(5, 2, 34000.00, 3),
(6, 3, 32000.00, 3),
(7, 1, 140000.00, 21),
(8, 4, 7000.00, 2),
(9, 4, 3500.00, 2),
(10, 3, 25000.00, 7);


INSERT INTO warehouses (name, address, phone) VALUES
('Центральный склад', 'Москва, ул. Складская, 1', '+7-495-111-11-11'),
('Северный склад', 'Санкт-Петербург, ул. Складская, 2', '+7-812-222-22-22'),
('Южный склад', 'Ростов-на-Дону, ул. Складская, 3', '+7-863-333-33-33');


INSERT INTO stock (product_id, warehouse_id, quantity, last_restocked) VALUES
(1, 1, 15, '2024-01-15'),
(2, 1, 20, '2024-01-10'),
(3, 1, 8, '2024-01-05'),
(4, 2, 12, '2024-01-12'),
(5, 1, 25, '2024-01-08'),
(6, 1, 18, '2024-01-09'),
(7, 1, 5, '2024-01-20'),
(8, 3, 50, '2024-01-07'),
(9, 3, 40, '2024-01-06'),
(10, 2, 15, '2024-01-11');


INSERT INTO customers (first_name, last_name, email, phone, address, registered_at) VALUES
('Алексей', 'Смирнов', 'alex.smirnov@mail.ru', '+7-916-123-45-67', 'Москва, ул. Пушкина, 10', '2024-01-01'),
('Мария', 'Иванова', 'maria.ivanova@gmail.com', '+7-925-234-56-78', 'Москва, ул. Лермонтова, 15', '2024-01-02'),
('Дмитрий', 'Петров', 'dmitry.petrov@yandex.ru', '+7-903-345-67-89', 'Санкт-Петербург, Невский пр., 20', '2024-01-03'),
('Екатерина', 'Сидорова', 'ekaterina.sidorova@mail.ru', '+7-911-456-78-90', 'Санкт-Петербург, ул. Садовая, 25', '2024-01-04'),
('Иван', 'Кузнецов', 'ivan.kuznetsov@gmail.com', '+7-915-567-89-01', 'Москва, пр. Мира, 30', '2024-01-05');


INSERT INTO employees (first_name, last_name, position, email, phone, salary, hire_date) VALUES
('Ольга', 'Васильева', 'Менеджер по продажам', 'olga.vasileva@dns.ru', '+7-495-001-01-01', 80000.00, '2023-01-15'),
('Сергей', 'Николаев', 'Старший менеджер', 'sergey.nikolaev@dns.ru', '+7-495-001-01-02', 100000.00, '2022-06-10'),
('Анна', 'Павлова', 'Консультант', 'anna.pavlova@dns.ru', '+7-495-001-01-03', 60000.00, '2023-03-20'),
('Михаил', 'Федоров', 'IT-специалист', 'mikhail.fedorov@dns.ru', '+7-495-001-01-04', 90000.00, '2022-11-05');


INSERT INTO payment_methods (name, description) VALUES
('Наличные', 'Оплата наличными при получении'),
('Банковская карта', 'Оплата банковской картой онлайн'),
('Кредит', 'Покупка в кредит'),
('Рассрочка', 'Рассрочка платежа');


INSERT INTO order_statuses (name, description) VALUES
('Оформлен', 'Заказ создан, ожидает обработки'),
('Оплачен', 'Заказ оплачен, готовится к отправке'),
('Отправлен', 'Заказ отправлен покупателю'),
('Доставлен', 'Заказ доставлен покупателю'),
('Отменен', 'Заказ отменен');


INSERT INTO orders (customer_id, employee_id, status_id, payment_method_id, total_amount, order_date, shipped_date, shipping_address) VALUES
(1, 1, 4, 2, 129999.99, '2024-01-10', '2024-01-12', 'Москва, ул. Пушкина, 10'),
(2, 2, 3, 1, 89999.99, '2024-01-11', '2024-01-13', 'Москва, ул. Лермонтова, 15'),
(3, 1, 2, 2, 199999.99, '2024-01-12', NULL, 'Санкт-Петербург, Невский пр., 20'),
(4, 3, 1, 3, 49999.99, '2024-01-13', NULL, 'Санкт-Петербург, ул. Садовая, 25'),
(5, 2, 4, 2, 8999.99, '2024-01-14', '2024-01-15', 'Москва, пр. Мира, 30');


INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 129999.99),
(2, 2, 1, 89999.99),
(3, 3, 1, 199999.99),
(4, 4, 1, 49999.99),
(5, 8, 1, 8999.99);


INSERT INTO promotions (name, description, discount_percent, start_date, end_date) VALUES
('Зимняя распродажа', 'Скидки на всю технику', 15.00, '2024-01-15', '2024-02-15'),
('Геймерские выходные', 'Скидки на игровые товары', 10.00, '2024-01-20', '2024-01-21'),
('Бack to School', 'Скидки для студентов', 12.50, '2024-01-25', '2024-02-10');


INSERT INTO product_promotions (product_id, promotion_id) VALUES
(1, 1),
(4, 1),
(7, 1),
(8, 1),
(9, 1),
(1, 2),
(4, 2),
(7, 2),
(8, 2),
(9, 2),
(2, 3),
(3, 3),
(8, 3);


INSERT INTO product_reviews (product_id, customer_id, rating, comment, created_at) VALUES
(1, 1, 5, 'Отличный игровой ноутбук, все игры на ультра настройках!', '2024-01-16'),
(2, 2, 4, 'Хороший ультрабук, легкий и стильный', '2024-01-14'),
(8, 5, 5, 'Лучшая клавиатура для игр, очень удобная', '2024-01-16'),
(4, 4, 3, 'Монитор хороший, но есть небольшой бэклайт', '2024-01-15'),
(9, 3, 4, 'Удобная мышь, отзывчивый сенсор', '2024-01-13');
