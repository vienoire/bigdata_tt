select * from pg_tables where schemaname='public';
select * from rental;
select * from customer;
select * from store;
select * from inventory;
select * from payment;
select * from inventory;
select * from staff;
select * from category;
select * from inventory;
select * from film_category;
select * from film;
select * from country;
select * from city;
select * from address;
-- ROLLUP:
-- 1 müşteri vs kiralanan film 

-- concat kullanıp group by'a ename'i eklemeye çalıştığımda hata verdi
-- MIN/MAX kullandım ama bu sefer rollup'a isim ekliyor ilk veya sonu olacak şekilde
select r.customer_id, MIN(concat(c.first_name, ' ', c.last_name)) as ename, COUNT(*) as total_movie
from rental r
inner JOIN customer c on r.customer_id=c.customer_id 
group by rollup ( r.customer_id)
order by r.customer_id ;

-- 2  PAYMENT, STORE

select s.store_id, SUM(p.amount) as total_amount
from payment p
inner join customer c on c.customer_id=p.customer_id 
inner join store s on s.store_id=c.store_id
group by rollup (s.store_id);


-- 3 film_category, film, category
select fc.category_id, AVG(f.rental_duration)
from film f
inner join film_category fc on f.film_id=fc.film_id 
inner join category c on c.category_id=fc.category_id 
group by rollup (fc.category_id)
order by fc.category_id ; 


-- 4 city, address, customer, rental, payment
select a.city_id , SUM(p.amount) as total_payment
from payment p
inner join customer c on c.customer_id = p.customer_id 
inner join address a on a.address_id = c.address_id 
group by rollup(a.city_id)
order by a.city_id;



-- 5 actor, film_actor, film

select fa.actor_id , COUNT(*) as rental_amount
from rental r
inner join inventory i on i.inventory_id = r.inventory_id 
inner join film_actor fa on fa.film_id = i.film_id 
group by rollup(fa.actor_id)
order by fa.actor_id ;



-- 6 mağaza- kiralanan film sayısı

select s.store_id, COUNT(*) as rental_amount
from rental r
inner join staff s on s.staff_id = r.staff_id 
group by rollup (s.store_id)
order by s.store_id ;


-- 7 staff başı ödeme miktarı 

select s.staff_id , SUM(p.amount)
from payment p
inner join staff s on s.staff_id = p.staff_id
group by rollup (s.staff_id)
order by s.staff_id ;

-- 8 her kategori kir. film ve maliyet
select fc.category_id, COUNT(*) rental_amount, SUM(f.replacement_cost) rep_cost
from rental r
inner join inventory i on i.inventory_id = r.inventory_id 
inner join film_category fc on fc.film_id = i.film_id 
inner join film f on f.film_id = i.film_id 
group by rollup (fc.category_id)
order by fc.category_id ;



-- CUBE 

-- 1 film, fc, cat
select fc.category_id , i.film_id , COUNT(*) as rental_movie
from rental r
inner join inventory i on i.inventory_id = r.inventory_id 
inner join film_category fc on fc.film_id = i.film_id 
group by cube (fc.category_id , i.film_id);



-- 2

select i.film_id, a.city_id , sum(p.amount) tot_amount
from rental r
     inner join inventory i on i.inventory_id = r.inventory_id 
     inner join staff s on r.staff_id =s.staff_id 
     inner join address a on a.address_id =s.address_id 
     inner join payment p on p.rental_id =r.rental_id 
group by cube(i.film_id, a.city_id);


-- 3

select a.city_id, s.store_id, COUNT(*)  rental_amount
from rental r
join staff s on s.staff_id = r.staff_id 
join address a on a.address_id = s.address_id 
group by cube(a.city_id, s.store_id);


-- 4
select fa.actor_id , fc.category_id , SUM(p.amount) as total_amount
from rental r
inner join inventory i on i.inventory_id = r.inventory_id 
inner join film_category fc on fc.film_id=i.film_id 
inner join film_actor fa on fa.film_id = i.film_id 
inner join payment p on p.rental_id = r.rental_id 
group by cube (fa.actor_id , fc.category_id);

-- 5
select i.film_id, fc.category_id, AVG(f.rental_duration) avg_rent_dur
from rental r
join inventory i on i.inventory_id = r.inventory_id 
join film f on f.film_id = i.film_id 
join film_category fc on fc.film_id = i.film_id 
group by cube (i.film_id, fc.category_id);

-- 6 
select s.staff_id, a.city_id, SUM(p.amount) total_payment
from payment p
join staff s on s.staff_id = p.staff_id 
join address a on a.address_id = s.address_id 
group by cube (s.staff_id, a.city_id);

-- 7
select i.film_id, c.customer_id, COUNT(*) rental_amount
from rental r
join customer c on c.customer_id = r.customer_id 
join inventory i on i.inventory_id = r.inventory_id 
group by cube (i.film_id, c.customer_id);

-- 8
select s.staff_id, s.store_id, SUM(p.amount) total_payment
from rental r
join payment p on p.rental_id = r.rental_id 
join staff s on s.staff_id = r.staff_id 
group by cube (s.staff_id, s.store_id);


-- GROUPING SETS

-- 1 film- custo
select i.film_id, c.customer_id, COUNT(*) total_rent
from rental r
join inventory i on i.inventory_id = r.inventory_id 
join customer c on c.customer_id = r.customer_id 
group by grouping sets (
                        (i.film_id, c.customer_id),
                        (i.film_id),
                        (c.customer_id),
                        () )
order by c.customer_id, i.film_id ;

-- 2 
select fc.category_id, i.film_id, SUM(p.amount) total_amount
from rental r
join inventory i on i.inventory_id = r.inventory_id 
join film_category fc on fc.film_id =i.film_id 
join payment p on p.rental_id = r.rental_id 
group by grouping sets(
                        (fc.category_id, i.film_id),
                        (fc.category_id),
                        ( i.film_id),
                        ()    )
order by fc.category_id, i.film_id;

-- 3 
select c.customer_id, c.store_id, SUM(p.amount) total_payment
from rental r
join payment p on p.rental_id = r.rental_id 
join customer c on c.customer_id = r.customer_id 
group by grouping sets (
                          (c.customer_id, c.store_id),
                          (c.customer_id),
                          ( c.store_id),
                          ()  )
order by c.customer_id, c.store_id;

-- 4 actor city
select fa.actor_id, a.city_id, COUNT(*) rental_count
from rental r
join inventory i on i.inventory_id = r.inventory_id 
join film_actor fa on fa.film_id = i.film_id 
join customer c on c.customer_id = r.customer_id 
join address a on a.address_id = c.address_id 
group by grouping sets(
                        (fa.actor_id, a.city_id),
                        (fa.actor_id),
                        (a.city_id),
                        ()  )
order by fa.actor_id, a.city_id ;

-- 5 film şehir toplam gelir 
select i.film_id, a.city_id, SUM(p.amount) tot_payment
from rental r
join payment p on p.rental_id = r.rental_id
join inventory i on i.inventory_id = r.inventory_id 
join customer c on c.customer_id = r.customer_id 
join address a on a.address_id = c.address_id 
group by grouping sets (
                        (i.film_id, a.city_id),
                        (i.film_id),
                        (a.city_id),
                        ())
order by i.film_id, a.city_id;


-- 6 store cat ödeme
select c.store_id, fc.category_id, SUM(p.amount) tot_pay
from rental r
join inventory i on i.film_id = r.inventory_id 
join film_category fc on fc.film_id = i.film_id 
join customer c on c.customer_id = r.customer_id 
join payment p on p.rental_id = r.rental_id 
group by grouping sets (
                        (c.store_id, fc.category_id),
                        (c.store_id),
                        (fc.category_id),
                        ())
order by c.store_id, fc.category_id;

-- 7 cust film tot gel
select r.customer_id , i.film_id , SUM(p.amount) tot_pay
from rental r
join inventory i on i.film_id = r.inventory_id  
join payment p on p.rental_id = r.rental_id 
group by grouping sets (
                        (r.customer_id , i.film_id),
                        (r.customer_id),
                        (i.film_id),
                        ())
order by r.customer_id , i.film_id;

-- 8 şehir film kiralama
select i.film_id, a.city_id, COUNT(*) rental_amount
from rental r
join inventory i on i.inventory_id = r.inventory_id 
join customer c on c.customer_id = r.customer_id 
join address a on a.address_id = c.address_id 
group by grouping sets (
                        (i.film_id, a.city_id),
                        (i.film_id),
                        (a.city_id),
                        ())
order by i.film_id, a.city_id;


-- ANALYTIC FUNC

-- 1 film kira sayısı (bitmedi)
select i.film_id , 
       COUNT(r.rental_id) over (partition by i.film_id order by COUNT(r.rental_id)) rental_amount,
       row_number() over (partition by i.film_id order by COUNT(r.rental_id)) seq 
from rental r
join inventory i on i.inventory_id = r.inventory_id
order by i.film_id, rental_amount;

-- 2 
select s.store_id , p.amount , 
       SUM(amount) over (partition by s.store_id) total_amount
from payment p
inner join staff s on s.staff_id = p.staff_id;







