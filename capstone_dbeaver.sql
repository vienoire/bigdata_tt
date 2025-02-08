
create table iceberg.hayatbilici.warehouse();
create table iceberg.hayatbilici.district();
create table iceberg.hayatbilici.customer();    
create table iceberg.hayatbilici.person_info();
create table iceberg.hayatbilici.address();
create table iceberg.hayatbilici.stock();
create table iceberg.hayatbilici.orders();
create table iceberg.hayatbilici.order_line();
create table iceberg.hayatbilici.item();


-- drop table iceberg.hayatbilici.customer ;

select * from iceberg.hayatbilici.warehouse ;

-- ASIL CUSTOMER BURASI
CREATE TABLE iceberg.hayatbilici.customer (
	c_id int,
	c_d_id int,
	c_w_id int,
	c_first string,
	c_middle string,
	c_last string,
	c_street_1 string,
	c_street_2 string,
	c_city string,
	c_state string,
	c_zip string,
	c_phone string,
	c_since timestamp,
	c_credit string,
	c_credit_lim decimal,
	c_discount decimal,
	c_balance decimal,
	c_ytd_payment decimal,
	c_payment_cnt int,
	c_delivery_cnt int,
	c_data string);

create table iceberg.hayatbilici.person_info(
     c_id int,
     phone string,
	 since timestamp,
	 credit string,
	 credit_lim decimal,
	 discount decimal,
	 balance decimal,
	 payment_cnt int,
	 delivery_cnt int
      );

create table iceberg.hayatbilici.address(
     address_id int,
     c_id int,
     c_state string,
     c_city string,
     c_street_1 string,
	 c_street_2 string,
	 c_zip string
);

-- enriched one:
CREATE TABLE iceberg.hayatbilici.customer (
	c_id int,
	c_d_id int,
	c_w_id int,
	c_first string,
	c_middle string,
	c_last string,
	c_street_1 string,
	c_street_2 string,
	c_city string,
	c_state string,
	c_zip string,
	c_phone string,
	c_since timestamp,
	c_credit string,
	c_credit_lim decimal,
	c_discount decimal,
	c_balance decimal,
	c_ytd_payment decimal,
	c_payment_cnt int,
	c_delivery_cnt int,
	d_city string,
	d_state string);

CREATE TABLE iceberg.hayatbilici.district (
	d_id int,
	d_w_id int,
	d_name string,
	d_street_1 string,
	d_street_2 string,
	d_city string,
	d_state string,
	d_zip string,
	d_tax decimal,
	d_ytd decimal,
	d_next_o_id int);

select * from iceberg.hayatbilici.customer ;


-- drop table iceberg.hayatbilici.film ;
-- drop table iceberg.hayatbilici.film_actor ;
-- drop table iceberg.hayatbilici.film_actor_mix ;

CREATE TABLE iceberg.hayatbilici.warehouse (
	w_id int,
	w_name string,
	w_street_1 string,
	w_street_2 string,
	w_city string,
	w_state string,
	w_zip string,
	w_tax decimal,
	w_ytd decimal);

CREATE TABLE iceberg.hayatbilici.stock (
	s_i_id int,
	s_w_id int,
	s_quantity int,
	s_dist_01 string,
	s_dist_02 string,
	s_dist_03 string,
	s_dist_04 string,
	s_dist_05 string,
	s_dist_06 string,  
	s_dist_07 string,
	s_dist_08 string,
	s_dist_09 string,
	s_dist_10 string,
	s_ytd decimal,
	s_order_cnt int,
	s_remote_cnt int,
	s_data string);


CREATE TABLE iceberg.hayatbilici.orders (
	o_id int,
	o_d_id int,
	o_w_id int,
	o_c_id int,
	o_entry_d timestamp,
	o_carrier_id int,
	o_ol_cnt int,
	o_all_local int);

CREATE TABLE iceberg.hayatbilici.order_line (
	ol_o_id int,
	ol_d_id int,
	ol_w_id int,
	ol_number int,
	ol_i_id int,
	ol_supply_w_id int,
	ol_delivery_d timestamp,
	ol_quantity int,
	ol_amount decimal,
	ol_dist_info string);

create table iceberg.hayatbilici.new_warehouse(
     w_id int,
     w_name string,
     w_address_id int,
     w_tax decimal,
     w_ytd decimal);

create table iceberg.hayatbilici.new_customer(
      c_id int, 
      c_fullname string ,
      c_address_id int,
      c_d_id int);

create table iceberg.hayatbilici.new_district(d_id int, d_name string, d_w_id int, d_address_id int, d_tax decimal, d_ytd decimal, d_next_o_id int);

CREATE TABLE iceberg.hayatbilici.item (
	i_id int,
	i_im_id int,
	i_name string,
	i_price decimal,
	i_data string);

SELECT * from iceberg.hayatbilici.customer ;
SELECT * from iceberg.hayatbilici.district ;
SELECT * from iceberg.hayatbilici.warehouse ;

select (10000000 + w_id) as address_id, 0 as c_id, w_state as state, w_city as city , w_street_1 as street_1, w_street_2 as street_2, w_zip as zip_code
from iceberg.hayatbilici.warehouse w 
UNION
select (20000000 + (10000 * d_w_id) + d_id) as address_id, 0 as c_id, d_state as state, d_city as city , d_street_1 as street_1, d_street_2 as street_2, d_zip as zip_code
from iceberg.hayatbilici.district d 
UNION
select (40000000 + (10000 * c_w_id) + (1000*c_d_id) + c_id) as address_id, c_id, c_state as state, c_city as city , c_street_1 as street_1, c_street_2 as street_2, c_zip as zip_code
from iceberg.hayatbilici.customer c  ;


if a_id > 40000000 : reach c_id
for d_id: ( a_id -(40000000+ c_id) ) % w_id /1000 


select c_id, c_phone, c_since, c_credit, c_credit_lim, c_discount, c_balance, c_payment_cnt, c_delivery_cnt from iceberg.hayatbilici.customer;

select distinct w_id, w_name, (10000000 + w_id) as w_address_id, w_tax, w_ytd 
from iceberg.hayatbilici.warehouse ;

select distinct c_id, c_first || ' ' || c_last as c_fullname, (40000000 + (10000 * c_w_id) + (1000*c_d_id) + c_id) c_address_id, c_d_id 
from iceberg.hayatbilici.customer ;

select distinct d_id, d_name, d_w_id , (20000000 + (10000 * d_w_id) + d_id) as d_address_id, d_tax , d_ytd, d_next_o_id 
from iceberg.hayatbilici.district;



CREATE TABLE iceberg.hayatbilici.online_orders (
	o_id int,
	o_d_id int,
	o_w_id int,
	o_c_id int,
	o_entry_d timestamp,
	effective_date timestamp,
	expiry_date timestamp,
	etl_date_create timestamp,
	etl_date_update timestamp,
	etl_id_c int,
	etl_id_u int,
	is_deleted_in_source int,
	is_current int);

create table iceberg.hayatbilici.online_customers(
     c_id int, c_fullname string, c_address_id int, c_d_id int,
     last_update timestamp,
	 effective_date timestamp,
   	 expiry_date timestamp,
	 etl_date_create timestamp,
	 etl_date_update timestamp,
	 etl_id_c int,
	 etl_id_u int,
	 is_deleted_in_source int,
	 is_current int);

CREATE TABLE iceberg.hayatbilici.online_item (
	i_id int,
	i_im_id int,
	i_name string,
	last_update timestamp,
	effective_date timestamp,
	expiry_date timestamp,
	etl_date_create timestamp,
	etl_date_update timestamp,
	etl_id_c int,
	etl_id_u int,
	is_deleted_in_source int,
	is_current int);

