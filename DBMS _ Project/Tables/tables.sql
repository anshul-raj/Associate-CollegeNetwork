create table clubs_and_societies{
club_id varchar Primary Key,
club_name varchar(50) unique key,
calendar timestamp unique key,
photos_link varchar (100) unique key, 
event_updates varchar(1000),
event_name varchar(100),
description varchar (1000)};

create table members{
student_id int not null,
club_id int not null,
contact_id not null,
foreign key (student_id) references students(student_id),
foreign key (club_id) references clubs_and_societies(club_id),
foreign key (contact_id) references contact_details(student_id)};

create table contact_details{
student_id int primary key,
telegram_handle varchar(30),
github varchar(30),
email_address varchar(40) unique key,
check (email_address like '%_@__%._%'),
foreign key (student_id) references students(student_id)};
