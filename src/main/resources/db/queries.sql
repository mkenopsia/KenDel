-- Получить данные водителей, находящихся в пути по маршруту Красноярск-Иркутск с хрупким грузом на борту
select distinct driver.c_fio, driver.c_phone_number, driver.c_job_start_date
from shipping_management.t_driver driver
         join shipping_management.t_shipping_way trip
              on trip.c_driver_id = driver.c_account_id
         join shipping_management.t_shipping_way_routes routes
              on routes.c_shipping_way_id = trip.c_shipping_way_id
         join shipping_management.t_shipping_way_shipping_order orders_in_trip
              on orders_in_trip.c_shipping_way_id = trip.c_shipping_way_id
         join shipping_management.t_cargo cargo
              on orders_in_trip.c_shipping_order_id = cargo.c_order_id
         join shipping_management.t_cargo_type_cargo cargo_type_link
              on cargo_type_link.c_cargo_id = cargo.c_cargo_id
         join shipping_management.t_cargo_type cargo_type
              on cargo_type.c_cargo_type_id = cargo_type_link.c_cargo_type_id
where trip.c_is_completed = false
  and routes.c_route_id in (select r.c_route_id
                            from shipping_management.t_route r
                                     join shipping_management.t_address a_start
                                          on r.c_start_point = a_start.c_address_id
                                     join shipping_management.t_settlement s_start
                                          on a_start.c_settlement_id = s_start.c_settlement_id
                                     join shipping_management.t_address a_end on r.c_end_point = a_end.c_address_id
                                     join shipping_management.t_settlement s_end
                                          on a_end.c_settlement_id = s_end.c_settlement_id
                            where s_start.c_name = 'Красноярск'
                              and s_end.c_name = 'Иркутск')
  and routes.c_status = 'в пути'
  and orders_in_trip.c_out_date is null
  and cargo_type.c_name = 'хрупкий';

-- Получить количество писем прошедших по маршруту Москва - Санкт-Петербург в период с сентябрь по октябрь 2025
select count(*)
from shipping_management.t_cargo cargo
         join shipping_management.t_cargo_type_cargo cargo_type_link
              on cargo_type_link.c_cargo_id = cargo.c_cargo_id
         join shipping_management.t_cargo_type type
              on type.c_cargo_type_id = cargo_type_link.c_cargo_type_id
         join shipping_management.t_shipping_order sorder
              on sorder.c_order_id = cargo.c_order_id
         join shipping_management.t_shipping_way_shipping_order trips_orders
              on trips_orders.c_shipping_order_id = sorder.c_order_id
         join shipping_management.t_shipping_way trip
              on trips_orders.c_shipping_way_id = trip.c_shipping_way_id
         join shipping_management.t_shipping_way_routes routes
              on routes.c_shipping_way_id = trip.c_shipping_way_id
where type.c_name = 'письмо'
  and routes.c_route_id in (select r.c_route_id
                            from shipping_management.t_route r
                                     join shipping_management.t_address a_start
                                          on r.c_start_point = a_start.c_address_id
                                     join shipping_management.t_settlement s_start
                                          on a_start.c_settlement_id = s_start.c_settlement_id
                                     join shipping_management.t_address a_end on r.c_end_point = a_end.c_address_id
                                     join shipping_management.t_settlement s_end
                                          on a_end.c_settlement_id = s_end.c_settlement_id
                            where s_start.c_name = 'Москва'
                              and s_end.c_name = 'Санкт-Петербург')
  and routes.c_status = 'пройден'
  and routes.c_end_date >= '2025-09-01 00:00:00+03'
  and routes.c_end_date < '2025-10-01 00:00:00+03';

-- Получить данные клиентов совершивших более 30 заказов на сумму более 20000 рублей
select client.c_account_id,
       client.c_fio,
       client.c_passport_series_number,
       client.c_phone_number,
       client.c_status,
       count(sorder.c_order_id) as order_count,
       sum(sorder.c_price)      as total_summa
from shipping_management.t_client client
         join shipping_management.t_shipping_order sorder
              on client.c_account_id = sorder.c_sender_id
group by client.c_account_id,
         client.c_fio,
         client.c_passport_series_number,
         client.c_phone_number,
         client.c_status
having count(sorder.c_order_id) >= 1
   and sum(sorder.c_price) > 100;

-- Получить самый популярный маршрут для перевозки животных за последний месяц
select city_from.c_name as shipment_city,
       city_to.c_name   as delivery_city,
       count(*)         as cargo_count
from shipping_management.t_cargo cargo
         join shipping_management.t_cargo_type_cargo cargo_type_link
              on cargo_type_link.c_cargo_id = cargo.c_cargo_id
         join shipping_management.t_cargo_type type
              on type.c_cargo_type_id = cargo_type_link.c_cargo_type_id
         join shipping_management.t_shipping_order sorder
              on cargo.c_order_id = sorder.c_order_id
         join shipping_management.t_address addr_from
              on sorder.c_shipment_address = addr_from.c_address_id
         join shipping_management.t_address addr_to
              on sorder.c_delivery_address = addr_to.c_address_id
         join shipping_management.t_settlement city_from
              on addr_from.c_settlement_id = city_from.c_settlement_id
         join shipping_management.t_settlement city_to
              on addr_to.c_settlement_id = city_to.c_settlement_id
where type.c_name = 'животные'
  and sorder.c_creation_date >= '2025-10-01 00:00:00+03'
  and sorder.c_creation_date < '2025-11-01 00:00:00+03'
group by addr_from.c_address_id,
         city_from.c_name,
         addr_to.c_address_id,
         city_to.c_name
order by cargo_count desc
limit 1;

-- Получить список автомобилей, перевёзших более 2000 заказов с  крупногабаритным грузом
select vh.c_vehicle_number as avto_number, count(distinct sorder.c_order_id) as orders_count
from shipping_management.t_vehicle vh
         join shipping_management.t_history history
              on history.c_vehicle_number = vh.c_vehicle_number
         join shipping_management.t_shipping_order sorder
              on sorder.c_order_id = history.c_order_id
         join shipping_management.t_cargo cargo
              on cargo.c_order_id = sorder.c_order_id
         join shipping_management.t_cargo_type_cargo cargo_type_link
              on cargo_type_link.c_cargo_id = cargo.c_cargo_id
         join shipping_management.t_cargo_type ctype
              on ctype.c_cargo_type_id = cargo_type_link.c_cargo_type_id
where ctype.c_name = 'крупногабарит'
  and sorder.c_is_completed is true
group by vh.c_vehicle_number
having count(distinct sorder.c_order_id) >= 1;


-- Получить данные водителя и его ТС с допустимыми грузами для назначения заказа в данном городе
select c_fio, vehicle.c_vehicle_id, type.c_name
from shipping_management.t_driver
         join shipping_management.t_driver_vehicle vehicle
              on t_driver.c_account_id = vehicle.c_driver_id
         join shipping_management.t_allowed_cargo_types types
              on vehicle.c_vehicle_id = types.c_vehicle_number
         join shipping_management.t_cargo_type type
              on types.c_cargo_type_id = type.c_cargo_type_id
where t_driver.c_status = 'свободен'
  and t_driver.c_current_address in (select c_address_id
                                     from shipping_management.t_address
                                     where c_settlement_id in (select c_settlement_id
                                                               from shipping_management.t_settlement
                                                               where t_settlement.c_name = 'Москва'));
