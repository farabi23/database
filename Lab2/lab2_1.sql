

create table customers(
id integer PRIMARY KEY,
full_name varchar(50) not null ,
timestamp text not null ,
delivery_address text not null

);


create table orders(
    code integer primary key,
    customer_id integer references customers (id),
    total_sum double precision not null ,
    is_paid boolean not null
);

create table order_items(
  order_code integer primary key references orders (code),
  product_id varchar UNIQUE not null references products (id),
  quantity integer not null check ( quantity > 0 )
);

create table products (
   id varchar primary key,
   name varchar UNIQUE not null,
   description text,
   price double precision not null check (price > 0)
);

