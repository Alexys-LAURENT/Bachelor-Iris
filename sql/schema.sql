-- Schema only. No exported user or business data.
drop database if exists syncpro;

CREATE DATABASE syncpro;

use syncpro;

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
        FOREIGN KEY (idNote) REFERENCES notes(idNote) ON DELETE CASCADE,
        FOREIGN KEY (idOwner) REFERENCES users(idUser),
        FOREIGN KEY (idShared) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

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

Create table
    dossiers(
        idDossier VARCHAR(255) not null,
        idUser int not null,
        nom VARCHAR(255) not null,
        constraint PK_DOSSIERS PRIMARY KEY(idDossier),
        constraint FK_DOSSIERS_USER FOREIGN KEY(idUser) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

Create table
    fichiers(
        idFichier VARCHAR(255) not null,
        idUser int not null,
        idDossier VARCHAR(255),
        nom VARCHAR(255) not null,
        constraint PK_FICHIERS PRIMARY KEY(idFichier),
        constraint FK_FICHIERS_DOSSIER FOREIGN KEY(idDossier) REFERENCES dossiers(idDossier),
        constraint FK_FICHIERS_USER FOREIGN KEY(idUser) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

Create table
    partages_dossiers(
        idPartageDossier VARCHAR(255) not null,
        idDossier VARCHAR(255) not null,
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
        idPartageFichier VARCHAR(255) not null,
        idFichier VARCHAR(255) not null,
        dateDebut TIMESTAMP NOT NULL,
        dateFin TIMESTAMP NOT NULL,
        constraint PK_PARTAGES_FICHIERS PRIMARY KEY(idPartageFichier),
        constraint FK_PARTAGES_FICHIERS_FICHIER FOREIGN KEY(idFichier) REFERENCES fichiers(idFichier)
    ) engine = innodb,
    charset = utf8;

Create table
    partages_fichiers_users(
        idPartageFichier VARCHAR(255) not null,
        idUser int not null,
        constraint PK_PARTAGES_FICHIERS_USERS PRIMARY KEY(idPartageFichier, idUser),
        constraint FK_PARTAGES_FICHIERS_USERS_PARTAGE FOREIGN KEY(idPartageFichier) REFERENCES partages_fichiers(idPartageFichier),
        constraint FK_PARTAGES_FICHIERS_USERS_USER FOREIGN KEY(idUser) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

Create table
    partages_dossiers_users(
        idPartageDossier VARCHAR(255) not null,
        idUser int not null,
        constraint PK_PARTAGES_DOSSIERS_USERS PRIMARY KEY(idPartageDossier, idUser),
        constraint FK_PARTAGES_DOSSIERS_USERS_PARTAGE FOREIGN KEY(idPartageDossier) REFERENCES partages_dossiers(idPartageDossier),
        constraint FK_PARTAGES_DOSSIERS_USERS_USER FOREIGN KEY(idUser) REFERENCES users(idUser)
    ) engine = innodb,
    charset = utf8;

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
