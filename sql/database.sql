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
        pp VARCHAR(255) DEFAULT 'default.png',
        theme VARCHAR(5) NOT NULL DEFAULT 'dark',
        statut enum(
            'Absent',
            'En ligne',
            'Occupé',
            'Hors ligne'
        ) NOT NULL DEFAULT 'Hors ligne',
        constraint PK_USER PRIMARY KEY(idUser),
        constraint FK_USER_ENTREPRISE FOREIGN KEY(idEntreprise) REFERENCES entreprises(idEntreprise)
    ) engine = innodb,
    charset = utf8;

create table
    discussions(
        idDiscussion int not null auto_increment,
        nom varchar(255),
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
        idUser int not null,
        -- 500 caractères pour le message
        content varchar(255) NOT NULL,
        timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        constraint PK_MESSAGES PRIMARY KEY(idMessage),
        constraint FK_MESSAGES_DISCUSSION FOREIGN KEY(idDiscussion) REFERENCES discussions(idDiscussion),
        constraint FK_MESSAGES_USER FOREIGN KEY(idUser) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

CREATE TABLE
    token (
        idToken INT NOT NULL AUTO_INCREMENT,
        idUser INT NOT NULL,
        token VARCHAR(255) NOT NULL,
        expireAt TIMESTAMP DEFAULT (
            CURRENT_TIMESTAMP + INTERVAL 1 DAY
        ) not null,
        CONSTRAINT PK_TOKEN PRIMARY KEY (idToken),
        CONSTRAINT FK_TOKEN_USER FOREIGN KEY (idUser) REFERENCES users(idUser)
    ) ENGINE = InnoDB,
    CHARSET = utf8;

CREATE TABLE
    message_reads (
        idMessageRead int(11) NOT NULL AUTO_INCREMENT,
        idMessage int(11) NOT NULL,
        idUser int(11) NOT NULL,
        timestamp timestamp NOT NULL,
        PRIMARY KEY (idMessageRead),
        KEY idMessage (idMessage),
        KEY idUser (`idUser`),
        CONSTRAINT PK_MESSAGES_READS FOREIGN KEY (idMessage) REFERENCES messages (idMessage),
        CONSTRAINT FK_MESSAGES_READS FOREIGN KEY (idUser) REFERENCES users (idUser)
    ) ENGINE = InnoDB,
    CHARSET = utf8;

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
        prenom,
        nom,
        email,
        hashedPass,
        metier,
        pp
    )
VALUES (
        1,
        'John',
        'Doe',
        'johndoe@email.com',
        '123',
        'Développeur Web',
        'John-Doe.jpg'
    ), (
        1,
        'Alice',
        'Smith',
        'alicesmith@email.com',
        '123',
        'Administrateur Systèmes',
        'Alice-Smith.jpg'
    ), (
        1,
        'Jane',
        'Doe',
        'janedoe@email.com',
        '123',
        'Développeur Full-Stack',
        'default.png'
    ), (
        1,
        'Bob',
        'Smith',
        'bobsmith@email.com',
        '123',
        'Développeur Front-End',
        'default.png'
    ), (
        1,
        'Michael',
        'Clark',
        'michaelclark@email.com',
        '123',
        'Développeur Back-End',
        'Michael-Clark.jpg'
    ), (
        1,
        'Ella',
        'Davis',
        'elladavis@email.com',
        '123',
        'Développeur Full-Stack',
        'Ella-Davis.jpg'
    ), (
        1,
        'Robert',
        'Johnson',
        'robertjohnson@email.com',
        '123',
        'Développeur Front-End',
        'Robert-Jonhson.jpg'
    ), (
        1,
        'Alexys',
        'Laurent',
        'alexyslaurent@email.com',
        '123',
        'Chef de projet',
        'Alexys-Laurent.jpg'
    );

INSERT INTO
    users (
        idEntreprise,
        nom,
        prenom,
        email,
        hashedPass,
        metier,
        pp,
        theme,
        statut
    )
VALUES (
        1,
        'Durand',
        'Sophie',
        'sophiedurand@email.com',
        '123',
        'Responsable RH',
        'default.png',
        'dark',
        'En ligne'
    ), (
        1,
        'Martin',
        'Louis',
        'louismartin@email.com',
        '123',
        'Développeur Full-Stack',
        'default.png',
        'dark',
        'Occupé'
    ), (
        1,
        'Bernard',
        'Emilie',
        'emiliebernard@email.com',
        '123',
        'Développeur Back-End',
        'default.png',
        'dark',
        'Absent'
    ), (
        1,
        'Petit',
        'Thomas',
        'thomaspetit@email.com',
        '123',
        'Manager',
        'default.png',
        'dark',
        'En ligne'
    ), (
        1,
        'Leroy',
        'Julie',
        'julieleroy@email.com',
        '123',
        'Directeur Technique',
        'default.png',
        'dark',
        'Occupé'
    ), (
        1,
        'Moreau',
        'Nicolas',
        'nicolasmoreau@email.com',
        '123',
        'Analyste Sécurité',
        'default.png',
        'dark',
        'Hors ligne'
    ), (
        1,
        'Simon',
        'Laura',
        'laurasimon@email.com',
        '123',
        'Ingénieur Système',
        'default.png',
        'dark',
        'En ligne'
    ), (
        1,
        'Lefebvre',
        'Maxime',
        'maximelefebvre@email.com',
        '123',
        'Designer UX/UI',
        'default.png',
        'dark',
        'Absent'
    ), (
        1,
        'Michel',
        'Clara',
        'claramichel@email.com',
        '123',
        'Spécialiste SEO',
        'default.png',
        'dark',
        'Occupé'
    ), (
        1,
        'Garcia',
        'Alexandre',
        'alexandregarcia@email.com',
        '123',
        'Chef de Projet Digital',
        'default.png',
        'dark',
        'Hors ligne'
    );

INSERT INTO
    users (
        idEntreprise,
        nom,
        prenom,
        email,
        hashedPass,
        metier,
        pp,
        theme,
        statut
    )
VALUES (
        1,
        'Dupont',
        'Marie',
        'mariedupont@email.com',
        '123',
        'Chargée de Recrutement',
        'default.png',
        'dark',
        'En ligne'
    ), (
        1,
        'Lopez',
        'David',
        'davidlopez@email.com',
        '123',
        'Analyste Financier',
        'default.png',
        'dark',
        'Absent'
    ), (
        1,
        'Girard',
        'Anne',
        'annegirard@email.com',
        '123',
        'Responsable Commercial',
        'default.png',
        'dark',
        'En ligne'
    ), (
        1,
        'Roux',
        'Julien',
        'julienroux@email.com',
        '123',
        'Consultant IT',
        'default.png',
        'dark',
        'Occupé'
    ), (
        1,
        'Fournier',
        'Élise',
        'elisefournier@email.com',
        '123',
        'Responsable Marketing',
        'default.png',
        'dark',
        'Absent'
    ), (
        1,
        'Morel',
        'Pierre',
        'pierremorel@email.com',
        '123',
        'Expert Cyber-sécurité',
        'default.png',
        'dark',
        'En ligne'
    ), (
        1,
        'Laurent',
        'Stéphanie',
        'stephanielaurent@email.com',
        '123',
        'Directrice Artistique',
        'default.png',
        'dark',
        'Occupé'
    ), (
        1,
        'Simon',
        'Éric',
        'ericsimon@email.com',
        '123',
        'Responsable de Production',
        'default.png',
        'dark',
        'Hors ligne'
    ), (
        1,
        'Michel',
        'Patricia',
        'patriciamichel@email.com',
        '123',
        'Coach Agile',
        'default.png',
        'dark',
        'En ligne'
    ), (
        1,
        'Lefevre',
        'Brice',
        'bricelefevre@email.com',
        '123',
        'Architecte Logiciel',
        'default.png',
        'dark',
        'Absent'
    );

-- Entreprise 2 (Data Systems)

INSERT INTO
    users (
        idEntreprise,
        prenom,
        nom,
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
        prenom,
        nom,
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

-- Insert d'un token test

INSERT INTO
    token (idUser, token, expireAt)
VALUES (
        1,
        'test',
        '2031-01-01 00:00:00'
    );

-- Insertion des discussions

INSERT INTO discussions VALUES (1,1), (2,2), (3,3);

-- Insertion des utilisateurs dans les discussions

-- Discussion 1

INSERT INTO discussions_users VALUES (1, 1), (2, 1);

-- Discussion 2

INSERT INTO discussions_users VALUES (3, 2), (4, 2);

-- Discussion 3

INSERT INTO discussions_users VALUES (5, 3);

-- Insertion des messages

-- Discussion 1

INSERT INTO
    messages (idDiscussion, idUser, content)
VALUES (
        1,
        1,
        'Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici !  Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, '
    ), (
        1,
        2,
        'Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici !  Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour,  !'
    ), (
        1,
        1,
        'Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici !  Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour,  !'
    ), (
        1,
        1,
        'Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici !  Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, '
    ), (
        1,
        2,
        'Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici !  Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour,  !'
    ), (
        1,
        1,
        'Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici !  Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour,  !'
    ), (
        1,
        1,
        'Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici !  Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, '
    ), (
        1,
        2,
        'Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici !  Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour,  !'
    ), (
        1,
        1,
        'Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici !  Bonjour, je suis nouveau ici ! Bonjour, je suis nouveau ici ! Bonjour,  !'
    ), (1, 2, 'De rien !'), (1, 1, 'A bientôt !'), (1, 1, 'A bientôt !'), (1, 1, 'A bientôt !'), (1, 2, 'A bientôt !'), (1, 1, 'A bientôt !'), (1, 2, 'A bientôt !'), (1, 1, 'A bientôt !'), (1, 2, 'A bientôt !'), (1, 1, 'A bientôt !'), (1, 2, 'A bientôt !'), (1, 1, 'A bientôt !'), (1, 2, 'A bientôt !'), (1, 1, 'A bientôt !'), (1, 2, 'A bientôt !'), (1, 1, 'A bientôt !'), (1, 2, 'A bientôt !');

-- Discussion 2

INSERT INTO
    messages (idDiscussion, idUser, content)
VALUES (
        2,
        3,
        'Bonjour, je suis nouveau ici !'
    ), (2, 4, 'Bienvenue !'), (2, 3, 'Merci !');

-- Discussion 3

INSERT INTO
    messages (idDiscussion, idUser, content)
VALUES (
        3,
        5,
        'Bonjour, je suis nouveau ici !'
    ), (3, 5, 'Merci !');