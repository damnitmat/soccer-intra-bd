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
(   SELECT "Joueur"."noJoueur" AS IDJOUEUR, "nom", "prenom","matricule","sexe","courriel", COUNT("noMatch") as NombreMatchs
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
(   SELECT "Joueur"."noJoueur" AS IDJOUEUR, "nom" , "prenom" ,"matricule","sexe","courriel", COUNT("noMatch") as NombreMatchs
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

CREATE VIEW "EquipeIndisponibiliteFact" AS
    SELECT "nomEquipe",
           "Equipe"."noIndisponibilite",
           "NomSaison"."nom" AS "nomSaison",
           "Division"."nom" AS "nomDivision"
    FROM "Equipe"
    JOIN "Indisponibilite" on "Indisponibilite"."noIndisponibilite" = "Equipe"."noIndisponibilite"
    JOIN "Saison" on "Saison"."noSaison" = "Equipe"."noSaison"
    JOIN "NomSaison" on "NomSaison"."noNomSaison" = "Saison"."noNomSaison"
    JOIN "Division" on "Division"."noDivision" = "Equipe"."noDivision";

CREATE VIEW "HoraireMatchFact" AS
    SELECT "Equipe"."nomEquipe",
           "dateMatch",
           "TypeDeMatch"."nomType",
           "NomSaison"."nom" AS "nomSaison"
    FROM "MatchDeSoccer"
    JOIN "Saison" on "Saison"."noSaison" = "Equipe"."noSaison"
    JOIN "NomSaison" on "NomSaison"."noNomSaison" = "Saison"."noNomSaison"
    JOIN "TypeDeMatch" on "TypeDeMatch"."noType" = "MatchDeSoccer"."noType";

/* Statistique Equipe */

CREATE VIEW "MatchDeSoccerGagnantFact" AS
SELECT "noMatch", "dateMatch", "noEquipeJaune" as "noEquipe", "scoreEquipeJaune" as "score", "nomEquipe", E."noDivision", S."noSaison", "dateDebut", "dateFin", NS."noNomSaison", NS."nom" as "nomSaison", D."nomDivision", TDM."nomType"
FROM "MatchDeSoccer" MS
        INNER JOIN "Equipe" E on E."noEquipe" = MS."noEquipeJaune"
        INNER JOIN "Saison" S on S."noSaison" = E."noSaison"
        INNER JOIN "NomSaison" NS on NS."noNomSaison" = S."noNomSaison"
        INNER JOIN "Division" D on D."noDivision" = E."noDivision"
        INNER JOIN "TypeDeMatch" TDM on TDM."noType" = MS."noType"
WHERE "scoreEquipeJaune" > "scoreEquipeVerte"
UNION
SELECT "noMatch", "dateMatch", "noEquipeVerte" as "noEquipe", "scoreEquipeVerte" as "score", "nomEquipe", E."noDivision", S."noSaison", "dateDebut", "dateFin", NS."noNomSaison", NS."nom" as "nomSaison", D."nomDivision", TDM."nomType"
FROM "MatchDeSoccer" MS
        INNER JOIN "Equipe" E on E."noEquipe" = MS."noEquipeVerte"
        INNER JOIN "Saison" S on S."noSaison" = E."noSaison"
        INNER JOIN "NomSaison" NS on NS."noNomSaison" = S."noNomSaison"
        INNER JOIN "Division" D on D."noDivision" = E."noDivision"
        INNER JOIN "TypeDeMatch" TDM on TDM."noType" = MS."noType"
WHERE "scoreEquipeVerte" > "scoreEquipeJaune";

CREATE VIEW "MatchDeSoccerPerdantFact" AS
    SELECT "noMatch", "dateMatch", "noEquipeVerte" as "noEquipe", "scoreEquipeVerte" as "score", "nomEquipe", E."noDivision", S."noSaison", "dateDebut", "dateFin", NS."noNomSaison", NS."nom" as "nomSaison", D."nomDivision", TDM."nomType"
    FROM "MatchDeSoccer" MS
        INNER JOIN "Equipe" E on E."noEquipe" = MS."noEquipeVerte"
        INNER JOIN "Saison" S on S."noSaison" = E."noSaison"
        INNER JOIN "NomSaison" NS on NS."noNomSaison" = S."noNomSaison"
        INNER JOIN "Division" D on D."noDivision" = E."noDivision"
        INNER JOIN "TypeDeMatch" TDM on TDM."noType" = MS."noType"
    WHERE "scoreEquipeJaune" > "scoreEquipeVerte"
    UNION
    SELECT "noMatch", "dateMatch", "noEquipeJaune" as "noEquipe", "scoreEquipeJaune" as "score", "nomEquipe", E."noDivision", S."noSaison", "dateDebut", "dateFin", NS."noNomSaison", NS."nom" as "nomSaison", D."nomDivision", TDM."nomType"
    FROM "MatchDeSoccer" MS
        INNER JOIN "Equipe" E on E."noEquipe" = MS."noEquipeJaune"
        INNER JOIN "Saison" S on S."noSaison" = E."noSaison"
        INNER JOIN "NomSaison" NS on NS."noNomSaison" = S."noNomSaison"
        INNER JOIN "Division" D on D."noDivision" = E."noDivision"
        INNER JOIN "TypeDeMatch" TDM on TDM."noType" = MS."noType"
    WHERE "scoreEquipeVerte" > "scoreEquipeJaune";

CREATE VIEW "StatistiqueEquipeFact" AS
    SELECT E."noEquipe", E."noDivision", E."nomEquipe", E."noCapitaine", E."noIndisponibilite", (STG."scoreTotal" + STP."scoreTotal") as "scoreTotal", "nombreVictoires", "nombreDefaites", ("nombreVictoires" + "nombreDefaites") as "nombreMatchs", S.*, NS."nom" as "nomSaison", D."nomDivision"
    FROM (SELECT "noEquipe", sum("score") as "scoreTotal", count("noEquipe") as "nombreVictoires"
            FROM "MatchDeSoccerGagnantFact"
            GROUP BY "noEquipe") STG --ScoreTotalGagnant
        INNER JOIN (SELECT "noEquipe", sum("score") as "scoreTotal", count("noEquipe") as "nombreDefaites"
                FROM "MatchDeSoccerPerdantFact"
                GROUP BY "noEquipe") STP --ScoreTotalPerdant
            on STG."noEquipe" = STP."noEquipe"
        INNER JOIN "Equipe" E on E."noEquipe" = STG."noEquipe"
        INNER JOIN "Saison" S on S."noSaison" = E."noSaison"
        INNER JOIN "NomSaison" NS on NS."noNomSaison" = S."noNomSaison"
        INNER JOIN "Division" D on D."noDivision" = E."noDivision";

/* Statistique Joueur */

CREATE VIEW "VictoiresJoueurFact" AS
    SELECT MJ."noJoueur", MJ.nom, MJ.prenom, MJ.matricule, MJ.sexe, MJ.courriel, MDSGF.*
    FROM (SELECT J.*, M."noEquipe", P."noMatch"
            FROM "Joueur" J
                INNER JOIN "Presence" P on J."noJoueur" = P."noJoueur"
                INNER JOIN "Membre" M on J."noJoueur" = M."noJoueur"
            UNION
            SELECT J.*, R."noEquipe", R."noMatch"
            FROM "Joueur" J
                INNER JOIN "Remplace" R on J."noJoueur" = R."noJoueur") MJ --MatchJoue
        INNER JOIN "MatchDeSoccerGagnantFact" MDSGF on MDSGF."noMatch" = MJ."noMatch" and MDSGF."noEquipe" = MJ."noEquipe";

CREATE VIEW "DefaitesJoueurFact" AS
    SELECT MJ."noJoueur", MJ.nom, MJ.prenom, MJ.matricule, MJ.sexe, MJ.courriel, MDSPF.*
    FROM (SELECT J.*, M."noEquipe", P."noMatch"
            FROM "Joueur" J
                INNER JOIN "Presence" P on J."noJoueur" = P."noJoueur"
                INNER JOIN "Membre" M on J."noJoueur" = M."noJoueur"
            UNION
            SELECT J.*, R."noEquipe", R."noMatch"
            FROM "Joueur" J
                INNER JOIN "Remplace" R on J."noJoueur" = R."noJoueur") MJ --MatchJoue
        INNER JOIN "MatchDeSoccerPerdantFact" MDSPF on MDSPF."noMatch" = MJ."noMatch" and MDSPF."noEquipe" = MJ."noEquipe";

CREATE VIEW "StatistiqueJoueurFact" AS
    SELECT J.*, coalesce(nombreVictoires, 0) as "nombreVictoires", coalesce(nombreDefaites, 0) as "nombreDefaites", coalesce((nombreVictoires + nombreDefaites), 0) as "nombreMatchs"
    FROM "Joueur" J
        FULL JOIN (SELECT "noJoueur", count("noJoueur") as nombreVictoires
                FROM "VictoiresJoueurFact"
                GROUP BY "noJoueur") NV --NombreVictoire
            on NV."noJoueur" = J."noJoueur"
        FULL JOIN (SELECT "noJoueur", count("noJoueur") as nombreDefaites
                FROM "DefaitesJoueurFact"
                GROUP BY "noJoueur"
                ) ND --NombreDefaite
            on ND."noJoueur" = J."noJoueur";
            