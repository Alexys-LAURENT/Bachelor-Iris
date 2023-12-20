drop database if exists syncpro;

CREATE DATABASE syncpro;

use syncpro;

-- BASE

Create table
    secteurs(
        idSecteur int not null auto_increment,
        nom VARCHAR(150) not null,
        constraint PK_SECTEUR PRIMARY KEY(idSecteur)
    ) engine = innodb,
    charset = utf8;

Create table
    entreprises(
        idEntreprise int not null auto_increment,
        idSecteur int not null,
        nom VARCHAR(50) not null,
        adresse VARCHAR(50) not null,
        codePostal VARCHAR(50) not null,
        ville VARCHAR(50) not null,
        siret VARCHAR(50) not null,
        constraint PK_ENTREPRISES PRIMARY KEY(idEntreprise),
        constraint FK_ENTREPRISES_SECTEURS FOREIGN KEY(idSecteur) REFERENCES secteurs(idSecteur)
    ) engine = innodb,
    charset = utf8;

Create table
    supports(
        idSupport int not null,
        qualification VARCHAR(150) not null,
        constraint PK_SUPPORT PRIMARY KEY(idSupport)
    ) engine = innodb,
    charset = utf8;

Create table
    managers(
        idManager int not null,
        constraint PK_MANAGER PRIMARY KEY(idManager)
    ) engine = innodb,
    charset = utf8;

create table
    admins(
        idAdmin int not null,
        role enum('Super Admin', 'Admin') not null,
        constraint PK_ADMIN PRIMARY KEY(idAdmin)
    ) engine = innodb,
    charset = utf8;

create table
    users(
        idUser int NOT NULL auto_increment,
        idEntreprise int not null,
        idManager int,
        nom VARCHAR(50) NOT NULL,
        prenom VARCHAR(50) NOT null,
        email varchar(50) not null,
        hashedPass VARCHAR(50) NOT NULL,
        metier VARCHAR(50) NOT NULL,
        pp VARCHAR(255) DEFAULT 'default.webp',
        theme VARCHAR(5) NOT NULL DEFAULT 'dark',
        statut enum(
            'Absent',
            'En ligne',
            'Occupé',
            'Hors ligne'
        ) NOT NULL DEFAULT 'Hors ligne',
        constraint PK_USER PRIMARY KEY(idUser),
        constraint FK_USER_ENTREPRISE FOREIGN KEY(idEntreprise) REFERENCES entreprises(idEntreprise),
        constraint FK_USER_MANAGER FOREIGN KEY(idManager) REFERENCES managers(idManager)
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

-- CHATSPHERE

create table
    discussions(
        idDiscussion int not null auto_increment,
        nom varchar(255),
        createdBy int,
        constraint PK_DISCUSSIONS PRIMARY KEY(idDiscussion),
        constraint FK_DISCUSSIONS_USER FOREIGN KEY(createdBy) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

create table
    discussions_users (
        idUser int not null,
        idDiscussion int not null,
        constraint PK_DISCUSSIONS_USER PRIMARY KEY(idUser, idDiscussion),
        constraint FK_DISCUSSIONS_USER_USER FOREIGN KEY(idUser) REFERENCES users(idUser),
        constraint FK_DISCUSSIONS_USER_DISCUSSION FOREIGN KEY(idDiscussion) REFERENCES discussions(idDiscussion) ON DELETE CASCADE
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
        constraint FK_MESSAGES_DISCUSSION FOREIGN KEY(idDiscussion) REFERENCES discussions(idDiscussion) ON DELETE CASCADE,
        constraint FK_MESSAGES_USER FOREIGN KEY(idUser) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

CREATE TABLE
    message_reads (
        idMessageRead int(11) NOT NULL AUTO_INCREMENT,
        idMessage int(11) NOT NULL,
        idUser int(11) NOT NULL,
        timestamp timestamp NOT NULL,
        PRIMARY KEY (idMessageRead),
        CONSTRAINT FK_MESSAGES_READS FOREIGN KEY (idMessage) REFERENCES messages (idMessage) ON DELETE CASCADE,
        CONSTRAINT FK_MESSAGES_READS2 FOREIGN KEY (idUser) REFERENCES users (idUser) ON DELETE CASCADE
    ) ENGINE = InnoDB,
    CHARSET = utf8;

-- NoteFlow

Create table
    categories(
        idCategorie int not null auto_increment,
        idUser int not null,
        libelle VARCHAR(255) not null,
        hex VARCHAR(255) not null,
        constraint PK_CATEGORIES PRIMARY KEY(idCategorie),
        constraint FK_CATEGORIES_USER FOREIGN KEY(idUser) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

Create table
    notes(
        idNote int not null auto_increment,
        idUser int not null,
        idCategorie int,
        titre VARCHAR(255) not null,
        isFavorite BOOLEAN NOT NULL DEFAULT false,
        content longtext not null,
        timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        constraint PK_NOTES PRIMARY KEY(idNote),
        constraint FK_NOTES_USER FOREIGN KEY(idUser) REFERENCES users(idUser),
        constraint FK_NOTES_CATEGORIE FOREIGN KEY(idCategorie) REFERENCES categories(idCategorie)
    ) engine = innodb,
    charset = utf8;

CREATE TABLE
    SharedNotes (
        idShare INT AUTO_INCREMENT,
        idNote INT,
        idOwner INT,
        idShared INT,
        permissions VARCHAR(255),
        PRIMARY KEY (idShare),
        FOREIGN KEY (idNote) REFERENCES notes(idNote),
        FOREIGN KEY (idOwner) REFERENCES users(idUser),
        FOREIGN KEY (idShared) REFERENCES users(idUser)
    );

-- TaskMate

Create table
    toDos(
        idToDo int not null auto_increment,
        idUser int not null,
        description VARCHAR(255) not null,
        timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        etat enum('En cours', 'Terminé') NOT NULL DEFAULT 'En cours',
        constraint PK_TODOS PRIMARY KEY(idToDo),
        constraint FK_TODOS_USER FOREIGN KEY(idUser) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

-- CloudNest

Create table
    dossiers(
        idDossier int not null auto_increment,
        idUser int not null,
        nom VARCHAR(255) not null,
        constraint PK_DOSSIERS PRIMARY KEY(idDossier),
        constraint FK_DOSSIERS_USER FOREIGN KEY(idUser) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

Create table
    fichiers(
        idFichier int not null auto_increment,
        idDossier int not null,
        nom VARCHAR(255) not null,
        constraint PK_FICHIERS PRIMARY KEY(idFichier),
        constraint FK_FICHIERS_DOSSIER FOREIGN KEY(idDossier) REFERENCES dossiers(idDossier)
    ) engine = innodb,
    charset = utf8;

Create table
    partages_dossiers(
        idPartageDossier int not null auto_increment,
        idDossier int not null,
        insertions BOOLEAN NOT NULL,
        modifications BOOLEAN NOT NULL,
        dateDebut TIMESTAMP NOT NULL,
        dateFin TIMESTAMP NOT NULL,
        constraint PK_PARTAGES_DOSSIERS PRIMARY KEY(idPartageDossier),
        constraint FK_PARTAGES_DOSSIERS_DOSSIER FOREIGN KEY(idDossier) REFERENCES dossiers(idDossier)
    ) engine = innodb,
    charset = utf8;

Create table
    partages_fichiers(
        idPartageFichier int not null auto_increment,
        idFichier int not null,
        dateDebut TIMESTAMP NOT NULL,
        dateFin TIMESTAMP NOT NULL,
        constraint PK_PARTAGES_FICHIERS PRIMARY KEY(idPartageFichier),
        constraint FK_PARTAGES_FICHIERS_FICHIER FOREIGN KEY(idFichier) REFERENCES fichiers(idFichier)
    ) engine = innodb,
    charset = utf8;

Create table
    partages_fichiers_users(
        idPartageFichier int not null,
        idUser int not null,
        constraint PK_PARTAGES_FICHIERS_USERS PRIMARY KEY(idPartageFichier, idUser),
        constraint FK_PARTAGES_FICHIERS_USERS_PARTAGE FOREIGN KEY(idPartageFichier) REFERENCES partages_fichiers(idPartageFichier),
        constraint FK_PARTAGES_FICHIERS_USERS_USER FOREIGN KEY(idUser) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

Create table
    partages_dossiers_users(
        idPartageDossier int not null,
        idUser int not null,
        constraint PK_PARTAGES_DOSSIERS_USERS PRIMARY KEY(idPartageDossier, idUser),
        constraint FK_PARTAGES_DOSSIERS_USERS_PARTAGE FOREIGN KEY(idPartageDossier) REFERENCES partages_dossiers(idPartageDossier),
        constraint FK_PARTAGES_DOSSIERS_USERS_USER FOREIGN KEY(idUser) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

-- HelpDesk

Create table
    applications(
        idApplication int not null auto_increment,
        nom VARCHAR(255) not null,
        constraint PK_APPLICATIONS PRIMARY KEY(idApplication)
    ) engine = innodb,
    charset = utf8;

Create table
    tickets(
        idTicket int not null auto_increment,
        idUser int not null,
        idApplication int not null,
        titre VARCHAR(255) not null,
        description longtext not null,
        etat enum('En cours', 'Terminé') NOT NULL DEFAULT 'En cours',
        constraint PK_TICKETS PRIMARY KEY(idTicket),
        constraint FK_TICKETS_USER FOREIGN KEY(idUser) REFERENCES users(idUser),
        constraint FK_TICKETS_APPLICATION FOREIGN KEY(idApplication) REFERENCES applications(idApplication)
    ) engine = innodb,
    charset = utf8;

Create table
    messages_tickets(
        idMessageTicket int not null auto_increment,
        idUser int not null,
        idTicket int not null,
        timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        content longtext not null,
        constraint PK_MESSAGES_TICKETS PRIMARY KEY(idMessageTicket),
        constraint FK_MESSAGES_TICKETS_USER FOREIGN KEY(idUser) REFERENCES users(idUser),
        constraint FK_MESSAGES_TICKETS_TICKET FOREIGN KEY(idTicket) REFERENCES tickets(idTicket)
    ) engine = innodb,
    charset = utf8;

-- Sprintify

Create table
    clients(
        idClient int not null auto_increment,
        nom VARCHAR(255) not null,
        siret VARCHAR(255) not null,
        constraint PK_CLIENTS PRIMARY KEY(idClient)
    ) engine = innodb,
    charset = utf8;

Create table
    projets(
        idProjet int not null auto_increment,
        idClient int not null,
        idManager int not null,
        titre VARCHAR(255) not null,
        dateDebut TIMESTAMP NOT NULL,
        dateFin TIMESTAMP NOT NULL,
        constraint PK_PROJETS PRIMARY KEY(idProjet),
        constraint FK_PROJETS_CLIENT FOREIGN KEY(idClient) REFERENCES clients(idClient),
        constraint FK_PROJETS_MANAGER FOREIGN KEY(idManager) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

Create table
    sprints(
        idSprint int not null auto_increment,
        idProjet int not null,
        titre VARCHAR(255) not null,
        dateDebut TIMESTAMP NOT NULL,
        dateFin TIMESTAMP NOT NULL,
        constraint PK_SPRINTS PRIMARY KEY(idSprint),
        constraint FK_SPRINTS_PROJET FOREIGN KEY(idProjet) REFERENCES projets(idProjet)
    ) engine = innodb,
    charset = utf8;

Create table
    sprints_users(
        idSprint int not null,
        idUser int not null,
        constraint PK_SPRINTS_USERS PRIMARY KEY(idSprint, idUser),
        constraint FK_SPRINTS_USERS_SPRINT FOREIGN KEY(idSprint) REFERENCES sprints(idSprint),
        constraint FK_SPRINTS_USERS_USER FOREIGN KEY(idUser) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

Create table
    missions(
        idMission int not null auto_increment,
        idSprint int not null,
        titre VARCHAR(255) not null,
        etat enum(
            'En cours',
            'Terminé',
            'Bloqué',
            'A faire'
        ) NOT NULL DEFAULT 'A faire',
        constraint PK_MISSIONS PRIMARY KEY(idMission),
        constraint FK_MISSIONS_SPRINT FOREIGN KEY(idSprint) REFERENCES sprints(idSprint)
    ) engine = innodb,
    charset = utf8;

Create table
    missions_users(
        idMission int not null,
        idUser int not null,
        constraint PK_MISSIONS_USERS PRIMARY KEY(idMission, idUser),
        constraint FK_MISSIONS_USERS_MISSION FOREIGN KEY(idMission) REFERENCES missions(idMission),
        constraint FK_MISSIONS_USERS_USER FOREIGN KEY(idUser) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

-- Insertion des secteurs

INSERT INTO secteurs (nom)
VALUES ('Informatique'), ('Finance'), ('Marketing'), ('Communication'), ('Ressources Humaines'), ('Juridique'), ('Santé'), ('Enseignement'), ('Commerce'), ('Transport'), ('Tourisme'), ('Hôtellerie'), ('Restauration'), ('Immobilier'), ('BTP'), ('Industrie'), ('Agriculture'), ('Artisanat'), ('Autre');

-- Insertion des entreprises

INSERT INTO
    entreprises (
        idSecteur,
        nom,
        adresse,
        codePostal,
        ville,
        siret
    )
VALUES (
        1,
        'Tech Solutions',
        '123 Main Street',
        '12345',
        'Techville',
        'SIRET12345'
    ), (
        1,
        'Data Systems',
        '456 Oak Avenue',
        '67890',
        'Datatown',
        'SIRET67890'
    ), (
        1,
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
        'John-Doe.webp'
    ), (
        1,
        'Alice',
        'Smith',
        'alicesmith@email.com',
        '123',
        'Administrateur Systèmes',
        'Alice-Smith.webp'
    ), (
        1,
        'Jane',
        'Doe',
        'janedoe@email.com',
        '123',
        'Développeur Full-Stack',
        'default.webp'
    ), (
        1,
        'Bob',
        'Smith',
        'bobsmith@email.com',
        '123',
        'Développeur Front-End',
        'default.webp'
    ), (
        1,
        'Michael',
        'Clark',
        'michaelclark@email.com',
        '123',
        'Développeur Back-End',
        'Michael-Clark.webp'
    ), (
        1,
        'Ella',
        'Davis',
        'elladavis@email.com',
        '123',
        'Développeur Full-Stack',
        'Ella-Davis.webp'
    ), (
        1,
        'Robert',
        'Johnson',
        'robertjohnson@email.com',
        '123',
        'Développeur Front-End',
        'Robert-Jonhson.webp'
    ), (
        1,
        'Alexys',
        'Laurent',
        'alexyslaurent@email.com',
        '123',
        'Chef de projet',
        'Alexys-Laurent.webp'
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
        'default.webp',
        'dark',
        'En ligne'
    ), (
        1,
        'Martin',
        'Louis',
        'louismartin@email.com',
        '123',
        'Développeur Full-Stack',
        'default.webp',
        'dark',
        'Occupé'
    ), (
        1,
        'Bernard',
        'Emilie',
        'emiliebernard@email.com',
        '123',
        'Développeur Back-End',
        'default.webp',
        'dark',
        'Absent'
    ), (
        1,
        'Petit',
        'Thomas',
        'thomaspetit@email.com',
        '123',
        'Manager',
        'default.webp',
        'dark',
        'En ligne'
    ), (
        1,
        'Leroy',
        'Julie',
        'julieleroy@email.com',
        '123',
        'Directeur Technique',
        'default.webp',
        'dark',
        'Occupé'
    ), (
        1,
        'Moreau',
        'Nicolas',
        'nicolasmoreau@email.com',
        '123',
        'Analyste Sécurité',
        'default.webp',
        'dark',
        'Hors ligne'
    ), (
        1,
        'Simon',
        'Laura',
        'laurasimon@email.com',
        '123',
        'Ingénieur Système',
        'default.webp',
        'dark',
        'En ligne'
    ), (
        1,
        'Lefebvre',
        'Maxime',
        'maximelefebvre@email.com',
        '123',
        'Designer UX/UI',
        'default.webp',
        'dark',
        'Absent'
    ), (
        1,
        'Michel',
        'Clara',
        'claramichel@email.com',
        '123',
        'Spécialiste SEO',
        'default.webp',
        'dark',
        'Occupé'
    ), (
        1,
        'Garcia',
        'Alexandre',
        'alexandregarcia@email.com',
        '123',
        'Chef de Projet Digital',
        'default.webp',
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
        'default.webp',
        'dark',
        'En ligne'
    ), (
        1,
        'Lopez',
        'David',
        'davidlopez@email.com',
        '123',
        'Analyste Financier',
        'default.webp',
        'dark',
        'Absent'
    ), (
        1,
        'Girard',
        'Anne',
        'annegirard@email.com',
        '123',
        'Responsable Commercial',
        'default.webp',
        'dark',
        'En ligne'
    ), (
        1,
        'Roux',
        'Julien',
        'julienroux@email.com',
        '123',
        'Consultant IT',
        'default.webp',
        'dark',
        'Occupé'
    ), (
        1,
        'Fournier',
        'Élise',
        'elisefournier@email.com',
        '123',
        'Responsable Marketing',
        'default.webp',
        'dark',
        'Absent'
    ), (
        1,
        'Morel',
        'Pierre',
        'pierremorel@email.com',
        '123',
        'Expert Cyber-sécurité',
        'default.webp',
        'dark',
        'En ligne'
    ), (
        1,
        'Laurent',
        'Stéphanie',
        'stephanielaurent@email.com',
        '123',
        'Directrice Artistique',
        'default.webp',
        'dark',
        'Occupé'
    ), (
        1,
        'Simon',
        'Éric',
        'ericsimon@email.com',
        '123',
        'Responsable de Production',
        'default.webp',
        'dark',
        'Hors ligne'
    ), (
        1,
        'Michel',
        'Patricia',
        'patriciamichel@email.com',
        '123',
        'Coach Agile',
        'default.webp',
        'dark',
        'En ligne'
    ), (
        1,
        'Lefevre',
        'Brice',
        'bricelefevre@email.com',
        '123',
        'Architecte Logiciel',
        'default.webp',
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
        'H4d58uy484k8ua4da4dsqdiazi1d2a31d5za15da',
        '2031-01-01 00:00:00'
    ), (
        2,
        'zdaz78d78zacd1za8c74d8917a484s8ax247dza',
        '2031-01-01 00:00:00'
    );

-- Insertion des discussions

-- Discussion 1

INSERT INTO discussions VALUES (1, null, null);

-- Discussion 2

INSERT INTO discussions VALUES (2, 'équipe 1', 1);

-- Discussion 3

INSERT INTO discussions VALUES (3, null, null);

-- Insertion des utilisateurs dans les discussions

-- Discussion 1

INSERT INTO discussions_users VALUES (1, 1), (2, 1);

-- Discussion 2

INSERT INTO discussions_users VALUES (3, 2), (4, 2), (5, 2), (1, 2);

-- Discussion 3

INSERT INTO discussions_users VALUES (5, 3), (1, 3);

-- Insertion des messages

-- Discussion 1

INSERT INTO
    messages (idDiscussion, idUser, content)
VALUES (
        1,
        1,
        'Bonjour, comment ça va ?'
    ), (1, 2, "Salut, ça va et toi ?"), (1, 1, 'Ça va bien merci !'), (1, 2, 'Super !'), (
        1,
        1,
        'Tu as vu le nouveau projet ?'
    ), (
        1,
        2,
        'Oui, il a l\'air super !'
    ), (
        1,
        1,
        'Oui, j\'ai hâte de commencer !'
    ), (1, 2, 'Moi aussi !');

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
        'Je viens tout juste de finir le projet !'
    );

-- Insertion des categories de notes

insert into categories VALUES (1, 1, "Perso", "#FF0000");

insert into categories VALUES (2, 1, "Ecole", "#00FF00");

insert into categories VALUES (3, 1, "Travail", "#0000FF");

-- Insertion des notes

insert into notes
values (
        1,
        1,
        1,
        "Ma première note",
        false,
        "'{\"time\":1702981067980,\"blocks\":[],\"version\":\"2.28.2\"}'",
        CURRENT_TIMESTAMP
    );

insert into notes
values (
        2,
        1,
        1,
        "Ma deuxième note",
        true,
        "'{\"time\":1702981067980,\"blocks\":[],\"version\":\"2.28.2\"}'",
        CURRENT_TIMESTAMP
    );

insert into notes
values (
        3,
        1,
        1,
        "Ma troisième note",
        false,
        "'{\"time\":1702981067980,\"blocks\":[],\"version\":\"2.28.2\"}'",
        CURRENT_TIMESTAMP
    );