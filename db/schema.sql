
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
    professorName VARCHAR(16) NOT NULL
);

ALTER TABLE class AUTO_INCREMENT=2000;

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
    comment_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_Id) REFERENCES users(user_Id),
    FOREIGN KEY(post_Id) REFERENCES post(post_Id)
); 

DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
    user_Id INTEGER NOT NULL,
    post_Id INTEGER NOT NULL,
    FOREIGN KEY(user_Id) REFERENCES users(user_Id),
    FOREIGN KEY(post_Id) REFERENCES post(post_Id)

);



DROP TABLE IF EXISTS connection;

--this table is made for follow schema , an alternative for follow/unfollow schema

CREATE TABLE connection(
    user_Id INTEGER PRIMARY KEY AUTO_INCREMENT,
    source INTEGER NOT NULL,
    target INTEGER NOT NULL,
    is_follow BOOLEAN NOT NULL,
    checked DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(source) REFERENCES users(user_Id),
    FOREIGN KEY(target) REFERENCES users(user_Id),
    UNIQUE KEY(source, target, checked)
   
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


CREATE PROCEDURE follow(IN source INTEGER, IN target INTEGER)
BEGIN
    INSERT INTO connection (source, target, is_follow) VALUES (source, target, true);
END $$

CREATE PROCEDURE unfollow(IN source INTEGER, IN target INTEGER)
BEGIN
    INSERT INTO connection (source, target, is_follow) VALUES (source, target, false);
END $$

DELIMITER ;

CREATE VIEW recent_connection AS
    SELECT user_Id, source, target, MAX(checked) OVER (PARTITION BY source, target) AS most_recent
        FROM connection;

CREATE VIEW follows AS
    SELECT G.source, G.target, G.is_follow, R.most_recent as checked
        FROM recent_connection R
        JOIN connection G ON R.user_Id = G.user_Id AND R.most_recent = G.checked
        WHERE G.is_follow = TRUE;




INSERT INTO users VALUES (1, 'Bernardo', 'Bernie', 'sander');

