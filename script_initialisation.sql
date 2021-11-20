/*
 Pour demarrer la BD dans un container Docker:
 docker run -e POSTGRES_USER=docker -e POSTGRES_PASSWORD=docker -e POSTGRES_DB=docker -p 5432:5432 library/postgres
 - Assurez vous d'avoir démarré votre docker engine
 - Vous pouvez utilsier un IDE comme DataGrip pour connecter la BD
 */

/**********
    TABLES
 *********/
CREATE TABLE "Division"(
    "noDivision" SERIAL,
    "nomDivision" VARCHAR(10) NOT NULL,
    PRIMARY KEY("noDivision")
);

CREATE TABLE "Joueur"(
    "noJoueur" SERIAL,
    "nom" VARCHAR(50) NOT NULL,
    "prenom" VARCHAR(50) NOT NULL,
    "matricule" INT,
    "sexe" VARCHAR(1) NOT NULL,
    "courriel" VARCHAR(80) NOT NULL,
    PRIMARY KEY("noJoueur")
);

CREATE TABLE "TypeDeMatch"(
    "noType" SERIAL,
    "nomType" VARCHAR(50) NOT NULL,
    PRIMARY KEY("noType")
);

CREATE TABLE "Indisponibilite"(
    "noIndisponibilite" SERIAL,
    "dimanche" BOOLEAN,
    "lundi" BOOLEAN,
    "mardi" BOOLEAN,
    "mercredi" BOOLEAN,
    "jeudi" BOOLEAN,
    "vendredi" BOOLEAN,
    "samedi" BOOLEAN,
    PRIMARY KEY("noIndisponibilite")
);

CREATE TABLE "NomSaison"(
    "noNomSaison" SERIAL,
    "nom" VARCHAR(50) NOT NULL,
    PRIMARY KEY("noNomSaison")
);

CREATE TABLE "Saison"(
    "noSaison" SERIAL,
    "dateDebut" DATE NOT NULL,
    "dateFin" DATE NOT NULL,
    "noNomSaison" INT NOT NULL,
    PRIMARY KEY("noSaison"),
    FOREIGN KEY("noNomSaison") REFERENCES "NomSaison"("noNomSaison")
);

CREATE TABLE "Equipe"(
    "noEquipe" SERIAL,
    "nomEquipe" VARCHAR(50) NOT NULL,
    "noIndisponibilite" INT NOT NULL,
    "noDivision" INT NOT NULL,
    "noSaison" INT NOT NULL,
    "noCapitaine" INT NOT NULL,
    PRIMARY KEY("noEquipe"),
    FOREIGN KEY("noIndisponibilite") REFERENCES "Indisponibilite"("noIndisponibilite"),
    FOREIGN KEY("noDivision") REFERENCES "Division"("noDivision"),
    FOREIGN KEY("noSaison") REFERENCES "Saison"("noSaison"),
    FOREIGN KEY("noCapitaine") REFERENCES "Joueur"("noJoueur")
);

/* on definit une representation d'un entier non signé */
CREATE DOMAIN uint2 AS int4
   CHECK(VALUE >= 0 AND VALUE < 65536);

CREATE TABLE "MatchDeSoccer"(
    "noMatch" SERIAL,
    "dateMatch" DATE,
    "scoreEquipeVerte" uint2 NOT NULL,
    "scoreEquipeJaune" uint2 NOT NULL,
    "noEquipeVerte" INT NOT NULL,
    "noEquipeJaune" INT NOT NULL,
    "noType" INT NOT NULL,
    PRIMARY KEY("noMatch"),
    FOREIGN KEY("noEquipeVerte") REFERENCES "Equipe"("noEquipe"),
    FOREIGN KEY("noEquipeJaune") REFERENCES "Equipe"("noEquipe"),
    FOREIGN KEY("noType") REFERENCES "TypeDeMatch"("noType")
);

CREATE TABLE "Facture"(
    "noFacture" SERIAL,
    "montant" DOUBLE PRECISION NOT NULL,
    "datePaiement" DATE NOT NULL,
    "noEquipe" INT NOT NULL,
    PRIMARY KEY("noFacture"),
    FOREIGN KEY("noEquipe") REFERENCES "Equipe"("noEquipe")
);

CREATE TABLE "Membre"(
    "noEquipe" INT NOT NULL,
    "noJoueur" INT NOT NULL,
    PRIMARY KEY("noEquipe", "noJoueur"),
    FOREIGN KEY("noEquipe") REFERENCES "Equipe"("noEquipe"),
    FOREIGN KEY("noJoueur") REFERENCES "Joueur"("noJoueur")
);

CREATE TABLE "Presence"(
    "noJoueur" INT NOT NULL,
    "noMatch" INT NOT NULL,
    PRIMARY KEY("noJoueur", "noMatch"),
    FOREIGN KEY("noJoueur") REFERENCES "Joueur"("noJoueur"),
    FOREIGN KEY("noMatch") REFERENCES "MatchDeSoccer"("noMatch")
);

CREATE TABLE "Remplace"(
    "noEquipe" INT NOT NULL,
    "noJoueur" INT NOT NULL,
    "noMatch" INT NOT NULL,
    PRIMARY KEY("noEquipe", "noJoueur", "noMatch"),
    FOREIGN KEY("noEquipe") REFERENCES "Equipe"("noEquipe"),
    FOREIGN KEY("noJoueur") REFERENCES "Joueur"("noJoueur"),
    FOREIGN KEY("noMatch") REFERENCES "MatchDeSoccer"("noMatch")
);


/**********
    VIEWS
 *********/
CREATE VIEW "PaiementEquipeFact" AS
    SELECT "nomEquipe",
           "nomDivision",
           NS."nom" AS "nomSaison",
           "dateDebut" AS "debutSaison",
           "dateFin" AS "finSaison",
           "datePaiement",
           "montant"
    FROM "Equipe"
    JOIN "Facture" ON "Equipe"."noEquipe" = "Facture"."noEquipe"
    JOIN "Saison" ON "Equipe"."noSaison" = "Saison"."noSaison"
    JOIN "NomSaison" NS ON NS."noNomSaison" = "Saison"."noNomSaison"
    JOIN "Division" ON "Equipe"."noDivision" = "Division"."noDivision"
;

CREATE VIEW "InscriptionFact" AS
    SELECT "matricule",
           "prenom",
           "Joueur"."nom" AS "nomJoueur",
           "nomEquipe", NS."nom" AS "nomSaison",
           "nomDivision",
           "dateDebut" AS "debutSaison",
           "dateFin" AS "finSaison"
    FROM "Joueur"
    JOIN "Equipe" ON "Joueur"."noJoueur" = "Equipe"."noCapitaine"
    JOIN "Saison" ON "Equipe"."noSaison" = "Saison"."noSaison"
    JOIN "NomSaison" NS ON NS."noNomSaison" = "Saison"."noNomSaison"
    JOIN "Division" ON "Equipe"."noDivision" = "Division"."noDivision"
;


CREATE VIEW "SerieJoueurPresenceFact" AS
WITH nombreMatchsJoueur AS
(   SELECT "Joueur"."noJoueur" AS IDJOUEUR, "nom", "prenom", COUNT("noMatch") as NombreMatchs,"matricule","sexe","courriel"
    FROM "Joueur"
    LEFT JOIN "Presence" P on "Joueur"."noJoueur" = P."noJoueur"
    GROUP BY IDJOUEUR
)
SELECT *
FROM nombreMatchsJoueur
WHERE NombreMatchs >= 5
;

CREATE VIEW "SerieRemplacantPresenceFact" AS
WITH nombreMatchsRemplacant AS
(   SELECT "Joueur"."noJoueur" AS IDJOUEUR, "nom" , "prenom", COUNT("noMatch") as NombreMatchs,"matricule","sexe","courriel"
    FROM "Joueur"
    LEFT JOIN "Remplace" R on "Joueur"."noJoueur" = R."noJoueur"
    GROUP BY IDJOUEUR
)
SELECT *
FROM nombreMatchsRemplacant
WHERE NombreMatchs >= 5
;
