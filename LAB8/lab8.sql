1)
A) create function incr(a int) returns integer as
    $$
    begin
        return a+1;
    end;
    $$
    language  plpgsql
select * from incr(1);
B) create function sum_two(a int,b int) returns integer as
    $$
    begin
        return a+b;
    end;
    $$
    language  plpgsql
select * from sum_two(1,2);
C) create function even_numb(a int) returns boolean as
    $$
    declare
        truth boolean;
    begin
        if a%2=0 then truth=true;
        else truth=false;
        end if;
        return truth;
    end;
    $$
    language  plpgsql
select * from even_numb(3);
D) create function pasw_valid(a text) returns boolean as
    $$
    declare
        truth boolean;
    begin
        if length(a)>=6 then truth =true;
        else truth=false;
        end if;
        return truth;
    end;
    $$
    language  plpgsql
select * from pasw_valid('chelo');
E) create function two_out(a integer,out a_plus integer,out a_minus integer) as
    $$
    begin
        a_plus=a+1;
        a_minus=a-1;
    end;
    $$
    language  plpgsql
select * from two_out(1);


2)
create table customers (
    id integer primary key,
    name varchar(255),
    name_changed date default now(),
    birth_date date,
    age integer
);
A) create or replace function log_name_changes()
    returns trigger
    language plpgsql
    as $$
    begin
        if (new.name!=old.name) then new.name_changed=current_date;
        end if;
       return new;
    end;
    $$
create trigger changes
    before update
    on customers
    for each row
    execute procedure log_name_changes();
insert into customers(id,name) values(1,'elnur');
update customers
set name='elnur1'
where name='elnur'
select name_changed from customers;
B) create or replace function age_inserts() returns trigger language plpgsql
    as $$
    begin
        update customers
        set age=round((current_date-new.birth_date) / 365.25)
        where id=new.id;
        return new;
    end;
    $$
create trigger changes
    after insert
    on customers
    for each row
    execute procedure age_inserts();
insert into customers(id, name, birth_date) values (12,'someone','03-08-2004');
select * from customers

C) create table products(
    id serial,
    name varchar(255),
    price integer
);
create or replace function price_tax() returns trigger language plpgsql
    as $$
    begin
        update products
        set price=price+0.12*price
        where id=new.id;
        return new;
    end;
    $$
create trigger changes
    after insert
    on products
    for each row
    execute procedure price_tax();
insert into products(name,price) values('milk',100);
select * from products;
D) create or replace function stop_del() returns trigger language plpgsql
    as $$
    begin
        insert into products(id,name,price) values(old.id,old.name,old.price);
        return old;
    end;
    $$
create trigger del_changes
    after delete
    on products
    for each row
    execute procedure stop_del();
delete from products where id=2;
select * from products;
E) create table passwords(
    name varchar(20),
    password text,
    validity boolean
   );
create or replace function two_launches() returns trigger language plpgsql
    as $$
    begin
        if pasw_valid(new.password)=true then
            update passwords
            set validity=true
            where name=new.name;
        else
            update passwords
            set password='RandomValidPas',validity=false
            where name=new.name;
        end if;
        return new;
    end;
    $$
create trigger two_changes
    after insert
    on passwords
    for each row
    execute procedure two_launches();
insert into passwords(name,password) values ('elnur3','some');
select * from passwords;


4)
create table employee(
    id serial primary key,
    name varchar,
    date_of_birth date,
    age integer,
    salary integer,
    workexperience integer,
    discount integer
);
A)
create or replace procedure sal_upd()
language plpgsql as $$
    declare
    begin
        update employee
        set salary=salary+salary*0.1*(workexperience/2),discount=discount+0.1*(workexperience/2),discount=discount+0.01*(workexperience/5);
        commit;
    end;
$$
B)
create or replace procedure sal_upd2()
language plpgsql as $$
    declare
    begin
        update employee
        set salary=salary+0.15*salary
        where age>=40;
        update employee
        set salary=salary+0.15*salary*(workexperience/8);
        update employee
        set discount=20
        where workexperience>=8;
        commit;
    end;
$$






