use project;

-- show tables; 

drop table if exists FMS_complaint;
drop table if exists FMS_Request;
drop table if exists Service_location;
drop table if exists contact_details;
drop table if exists members;
drop table if exists admins;
drop table if exists calender;
drop table if exists contents;
drop table if exists interests;
drop table if exists Subscribers;
drop table if exists events;
drop table if exists clubs_and_societies;
drop table if exists students;

create table students(
student_id int,
full_name varchar(30)not null,
date_of_birth date,
year_of_study int not null,
branch varchar(30) not null,
primary key(student_id),
check (year_of_study >= 2000 and year_of_study <= 9999),
check (length(full_name) >= 2),
check (length(branch) >= 3)
);

create table clubs_and_societies(
club_id varchar(20),
club_name varchar(50) UNIQUE not null,
calendar timestamp UNIQUE,
primary key(club_id),
check (length(club_name) >= 4)
);

create table events(
event_id int auto_increment,
club_id varchar(20) not null,
photos_link varchar (100) UNIQUE, 
event_updates varchar(1000),
event_name varchar(100) not null,
description varchar (1000),
primary key(event_id),
foreign key(club_id) references clubs_and_societies(club_id) on delete cascade
);

create table Subscribers(
sub_id int auto_increment,
student_id int not null,
club_name varchar(30) not null,
primary key(sub_id),
check (length(club_name) >= 4),
foreign key(student_id) references students(student_id) on delete cascade,
foreign key(club_name) references clubs_and_societies(club_name) on delete cascade,
unique key(student_id,club_name)
);

create table interests(
int_id int auto_increment,
student_id int,
interest varchar(30),
primary key(int_id),
check (length(interest) >= 4),
foreign key(student_id) references students(student_id) on delete cascade,
unique key(student_id,interest)
);

create table contents(
con_id int auto_increment,
created_at varchar(50),
student_id int not null,
name_of_content varchar(30) unique not null,
type_of_doc varchar(30) not null,
link_of_doc varchar(30) not null unique,
primary key(con_id),
foreign key(student_id) references students(student_id) on delete cascade
);

create table calender(
cid int,
student_id int not null,
datex datetime not null,
title varchar(30) not null,
descriptions varchar(1000),
venue varchar(20) not null,
primary key(cid),
foreign key(student_id) references students(student_id) on delete cascade
);

create table admins(
admin_id varchar(20),
student_id int not null,
name varchar(30) not null,
club_id varchar(20) not null,
club_name varchar(30),
primary key(admin_id),
foreign key(student_id) references students(student_id) on delete cascade,
foreign key(club_id) references clubs_and_societies(club_id) on delete cascade,
foreign key(club_name) references clubs_and_societies(club_name),
unique key (student_id,club_id)
);

create table members(
mem_id int auto_increment,
student_id int,
club_id varchar(20) not null,
club_tag varchar(20),
primary key(mem_id),
foreign key (student_id) references students(student_id),
foreign key (club_id) references clubs_and_societies(club_id) on delete cascade,
unique key (student_id,club_id)
);

create table contact_details(
student_id int,
telegram_handle varchar(30),
github varchar(30),
email_address varchar(40) UNIQUE,
primary key(student_id),
check (email_address like '%_@__%._%'),
foreign key (student_id) references students(student_id) on delete cascade
);

CREATE TABLE Service_Location (
  Location_ID int AUTO_INCREMENT,
  Location_Name varchar(45) NOT NULL,
  PRIMARY KEY (Location_ID)
);

CREATE TABLE FMS_Complaint (
  Complaint_ID int NOT NULL AUTO_INCREMENT UNIQUE,
  Full_Name varchar(250) NOT NULL,
  Email varchar(250) NOT NULL,
  Phone_Number char(10) NOT NULL,
  Location_ID int NOT NULL,
  Room varchar(50) NOT NULL,
  Description varchar(500) NOT NULL,
  PRIMARY KEY (Complaint_ID),
  FOREIGN KEY (Location_ID) REFERENCES Service_Location (Location_ID),
  check (Phone_Number like '0-9')
);

CREATE TABLE FMS_Request (
  request_ID int NOT NULL AUTO_INCREMENT UNIQUE,
  Full_Name varchar(250) NOT NULL,
  Email varchar(250) NOT NULL,
  Phone_Number char(10) NOT NULL,
  Location_ID int NOT NULL,
  Room varchar(50) NOT NULL,
  Description varchar(500) NOT NULL,
  PRIMARY KEY (request_ID),
  FOREIGN KEY (Location_ID) REFERENCES Service_Location (Location_ID),
  check (Phone_Number like '0-9')
  );
  

