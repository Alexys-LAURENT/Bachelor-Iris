drop database if exists syncpro;

create database syncpro;

use syncpro;

Create table
    entreprises(
        idEntreprise int not null auto_increment,
        nom VARCHAR(50) not null,
        adresse VARCHAR(50) not null,
        codePostal VARCHAR(50) not null,
        ville VARCHAR(50) not null,
        siret VARCHAR(50) not null,
        constraint PK_ENTREPRISES PRIMARY KEY(idEntreprise)
    ) engine = innodb,
    charset = utf8;

create table
    users(
        idUser int NOT NULL auto_increment,
        idEntreprise int not null,
        nom VARCHAR(50) NOT NULL,
        prenom VARCHAR(50) NOT null,
        email varchar(50) not null,
        hashedPass VARCHAR(50) NOT NULL,
        metier VARCHAR(50) NOT NULL,
        constraint PK_USER PRIMARY KEY(idUser),
        constraint FK_USER_ENTREPRISE FOREIGN KEY(idEntreprise) REFERENCES entreprises(idEntreprise)
    ) engine = innodb,
    charset = utf8;

create table
    discussions(
        idDiscussion int not null auto_increment,
        constraint PK_DISCUSSIONS PRIMARY KEY(idDiscussion)
    ) engine = innodb,
    charset = utf8;

create table
    discussions_users (
        idUser int not null,
        idDiscussion int not null,
        constraint PK_DISCUSSIONS_USER PRIMARY KEY(idUser, idDiscussion),
        constraint FK_DISCUSSIONS_USER_USER FOREIGN KEY(idUser) REFERENCES users(idUser),
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

-- Insertion des entreprises

INSERT INTO
    entreprises (
        nom,
        adresse,
        codePostal,
        ville,
        siret
    )
VALUES (
        'Tech Solutions',
        '123 Main Street',
        '12345',
        'Techville',
        'SIRET12345'
    ), (
        'Data Systems',
        '456 Oak Avenue',
        '67890',
        'Datatown',
        'SIRET67890'
    ), (
        'Web Services Inc.',
        '789 Elm Road',
        '54321',
        'Webville',
        'SIRET54321'
    );

-- Insertion des utilisateurs

-- Entreprise 1 (Tech Solutions)

INSERT INTO
    users (
        idEntreprise,
        nom,
        prenom,
        email,
        hashedPass,
        metier
    )
VALUES (
        1,
        'John',
        'Doe',
        'johndoe@email.com',
        '123',
        'Développeur Web'
    ), (
        1,
        'Alice',
        'Smith',
        'alicesmith@email.com',
        '123',
        'Administrateur Systèmes'
    );

-- Entreprise 2 (Data Systems)

INSERT INTO
    users (
        idEntreprise,
        nom,
        prenom,
        email,
        hashedPass,
        metier
    )
VALUES (
        2,
        'Robert',
        'Johnson',
        'robertjohnson@email.com',
        '123',
        'Analyste de Données'
    ), (
        2,
        'Ella',
        'Davis',
        'elladavis@email.com',
        '123',
        'Ingénieur en Données'
    );

-- Entreprise 3 (Web Services Inc.)

INSERT INTO
    users (
        idEntreprise,
        nom,
        prenom,
        email,
        hashedPass,
        metier
    )
VALUES (
        3,
        'Michael',
        'Clark',
        'michaelclark@email.com',
        '123',
        'Développeur Full-Stack'
    );