create database pizza_restaurant;

create table pizza_restaurant.`customers` (
customer_id int not null,
customer_name varchar (200),
phone_number varchar (20),
primary key customer_id (customer_id)
);

create table pizza_restaurant.`orders` (
order_numb int not null,
order_date DATETIME,
primary key order_numb (order_numb)
);

create table pizza_restaurant.`pizzas` (
pizza_numb int not null,
pizza_name varchar (50),
pizza_price decimal (10,2),
primary key (pizza_numb)
);

create table pizza_restaurant.`customer_order` (
customer_id int not null,
order_numb int not null,
foreign key (customer_id) references customers (customer_id),
foreign key (order_numb) references orders (order_numb)
);

    
create table pizza_restaurant.`pizza_ordered` (
order_numb int not null,
pizza_numb int not null,
quantity int,
foreign key (order_numb) references orders (order_numb),
foreign key (pizza_numb) references pizzas (pizza_numb)
);

insert into pizza_restaurant.customers (customer_id, customer_name, phone_number)
values (1, 'Trevor Page', '226-555-4982');

insert into pizza_restaurant.customers (customer_id, customer_name, phone_number)
values (2, 'John Doe', '555-555-9498');

INSERT INTO `pizza_restaurant`.`orders` (`order_numb`, `order_date`)
VALUES (1, '2014-10-09 09:47:00'); 

INSERT INTO `pizza_restaurant`.`orders` (`order_numb`, `order_date`)
VALUES (2, '2014-10-09 13:20:00');

INSERT INTO `pizza_restaurant`.`orders` (`order_numb`, `order_date`)
VALUES (3, '2014-10-09 9:47:00');

INSERT INTO `pizza_restaurant`.`pizzas`(`pizza_numb`, `pizza_name`, `pizza_price`)
VALUES (1, 'Pepperoni & Cheese', 7.99);

INSERT INTO `pizza_restaurant`.`pizzas`(`pizza_numb`, `pizza_name`, `pizza_price`)
VALUES (2, 'Vegetarian', 9.99);

INSERT INTO `pizza_restaurant`.`pizzas`(`pizza_numb`, `pizza_name`, `pizza_price`)
VALUES (3, 'Meat Lovers', 14.99);

INSERT INTO `pizza_restaurant`.`pizzas`(`pizza_numb`, `pizza_name`, `pizza_price`)
VALUES (4, 'Hawaiian', 12.99);

INSERT INTO `pizza_restaurant`.`customer_order` (`customer_id`, `order_numb`)
VALUES (1, 1);

INSERT INTO `pizza_restaurant`.`customer_order` (`customer_id`, `order_numb`)
VALUES (2, 2);

INSERT INTO `pizza_restaurant`.`customer_order` (`customer_id`, `order_numb`)
VALUES (1, 3);

INSERT INTO `pizza_restaurant`.`pizza_ordered` (`order_numb`, `pizza_numb`, `quantity`)
VALUES (1, 1, 1);

INSERT INTO `pizza_restaurant`.`pizza_ordered` (`order_numb`, `pizza_numb`, `quantity`)
VALUES (1, 3, 1);

INSERT INTO `pizza_restaurant`.`pizza_ordered` (`order_numb`, `pizza_numb`, `quantity`)
VALUES (2, 2, 1);

INSERT INTO `pizza_restaurant`.`pizza_ordered` (`order_numb`, `pizza_numb`, `quantity`)
VALUES (2, 3, 2);

INSERT INTO `pizza_restaurant`.`pizza_ordered` (`order_numb`, `pizza_numb`, `quantity`)
VALUES (3, 3, 1);

INSERT INTO `pizza_restaurant`.`pizza_ordered` (`order_numb`, `pizza_numb`, `quantity`)
VALUES (3, 4, 1);

SELECT * FROM `pizza_restaurant`.`customers`;

SELECT * FROM `pizza_restaurant`.`orders`;

SELECT * FROM `pizza_restaurant`.`pizzas`;

SELECT * FROM `pizza_restaurant`.`customer_order`;

SELECT * FROM `pizza_restaurant`.`pizza_ordered`;

-- Q4
select cus.customer_id, customer_name, sum(
case 
	when quantity > 0 then quantity * pizza_price
    end) as total_order_price from pizza_restaurant.customers cus
join customer_order co on co.customer_id = cus.customer_id
join orders ord on ord.order_numb = co.order_numb
join pizza_ordered po on po.order_numb = ord.order_numb
join pizzas on pizzas.pizza_numb = po.pizza_numb
group by cus.customer_id;

-- Q5
select cus.customer_id, cus.customer_name, convert(ord.order_date, date) as order_date, sum(
case 
	when quantity > 0 then quantity * pizza_price
    end) as total_price 
    from pizza_restaurant.customers cus
join customer_order co on co.customer_id = cus.customer_id
join orders ord on ord.order_numb = co.order_numb
join pizza_ordered po on po.order_numb = ord.order_numb
join pizzas on pizzas.pizza_numb = po.pizza_numb
group by cus.customer_id, order_date_without_time
order by cus.customer_id;