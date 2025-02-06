-- https://dbdiagram.io/d/capstone_ERD-67a53e87263d6cf9a050d24b
-- üstteki linkte şemanın görünüyor olması gerek
-- görünmezse dbdiagram.io sistesine aşağıdaki kodu yazarak oluşturdum

Table warehouse{
  warehouse_id integer [primary key]
  warehouse_name varchar
  w_address_id integer [note: "address tablosu üzerinden ayırt edebilmek adına 0-1xxxxx.. şeklinde numaralandırılabilir"]
  w_tax_rate decimal
  w_ytd_balance decimal
}

Table district{
  district_id integer [primary key]
  district_name varchar
  w_id integer
  d_address_id integer [note: "2-3-4xxxxxxx"]
  next_available_id integer
  d_tax_rate decimal
  d_ytd_balance decimal
}

Table customer{
  customer_id integer [primary key, 
  note: "çalışanlarla karışmaması adına 0-6xxxxxx şeklinde verilebilir"]
  customer_name varchar
  c_adress_id integer [note:"5-9xxxxx"]
  d_id integer
  order_id_if_exists integer
}

Table person_info{
  person_id integer
  full_name varchar
  email varchar
  phone varchar
  here_since timestamp [note: "çalışanlar için çalışma, müşteriler için kayıtlı olma süresi"]
  status varchar [note:"AA-BA-BB şeklinde ilerleyen, çalışma/ödeme durumlarına göre müşteriye indirim, çalışana bonus olarak dönebilen notlama sistemi"]
  bonus_rate decimal [note:"status belli seviyelere ulaştıkça indirim/bonus olarak döner"]
}

Table address{
  address_id integer [primary key]
  country varchar
  city varchar
  street1 text
  street2 text
  zipcode integer
}

Table orders{
  order_id integer [primary key]
  order_line_id integer
  i_id integer
  c_id integer
  order_date timestamp
  order_price decimal
  item_quantity integer
  discount_rate decimal
}

Table order_line{
  orderline_id integer [primary key]
  i_id integer
  item_quantity integer
  delivery_date timestamp
  carrier_id integer
  delivery_info text
}

Table item{
  item_id integer [primary key]
  category varchar
  price decimal
  name varchar
  add_data text 
}

Table stock{
  i_id integer
  s_quantity integer
  ytd_sales decimal
  total_orders integer
  next_available timestamp
}


Ref: warehouse.w_address_id - address.address_id
Ref: district.d_address_id - address.address_id
Ref: customer.c_adress_id > address.address_id
Ref: customer.d_id > district.district_id
Ref: district.w_id - warehouse.warehouse_id
Ref: customer.customer_id - person_info.person_id
Ref: order_line.carrier_id - person_info.person_id
Ref: orders.i_id - item.item_id
Ref: stock.i_id < item.item_id
Ref: orders.order_line_id < order_line.orderline_id
Ref: orders.c_id > customer.customer_id
Ref: district.next_available_id - orders.order_id
Ref: customer.order_id_if_exists < orders.order_id
Ref: person_info.bonus_rate <> orders.discount_rate

