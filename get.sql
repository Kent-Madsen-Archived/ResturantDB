-- Opgave 2
select c.username as customer_username,
       booked_space.reserved_begin as reserveration_begins,
       booked_space.pris as reserveration_cost,
       rt.table_identifier as reserved_table,
       rt.number_of_seats as reserverd_table_number_of_seats
from booked_space
left join customer c on booked_space.customer_id = c.identity
left join resturant_table rt on booked_space.resturant_table_id = rt.identity
where c.identity = 1
order by booked_space.reserved_begin;

-- Opgave 3
select resturant_table.table_identifier,
       resturant_table.number_of_seats,
       bs.pris as book_price,
       DATE(bs.reserved_begin) as reservation_date,
       c.username as customer_name
from resturant_table
left join booked_space bs on resturant_table.identity = bs.resturant_table_id
left join customer c on bs.customer_id = c.identity
where resturant_table.identity = 3 and date(bs.reserved_begin)=date('2020-10-11');