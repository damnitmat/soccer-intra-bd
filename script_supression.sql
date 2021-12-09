/*
 TABLES
 */
DROP TABLE IF EXISTS "Presence" CASCADE;
DROP TABLE IF EXISTS "Division" CASCADE;
DROP TABLE IF EXISTS "TypeDeMatch" CASCADE;
DROP TABLE IF EXISTS "MatchDeSoccer" CASCADE;
DROP TABLE IF EXISTS "Facture" CASCADE;
DROP TABLE IF EXISTS "Remplace" CASCADE;
DROP TABLE IF EXISTS "Indisponibilite" CASCADE;
DROP TABLE IF EXISTS "Saison" CASCADE;
DROP TABLE IF EXISTS "Equipe" CASCADE;
DROP TABLE IF EXISTS "Joueur" CASCADE;
DROP TABLE IF EXISTS "Membre" CASCADE;
DROP TABLE IF EXISTS "NomSaison" CASCADE;

/*
 VIEWS
 */
DROP VIEW IF EXISTS "PaiementEquipeFact" CASCADE;
DROP VIEW IF EXISTS "InscriptionFact" CASCADE;
DROP VIEW IF EXISTS "SerieJoueurPresenceFact" CASCADE;
DROP VIEW IF EXISTS "SerieRemplacantPresenceFact" CASCADE;
DROP VIEW IF EXISTS "PresenceFact" CASCADE;
DROP VIEW IF EXISTS "RemplacementFact" CASCADE;
DROP VIEW IF EXISTS "MatchDeSoccerGagnantFact" CASCADE;
DROP VIEW IF EXISTS "MatchDeSoccerPerdantFact" CASCADE;
DROP VIEW IF EXISTS "StatistiqueEquipeFact" CASCADE;
DROP VIEW IF EXISTS "VictoiresJoueurFact" CASCADE;
DROP VIEW IF EXISTS "DefaitesJoueurFact" CASCADE;
DROP VIEW IF EXISTS "StatistiqueJoueurFact" CASCADE;

/*
 FUNCTIONS
*/
DROP FUNCTION IF EXISTS "matchDeSoccer_copierOldDansHistorique" CASCADE;
DROP FUNCTION IF EXISTS "matchDeSoccer_beforeUpdate" CASCADE;
DROP FUNCTION IF EXISTS "equipe_copierOldDansHistorique" CASCADE;
DROP FUNCTION IF EXISTS "equipe_beforeUpdate" CASCADE;
DROP FUNCTION IF EXISTS "joueur_copierOldDansHistorique" CASCADE;
DROP FUNCTION IF EXISTS "joueur_beforeUpdate" CASCADE;

/*
 TRIGGERS
*/
DROP TRIGGER IF EXISTS "MatchDeSoccer_beforeUpdate" ON "MatchDeSoccer";
DROP TRIGGER IF EXISTS "MatchDeSoccer_afterUpdateOrDelete" ON "MatchDeSoccer";
DROP TRIGGER IF EXISTS "Equipe_beforeUpdate" ON "Equipe";
DROP TRIGGER IF EXISTS "Equipe_afterUpdateOrDelete" ON "Equipe";
DROP TRIGGER IF EXISTS "Joueur_beforeUpdate" ON "Joueur";
DROP TRIGGER IF EXISTS "Joueur_afterUpdateOrDelete" ON "Joueur";

/*
 TYPES
 */
DROP TYPE IF EXISTS uint2;
