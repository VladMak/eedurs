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


-- Ответы
create table answer (
    ansid serial primary key,
    anstext text,
    anscorrect boolean,
    queid integer,
    constraint queans_fk foreign key (queid) references question (queid) on delete cascade
);

--Заполняем таблицу Тем
insert into theme (thename) values ('DBA2.Изоляция');
--Затаскиваем данные из файла
copy question from '/home/mvasion/Документы/work/rust/elearn/data/question.csv'
with (format csv, header true);
copy answer from '/home/mvasion/Документы/work/rust/elearn/data/answer.csv'
with (format csv, header true);





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


