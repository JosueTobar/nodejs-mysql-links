CREATE DATABASE db_links;

USE db_links;

-- TABLE USER
-- all pasword wil be encrypted using SHA1
CREATE TABLE users (
  id INT(11) NOT NULL,
  username VARCHAR(16) NOT NULL,
  password VARCHAR(60) NOT NULL,
  fullname VARCHAR(100) NOT NULL
);

ALTER TABLE users
  ADD PRIMARY KEY (id);

ALTER TABLE users
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

DESCRIBE users;
SELECT * FROM users;

-- LINKS TABLE
CREATE TABLE links (
  id INT(11) NOT NULL,
  title VARCHAR(150) NOT NULL,
  url VARCHAR(255) NOT NULL,
  description TEXT,
  user_id INT(11),
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id)
);

ALTER TABLE links
  ADD PRIMARY KEY (id);
ALTER TABLE links
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;
  
  -- Menu roles 

DESCRIBE links;

--  NEW ----------------------------- 

drop table menu;
CREATE TABLE MENU (
	id INT primary KEY auto_increment,
    idmenu INT,
	nombre varchar(100),
	url VARCHAR(250),
	estado varchar(1),
    tipo varchar(2),
    logo varchar(100),
	foreign key (idmenu) REFERENCES menu(ID)
);

INSERT INTO MENU (idmenu,nombre,url,estado,tipo,logo) VALUES (1,'Mantenimeinto','url','A','ME','logo');
INSERT INTO MENU (idmenu,nombre,url,estado,tipo,logo) VALUES (1,'Bodega','url','A','SM','logo');
INSERT INTO MENU (idmenu,nombre,url,estado,tipo,logo) VALUES (1,'Zona','url','A','SM','logo');
INSERT INTO MENU (idmenu,nombre,url,estado,tipo,logo) VALUES (1,'Mantenimeinto','url','A','SM','logo');

select * from menu where idmenu = 1;

SELECT * FROM MENU;

CREATE TABLE ROLES(
ID INT primary KEY auto_increment,
NOMBRE VARCHAR(100)
);

INSERT INTO ROLES (NOMBRE) VALUES ('ADMIN');
INSERT INTO ROLES (NOMBRE) VALUES ('ESTANDAR');

select * FROM ROLES ;

drop table users;
CREATE TABLE users (
  id INT(11) NOT NULL primary key auto_increment,
  username VARCHAR(16) NOT NULL,
  password VARCHAR(60) NOT NULL,
  fullname VARCHAR(100) NOT NULL,
  idrol INT,
  foreign key (idrol) REFERENCES ROLES(ID)
);
INSERT INTO users (username, password, fullname, idrol) values('ADMIN','12345','ADMINISTRADOR',1); 
INSERT INTO users (username, password, fullname, idrol) values('ESTANDAR','12345','ESTANDAR',2); 
select * from users;

drop table menu_rol;
CREATE TABLE MENU_ROL (
ID INT primary KEY auto_increment,
IDROL INT,
IDMENU INT,
foreign key (IDROL) REFERENCES ROLES(ID),
foreign key (IDMENU) REFERENCES MENU(IDmenu)
);
select * from menu ;
insert into menu_rol (idrol,idmenu) values (1,2);
select * from menu_rol;

-- PETICION MENUS PRINCIPALES 
select r.idmenu ,r.idrol,  u.idrol rolU, m.id, m.nombre, m.estado, m.tipo  from menu_rol r, menu m, users u 
where r.idmenu = u.id 
and  u.idrol = r.idrol;
 ;
-- PETICION SUB MENU 

select * from menu_rol r inner join menu m
 on r.id = m.id
 inner join users u on u.idrol = r.idrol
 
