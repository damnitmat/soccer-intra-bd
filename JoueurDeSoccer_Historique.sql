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

CREATE TABLE "JoueurHistorique" AS TABLE  "Joueur";
CREATE OR REPLACE FUNCTION "Joueur_copierOldDansHistorique"() RETURNS trigger AS $Joueur_copierOldDansHistorique$
    BEGIN
        INSERT INTO "JoueurHistorique" ("noJoueur", "nom", "prenom", "matricule", "sexe", "courriel", "periode")
        VALUES (OLD."noJoueur", OLD."nom", OLD."prenom", OLD."matricule", OLD."sexe", OLD."courriel", tstzrange(lower(OLD.periode), current_timestamp));

        RETURN NULL;
    END;
$Joueur_copierOldDansHistorique$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "Joueur_beforeUpdate"() RETURNS trigger AS $Joueur_beforeUpdate$
    BEGIN
        NEW.periode = tstzrange(current_timestamp, NULL);
        RETURN NEW;
    END;
$Joueur_beforeUpdate$ LANGUAGE plpgsql;

CREATE TRIGGER "Joueur_beforeUpdate"
    BEFORE UPDATE ON "Joueur"
    FOR EACH ROW
    EXECUTE PROCEDURE "Joueur_beforeUpdate"();

CREATE TRIGGER "Joueur_afterUpdateOrDelete"
    AFTER UPDATE OR DELETE ON "Joueur"
    FOR EACH ROW
    EXECUTE PROCEDURE "Joueur_copierOldDansHistorique"();
