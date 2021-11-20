DROP VIEW IF EXISTS "RemplacementFact" CASCADE;

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