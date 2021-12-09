CREATE TABLE "Joueur"(
    "noJoueur" SERIAL,
    "nom" VARCHAR(50) NOT NULL,
    "prenom" VARCHAR(50) NOT NULL,
    "matricule" INT,
    "sexe" VARCHAR(1) NOT NULL,
    "courriel" VARCHAR(80) NOT NULL,
    "periode" TSTZRANGE DEFAULT tstzrange(current_timestamp, NULL),
    PRIMARY KEY("noJoueur")
);

CREATE TABLE "JoueurHistorique" AS TABLE "Joueur";

CREATE OR REPLACE FUNCTION "joueur_copierOldDansHistorique"() RETURNS trigger AS $joueur_copierOldDansHistorique$
    BEGIN
        INSERT INTO "JoueurHistorique" ("noJoueur", "nom", "prenom", "matricule", "sexe", "courriel", "periode")
        VALUES (OLD."noJoueur", OLD."nom", OLD."prenom", OLD."matricule", OLD."sexe", OLD."courriel", tstzrange(lower(OLD.periode), current_timestamp));

        RETURN NULL;
    END;
$joueur_copierOldDansHistorique$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "joueur_beforeUpdate"() RETURNS trigger AS $joueur_beforeUpdate$
    BEGIN
        NEW.periode = tstzrange(current_timestamp, NULL);
        RETURN NEW;
    END;
$joueur_beforeUpdate$ LANGUAGE plpgsql;

CREATE TRIGGER "Joueur_beforeUpdate"
    BEFORE UPDATE ON "Joueur"
    FOR EACH ROW
    EXECUTE PROCEDURE "joueur_beforeUpdate"()
;

CREATE TRIGGER "Joueur_afterUpdateOrDelete"
    AFTER UPDATE OR DELETE ON "Joueur"
    FOR EACH ROW
    EXECUTE PROCEDURE "joueur_copierOldDansHistorique"()
;
