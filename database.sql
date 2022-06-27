CREATE DATABASE IF NOT EXISTS laravel_master;
USE laravel_master;

CREATE TABLE IF NOT EXISTS users(
    id int(255) auto_increment not null,
    role varchar(20),
    name varchar(100),
    surname varchar(200),
    nick varchar(100),
    email varchar(255),
    password varchar(255),
    image varchar(255),
    created_at datetime,
    updated_at datetime,
    remember_token varchar(255),
    CONSTRAINT PK_USERS PRIMARY KEY(id)
)ENGINE=InnoDB;

INSERT INTO users VALUES(NULL, 'user', 'Pepe', 'Varo', 'pepevaro', 'pepe@varo.com', 'pass', NULL, CURTIME(), CURTIME(), NULL);
INSERT INTO users VALUES(NULL, 'user', 'Peter', 'Parker', 'spidey', 'peter@parker.com', 'pass', NULL, CURTIME(), CURTIME(), NULL);
INSERT INTO users VALUES(NULL, 'user', 'Pablo', 'Villa', 'simongarcia', 'pablo@villa.com', 'pass', NULL, CURTIME(), CURTIME(), NULL);

CREATE TABLE IF NOT EXISTS images(
    id int(255) auto_increment not null,
    user_id int(255),
    image_path varchar(255),
    description text,
    created_at datetime,
    updated_at datetime,
    CONSTRAINT PK_IMAGES PRIMARY KEY(id),
    CONSTRAINT FK_IMAGES_USERS FOREIGN KEY(user_id) REFERENCES users(id)
)ENGINE=InnoDB;

INSERT INTO images VALUES(NULL, 1, 'test.jpg', 'descripción de prueba 1', CURTIME(), CURTIME());
INSERT INTO images VALUES(NULL, 1, 'playa.jpg', 'descripción de prueba 2', CURTIME(), CURTIME());
INSERT INTO images VALUES(NULL, 1, 'arena.jpg', 'descripción de prueba 3', CURTIME(), CURTIME());
INSERT INTO images VALUES(NULL, 3, 'familia.jpg', 'descripción de prueba 4', CURTIME(), CURTIME());

CREATE TABLE IF NOT EXISTS comments(
    id int(255) auto_increment not null,
    user_id int(255),
    image_id int(255),
    content text,
    created_at datetime,
    updated_at datetime,
    CONSTRAINT PK_COMMENTS PRIMARY KEY(id),
    CONSTRAINT FK_COMMENTS_USERS FOREIGN KEY(user_id) REFERENCES users(id),
    CONSTRAINT FK_COMMENTS_IMAGES FOREIGN KEY(image_id) REFERENCES images(id)
)ENGINE=InnoDB;

INSERT INTO comments VALUES(NULL, 1, 4, 'Buena foto', CURTIME(), CURTIME());
INSERT INTO comments VALUES(NULL, 2, 1, 'Saludos a la banda', CURTIME(), CURTIME());
INSERT INTO comments VALUES(NULL, 2, 4, 'Cómo vas?', CURTIME(), CURTIME());

CREATE TABLE IF NOT EXISTS likes(
    id int(255) auto_increment not null,
    user_id int(255),
    image_id int(255),
    created_at datetime,
    updated_at datetime,
    CONSTRAINT PK_LIKES PRIMARY KEY(id),
    CONSTRAINT FK_LIKES_USERS FOREIGN KEY(user_id) REFERENCES users(id),
    CONSTRAINT FK_LIKES_IMAGES FOREIGN KEY(image_id) REFERENCES images(id)
)ENGINE=InnoDB;

INSERT INTO likes VALUES(NULL, 1, 4, CURTIME(), CURTIME());
INSERT INTO likes VALUES(NULL, 2, 4, CURTIME(), CURTIME());
INSERT INTO likes VALUES(NULL, 3, 1, CURTIME(), CURTIME());
INSERT INTO likes VALUES(NULL, 3, 2, CURTIME(), CURTIME());
INSERT INTO likes VALUES(NULL, 2, 1, CURTIME(), CURTIME());