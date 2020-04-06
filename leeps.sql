drop database leeps_store;
create database leeps_store;
use leeps_store;

create table category(
	cate_id integer(11) auto_increment not null,
    cate_name varchar(40) not null,
    primary key (cate_id)
);

create table subcategory(
	sub_cate_id	integer(11) not null auto_increment ,
    name varchar(40)	not null,
    cate_id_fk int(11) not null,
    primary key (sub_cate_id),
    foreign key (cate_id_fk) references category(cate_id)
    
);

create table product(
	product_id integer(11) not null auto_increment,
    product_name varchar(50) not null,
    brand varchar(30) not null,
    sub_cate_id_fk int(11) not null,
    primary key (product_id),
    foreign key(sub_cate_id_fk) references subcategory(sub_cate_id)
);

create table product_description(
	descrip_id	integer(11) not null auto_increment,
    product_id_fk integer(11) not null,
    sub_cate_id_fk integer(11) not null,
    SKU	varchar(19) not null,
    color	varchar(15) not null,
    weight  decimal(5,2) not null,
    main_material varchar(30) ,
    model varchar(30),
    size varchar(15) ,
    production_country	varchar(20) not null,
    production_line varchar(30) not null,
    image_urls varchar(400) not null,
    foreign key (product_id_fk) references product(product_id),
   
    primary key(descrip_id)
);

create table customer(
	customer_id	integer(11) auto_increment not null,
    fname	text(20) not null ,
    lname	text(20) not null,
    gender	text(10)	not null,
    email	varchar(30)	not null,
    phone	varchar(12)	not null,
    cus_password varchar(20)  not null,
    user_name	varchar(20) not null,
    primary key(customer_id)
);





create table order_item(
	order_item_id integer(11) not null auto_increment,
    product_id_fk integer(11) not null,
    amount_id_fk integer(11) not null,
    sub_total decimal(7,2) not null,
    quantity integer(6) not null,
    order_date timestamp default current_timestamp,
    primary key(order_item_id),
    foreign key (product_id_fk) references product(product_id),
    foreign key (amount_id_fk) references amount(amount_id)
);

create table checkout(
	checkout_id integer(10) not null auto_increment,
    customer_id_fk integer(11) not null,
    order_item_id_fk integer(11) not null,
    total decimal(10,2) not null,
    address varchar(60) not null,
    delivery_id_fk integer(2) not null,
    primary key (checkout_id),
    foreign key (customer_id_fk) references customer(customer_id),
    foreign key (order_item_id_fk) references order_item(order_item_id),
    foreign key (delivery_id_fk) references delivery_method(delivery_id)
    
    );
    
create table delivery_method( -- Home delivery or pick location
	delivery_id integer(11) not null auto_increment,
    delivery_type varchar(15) not null,
    price decimal (9,2) not null,
    primary key(delivery_id)
);
create table  amount(	-- to avoid repeation of data in the product's, order's table
	amount_id integer(11) not null auto_increment,
    product_id_fk integer(11) not null,
    unit_price decimal(6,2) not null,
    discount decimal(5,2),
    primary key (amount_id),
    foreign key (product_id_fk) references product(product_id)
);

create table shippment(
	shippment_id integer(11) auto_increment not null,
    company_id_fk integer(5) not null,
     checkout_id_fk integer(10) not null,
     shipped_date timestamp default current_timestamp not null,
     shippment_status varchar(15) not null,
     is_delivered boolean default false,
     primary key(shippment_id),
     foreign key (company_id_fk) references shippers(company_id),
     foreign key (checkout_id_fk) references checkout(checkout_id)
);

create table transactions(
	trans_id integer(11) auto_increment not null,
       shippment_id_fk integer(11) not null,
       payment_status varchar(10) not null, 
       transaction_status  varchar(15) not null,
    primary key(trans_id),
    foreign key (shippment_id_fk) references shippment(shippment_id)
);
create table shippers (
	company_id integer(4) auto_increment not null,
    company_name varchar(20) not null,
    primary key(company_id)
);