drop table if exists answer;
drop table if exists question;
drop table if exists theme;

--Тема
create table theme (
    theid serial primary key,
    thename varchar(50)
);

-- Вопросы
create table question (
    queid serial primary key,
    quetext text,
    theid integer,
    constraint theque foreign key (theid) references theme (theid) on delete cascade
);
--Затаскиваем данные из файла
copy answer from '/home/mvasion/Документы/work/rust/elearn/data/question.csv'
with (format csv, header true);

-- Ответы
create table answer (
    ansid serial primary key,
    anstext text,
    anscorrect boolean,
    queid integer,
    constraint queans_fk foreign key (queid) references question (queid) on delete cascade
);
--Затаскиваем данные из файла
copy answer from '/home/mvasion/Документы/work/rust/elearn/data/answer.csv'
with (format csv, header true);

--Заполняем таблицу Тем
insert into theme (thename) values ('DBA2.Изоляция');

--Заполняем таблицу Вопросы
insert into question (quetext, theid) values ('Что такое транзакция?', 1),
('Что такое свойства ACID?', 1),
('Что такое Согласованность?', 1),
('Что такое Атомарность?', 1),
('Изоляция - это?', 1),
('Долговечность - это?', 1),
('Какие аномалии бывают?', 1),
('Что такое "грязное" чтение?', 1),
('Что такое неповторяющееся чтение?', 1),
('Что такое фантомное чтение?', 1),
('Какие уровни изоляции бывают?', 1),
('Какие аномалии допускаются на уровне Read Uncommited в стандарте ISO?', 1),
('Какие аномалии допускаются на уровне Read Commited в стандарте ISO?', 1),
('Какие аномалии допускаются на уровне Repeatable Read в стандарте ISO?', 1),
('Какие аномалии допускаются на уровне Serializable в стандарте ISO?', 1),
('Какие аномалии допускаются на уровне Read Uncommited в реализации PostgreSQL?', 1),
('Какие аномалии допускаются на уровне Read Commited в реализации PostgreSQL?', 1),
('Какие аномалии допускаются на уровне Repeatable Read в реализации PostgreSQL?', 1),
('Какие аномалии допускаются на уровне Serializable в реализации PostgreSQL?', 1),
('Поддерживает ли PostgreSQL уровень изоляции Read Uncommitted?', 1),
('Какие уровни изоляции поддерживает PostgreSQL?', 1),
('Начиная с какого уровня изоляции перестает действовать аномалия "грязное" чтение согласно стандарту ISO?', 1),
('Начиная с какого уровня изоляции перестает действовать аномалия неповторяющееся чтение согласно стандарту ISO?', 1),
('Начиная с какого уровня изоляции перестает действовать аномалия фантомное чтение согласно стандарту ISO?', 1),
('Какой уровень изоляции используется в PostgreSQL по умолчанию?', 1);

insert into answer (anstext, anscorrect, queid) values ('Множество операций, которые переводят базу из одного корректного состояния в другое корректного состояние при условии, что транзакция выполнена полностью и без помех со стороны других транзакций', true, 1),
('Один SQL оператор, выполняемый от пользователя postgres', false, 1),
('Множество операций, которые переводят базу из одного состояния в другое. Транзакция может выполнится не полностью.', false, 1),
('Не подвергающийся блокировкам SQL оператор.', false, 1)
;

select 1;

--Берем 10 рандомных вопросов
select * from question order by random() limit 10;

--Выбор всех вопросов по теме, а потом сортировка их рандомно, и только 10 из них
select 
    q.quetext, 
    t.thename 
from question q
    inner join theme t on q.theid = t.theid and t.theid = 1
    order by random() limit 10; 

--Выбор вопроса и ответов к нему
select q.quetext, a.anstext from question q
inner join answer a on q.queid = a.queid and q.queid = 1
order by random();


