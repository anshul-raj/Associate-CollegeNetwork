use project;

show tables;

-- Insertion into Students:

describe students;

insert into students values
("2018275","Advika Singh",NULL,"2018","CSD"),
("2018277","ANEESHA LAKRA",NULL,"2018","CSD"),
("2018278","Arnav",NULL,"2018","CSD"),
("2018279","Arunesh",NULL,"2018","CSD"),
("2017041","Chirag Jain",NULL,"2017","CSE");

select * from students;

-- Insertion into clubs_and_societies

describe clubs_and_societies;

insert into clubs_and_societies values
("cc","Cultural Committee",NULL),
("mt","MadToes",NULL),
("fb","foobar",NULL),
("by","byld",NULL),
("el","elecroholics",NULL);

select * from clubs_and_societies;

-- Insertion into Events

describe events;

insert into events values
(NULL,"cc",NULL,NULL,"cadence",NULL),
(NULL,"by",NULL,NULL,"hackathon",NULL),
(NULL,"fb",NULL,NULL,"pro_sort",NULL),
(NULL,"fb",null,null,"icpc_type_pro_sort",null),
(NULL,"el",null,null,"tinker_hack",null);

insert into events values(NULL,"el",null,null,"tinker_hack",null);

select * from events;

-- Insertion into Subscribers

describe Subscribers;

insert into Subscribers values
(NULL,"2018275","Cultural Committee"),
(NULL,"2018275","MadToes"),
(NULL,"2018279","Cultural Committee"),
(NULL,"2018278","elecroholics"),
(NULL,"2017041","byld");

insert into Subscribers values (NULL,"2018275","byld");

select * from Subscribers order by sub_id;

-- Insertion into interests

describe interests;

insert into interests values
(null,"2018275","Dance"),
(null,"2018278","Design"),
(null,"2018279","Sports"),
(null,"2018279","Dance"),
(null,"2017041","Fashion"); 

insert into interests values(NULL,"2017041","Fashion&Dance");

select * from Interests;

-- Insertion into Contents

describe contents;


















