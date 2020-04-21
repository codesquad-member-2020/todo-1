drop table if exists project;
drop table if exists category;
drop table if exists user;
drop table if exists card;
drop table if exists history;

create table project (
    id int primary key auto_increment
);

create table category (
                      id int primary key auto_increment,
                      column_name varchar (45),
                      project int references project(id) on delete cascade on update cascade,
                      project_key int
);

create table user (
                      id int primary key auto_increment,
                      user_id varchar (45),
                      password varchar (45)
);

create table card (
                      id int primary key auto_increment,
                      user_id varchar(45) references user(user_id) on delete cascade on update cascade,
                      title varchar(45),
                      contents text,
                      device varchar(45),
                      category int references category(id) on delete cascade on update cascade,
--                       user_key int,
                      category_key int
);

create table history (
                         id int primary key auto_increment,
                         user_id varchar(45),
                         profile_url varchar(200),
                         action varchar(45),
                         title varchar(45),
                         from_column int,
                         to_column int,
                         action_time TIMESTAMP not null default now()
);