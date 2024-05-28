drop database if exists carnet_SD_24 ;
create database carnet_SD_24;
use carnet_SD_24;

CREATE TABLE contact (
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR ( 50 ),
    prenom VARCHAR(50),
    email VARCHAR(50),
    PRIMARY KEY (id)
);