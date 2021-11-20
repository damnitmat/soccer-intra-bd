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

CREATE VIEW "PresenceFact" AS
    SELECT "matricule",
           "prenom",
           "Joueur"."nom" AS "nomJoueur",
           "dateMatch",
           "nomType",
           "nomEquipe",
           "nomDivision",
           NS."nom" AS "nomSaison"
FROM "Joueur"
JOIN "Membre" M on "Joueur"."noJoueur" = M."noJoueur"
JOIN "Equipe" E on M."noEquipe" = E."noEquipe"
JOIN "Saison" S on S."noSaison" = E."noSaison"
JOIN "NomSaison" NS ON NS."noNomSaison" = S."noNomSaison"
JOIN "Division" D on D."noDivision" = E."noDivision"
JOIN "Presence" P on "Joueur"."noJoueur" = P."noJoueur"
JOIN "MatchDeSoccer" MDS on MDS."noMatch" = P."noMatch"
JOIN "TypeDeMatch" TDM on TDM."noType" = MDS."noType"
;

CREATE VIEW "RemplacementFact" AS
    SELECT "prenom",
           "Joueur"."nom" AS "nomJoueur",
           "dateMatch",
           "nomType",
           "nomEquipe",
           "nomDivision",
           NS."nom" AS "nomSaison"
FROM "Joueur"
JOIN "Remplace" R on "Joueur"."noJoueur" = R."noJoueur"
JOIN "Equipe" E on R."noEquipe" = E."noEquipe"
JOIN "Saison" S on S."noSaison" = E."noSaison"
JOIN "NomSaison" NS ON NS."noNomSaison" = S."noNomSaison"
JOIN "Division" D on D."noDivision" = E."noDivision"
JOIN "MatchDeSoccer" MDS on MDS."noMatch" = R."noMatch"
JOIN "TypeDeMatch" TDM on TDM."noType" = MDS."noType"
;

CREATE VIEW EquipeIndisponibiliteFact AS
    SELECT "nomEquipe",
           "Equipe"."noIndisponibilite",
           "NomSaison"."nom" AS "nomSaison",
           "Division"."nom" AS "nomDivision"
    FROM "Equipe"
    JOIN "Indisponibilite" on "Indisponibilite"."noIndisponibilite" = "Equipe"."noIndisponibilite"
    JOIN "Saison" on "Saison"."noSaison" = "Equipe"."noSaison"
    JOIN "NomSaison" on "NomSaison"."noNomSaison" = "Saison"."noNomSaison"
    JOIN "Division" on "Division"."noDivision" = "Equipe"."noDivision";

CREATE VIEW HoraireMatchFact AS
    SELECT "Equipe"."nomEquipe",
           "dateMatch",
           "TypeDeMatch"."nomType",
           "NomSaison"."nom" AS "nomSaison"
    FROM "MatchDeSoccer"
    JOIN "Saison" on "Saison"."noSaison" = "Equipe"."noSaison"
    JOIN "NomSaison" on "NomSaison"."noNomSaison" = "Saison"."noNomSaison"
    JOIN "TypeDeMatch" on "TypeDeMatch"."noType" = "MatchDeSoccer"."noType";