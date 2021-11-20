DROP VIEW IF EXISTS "EquipeIndisponibiliteFact" CASCADE;
DROP VIEW IF EXISTS "HoraireMatchFact" CASCADE;

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