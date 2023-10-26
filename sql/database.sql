drop tables if exists syncpro;

create database syncpro;

use syncpro;

create table
    user(
        idUser int NOT NULL auto_increment,
        nom VARCHAR(50) NOT NULL,
        prenom VARCHAR(50) NOT null,
        email varchar(50) not null,
        hashedPass VARCHAR(50) NOT NULL,
        metier VARCHAR(50) NOT NULL,
        constraint PK_USER PRIMARY KEY(idUser)
    ) engine = innodb,
    charset = utf8;

create table
    discussions(
        idDiscussion int not null auto_increment,
        constraint PK_DISCUSSIONS PRIMARY KEY(idDiscussion)
    ) engine = innodb,
    charset = utf8;

create table
    discussions_user (
        idUser int not null,
        idDiscussion int not null,
        constraint PK_DISCUSSIONS_USER PRIMARY KEY(idUser, idDiscussion),
        constraint FK_DISCUSSIONS_USER_USER FOREIGN KEY(idUser) REFERENCES user(idUser),
        constraint FK_DISCUSSIONS_USER_DISCUSSION FOREIGN KEY(idDiscussion) REFERENCES discussions(idDiscussion)
    ) engine = innodb,
    charset = utf8;

CREATE TABLE
    messages(
        idMessage int not null auto_increment,
        idDiscussion int not null,
        content VARCHAR(250) not null,
        constraint PK_MESSAGES PRIMARY KEY(idMessage),
        constraint FK_MESSAGES_DISCUSSION FOREIGN KEY(idDiscussion) REFERENCES discussions(idDiscussion)
    ) engine = innodb,
    charset = utf8;