drop table if exists todo;
drop table if exists user;
drop table if exists card;
drop table if exists history;

create table todo (
    id int primary key auto_increment,
    column_name varchar (45),
    section int
);

create table user (
    id int primary key auto_increment,
    user_id varchar (45),
    password varchar (45)
);

create table card (
    id int primary key auto_increment,
    user_id int references user(id) on delete cascade on update cascade,
    title varchar(45),
    contents text,
    device varchar(45),
    row int,
    todo int references todo(id) on delete cascade on update cascade,
    todo_key int
);

create table history (
    id int primary key auto_increment,
    user_id varchar(45),
    action varchar(45),
    title varchar(45),
    from_column int,
    to_column int,
    create_time TIMESTAMP not null default now()
);
