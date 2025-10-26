insert into shipping_management.t_client (c_fio, c_passport_series_number, c_phone_number, c_status)
values ('Иванов Василь Павлович',
        '0420112432',
        '88005553535',
        'клиент');
insert into shipping_management.t_client (c_fio, c_passport_series_number, c_phone_number, c_status)
values ('Стариков Макс Алексеевич',
        '0419442435',
        '89509494356',
        'клиент');
insert into shipping_management.t_client (c_fio, c_passport_series_number, c_phone_number, c_status)
values ('Гранин Егор Вадимович',
        '0439442435',
        '89504324540',
        'клиент');
insert into shipping_management.t_client (c_fio, c_passport_series_number, c_phone_number, c_status)
values ('Еркалов Александр Евегьевич',
        '0309314295',
        '895048769013',
        'партнёр');

-- Регионы
insert into shipping_management.t_region (c_name)
values ('Московская область'),
       ('Ленинградская область'),
       ('Красноярский край'),
       ('Иркутская область');
--4

-- Населённые пункты
insert into shipping_management.t_settlement (c_region_id, c_name)
values (1, 'Москва'),
       (1, 'Подольск'),
       (2, 'Санкт-Петербург'),
       (2, 'Выборг'),
       (3, 'Красноярск'), --5
       (4, 'Иркутск');
--6

-- Адреса
insert into shipping_management.t_address (c_settlement_id, c_street, c_building, c_type)
values (1, 'Тверская', '1', 'СЦ'),
       (1, 'Ленинский проспект', '15', 'пункт выдачи'),
       (2, 'Мира', '10', 'склад'),
       (3, 'Невский проспект', '22', 'СЦ'),
       (3, null, null, null),
       (5, null, null, null),
       (5, 'Мира', '26', 'пункт выдачи'),   --7
       (6, 'Ленина', '15', 'пункт выдачи'), --8
       (4, 'Советская', '5', 'пункт выдачи');

-- Типы груза
insert into shipping_management.t_cargo_type (c_name)
values ('хрупкий'),
       ('требует холодного температурного режима'),
       ('животные'),
       ('письмо'),
       ('крупногабарит'),
       ('обычный');

-- Тарифы
insert into shipping_management.t_rate (c_name, c_max_width, c_max_height, c_max_length, c_max_weight, c_multiplier)
values ('стандарт', 31, 25, 38, 20.0, 1.2),
       ('XL', 100, 50, 50, 100.0, 2),
       ('письмо', 34, 27, 7, 0.5, 1),
       ('договорной', 500, 500, 500, 500, 5),
       ('крупногабарит', 200, 200, 200, 300.0, 3);

-- Водители
insert into shipping_management.t_driver (c_fio, c_phone_number, c_job_start_date, c_status, c_current_address)
values ('Сидоров Сидор Сидорович', '79991112233', '2020-01-15', 'свободен', 5),
       ('Кузнецов Алексей Иванович', '79994445566', '2019-03-22', 'свободен', 6),
       ('Сергейчиков Сергей Владимирович', '78001234567', '2012-03-22', 'в отпуске', 6),
       ('Зайцев Ратибор Виленович', '78001234567', '2012-03-22', 'свободен', 5);

-- Транспорт
insert into shipping_management.t_vehicle (c_vehicle_number, c_carrying_capacity, c_body_volume)
values ('А123ВС77', 5000, 20),
       ('В456ДЕ78', 10000, 40),
       ('СН432К124', 10000, 40);

-- Допустимые типы груза для транспорта
insert into shipping_management.t_allowed_cargo_types (c_vehicle_number, c_cargo_type_id)
values ('А123ВС77', 3),
       ('В456ДЕ78', 2),
       ('В456ДЕ78', 3);

-- Связь водителей и транспорта
insert into shipping_management.t_driver_vehicle (c_driver_id, c_vehicle_id, c_exploitation_start_date,
                                                  c_exploitation_end_date)
values (1, 'А123ВС77', '2020-01-15', '2030-01-15'),
       (2, 'В456ДЕ78', '2019-03-22', '2030-03-22');

-- Маршруты
insert into shipping_management.t_route (c_start_point, c_end_point, c_length)
values (1, 2, 30),
       (2, 3, 150),
       (7, 8, 1058),
       (4, 5, 80);

-- Заказы на доставку
insert into shipping_management.t_shipping_order (c_sender_id,
                                                  c_consumer_id,
                                                  c_shipment_address,
                                                  c_delivery_address,
                                                  c_price,
                                                  c_creation_date,
                                                  c_completion_date,
                                                  c_is_completed,
                                                  c_priority)
values (1, 2, 1, 2, 0, '2025-10-25 10:00:00+03', '2025-10-26 14:00:00+03', false, 'стандарт'),
       (2, 4, 3, 4, 0, '2025-10-25 11:30:00+03', '2025-10-27 16:00:00+03', false, 'срочная доставка');

-- Грузы
insert into shipping_management.t_cargo (c_order_id,
                                         c_rate_id,
                                         c_width,
                                         c_height,
                                         c_length,
                                         c_weight,
                                         c_type,
                                         c_price)
values (1, 1, 0.5, 0.5, 0.5, 10.0, 3, 0),
       (2, 2, 1.8, 1.8, 1.8, 80.0, 5, 0);

-- Рейсы
insert into shipping_management.t_shipping_way (c_driver_id, c_is_completed)
values (1, false),
       (2, false);

-- Маршруты рейса
insert into shipping_management.t_shipping_way_routes (c_shipping_way_id, c_route_id, c_status, c_start_date, c_end_date)
values (1, 1, 'в пути', '2025-10-25 12:00:00+03', '2025-10-25 14:00:00+03'),
       (1, 2, 'предстоит', '2025-10-25 15:00:00+03', '2025-10-26 10:00:00+03'),
       (2, 3, 'в пути', '2025-10-25 13:00:00+03', '2025-10-26 12:00:00+03');

-- История
insert into shipping_management.t_history (c_order_id,
                                           c_date,
                                           c_route_id,
                                           c_status,
                                           c_comment,
                                           c_driver_id,
                                           c_vehicle_number)
values (1, '2025-10-25 12:05:00+03', 1, 'в пути', 'Выехал со склада', 1, 'А123ВС77'),
       (2, '2025-10-25 13:10:00+03', 3, 'в пути', 'Направляется в пункт выдачи', 2, 'В456ДЕ78');

-- Отчётность
insert into shipping_management.t_report (c_shipping_way_id, c_date, c_road_hours)
values (1, '2025-10-25 14:00:00+03', 2),
       (2, '2025-10-25 15:00:00+03', 1);








-- отправка из Красноярска в Иркутск
insert into shipping_management.t_shipping_order (c_sender_id,
                                                  c_consumer_id,
                                                  c_shipment_address,
                                                  c_delivery_address,
                                                  c_price,
                                                  c_creation_date,
                                                  c_is_completed,
                                                  c_priority)
values (4, -- Еркалов,
        3, -- Гранин
        7, -- Красноярск
        8, -- Иркутск
        0,
        '2025-10-25 09:00:00+03',
        false,
        'стандарт');

insert into shipping_management.t_cargo (c_order_id,
                                         c_rate_id,
                                         c_width,
                                         c_height,
                                         c_length,
                                         c_weight,
                                         c_type,
                                         c_price)
values (3, -- новый заказ
        1, -- тариф "Стандарт"
        0.4, -- габариты
        0.3,
        0.5,
        5.0, -- вес в допустимом диапазоне
        1, -- тип "хрупкий"
        2100.53),
       (3,
        1,
        0.4,
        0.3,
        0.5,
        5.0,
        5,
        1500.53);

insert into shipping_management.t_shipping_way_shipping_order (c_shipping_way_id,
                                                               c_shipping_order_id,
                                                               c_entry_date,
                                                               c_out_date)
values (2,
        3,
        '2025-10-25 13:00:00+03',
        null);


-- Получить количество писем прошедших по маршруту Москва - Санкт-Петербург в период с сентябрь по октябрь 2025
insert into shipping_management.t_route (c_start_point, c_end_point, c_length)
values (1, 4, 700);

insert into shipping_management.t_shipping_order (c_sender_id,
                                                  c_consumer_id,
                                                  c_shipment_address,
                                                  c_delivery_address,
                                                  c_price,
                                                  c_creation_date,
                                                  c_completion_date,
                                                  c_is_completed,
                                                  c_priority)
values (1, --Иванов
        2, --Стариков
        1,
        3,
        0,
        '2025-09-15 10:00:00+03',
        null,
        false,
        'стандарт');

insert into shipping_management.t_cargo (c_order_id,
                                         c_rate_id,
                                         c_width,
                                         c_height,
                                         c_length,
                                         c_weight,
                                         c_type,
                                         c_price)
values (4,
        3,
        30,
        25,
        5,
        0.3,
        4,
        250.0),
       (4,
        3,
        30,
        25,
        5,
        0.2,
        4,
        210.0);

insert into shipping_management.t_shipping_way (c_driver_id, c_is_completed)
values (4, false);

insert into shipping_management.t_shipping_way_shipping_order (c_shipping_way_id,
                                                               c_shipping_order_id,
                                                               c_entry_date,
                                                               c_out_date)
values (3,4,'2025-09-15 11:00:00+03', null);

insert into shipping_management.t_shipping_way_routes (c_shipping_way_id, c_route_id, c_status, c_start_date, c_end_date)
values (3,5,'пройден','2025-09-15 12:00:00+03','2025-09-16 18:30:00+03');








-- Получить самый популярный маршрут для перевозки животных за последний месяц
insert into shipping_management.t_shipping_order (c_sender_id, c_consumer_id, c_shipment_address, c_delivery_address,
                                                  c_price, c_creation_date, c_is_completed, c_priority)
values (1, 2, 1, 4,
        5000.0,
        '2025-10-05 10:00:00+03',
        true,
        'стандарт');

insert into shipping_management.t_cargo (c_order_id, c_rate_id, c_width, c_height, c_length, c_weight, c_type, c_price)
values (5, 5, 150, 100, 150, 150.0, 3, 5000.0);

insert into shipping_management.t_shipping_order (c_sender_id, c_consumer_id, c_shipment_address, c_delivery_address,
                                                  c_price, c_creation_date, c_is_completed, c_priority)
values (1, 3, 1, 4,
        5200.0,
        '2025-10-12 11:30:00+03',
        true,
        'стандарт');

insert into shipping_management.t_cargo (c_order_id, c_rate_id, c_width, c_height, c_length, c_weight, c_type, c_price)
values (6, 5, 140, 90, 140, 140.0, 3, 5200.0),
       (6, 5, 140, 90, 140, 140.0, 5, 15200.0);

insert into shipping_management.t_shipping_order (c_sender_id, c_consumer_id, c_shipment_address, c_delivery_address,
                                                  c_price, c_creation_date, c_is_completed, c_priority)
values (2, 4, 2, 9, -- Подольск → Выборг
        4800.0,
        '2025-10-18 09:15:00+03',
        true,
        'стандарт');

insert into shipping_management.t_cargo (c_order_id, c_rate_id, c_width, c_height, c_length, c_weight, c_type, c_price)
values (7, 5, 130, 85, 130, 130.0, 3, 4800.0);







-- Получить список автомобилей, перевёзших более 2000 заказов с  крупногабаритным грузом
insert into shipping_management.t_shipping_order (
    c_sender_id, c_consumer_id, c_shipment_address, c_delivery_address,
    c_price, c_creation_date, c_completion_date, c_is_completed, c_priority
) values (
             1, 2, 1, 4,
             12000.0,
             '2025-10-05 08:00:00+03',
             '2025-10-06 14:00:00+03',
             true,
             'стандарт'
         );

insert into shipping_management.t_cargo (
    c_order_id, c_rate_id, c_width, c_height, c_length, c_weight, c_type, c_price
) values (
             8, 5, 180, 180, 180, 250.0, 5, 12000.0
         );

insert into shipping_management.t_shipping_order (
    c_sender_id, c_consumer_id, c_shipment_address, c_delivery_address,
    c_price, c_creation_date, c_completion_date, c_is_completed, c_priority
) values (
             1, 3, 1, 4,
             13500.0,
             '2025-10-10 09:30:00+03',
             '2025-10-11 16:00:00+03',
             true,
             'стандарт'
         );

insert into shipping_management.t_cargo (
    c_order_id, c_rate_id, c_width, c_height, c_length, c_weight, c_type, c_price
) values (
             9, 5, 190, 190, 190, 280.0, 5, 13500.0
         );

insert into shipping_management.t_shipping_order (
    c_sender_id, c_consumer_id, c_shipment_address, c_delivery_address,
    c_price, c_creation_date, c_completion_date, c_is_completed, c_priority
) values (
             2, 4, 2, 9,
             11000.0,
             '2025-10-15 10:00:00+03',
             '2025-10-16 12:00:00+03',
             true,
             'стандарт'
         );

insert into shipping_management.t_cargo (
    c_order_id, c_rate_id, c_width, c_height, c_length, c_weight, c_type, c_price
) values (
             10, 5, 170, 170, 170, 220.0, 5, 11000.0
         );

insert into shipping_management.t_history (
    c_order_id, c_date, c_route_id, c_status, c_comment, c_driver_id, c_vehicle_number
) values (
             8,
             '2025-10-06 14:00:00+03',
             5,
             'получен',
             null,
             2,
             'В456ДЕ78'
         );

insert into shipping_management.t_history (
    c_order_id, c_date, c_route_id, c_status, c_comment, c_driver_id, c_vehicle_number
) values (
             9,
             '2025-10-11 16:00:00+03',
             5,
             'получен',
             null,
             2,
             'В456ДЕ78'
         );

insert into shipping_management.t_history (
    c_order_id, c_date, c_route_id, c_status, c_comment, c_driver_id, c_vehicle_number
) values (
             10,
             '2025-10-16 12:00:00+03',
             2,
             'получен',
             null,
             1,
             'А123ВС77'
         );








insert into shipping_management.t_driver (c_fio, c_phone_number, c_job_start_date, c_status, c_current_address)
values
    ('Петров Иван Сергеевич', '79001234567', '2022-05-10', 'свободен', 1),
    ('Смирнова Анна Олеговна', '79007654321', '2023-01-15', 'свободен', 2);

insert into shipping_management.t_vehicle (c_vehicle_number, c_carrying_capacity, c_body_volume)
values
    ('М777ОР777', 8000, 30),
    ('К555ЕК123', 12000, 50);

insert into shipping_management.t_driver_vehicle (c_driver_id, c_vehicle_id, c_exploitation_start_date, c_exploitation_end_date)
values
    (5, 'М777ОР777', '2022-05-10', '2030-05-10'),
    (6, 'К555ЕК123', '2023-01-15', '2030-01-15');


insert into shipping_management.t_allowed_cargo_types (c_vehicle_number, c_cargo_type_id)
values
    ('М777ОР777', 1),
    ('М777ОР777', 4),
    ('М777ОР777', 6),
    ('К555ЕК123', 2),
    ('К555ЕК123', 3),
    ('К555ЕК123', 5),
    ('К555ЕК123', 6);