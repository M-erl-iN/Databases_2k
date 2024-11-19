drop table if exists group_subject_teacher;
drop table if exists student;
drop table if exists "group";
drop table if exists institute;
drop table if exists university;
drop table if exists teacher;
drop table if exists personal_info;
drop table if exists address;
drop table if exists city;
drop table if exists country;
drop table if exists subject;


create table country
(
    id   bigserial primary key,
    name varchar(60) not null unique
);

create table city
(
    id         bigserial primary key,
    name       varchar(75) not null,
    country_id bigint references country (id),
    unique (name, country_id)
);

create table address
(
    id      bigserial primary key,
    street  varchar(150) not null,
    city_id bigint references city (id)
);

create table personal_info
(
    id         bigserial primary key,
    passport   varchar(20) not null,
    birthdate  date        not null,
    address_id bigint references address (id)
);



create table university
(
    id          bigserial primary key,
    title       varchar(100) unique not null,
    description varchar(400)
);

create table institute
(
    id            bigserial primary key,
    title         varchar(100) unique not null,
    description   varchar(400),
    faculty       varchar(75)         not null,
    address_id    bigint references address (id),
    university_id bigint references university (id)
);

create table "group"
(
    id           bigserial primary key,
    number       int unique not null,
    course       numeric(2) check ( course > 0 and course < 12 ),
    institute_id bigint references institute (id),
    unique (institute_id, number)
);

create table student
(
    id               bigserial primary key,
    firstname        varchar(50) not null,
    surname          varchar(50) not null,
    patronymic       varchar(50) not null,
    phone            numeric(11) not null check ( phone >= 1000000000 ) unique,
    email            varchar(70) not null unique,
    entry_year       smallint check ( entry_year > 1900 ),
    personal_info_id bigint references personal_info (id),
    group_id         bigint references "group" (id)
);

create table teacher
(
    id               bigserial primary key,
    firstname        varchar(50) not null,
    surname          varchar(50) not null,
    patronymic       varchar(50) not null,
    phone            numeric(11) not null check ( phone >= 1000000000 ) unique,
    email            varchar(70) not null unique,
    personal_info_id bigint references personal_info (id)
);

create table subject --предмет
(
    id          smallserial primary key,
    title       varchar(100) not null,
    description varchar(400)
);

create table group_subject_teacher
(
    id         bigserial primary key,
    group_id   bigint references "group" (id),
    teacher_id bigint references teacher (id),
    subject_id bigint references subject (id),
    unique (group_id, subject_id, teacher_id)
);


-- Country
INSERT INTO country (id, name)
VALUES (1, 'Россия'),
       (2, 'США'),
       (3, 'Китай'),
       (4, 'Великобритания'),
       (5, 'Германия');


-- City
INSERT INTO city (id, name, country_id)
VALUES (1, 'Москва', 1),
       (2, 'Санкт-Петербург', 1),
       (3, 'Нью-Йорк', 2),
       (4, 'Лос-Анджелес', 2),
       (5, 'Пекин', 3);


-- Address
INSERT INTO address (id, street, city_id)
VALUES (1, 'ул. Ленина, д. 1', 1),
       (2, 'пр. Невский, д. 10', 2),
       (3, '5th Avenue', 3),
       (4, 'Hollywood Boulevard', 4),
       (5, 'Tiananmen Square', 5);


-- Personal_info
INSERT INTO personal_info (id, passport, birthdate, address_id)
VALUES (1, '1234567890', '1990-01-15', 1),
       (2, '9876543210', '1985-05-20', 2),
       (3, '1122334455', '1995-10-10', 3);


-- University
INSERT INTO university (id, title, description)
VALUES (1, 'МГУ', 'Московский государственный университет'),
       (2, 'СПбГУ', 'Санкт-Петербургский государственный университет'),
       (3, 'Harvard University', 'Prestigious US university');


-- Institute
INSERT INTO institute (id, title, description, faculty, address_id, university_id)
VALUES (1, 'Мехмат', 'Механико-математический факультет', 'Математика', 1, 1),
       (2, 'Физтех', 'Физико-технический факультет', 'Физика', 2, 1),
       (3, 'Harvard Business School', 'Business School', 'Business Administration', 3, 3);


-- Group
INSERT INTO "group" (id, number, course, institute_id)
VALUES (1, 101, 1, 1),
       (2, 202, 2, 1),
       (3, 102, 1, 2);


-- Student
INSERT INTO student (id, firstname, surname, patronymic, phone, email, entry_year, personal_info_id, group_id)
VALUES (1, 'Иван', 'Иванов', 'Иванович', 9123456789, 'ivan@example.com', 2022, 1, 1),
       (2, 'Петр', 'Петров', 'Петрович', 9234567890, 'petr@example.com', 2023, 2, 2);


-- Teacher
INSERT INTO teacher (id, firstname, surname, patronymic, phone, email, personal_info_id)
VALUES (1, 'Сидор', 'Сидоров', 'Сидорович', 9345678901, 'sid@example.com', 3);


-- Subject
INSERT INTO subject (id, title, description)
VALUES (1, 'Математический анализ', 'Курс высшей математики'),
       (2, 'Физика', 'Основы физики'),
       (3, 'Экономика', 'Микро- и макроэкономика');


-- group_subject_teacher
INSERT INTO group_subject_teacher (id, group_id, teacher_id, subject_id)
VALUES (1, 1, 1, 1),
       (2, 2, 1, 2);