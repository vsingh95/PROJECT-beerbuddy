drop database if exists beerbuddy;
create database beerbuddy;
use beerbuddy;


CREATE TABLE user(
	username varchar(30) NOT NULL,
    birthdate datetime,
    password varchar(100) NOT NULL,
    PRIMARY KEY (username),
    unique (username)
);

create table bar_owner
(
	username		varchar(30) NOT NULL,
	owner_name		varchar(50) NOT NULL,
    unique (username),
	foreign key (username) references user(username)
);

create table bar
(
    username		varchar(30) NOT NULL, 
	bar_name		varchar(20) NOT NULL, 
	bar_id INT(5) NOT NULL,
	primary key (bar_id,username),
	foreign key (username) references bar_owner(username)
);

CREATE TABLE bar_location 
(
	cityname varchar(25) not null,
    state_name varchar(25) not null,
    address varchar(25) not null,
	bar_id INT(5) NOT NULL,
    unique (bar_id),
    foreign key (bar_id) references bar(bar_id)
);

CREATE TABLE drink
(
	name varchar(50) NOT NULL,
	alcohol_content int(10),
	type varchar(20),
	calories int(10),
	price int(10),
	bar_id INT(5) NOT NULL,
    primary key (bar_id, name),
    foreign key (bar_id) references bar(bar_id)
);

-- Ingredients
CREATE TABLE ingredients (
	name VARCHAR(50) NOT NULL, 
	bar_id INT(5) NOT NULL,
	ing_name VARCHAR(30) NOT NULL,
    primary key (bar_id, name, ing_name),
    foreign key (bar_id, name) references drink(bar_id, name)
    );

-- ALTER TABLE ingredients ADD CONSTRAINT FK_ingredients_name 
-- 	FOREIGN KEY (name) REFERENCES drink(name);
    
-- ALTER TABLE ingredients ADD CONSTRAINT FK_ingredients_bar_id 
-- 	FOREIGN KEY (bar_id) REFERENCES drink(bar_id);

-- Serves
CREATE TABLE serves  
(
	username VARCHAR(20) NOT NULL, 
	bar_id INT(5) NOT NULL,
	name VARCHAR(30) NOT NULL,
    primary key (username, bar_id, name),
    foreign key (username) references bar(username),
    foreign key (bar_id, name) references drink(bar_id, name)
);

-- ALTER TABLE serves ADD CONSTRAINT FK_serves_username FOREIGN 
-- 	KEY (username) REFERENCES bar(username);

-- ALTER TABLE serves ADD CONSTRAINT FK_serves_bar_id FOREIGN KEY 
-- 	(bar_id) REFERENCES bar(bar_id);
    
CREATE TABLE in_house(
	name varchar(50) NOT NULL,
	in_house_taste varchar(200),
	bar_id INT(5) NOT NULL,
	primary key (bar_id, name),
    FOREIGN KEY (bar_id, name) REFERENCES drink(bar_id, name)
);

CREATE TABLE common_brand(
	name varchar(50) NOT NULL REFERENCES drink(name),
	manufacturer varchar(50),
	common_taste varchar(200),
	bar_id INT(5) NOT NULL,
	PRIMARY KEY(bar_id, name),
	FOREIGN KEY (bar_id, name) REFERENCES drink(bar_id, name)
);
    
CREATE TABLE rate_drink 
(
	username varchar(25) not null,
    name varchar(25) not null,
    stars integer,
    taste varchar(25),
	bar_id INT(5) NOT NULL,
    primary key (username),
    unique (username),
    unique (bar_id),
    foreign key (username) references user(username),
    foreign key (bar_id) references serves(bar_id)
);

CREATE TABLE rate_bar (
	username varchar(30) NOT NULL,
	bar_id INT(5) NOT NULL,
    stars integer NOT NULL,
    PRIMARY KEY (username, bar_id),
    foreign key (username) references user(username),
    foreign key (bar_id) references bar(bar_id)
);

-- ALTER TABLE drink ADD FOREIGN KEY (bar_id) REFERENCES serves(bar_id);


