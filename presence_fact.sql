DROP VIEW IF EXISTS "PresenceFact" CASCADE;

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