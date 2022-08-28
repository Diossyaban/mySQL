
create table sales.suppliers(
supr_id int identity(1,2) constraint supr_id_pk primary key,
supr_name nvarchar (40),
supr_contact_name nvarchar(30),
supr_city nvarchar(15)
constraint supr_location_id foreign key (supr_id) references hr.locations(location_id));

create table sales.product (
prod_id int identity (1,1) constraint prod_id_pk primary key,
prod_name nvarchar (40),
prod_quantity nvarchar (40),
prod_price money,
prod_in_stock smallint,
prod_on_order smallint,
prod_reorder_level smallint,
prod_discountinued bit,
prod_cate_id int,
prod_supr_id int,
constraint prod_cate_id_fk foreign key(prod_cate_id) references sales.categories(cate_id),
constraint prod_supr_id_fk foreign key(prod_supr_id) references sales.suppliers(supr_id));



create table sales.categories(
cate_id int identity(1,1),
cate_name varchar (15),
cate_description ntext
constraint cate_id_pk primary key(cate_id));

create table sales.costumers(
cust_id int identity(1,1) constraint cust_id_pk primary key,
cust_name nvarchar (40),
cust_city nvarchar (15),
cust_location_id int,
constraint cust_location_id_fk foreign key (cust_location_id) references hr.locations(location_id));

create table sales.orders(
order_id int identity constraint order_id_pk primary key,
order_date datetime,
order_required_date datetime,
order_freight money,
order_subtotal money,
order_total_qty smallint,
order_ship_city nvarchar(15),
order_ship_address nvarchar(60),
order_status nvarchar (15),
order_employee_id int,
order_cust_id int,
order_ship_id int,
constraint order_employee_id_fk foreign key(order_employee_id) references hr.employees(employee_id),
constraint order_cust_id_fk foreign key(order_cust_id) references sales.costumers(cust_id),
constraint order_ship_id_fk foreign key(order_ship_id) references sales.shippers(ship_id));

create table sales.shippers(
ship_id int identity constraint ship_id_pk primary key,
ship_name nvarchar(40),
ship_phone nvarchar(24));

create table sales.order_detail(
ordet_order_id int,
ordet_prod_id int,
constraint ordet_order_id_ordet_prod_id_pk primary key (ordet_order_id,ordet_prod_id),
ordet_price money,
ordet_quantity money,
ordet_discount real,
constraint ordet_order_id_fk foreign key(ordet_order_id) references sales.orders(order_id),
constraint ordet_prod_id_fk foreign key(ordet_prod_id) references sales.product(prod_id));
