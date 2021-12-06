CREATE TABLE "MatchDeSoccer" (
    "noMatch" SERIAL,
    "dateMatch" DATE,
    "scoreEquipeVerte" uint2 NOT NULL,
    "scoreEquipeJaune" uint2 NOT NULL,
    "noEquipeVerte" INT NOT NULL,
    "noEquipeJaune" INT NOT NULL,
    "noType" INT NOT NULL,
    "periode" TSTZRANGE DEFAULT tstzrange(current_timestamp, NULL),
    PRIMARY KEY("noMatch"),
    FOREIGN KEY("noEquipeVerte") REFERENCES "Equipe"("noEquipe"),
    FOREIGN KEY("noEquipeJaune") REFERENCES "Equipe"("noEquipe"),
    FOREIGN KEY("noType") REFERENCES "TypeDeMatch"("noType")
);

CREATE TABLE "MatchDeSoccerHistorique" AS TABLE  "MatchDeSoccer";

CREATE OR REPLACE FUNCTION "matchDeSoccer_copierOldDansHistorique"() RETURNS trigger AS $matchDeSoccer_copierOldDansHistorique$
    BEGIN
        INSERT INTO "MatchDeSoccerHistorique" ("noMatch", "dateMatch", "scoreEquipeVerte", "scoreEquipeJaune", "noEquipeVerte", "noEquipeJaune", "noType", "periode")
        VALUES (OLD."noMatch", OLD."dateMatch", OLD."scoreEquipeVerte", OLD."scoreEquipeJaune", OLD."noEquipeVerte", OLD."noEquipeJaune", OLD."noType", tstzrange(lower(OLD.periode), current_timestamp));

        RETURN NULL;
    END;
$matchDeSoccer_copierOldDansHistorique$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION "matchDeSoccer_beforeUpdate"() RETURNS trigger AS $matchDeSoccer_beforeUpdate$
    BEGIN
        NEW.periode = tstzrange(current_timestamp, NULL);
        RETURN NEW;
    END;
$matchDeSoccer_beforeUpdate$ LANGUAGE plpgsql;

CREATE TRIGGER "MatchDeSoccer_beforeUpdate"
    BEFORE UPDATE ON "MatchDeSoccer"
    FOR EACH ROW
    EXECUTE PROCEDURE "matchDeSoccer_beforeUpdate"();

CREATE TRIGGER "MatchDeSoccer_afterUpdateOrDelete"
    AFTER UPDATE OR DELETE ON "MatchDeSoccer"
    FOR EACH ROW
    EXECUTE PROCEDURE "matchDeSoccer_copierOldDansHistorique"();
