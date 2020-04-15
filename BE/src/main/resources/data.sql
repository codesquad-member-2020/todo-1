insert into project (id) values (1);
insert into category (column_name, project, project_key) values ('Todo', 1, 1);
insert into category (column_name, project, project_key) values ('In Progress', 1, 2);
insert into category (column_name, project, project_key) values ('Done', 1, 3);

insert into user (user_id, password) values ('sunny', '1234');
insert into user (user_id, password) values ('cory', '12');

insert into card (user_id, title, contents, device, category, category_key) values
('sunny', '아이언맨', 'hello', 'web', 1, 0);
insert into card (user_id, title, contents, device, category, category_key) values
('sunny', '스파이더맨', 'hello', 'web', 1, 1);
insert into card (user_id, title, contents, device, category, category_key) values
('sunny', '블랙위도우', 'hello', 'web', 1, 2);
insert into card (user_id, title, contents, device, category, category_key) values
('sunny', '조커', 'hello', 'web', 2, 0);
insert into card (user_id, title, contents, device, category, category_key) values
('sunny', '배트맨', 'hello', 'web', 2, 1);
