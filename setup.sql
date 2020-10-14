drop database if exists resturantdb;
create database resturantdb;

use resturantdb;

-- Creation process
create table person_first_name(
    identity int not null auto_increment,
    content varchar(256),
    primary key (identity)
);

create table person_middle_name(
    identity int not null auto_increment,
    content varchar(256),
    primary key (identity)
);

create table person_last_name(
    identity int not null auto_increment,
    content varchar(256),
    primary key (identity)
);

create table person_email(
    identity int not null auto_increment,
    content varchar(256),
    primary key (identity)
);

create table address_road_name(
    identity int not null auto_increment,
    content varchar(256),
    primary key (identity)
);

create table address_post_number(
    identity int not null auto_increment,
    content varchar(256),
    primary key (identity)
);

create table address_city(
    identity int not null auto_increment,
    content varchar(256),
    primary key (identity)
);

create table Customer_name(
    identity int not null auto_increment,
    customer_first_name_id int not null,
    customer_middle_name_id int not null,
    customer_last_name_id int not null,
    primary key (identity)
);

create table customer_address(
    identity int not null auto_increment,
    road_name_id int not null,
    post_number_id int not null,
    city_id int not null,
    house_number int not null,
    primary key (identity)
);

create table customer(
    identity int not null auto_increment,
    username varchar(256) not null,
    password varchar(1024) not null,
    primary_email_id int default null,
    primary key (identity)
);

create table customer_associated_email(
    identity int not null auto_increment,
    customer_id int not null,
    email_id int not null,
    primary key (identity)
);

create table customer_Information(
    identity int not null auto_increment,
    phone_number varchar(256),
    customer_name_id int not null,
    address_id int not null,
    customer_id int not null,
    primary key (identity)
);

create table resturant_table(
    identity int not null auto_increment,
    number_of_seats int not null default 0,
    table_identifier text not null ,
    primary key (identity)
);

create table available_space(
    identity int not null auto_increment,
    resturant_table_id int not null,
    reserved_begin datetime default now(),
    reserved_end datetime default now(),
    pris double not null default 0.0,
    primary key (identity)
);

create table booked_space(
    identity int not null auto_increment,
    resturant_table_id int not null,
    available_space_id int not null,
    reserved_begin datetime default now(),
    reserved_end datetime default now(),
    pris double not null default 0.0,
    customer_id int not null,
    primary key (identity)
);

create table invoices(
    identity int not null auto_increment,
    total_pris double precision,
    customer_address_id int,
    customer_name_id int,
    customer_id int,
    primary key (identity)
);

create table invoice_associated_with_booking(
    identity int not null auto_increment,
    invoice_id int not null,
    booked_space_id int not null,
    primary key (identity)
);

-- Connect
-- Customer name setup ----------------------------------------------------------------------------------------------------------
alter table customer_name
	add constraint customer_name_person_first_name_identity_fk
		foreign key (customer_first_name_id) references person_first_name (identity);

alter table customer_name
	add constraint customer_name_person_last_name_identity_fk
		foreign key (customer_last_name_id) references person_last_name (identity);

alter table customer_name
	add constraint customer_name_person_middle_name_identity_fk
		foreign key (customer_middle_name_id) references person_middle_name (identity);

## Customer Address Setup ----------------------------------------------------------------------------------------------------------
alter table customer_address
	add constraint customer_address_address_city_identity_fk
		foreign key (city_id) references address_city (identity);

alter table customer_address
	add constraint customer_address_address_post_number_identity_fk
		foreign key (post_number_id) references address_post_number (identity);

alter table customer_address
	add constraint customer_address_address_road_name_identity_fk
		foreign key (road_name_id) references address_road_name (identity);

alter table customer_information
	add constraint customer_information_customer_name_identity_fk
		foreign key (customer_name_id) references customer_name (identity);

alter table customer_information
	add constraint customer_information_customer_address_identity_fk
		foreign key (address_id) references customer_address (identity);

alter table customer_information
	add constraint customer_information_customer_identity_fk
		foreign key (customer_id) references customer (identity);

alter table invoices
	add constraint invoices_customer_address_identity_fk
		foreign key (customer_address_id) references customer_address (identity);

alter table invoices
	add constraint invoices_customer_identity_fk
		foreign key (customer_id) references customer (identity);

alter table invoices
	add constraint invoices_customer_name_identity_fk
		foreign key (customer_name_id) references customer_name (identity);

alter table invoice_associated_with_booking
	add constraint invoice_associated_with_booking_booked_space_identity_fk
		foreign key (booked_space_id) references booked_space (identity);

alter table invoice_associated_with_booking
	add constraint invoice_associated_with_booking_invoices_identity_fk
		foreign key (invoice_id) references invoices (identity);

alter table customer_associated_email
	add constraint customer_associated_email_customer_identity_fk
		foreign key (customer_id) references customer (identity);

alter table customer_associated_email
	add constraint customer_associated_email_person_email_identity_fk
		foreign key (email_id) references person_email (identity);

alter table customer
	add constraint customer_customer_associated_email_identity_fk
		foreign key (primary_email_id) references customer_associated_email (identity);

alter table booked_space
	add constraint booked_space_available_space_identity_fk
		foreign key (available_space_id) references available_space (identity);

alter table booked_space
	add constraint booked_space_customer_identity_fk
		foreign key (customer_id) references customer (identity);

alter table booked_space
	add constraint booked_space_resturant_table_identity_fk
		foreign key (resturant_table_id) references resturant_table (identity);

alter table available_space
	add constraint available_space_resturant_table_identity_fk
		foreign key (resturant_table_id) references resturant_table (identity);


-- Index data
create unique index address_city_index
on address_city(content);

create unique index address_post_number_index
on address_post_number(content);

create unique index address_road_name_index
on address_road_name(content);

create unique index person_first_name_index
on person_first_name(content);

create unique index person_last_name_index
on person_last_name(content);

create unique index person_middle_name_index
on person_middle_name(content);

create unique index person_email_index
on person_email(content);

-- Insert data
insert into person_first_name(content) values ('unknown'), ('kent'), ('karsten'), ('katrine'), ('erik'), ('henrik'), ('jørgen');

insert into person_last_name(content) values ('unknown'), ('madsen'), ('vejrup');
insert into person_middle_name(content) values ('unknown'), ('madsen'), ('vejrup');

insert into address_city (content)
values ('unknown'), ('skive'), ('esbjerg'), ('hjerting'), ('odense'), ('århus'), ('');

insert into address_post_number (content)
values ('unknown'), ('6705'), ('6700'), ('6710');

insert into address_road_name (content)
values ('unknown'), ('kirkebakken'), ('adams vej');

insert into resturant_table(number_of_seats, table_identifier) values (2, 'a'), (2, 'b'), (2, 'c'), (2, 'd');
insert into resturant_table(number_of_seats, table_identifier) values (4, 'e'), (8, 'f'), (2, 'g'), (2, 'h');

insert into customer (username, password)
values ('madsen', 'test password'), ('lorem', 'test password'), ('peter', 'test password');

insert into person_email(content) values ('unknown'), ('kent.vejrup.madsen@outlook.com'), ('adam@test.23.dk');

INSERT available_space(resturant_table_id, reserved_begin, reserved_end, pris)
select resturant_table.identity, '2020-10-11 08:00:00', '2020-10-11 10:00:00', 200
from resturant_table;

INSERT available_space(resturant_table_id, reserved_begin, reserved_end, pris)
select resturant_table.identity, '2020-10-11 10:00:00', '2020-10-11 12:00:00', 200
from resturant_table;

INSERT available_space(resturant_table_id, reserved_begin, reserved_end, pris)
select resturant_table.identity, '2020-10-11 12:00:00', '2020-10-11 14:00:00', 200
from resturant_table;

INSERT available_space(resturant_table_id, reserved_begin, reserved_end, pris)
select resturant_table.identity, '2020-10-11 14:00:00', '2020-10-11 16:00:00', 200
from resturant_table;

INSERT available_space(resturant_table_id, reserved_begin, reserved_end, pris)
select resturant_table.identity, '2020-10-11 16:00:00', '2020-10-11 20:00:00', 200
from resturant_table;

insert into customer_name(customer_first_name_id, customer_middle_name_id, customer_last_name_id)
values (2, 3, 2);



-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
create view overview_of_tables as
select available_space.identity,
       rt.table_identifier,
       rt.number_of_seats,
       available_space.pris,
       available_space.reserved_begin,
       available_space.reserved_end
from available_space
left join resturant_table rt on available_space.resturant_table_id = rt.identity;

create view person_name_view as
select Customer_name.identity, pfn.content as firstname, pmn.content as middlename, pln.content as lastname
from customer_name
left join person_first_name pfn on Customer_name.customer_first_name_id = pfn.identity
left join person_last_name pln on Customer_name.customer_last_name_id = pln.identity
left join person_middle_name pmn on Customer_name.customer_middle_name_id = pmn.identity;