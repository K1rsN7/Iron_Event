-- Удаление всех таблиц, если они существуют
DROP TABLE IF EXISTS request_addition CASCADE;
DROP TABLE IF EXISTS barrier_list CASCADE;
DROP TABLE IF EXISTS apartament CASCADE;
DROP TABLE IF EXISTS house_list CASCADE;
DROP TABLE IF EXISTS request CASCADE;
DROP TABLE IF EXISTS car_user CASCADE;
DROP TABLE IF EXISTS user_list CASCADE;
DROP TABLE IF EXISTS role_list CASCADE;

-- Роли пользователей
create table role_list (
	ID_role serial,
	name_role varchar(100) not null,
	primary key(ID_role)
);
insert into role_list (ID_role, name_role) 
values 
	(0, 'Пользователь'), 
	(1, 'Староста дома'), 
	(2, 'Администратор');

-- Пользователи
create table user_list (
	id BIGINT,
	username varchar(100) not null,
	fio varchar(100) not null,
	phone varchar(20) not null,
	ID_list_role int not null default 0,
	reg_date date not null default current_timestamp,
	upd_date date not null default current_timestamp,
	primary key(id),
 	foreign key(ID_list_role) references role_list(ID_role) on delete cascade
);

-- Добавление администратора в таблицу пользователей
INSERT INTO user_list (id, username, fio, phone, ID_list_role, reg_date, upd_date)
VALUES 
	(5339421737, 'DianaSukhorukova', 'Сухорукова Диана Андреевна', '89888888888', 0, '2024-10-06', '2024-10-06'),
    (975499333, 'K1rsN7', 'Сухоруков Кирилл Андреевич', '89999999999', 2, '2024-10-06', '2024-10-06');

-- Автомобили пользователей
create table car_user (
	ID_car serial, 
	ID_user BIGINT,
	number_plate varchar(9) not null,
	primary key (ID_car),
	foreign key (ID_user) references user_list(id) on delete cascade
);

-- Запросы пользователя
create table request (
        ID_request serial,
        date_request date not null default current_timestamp,
        ID_user BIGINT not null,
        title varchar(100) not null,
        description text not null,
        status bool default false not null,
        response text, 
        primary key(ID_request),
        foreign key(ID_user) references user_list(id) on delete cascade
);

-- Дом
create table house_list (
	ID_house serial,
	city varchar(50) not null,
	street varchar(150) not null,
	number_house int not null,
	max_apartament int not null,
	primary key(ID_house)
);

-- Квартиры
create table apartament (
	ID_user BIGINT references user_list(id) on delete cascade,
	ID_house_list int references house_list(ID_house) on delete cascade,
	number_apartament INT not null,
	is_elder bool default false not null,
	constraint apartament_pkey primary key(ID_user, ID_house_list)
);

-- Запросы на добавление в дом
create table request_addition (
	ID_request serial,
	ID_user BIGINT not null,
	ID_house_list int not null,
	status bool default false not null,
	primary key(ID_request),
	foreign key(ID_user) references user_list(id) on delete cascade,
	foreign key(ID_house_list) references house_list(ID_house) on delete cascade
);

-- Список шлагбаумов
create table barrier_list(
	ID_barrier serial,
	ID_house_list int not null,
	title varchar(100) not null,
	ip_camera text not null,
	primary key(ID_barrier),
	foreign key(ID_house_list) references house_list(ID_house) on delete cascade
);

-- Выдать права роли
GRANT SELECT, INSERT, UPDATE, delete ON ALL TABLES IN SCHEMA private TO admin_smart_barrier;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA private TO admin_smart_barrier;


-- Тестовые записи
INSERT INTO house_list (city, street, number_house, max_apartament) VALUES
('Москва', 'Тверская улица', 1, 10),
('Москва', 'Невский проспект', 2, 10),
('Москва', 'Арбат', 3, 10),
('Санкт-Петербург', 'Невский проспект', 25, 10),
('Санкт-Петербург', 'Лиговский проспект', 30, 10),
('Екатеринбург', 'Ленина проспект', 12, 10),
('Екатеринбург', 'Куйбышева улица', 45, 10),
('Казань', 'Баумана улица', 7, 10),
('Казань', 'Пушкина улица', 15, 10),
('Новосибирск', 'Красный проспект', 45, 10),
('Новосибирск', 'Ленина улица', 20, 10),
('Челябинск', 'Кировский проспект', 30, 10),
('Челябинск', 'Тракторостроителей улица', 10, 10),
('Самара', 'Ленина улица', 5, 10),
('Самара', 'Московское шоссе', 8, 10),
('Ростов-на-Дону', 'Северный проспект', 18, 10),
('Ростов-на-Дону', 'Пушкинская улица', 22, 10),
('Уфа', 'Пушкина улица', 22, 10),
('Уфа', 'Ленина улица', 14, 10),
('Волгоград', 'Мира улица', 14, 10),
('Волгоград', 'Комсомольская улица', 9, 10),
('Красноярск', 'Ленина проспект', 33, 10),
('Красноярск', 'Мира улица', 5, 10),
('Пермь', 'Сибирская улица', 12, 10),
('Пермь', 'Кирова улица', 3, 10),
('Тюмень', 'Ленина улица', 7, 10),
('Тюмень', 'Гагарина улица', 20, 10),
('Ижевск', 'Кирова улица', 1, 10),
('Ижевск', 'Пушкина улица', 4, 10),
('Барнаул', 'Ленина проспект', 11, 10),
('Барнаул', 'Мира улица', 15, 10),
('Воронеж', 'Ленина улица', 2, 10),
('Воронеж', 'Пушкинская улица', 6, 10),
('Нижний Новгород', 'Горького улица', 9, 10),
('Нижний Новгород', 'Свердлова улица', 14, 10),
('Саратов', 'Ленина улица', 3, 10),
('Саратов', 'Московская улица',18 ,10), 
('Тула','Ленина улица' ,10 ,10), 
('Тула','Суворова улица' ,25 ,10), 
('Ярославль','Свердлова улица' ,4 ,10), 
('Ярославль','Ленина улица' ,8 ,10), 
('Калуга','Ленина улица' ,12 ,10), 
('Калуга','Пушкина улица' ,5 ,10), 
('Сочи','Морская улица' ,1 ,10), 
('Сочи','Ленина улица' ,20 ,10), 
('Кострома','Ленина улица' ,7 ,10), 
('Кострома','Пушкина улица' ,3 ,10), 
('Астрахань','Ленина улица' ,15 ,10), 
('Астрахань','Московская улица' ,9 ,10), 
('Мурманск','Ленина улица' ,6 ,10), 
('Мурманск','Свердлова улица' ,11 ,10), 
('Архангельск','Ленина улица' ,4 ,10), 
('Архангельск','Мира улица' ,8 ,10), 
('Севастополь','Ленина улица' ,12 ,10), 
('Севастополь','Пушкина улица' ,5 ,10); 

INSERT INTO apartament (ID_user, ID_house_list, number_apartament, is_elder)
VALUES 
    (975499333, 1, 2, true),
    (5339421737, 1, 2, false);
