
DROP DATABASE IF EXISTS collegeDB;
CREATE DATABASE collegeDB;
USE collegeDB;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_Id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(16) UNIQUE NOT NULL,
    first_Name VARCHAR(16) NOT NULL,
    last_Name VARCHAR(16) NOT NULL
 );

ALTER TABLE users AUTO_INCREMENT=1000;

DROP TABLE IF EXISTS class;
CREATE TABLE class(
    class_Id INT PRIMARY KEY AUTO_INCREMENT,
    class_Name VARCHAR(16) UNIQUE NOT NULL,
    professorName VARCHAR(16) NOT NULL,
    FOREIGN KEY(professorName) REFERENCES professors(professorName),
);

ALTER TABLE class AUTO_INCREMENT=2000;

DROP TABLE IF EXISTS follows;
CREATE TABLE follows(
    user_Id INTEGER NOT NULL,
    followeduserID INTEGER NOT NULL,
    FOREIGN KEY(user_Id) REFERENCES users(user_Id)

);

DROP TABLE IF EXISTS post;
CREATE TABLE post (
    post_Id INT PRIMARY KEY,
    class_Id INTEGER NOT NULL,
    post_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(class_Id) REFERENCES class(class_Id)
);


DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
    user_Id INTEGER NOT NULL,
    post_Id INTEGER NOT NULL,
    comment_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    FOREIGN KEY(user_Id) REFERENCES users(user_Id),
    FOREIGN KEY(post_Id) REFERENCES post(post_Id)
); 

DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
    user_Id INTEGER NOT NULL,
    post_Id INTEGER NOT NULL,
    FOREIGN KEY(user_Id) REFERENCES users(user_Id),
    FOREIGN KEY(post_Id) REFERENCES users(post_Id)

);

DROP TABLE IF EXISTS professors;
CREATE TABLE professors (
    professorName INT PRIMARY KEY,
    class_Id INTEGER NOT NULL,
    class_Name VARCHAR(16) UNIQUE NOT NULL,
    FOREIGN KEY(class_Id) REFERENCES class(class_Id),
);


DELIMITER $$
    CREATE FUNCTION get_user_id_from_name(userName VARCHAR(16))
    RETURNS INTEGER
DETERMINISTIC
BEGIN
RETURN (SELECT user_Id FROM users WHERE user_name=userName);
END $$

CREATE FUNCTION get_user_name_from_id(userId INTEGER)
RETURNS VARCHAR(16)
DETERMINISTIC
BEGIN
RETURN (SELECT user_name FROM users WHERE user_Id=userId);
END $$


INSERT INTO users VALUES (1, 'Bernardo', 'Bernie', 'sander');

