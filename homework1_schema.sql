create table course
(
    id             bigserial primary key,
    title          varchar(100)                   not null,
    description    varchar(400),
    teacher_id     bigint references teacher (id) not null,
    lesson_count   int     default 15,
    student_count  int     default 0,
    start_datetime timestamp                      not null check (start_datetime > '2020-01-01'),
    end_datetime   timestamp                      not null,
    cost           decimal default 1000 check (cost >= 0),

    unique (title, teacher_id)
);

drop table if exists course;


create table teacher
(
    id         bigserial primary key,
    first_name varchar(25) not null,
    last_name  varchar(25),
    role       varchar(100)
);


insert into teacher (first_name, last_name, role)
values ('Emil', 'Miramistinov', 'Teacher'),
       ('Alex', 'Minecraft', 'Teacher'),
       ('Steve', 'Jobs', 'Professor'),
       ('Alina', 'Minnihanova', 'Professor'),
       ('Penelopa', 'Fonkeks', 'Professor');

insert into course (title, description, teacher_id, start_datetime, end_datetime)
values ('Как правильно бегать', 'научим правильно бегать', 1, '2022-01-01', '2024-01-02'),
       ('Как правильно плавать', 'научим правильно плавать', 1, '2022-01-01', '2024-01-03'),
       ('Как правильно дышать', 'научим правильно дышать', 1, '2022-01-01', '2024-02-05'),
       ('Как правильно прыгать', 'научим правильно прыгать', 1, '2022-01-01', '2024-01-02'),
       ('Как править миром', 'научим быть тираном', 2, '1204-01-01', '1305-05-05'),
       ('Математика', 'научим считать', 3, '2024-01-01', '2025-01-02'),
       ('Русский язык', 'школьный предмет', 2, '2024-01-01', '2025-01-02'),
       ('Экономика', 'школьный предмет', 2, '2024-01-01', '2025-01-02'),
       ('Химия', 'школьный предмет', 2, '2024-01-01', '2025-01-02'),
       ('Обществознание', 'школьный предмет', 4, '2024-01-01', '2025-01-02'),
       ('Музыка', 'школьный предмет', 4, '2024-01-01', '2025-01-02'),
       ('Технология', 'школьный предмет', 4, '2024-01-01', '2025-01-02'),
       ('Дискретная математика', 'университетский предмет', 5, '2024-01-01',
        '2025-01-02'),
       ('Математический анализ', 'университетский предмет', 5, '2024-01-01',
        '2025-01-02'),
       ('Линейная алгебра', 'университетский предмет', 5,
        '2024-01-01', '2025-01-02'),
       ('Аналитическая геометрия', 'университетский предмет', 5,
        '2024-01-01', '2025-01-02'),
       ('Java Backend', 'курс по выбору', 5, '2024-01-01', '2025-01-02'),
       ('Религия', 'Бог есть (нет)', 1, '2024-01-01', '2025-01-02');


select * from course;


select title from course where description like '%предме_%';


update course
set end_datetime='2028-01-01'
where description like '%универ%';


delete from course where end_datetime > now();


drop table if exists course;