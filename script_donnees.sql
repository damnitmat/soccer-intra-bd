/************************
*************************
    Données importées du Jalon 2
*************************
*************************/

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
    /* match 1, equipe 1, Cereales Madrid */
    ((select "noJoueur" from "Joueur" where matricule=17275993), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    ((select "noJoueur" from "Joueur" where matricule=19820417), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    ((select "noJoueur" from "Joueur" where matricule=20553952), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    ((select "noJoueur" from "Joueur" where matricule=18234987), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    ((select "noJoueur" from "Joueur" where matricule=18000068), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-25')),
    /* match 1, equipe 2, FC Sherb */
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

/************************
*************************
    Données du Jalon 3
*************************
*************************/

INSERT INTO "MatchDeSoccer"("dateMatch", "scoreEquipeVerte", "scoreEquipeJaune", "noEquipeVerte", "noEquipeJaune", "noType")
VALUES
    /* Cereales Madrid vs FC Sherb, match 3 */
    ('2021-10-15', 2, 0, (select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'),
                        (select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'),
                        (select "noType" from "TypeDeMatch" where "nomType"='Régulier')),
    /* FC Sherb vs Cereales Madrid, match 4 */
    ('2021-10-20', 3, 2, (select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'),
                        (select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'),
                        (select "noType" from "TypeDeMatch" where "nomType"='Régulier')),
    /* Cereales Madrid vs FC Sherb, match 5 */
    ('2021-10-25', 0, 0, (select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'),
                        (select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'),
                        (select "noType" from "TypeDeMatch" where "nomType"='Régulier')),
    /* FC Sherb vs Cereales Madrid, match 6 */
    ('2021-10-30', 0, 2, (select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'),
                        (select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'),
                        (select "noType" from "TypeDeMatch" where "nomType"='Régulier')),
    /* FC Sherb vs Cereales Madrid, match 7 */
    ('2021-11-01', 1, 2, (select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'),
                        (select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'),
                        (select "noType" from "TypeDeMatch" where "nomType"='Régulier')),
    /* Cereales Madrid vs FC Sherb, match 8 */
    ('2021-11-05', 1, 0, (select "noEquipe" from "Equipe" where "nomEquipe"='Céréales Madrid'),
                        (select "noEquipe" from "Equipe" where "nomEquipe"='FC Sherb'),
                        (select "noType" from "TypeDeMatch" where "nomType"='Régulier'))
;

INSERT INTO "Presence"("noJoueur", "noMatch")
VALUES
    /* match 3, Cereales Madrid */
    ((select "noJoueur" from "Joueur" where matricule=17275993), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-15')),
    ((select "noJoueur" from "Joueur" where matricule=19820417), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-15')),
    ((select "noJoueur" from "Joueur" where matricule=20553952), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-15')),
    ((select "noJoueur" from "Joueur" where matricule=18234987), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-15')),
    ((select "noJoueur" from "Joueur" where matricule=18000068), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-15')),
    /* match 3, FC Sherb */
    ((select "noJoueur" from "Joueur" where matricule=20539265), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-15')),
    ((select "noJoueur" from "Joueur" where matricule=20728889), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-15')),
    ((select "noJoueur" from "Joueur" where matricule=19596066), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-15')),
    ((select "noJoueur" from "Joueur" where matricule=17704160), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-15')),
    ((select "noJoueur" from "Joueur" where matricule=19163464), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-15')),
    /* match 4, FC Sherb */
    ((select "noJoueur" from "Joueur" where matricule=20539265), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-20')),
    ((select "noJoueur" from "Joueur" where matricule=20728889), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-20')),
    ((select "noJoueur" from "Joueur" where matricule=19596066), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-20')),
    ((select "noJoueur" from "Joueur" where matricule=17704160), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-20')),
    ((select "noJoueur" from "Joueur" where matricule=19163464), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-20')),
    /* match 4, Cereales Madrid */
    ((select "noJoueur" from "Joueur" where matricule=17275993), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-20')),
    ((select "noJoueur" from "Joueur" where matricule=19820417), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-20')),
    ((select "noJoueur" from "Joueur" where matricule=20553952), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-20')),
    ((select "noJoueur" from "Joueur" where matricule=18234987), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-20')),
    ((select "noJoueur" from "Joueur" where matricule=18000068), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-20')),
    /* match 5, Cereales Madrid */
    ((select "noJoueur" from "Joueur" where matricule=17275993), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-25')),
    ((select "noJoueur" from "Joueur" where matricule=19820417), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-25')),
    ((select "noJoueur" from "Joueur" where matricule=20553952), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-25')),
    ((select "noJoueur" from "Joueur" where matricule=18234987), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-25')),
    ((select "noJoueur" from "Joueur" where matricule=18000068), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-25')),
    /* match 5, FC Sherb */
    ((select "noJoueur" from "Joueur" where matricule=20539265), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-25')),
    ((select "noJoueur" from "Joueur" where matricule=20728889), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-25')),
    ((select "noJoueur" from "Joueur" where matricule=19596066), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-25')),
    ((select "noJoueur" from "Joueur" where matricule=17704160), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-25')),
    ((select "noJoueur" from "Joueur" where matricule=19163464), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-25')),
    /* match 6, FC Sherb */
    ((select "noJoueur" from "Joueur" where matricule=20539265), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-30')),
    ((select "noJoueur" from "Joueur" where matricule=20728889), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-30')),
    ((select "noJoueur" from "Joueur" where matricule=19596066), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-30')),
    ((select "noJoueur" from "Joueur" where matricule=17704160), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-30')),
    ((select "noJoueur" from "Joueur" where matricule=19163464), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-30')),
    /* match 6, Cereales Madrid */
    ((select "noJoueur" from "Joueur" where matricule=17275993), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-30')),
    ((select "noJoueur" from "Joueur" where matricule=19820417), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-30')),
    ((select "noJoueur" from "Joueur" where matricule=20553952), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-30')),
    ((select "noJoueur" from "Joueur" where matricule=18234987), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-30')),
    ((select "noJoueur" from "Joueur" where matricule=18000068), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-30')),
    /* match 7, FC Sherb */
    ((select "noJoueur" from "Joueur" where matricule=20539265), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-01')),
    ((select "noJoueur" from "Joueur" where matricule=20728889), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-01')),
    ((select "noJoueur" from "Joueur" where matricule=19596066), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-01')),
    ((select "noJoueur" from "Joueur" where matricule=17704160), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-01')),
    ((select "noJoueur" from "Joueur" where matricule=19163464), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-01')),
    /* match 7, Cereales Madrid */
    ((select "noJoueur" from "Joueur" where matricule=17275993), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-01')),
    ((select "noJoueur" from "Joueur" where matricule=19820417), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-01')),
    ((select "noJoueur" from "Joueur" where matricule=20553952), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-01')),
    ((select "noJoueur" from "Joueur" where matricule=18234987), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-01')),
    ((select "noJoueur" from "Joueur" where matricule=18000068), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-01')),
    /* match 8, Cereales Madrid */
    ((select "noJoueur" from "Joueur" where matricule=17275993), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-05')),
    ((select "noJoueur" from "Joueur" where matricule=19820417), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-05')),
    ((select "noJoueur" from "Joueur" where matricule=20553952), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-05')),
    ((select "noJoueur" from "Joueur" where matricule=18234987), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-05')),
    ((select "noJoueur" from "Joueur" where matricule=18000068), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-05')),
    /* match 8, FC Sherb */
    ((select "noJoueur" from "Joueur" where matricule=20539265), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-05')),
    ((select "noJoueur" from "Joueur" where matricule=20728889), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-05')),
    ((select "noJoueur" from "Joueur" where matricule=19596066), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-05')),
    ((select "noJoueur" from "Joueur" where matricule=17704160), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-05')),
    ((select "noJoueur" from "Joueur" where matricule=19163464), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-11-05'))
;

INSERT INTO "Joueur"(nom, prenom, matricule, sexe, courriel)
VALUES
    /* equipe 3, Sherbrooke Saint-Germain */
    ('Lespérance', 'Véronique', 18872679, 'F', 'veronique.lesperence@usherbrooke.ca'),
    ('Fresne', 'Geoffrey', 17573400, 'M', 'geoffrey.fresne@usherbrooke.ca'),
    ('Michaud', 'Christine', 17893019, 'F', 'christine.michaud@usherbrooke.ca'),
    ('Ayot', 'Gilles', 19834570, 'M', 'gilles.ayot@usherbrooke.ca'),
    ('Riel', 'Pierre', 16018767, 'M', 'pierre.riel@usherbrooke.ca'),
    /* equipe 4, Atletico Granby */
    ('Sayyid', 'Wasil', 20506401, 'M', 'wasil.sayyid@usherbrooke.ca'),
    ('Costa', 'Julia', 17360208, 'F', 'julia.costa@usherbrooke.ca'),
    ('Rukan', 'Maysam', 19016897, 'F', 'maysam.rukan@usherbrooke.ca'),
    ('Pisano', 'Edgardo', 18392376, 'M', 'edgardo.pisano@usherbrooke.ca'),
    ('Lapierre', 'Rabican', 17057648, 'M', 'rabican.lapierre@usherbrooke.ca'),
    /* remplacants */
    ('Jørgensen', 'Henrik', 20859572, 'M', 'henrik.jorgsen@usherbrooke.ca'),
    ('Nesheim', 'Sindre', NULL, 'F', 'sindre.contact@gmail.com'),
    ('Souma', 'Kentarou', 20657867, 'M', 'kentarou.souma@usherbrooke.ca')
;

INSERT INTO "Equipe"("nomEquipe", "noIndisponibilite", "noDivision", "noSaison", "noCapitaine")
VALUES
    ('Sherbrooke Saint-Germain', (select "noIndisponibilite" from "Indisponibilite" where dimanche=true),
                                 (select "noDivision" from "Division" where "nomDivision"='AA'),
                                 (select "noSaison" from "Saison" where date_part('year', "dateDebut")='2021' and "noNomSaison"=(select "noNomSaison" from "NomSaison" where nom='Automne')),
                                 (select "noJoueur" from "Joueur" where matricule=18872679)),
    ('Atletico Granby', (select "noIndisponibilite" from "Indisponibilite" where dimanche=false),
                        (select "noDivision" from "Division" where "nomDivision"='AA'),
                        (select "noSaison" from "Saison" where date_part('year', "dateDebut")='2021' and "noNomSaison"=(select "noNomSaison" from "NomSaison" where nom='Automne')),
                        (select "noJoueur" from "Joueur" where matricule=20506401))
;

INSERT INTO "Membre"("noEquipe", "noJoueur")
VALUES
    /* equipe 3, Sherbrooke Saint-Germain */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'), (select "noJoueur" from "Joueur" where matricule=18872679)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'), (select "noJoueur" from "Joueur" where matricule=17573400)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'), (select "noJoueur" from "Joueur" where matricule=17893019)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'), (select "noJoueur" from "Joueur" where matricule=19834570)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'), (select "noJoueur" from "Joueur" where matricule=16018767)),
    /* equipe 4, Atletico Granby */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'), (select "noJoueur" from "Joueur" where matricule=20506401)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'), (select "noJoueur" from "Joueur" where matricule=17360208)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'), (select "noJoueur" from "Joueur" where matricule=19016897)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'), (select "noJoueur" from "Joueur" where matricule=18392376)),
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'), (select "noJoueur" from "Joueur" where matricule=17057648))
;

INSERT INTO "MatchDeSoccer"("dateMatch", "scoreEquipeVerte", "scoreEquipeJaune", "noEquipeVerte", "noEquipeJaune", "noType")
VALUES
    /* Sherbrooke Saint-Germain vs Atletico Granby, match 1 */
    ('2021-09-03', 0, 0, (select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
                        (select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
                        (select "noType" from "TypeDeMatch" where "nomType"='Régulier')),
    /* Atletico Granby vs Sherbrooke Saint-Germain, match 2 */
    ('2021-09-09', 1, 3, (select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
                        (select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
                        (select "noType" from "TypeDeMatch" where "nomType"='Régulier')),
    /* Sherbrooke Saint-Germain vs Atletico Granby, match 3 */
    ('2021-09-16', 1, 2, (select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
                        (select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
                        (select "noType" from "TypeDeMatch" where "nomType"='Régulier')),
    /* Atletico Granby vs Sherbrooke Saint-Germain, match 4 */
    ('2021-09-23', 1, 1, (select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
                        (select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
                        (select "noType" from "TypeDeMatch" where "nomType"='Régulier')),
    /* Sherbrooke Saint-Germain vs Atletico Granby, match 5 */
    ('2021-09-29', 1, 1, (select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
                        (select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
                        (select "noType" from "TypeDeMatch" where "nomType"='Régulier')),
    /* Atletico Granby vs Sherbrooke Saint-Germain, match 6 */
    ('2021-10-02', 2, 4, (select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
                        (select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
                        (select "noType" from "TypeDeMatch" where "nomType"='Régulier'))
;

INSERT INTO "Presence"("noJoueur", "noMatch")
VALUES
    /* match 1, Sherbrooke Saint-Germain */
    ((select "noJoueur" from "Joueur" where matricule=18872679), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-03')),
    ((select "noJoueur" from "Joueur" where matricule=17573400), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-03')),
    ((select "noJoueur" from "Joueur" where matricule=17893019), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-03')),
    /* match 1, Atletico Granby */
    ((select "noJoueur" from "Joueur" where matricule=20506401), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-03')),
    ((select "noJoueur" from "Joueur" where matricule=17057648), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-03')),
    /* match 2, Atletico Granby */
    ((select "noJoueur" from "Joueur" where matricule=20506401), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-09')),
    ((select "noJoueur" from "Joueur" where matricule=17057648), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-09')),
    /* match 2, Sherbrooke Saint-Germain */
    ((select "noJoueur" from "Joueur" where matricule=18872679), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-09')),
    ((select "noJoueur" from "Joueur" where matricule=17573400), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-09')),
    ((select "noJoueur" from "Joueur" where matricule=17893019), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-09')),
    /* match 3, Sherbrooke Saint-Germain */
    ((select "noJoueur" from "Joueur" where matricule=18872679), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-16')),
    ((select "noJoueur" from "Joueur" where matricule=17573400), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-16')),
    ((select "noJoueur" from "Joueur" where matricule=17893019), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-16')),
    /* match 3, Atletico Granby */
    ((select "noJoueur" from "Joueur" where matricule=20506401), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-16')),
    ((select "noJoueur" from "Joueur" where matricule=17057648), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-16')),
    /* match 4, Atletico Granby */
    ((select "noJoueur" from "Joueur" where matricule=20506401), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-23')),
    ((select "noJoueur" from "Joueur" where matricule=17057648), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-23')),
    /* match 4, Sherbrooke Saint-Germain */
    ((select "noJoueur" from "Joueur" where matricule=18872679), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-23')),
    ((select "noJoueur" from "Joueur" where matricule=17573400), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-23')),
    ((select "noJoueur" from "Joueur" where matricule=17893019), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-23')),
    /* match 5, Sherbrooke Saint-Germain */
    ((select "noJoueur" from "Joueur" where matricule=18872679), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-29')),
    ((select "noJoueur" from "Joueur" where matricule=17573400), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-29')),
    ((select "noJoueur" from "Joueur" where matricule=17893019), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-29')),
    /* match 5, Atletico Granby */
    ((select "noJoueur" from "Joueur" where matricule=20506401), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-29')),
    ((select "noJoueur" from "Joueur" where matricule=17057648), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-29')),
    /* match 6, Atletico Granby */
    ((select "noJoueur" from "Joueur" where matricule=20506401), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-02')),
    ((select "noJoueur" from "Joueur" where matricule=17057648), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-02')),
    /* match 6, Sherbrooke Saint-Germain */
    ((select "noJoueur" from "Joueur" where matricule=18872679), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-02')),
    ((select "noJoueur" from "Joueur" where matricule=17573400), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-02')),
    ((select "noJoueur" from "Joueur" where matricule=17893019), (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-02'))
;

INSERT INTO "Remplace"("noEquipe", "noJoueur", "noMatch")
VALUES
    /* match 1, Sherbrooke Saint-Germain (2 remplacants) */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
     (select "noJoueur" from "Joueur" where nom='Jørgensen' and prenom='Henrik'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-03')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
     (select "noJoueur" from "Joueur" where nom='Nesheim' and prenom='Sindre'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-03')),

    /* match 1, Atletico Granby (3 remplacants) */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Souma' and prenom='Kentarou'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-03')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Brunelle' and prenom='Melville'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-03')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Bisson' and prenom='Zacharie'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-03')),

    /* match 2, Sherbrooke Saint-Germain (2 remplacants) */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
     (select "noJoueur" from "Joueur" where nom='Jørgensen' and prenom='Henrik'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-09')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
     (select "noJoueur" from "Joueur" where nom='Nesheim' and prenom='Sindre'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-09')),

    /* match 2, Atletico Granby (3 remplacants) */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Souma' and prenom='Kentarou'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-09')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Brunelle' and prenom='Melville'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-09')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Bisson' and prenom='Zacharie'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-09')),

    /* match 3, Sherbrooke Saint-Germain (2 remplacants) */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
     (select "noJoueur" from "Joueur" where nom='Jørgensen' and prenom='Henrik'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-16')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
     (select "noJoueur" from "Joueur" where nom='Nesheim' and prenom='Sindre'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-16')),

    /* match 3, Atletico Granby (3 remplacants) */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Souma' and prenom='Kentarou'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-16')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Brunelle' and prenom='Melville'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-16')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Bisson' and prenom='Zacharie'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-16')),

    /* match 4, Sherbrooke Saint-Germain (2 remplacants) */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
     (select "noJoueur" from "Joueur" where nom='Jørgensen' and prenom='Henrik'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-23')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
     (select "noJoueur" from "Joueur" where nom='Nesheim' and prenom='Sindre'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-23')),

    /* match 4, Atletico Granby (3 remplacants) */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Souma' and prenom='Kentarou'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-23')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Brunelle' and prenom='Melville'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-23')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Bisson' and prenom='Zacharie'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-23')),

    /* match 5, Sherbrooke Saint-Germain (2 remplacants) */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
     (select "noJoueur" from "Joueur" where nom='Jørgensen' and prenom='Henrik'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-29')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
     (select "noJoueur" from "Joueur" where nom='Nesheim' and prenom='Sindre'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-29')),

    /* match 5, Atletico Granby (3 remplacants) */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Souma' and prenom='Kentarou'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-29')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Brunelle' and prenom='Melville'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-29')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Bisson' and prenom='Zacharie'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-09-29')),

    /* match 6, Sherbrooke Saint-Germain (2 remplacants) */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
     (select "noJoueur" from "Joueur" where nom='Jørgensen' and prenom='Henrik'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-02')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Sherbrooke Saint-Germain'),
     (select "noJoueur" from "Joueur" where nom='Nesheim' and prenom='Sindre'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-02')),

    /* match 6, Atletico Granby (3 remplacants) */
    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Souma' and prenom='Kentarou'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-02')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Brunelle' and prenom='Melville'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-02')),

    ((select "noEquipe" from "Equipe" where "nomEquipe"='Atletico Granby'),
     (select "noJoueur" from "Joueur" where nom='Bisson' and prenom='Zacharie'),
     (select "noMatch" from "MatchDeSoccer" where "dateMatch"='2021-10-02'))
    ;
