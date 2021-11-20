/**********
    Données importées du Jalon 2
**********/

INSERT INTO "Division"("nomDivision")
VALUES ('AA'), ('A'), ('B'), ('C');

INSERT INTO "TypeDeMatch"("nomType")
VALUES
    ('Finale'),
    ('Demi-Finale'),
    ('Quarts de Finale'),
    ('Saison'),
    ('Pré-saison'),
    ('Régulier');

INSERT INTO "NomSaison"("nom")
VALUES ('Automne'), ('Été'), ('Hiver');

INSERT INTO "Saison"("dateDebut", "dateFin", "noNomSaison")
VALUES
    ('2021-05-01', '2021-08-31', (select "noNomSaison" from "NomSaison" where "nom"='Été')),
    ('2021-09-01', '2021-12-31', (select "noNomSaison" from "NomSaison" where "nom"='Automne'));

INSERT INTO "Indisponibilite"("dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi")
VALUES
    (false, false, true, false, true, false, false),
    (true, false, false, false, false, false, false);

INSERT INTO "Joueur"(nom, prenom, matricule, sexe, courriel)
VALUES
    /* equipe 1 */
    ('Ruel', 'Nathalie', 17275993, 'F', 'nathalie.ruel@usherbrooke.ca'),
    ('Arpin', 'Melisandre', 19820417, 'F', 'melisandre.arpin@usherbrooke.ca'),
    ('Blondlot', 'Marc', 20553952, 'M', 'marc.blondlot@usherbrooke.ca'),
    ('Beauchesne', 'Isaac', 18234987, 'M', 'Isaac.Beauchesne@usherbrooke.ca'),
    ('Charbonneau', 'Franck', 18000068, 'M', 'Franck.Charbonneau@usherbrooke.ca'),
    /* equipe 2 */
    ('Voisine', 'Fayme', 20539265, 'F', 'Fayme.Voisine@usherbrooke.ca'),
    ('Gadbois', 'Jeannine', 20728889, 'F', 'Jeannine.Gadbois@usherbrooke.ca'),
    ('Poisson', 'Maryse', 19596066, 'F', 'Maryse.Poisson@usherbrooke.ca'),
    ('Mouet', 'Olivier', 17704160, 'M', 'Olivier.Mouet@usherbrooke.ca'),
    ('Fontaine', 'Benoit', 19163464, 'M', 'Benoit.Fontaine@usherbrooke.ca'),
    /* remplacants */
    ('Brunelle', 'Melville', NULL, 'M', 'melville.brunelle@gmail.com'),
    ('Bourque', 'Noelle', 19876407, 'F', 'noelle.bourque72@outlook.com'),
    ('Bisson', 'Zacharie', NULL, 'M', 'zaka.the.goat155@gmail.com')
    ;

INSERT INTO "Equipe"("nomEquipe", "noIndisponibilite", "noDivision", "noSaison", "noCapitaine")
VALUES
    ('Céréales Madrid', (select "noIndisponibilite" from "Indisponibilite" where dimanche=true),
                        (select "noDivision" from "Division" where "nomDivision"='AA'),
                        (select "noSaison" from "Saison" where date_part('year', "dateDebut")='2021' and "noNomSaison"=(select "noNomSaison" from "NomSaison" where nom='Automne')),
                        (select "noJoueur" from "Joueur" where matricule=17275993)),
    ('FC Sherb',    (select "noIndisponibilite" from "Indisponibilite" where dimanche=false),
                    (select "noDivision" from "Division" where "nomDivision"='AA'),
                    (select "noSaison" from "Saison" where date_part('year', "dateDebut")='2021' and "noNomSaison"=(select "noNomSaison" from "NomSaison" where nom='Automne')),
                    (select "noJoueur" from "Joueur" where matricule=20539265))
    ;

INSERT INTO "Membre"("noEquipe", "noJoueur")
VALUES
    /* equipe 1 */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'), (select "noJoueur" from "Joueur" where matricule=17275993)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'), (select "noJoueur" from "Joueur" where matricule=19820417)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'), (select "noJoueur" from "Joueur" where matricule=20553952)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'), (select "noJoueur" from "Joueur" where matricule=18234987)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'), (select "noJoueur" from "Joueur" where matricule=18000068)),
    /* equipe 2 */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'), (select "noJoueur" from "Joueur" where matricule=20539265)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'), (select "noJoueur" from "Joueur" where matricule=20728889)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'), (select "noJoueur" from "Joueur" where matricule=19596066)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'), (select "noJoueur" from "Joueur" where matricule=17704160)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'), (select "noJoueur" from "Joueur" where matricule=19163464))
    ;

INSERT INTO "Facture"(montant, "datePaiement", "noEquipe")
VALUES
    (500, '2021-09-05', (select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid')),
    (500, '2021-09-08', (select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'))
    ;

INSERT INTO "MatchDeSoccer"("dateMatch", "scoreEquipeVerte", "scoreEquipeJaune", "noEquipeVerte", "noEquipeJaune", "noType")
VALUES
    ('2021-10-10', 2, 0, (select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'),
                        (select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'),
                        (select "noType" from "TypeDeMatch" where "nomType"='Régulier')),
    ('2021-09-25', 1, 2, (select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'),
                        (select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'),
                        (select "noType" from "TypeDeMatch" where "nomType"='Régulier'))
    ;

INSERT INTO "Presence"("noJoueur", "noMatch")
VALUES
    /* match 1, equipe 1 */
    ((select "noJoueur" from "Joueur" where matricule=17275993), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    ((select "noJoueur" from "Joueur" where matricule=19820417), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    ((select "noJoueur" from "Joueur" where matricule=20553952), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    ((select "noJoueur" from "Joueur" where matricule=18234987), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    ((select "noJoueur" from "Joueur" where matricule=18000068), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    /* match 1, equipe 2 */
    ((select "noJoueur" from "Joueur" where matricule=20539265), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    ((select "noJoueur" from "Joueur" where matricule=20728889), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    ((select "noJoueur" from "Joueur" where matricule=19596066), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    ((select "noJoueur" from "Joueur" where matricule=17704160), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    ((select "noJoueur" from "Joueur" where matricule=19163464), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    /* match 2, equipe 1 (2 absents) */
    ((select "noJoueur" from "Joueur" where matricule=17275993), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-10')),
    ((select "noJoueur" from "Joueur" where matricule=19820417), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-10')),
    ((select "noJoueur" from "Joueur" where matricule=20553952), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-10')),
    /* match 2, equipe 2 (1 absent) */
    ((select "noJoueur" from "Joueur" where matricule=20539265), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-10')),
    ((select "noJoueur" from "Joueur" where matricule=20728889), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-10')),
    ((select "noJoueur" from "Joueur" where matricule=19596066), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-10')),
    ((select "noJoueur" from "Joueur" where matricule=17704160), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-10'))
    ;

INSERT INTO "Remplace"("noEquipe", "noJoueur", "noMatch")
VALUES
    /* match 2, equipe 1 (2 absents) */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'),
     (select "noJoueur" from "Joueur" where nom='Brunelle' and prenom='Melville'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'),
     (select "noJoueur" from "Joueur" where nom='Bisson' and prenom='Zacharie'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),

    /* match 2, equipe 2 (1 absent) */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'),
     (select "noJoueur" from "Joueur" where nom='Bisson' and prenom='Zacharie'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-10'))
    ;

/**********
    Données du Jalon 3
**********/
