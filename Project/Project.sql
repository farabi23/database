create table customer(
    customer_id integer,
    name varchar(20),
    address varchar(30),
    phone_number integer,
    seller_ID integer,
    primary key(customer_id),
    foreign key(seller_ID) references seller(seller_id)
);
create table products(
    product_id integer primary key,
    product_name varchar(15) not null,
    product_price float not null
);
create table seller(
    seller_id integer primary key,
    seller_name varchar(15) not null
);
create table sell(
    seller_ID integer not null,
    customer_ID integer not null,
    product_ID integer not null,
    foreign key(seller_ID) references seller(seller_id),
    foreign key(customer_ID) references customer(customer_id),
    foreign key(product_ID) references products(product_id)
);

create table shop_orders(
    order_id integer primary key,
    customer_ID integer,
    date date,
    product_ID float,
    customer_name varchar(15),
    foreign key(customer_name) references customer(name),
    foreign key(customer_ID) references customer(customer_id),
    foreign key(product_ID) references products(product_id)
);
create table delivery(
    delivery_id integer primary key,
    date date,
    customer_ID integer,
    order_ID integer,
    foreign key(order_ID) references shop_orders(order_id),
    foreign key(customer_ID) references customer(customer_id)
);



INSERT INTO seller (seller_id, seller_name) VALUES (69, 'A');
INSERT INTO seller (seller_id, seller_name) VALUES (79, 'B');
INSERT INTO seller (seller_id, seller_name) VALUES (89, 'C');


INSERT INTO customer (customer_id, name, address, tele_number, "seller_ID") VALUES (169, 'Farabi', 'Shymkent', '8705', 69);
INSERT INTO customer (customer_id, name, address, tele_number, "seller_ID") VALUES (179, 'Asel', 'Almaty', '8775', 79);
INSERT INTO customer (customer_id, name, address, tele_number, "seller_ID") VALUES (189, 'Shmara', 'London', '9000', 89);


INSERT INTO products (product_id, product_name, product_price) VALUES (269, 'Phone', 500.00);
INSERT INTO products (product_id, product_name, product_price) VALUES (279, 'Computer', 1000.50);
INSERT INTO products (product_id, product_name, product_price) VALUES (389, 'Speaker', 700.60);


INSERT INTO sell (seller_ID, customer_ID, product_ID, date) VALUES (69, 189, 369, '2021-11-01');
INSERT INTO sell (seller_ID, customer_ID, product_ID, date) VALUES (89, 169, 389, '2020-10-21');
INSERT INTO sell (seller_ID, customer_ID, product_ID, date) VALUES (79, 169, 379, '2020-11-02');
INSERT INTO sell (seller_ID, customer_ID, product_ID, date) VALUES (79, 189, 369, '2021-01-12');
INSERT INTO sell (seller_ID, customer_ID, product_ID, date) VALUES (89, 179, 389, '2020-03-30');
INSERT INTO sell (seller_ID, customer_ID, product_ID, date) VALUES (89, 189, 369, '2020-01-30');


INSERT INTO shop_orders (order_ID, customer_ID, customer_name, date, product_ID) VALUES (01, 189, 'Shmara' ,'2021-11-01', 301);
INSERT INTO shop_orders (order_ID, customer_ID, customer_name, date, product_ID) VALUES (02, 169, 'Farabi' ,'2020-10-21', 303);
INSERT INTO shop_orders (order_ID, customer_ID, customer_name, date, product_ID) VALUES (03, 169, 'Farabi' ,'2020-11-02', 302);
INSERT INTO shop_orders (order_ID, customer_ID, customer_name, date, product_ID) VALUES (04, 189, 'Shmara' ,'2021-01-12', 301);
INSERT INTO shop_orders (order_ID, customer_ID, customer_name, date, product_ID) VALUES (05, 179, 'Asel' ,'2020-03-30', 303);
INSERT INTO shop_orders (order_ID, customer_ID, customer_name, date, product_ID) VALUES (06, 189, 'Shmara' ,'2020-01-30', 301);


INSERT INTO delivery (delivery_id, date, customer_ID, order_ID) VALUES (469, '2021-11-03', 189, 01);
INSERT INTO delivery (delivery_id, date, customer_ID, order_ID) VALUES (479, '2020-10-28', 169, 02);
INSERT INTO delivery (delivery_id, date, customer_ID, order_ID) VALUES (489, '2020-11-30', 169, 03);
INSERT INTO delivery (delivery_id, date, customer_ID, order_ID) VALUES (499, '2021-01-15', 189, 04);
INSERT INTO delivery (delivery_id, date, customer_ID, order_ID) VALUES (459, '2020-04-05', 179, 05);
INSERT INTO delivery (delivery_id, date, customer_ID, order_ID) VALUES (449, '2020-02-03', 189, 06);


select count(shop_orders.customer_ID), sum(products.product_price), shop_orders.customer_name
from shop_orders join products on shop_orders.product_ID = products.product_id and EXTRACT(year FROM shop_orders.date) = EXTRACT(year FROM now())-1
group by shop_orders.customer_ID, shop_orders.customer_name
order by shop_orders.customer_ID asc limit 1;

--
select count(sell.product_ID), products.product_name
from sell join products on products.product_id = sell.product_ID and EXTRACT(year FROM sell.date) = EXTRACT(year FROM now())-1
group by sell.product_ID, products.product_name
order by count(sell.product_ID) desc limit 2;

--
select count(sell.product_ID), products.product_name, sum(products.product_price)
from sell join products on products.product_id = sell.product_ID and EXTRACT(year FROM sell.date) = EXTRACT(year FROM now())-1
group by sell.product_ID, products.product_name
order by sum(products.product_price) desc limit 2;

--
select delivery.delivery_id, shop_orders.order_ID, shop_orders.customer_name
from delivery join shop_orders on delivery.order_ID = shop_orders.order_ID and shop_orders.date<delivery.date
group by delivery.delivery_id, shop_orders.order_ID, shop_orders.customer_name;

--
select count(shop_orders.customer_ID), sum(products.product_price), shop_orders.customer_name
from shop_orders join products on shop_orders.product_ID=products.product_id and EXTRACT (month FROM shop_orders.date) = EXTRACT(month FROM now())-1
group by shop_orders.customer_ID, shop_orders.customer_name
order by shop_orders.customer_ID;

