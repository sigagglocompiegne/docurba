-- ############################################################################################ SUIVI CODE SQL ###################################################################################################

-- 2018/01/16 : GB / initialisation du script SQL de création de la nouvelle structure de données suite au nouveau standard CNIG de décembre 2017
--		GB / ATTENTION : les tables et liste de domaine (ou valeur), ..... spécifiques au PNR et à OLV ont été mis en commentaire dans ce script mais adaptée au modèle
--		GB / Reste à la charge de chaque partenaire d'adapter ce script à sa situation
-- 2018/04/19 : GB / Intégration dans la chaine de production des tables geo_p_zone_urba et an_ads_commune non compris dans le standard CNIG mais servant également à la gestion des données des docs d'urbanisme
--                   initialisation du code et migration des données intégrées pour ces 2 tables
-- 2018/04/27 : GB / Adaptation de la migration des données PSC et INFO suite validation de la grille de correspondance 2014-2017
-- 2018/07/25 : GB / Intégration du champ optionnel l_meta dans le script de migration et adaptation des sous-types dans les migrations suites aux dernières procédures intégrées
-- 2018/08/07 : GB / Ajout des vues matérialisées Grand Public pour l'application de consultation des documents d'urbanisme
--                 / Ajout des nouveaux profils de connexion et leur privilège suite à la modification des rôles dans la base de l'ARC
-- 2018/08/16 : GB / Correction bug de migration sur la réécriture des noms de fichiers (suite test intégration GeoPortail)
-- 2018/08/20 : GB / Intégration des vues applicatives PLUi de l'ARC
-- 2018/10/29 : GB / Intégration des modifications mineures du standard v2017b (ajout du code 98-00 comme information) et modification de l'idzone (ZO et non Z)

-- ############################################################################################## SCHEMA #########################################################################################################

--

-- COMMENT GB : -------------------------------------------------------------------
-- Début de la transaction (ne s'exécutera en base qu'une fois le processus réussi)
-- --------------------------------------------------------------------------------

BEGIN;



-- COMMENT GB : ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Création d'un schéma pour tester le script d'import et vérifier les données
-- Mettre en commentaire pour la mise en production, le rennomage des tables s'effectue à la fin de ce script (qui seront à décommenter pour la mise en production)
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures

-- IMPORTANT : lors de la mise en production il faut remplacer m_urbanisme_doc_cnig2017 par m_urbanisme_doc_cnig2017 ,mettre en commentaire lacréation du schéma et décommenter la partie de DROP IF EXISTS ou ALTER TABLE qui suivent
-- IMPORTANT : depuis le 7 août 2018, les nouveaux profils de connexion intégrés dans la base de données de l'ARC
-- ainsi que leurs privilèges ont été insérés dans ce script.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- COMMENT GB : ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- IMPORTANT : Mettre en commentaire pour la mise en production

DROP SCHEMA IF EXISTS m_urbanisme_doc_cnig2017 CASCADE;
CREATE SCHEMA m_urbanisme_doc_cnig2017
  AUTHORIZATION sig_create;

GRANT USAGE ON SCHEMA m_urbanisme_doc_cnig2017 TO edit_sig;
GRANT ALL ON SCHEMA m_urbanisme_doc_cnig2017 TO sig_create;
GRANT ALL ON SCHEMA m_urbanisme_doc_cnig2017 TO create_sig;
GRANT USAGE ON SCHEMA m_urbanisme_doc_cnig2017 TO read_sig;
ALTER DEFAULT PRIVILEGES IN SCHEMA m_urbanisme_doc_cnig2017
GRANT ALL ON TABLES TO create_sig;
ALTER DEFAULT PRIVILEGES IN SCHEMA m_urbanisme_doc_cnig2017
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLES TO edit_sig;
ALTER DEFAULT PRIVILEGES IN SCHEMA m_urbanisme_doc_cnig2017
GRANT SELECT ON TABLES TO read_sig;

COMMENT ON SCHEMA m_urbanisme_doc_cnig2017
  IS 'Schéma contenant les données métiers relatives aux documents d''urbanisme du nouveau modèle CNIG2017 pour test';




-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  DOMAINES DE VALEURS                                                         ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################




-- COMMENT GB : --------------------------------------------------------------------------------------
-- Création des domaines de valeurs avant les tables nécessaires pour la création des clés étrangères
-- ---------------------------------------------------------------------------------------------------

-- ################################################################# Domaine valeur - lt_etat #############################################

-- Table: m_urbanisme_doc_cnig2017.lt_etat

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_etat;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_etat
(
  code character(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_etat_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_etat
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_etat TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_etat TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_etat TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_etat
  IS 'Liste des valeurs de l''attribut état de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_etat.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_etat.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_cnig2017.lt_etat(
            code, valeur)
    VALUES
    ('01','en cours de procédure'),
    ('02','arrêté'),
    ('03','opposable'),
    ('04','annulé'),
    ('05','remplacé'),
    ('06','abrogé'),
    ('07','approuvé'),
    ('08','partiellement annulé'),
    ('09','caduc');

-- ################################################################# Domaine valeur - lt_typedoc #############################################

-- Table: m_urbanisme_doc_cnig2017.lt_typedoc

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_typedoc;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_typedoc
(
  code character varying(4) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_typedoc_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_typedoc
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_typedoc TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typedoc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_typedoc TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_typedoc
  IS 'Liste des valeurs de l''attribut typedoc de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typedoc.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typedoc.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_cnig2017.lt_typedoc(
            code, valeur)
    VALUES
    ('RNU','Règlement national de l''urbanisme'),
    ('PLU','Plan local d''urbanisme'),
    ('PLUI','Plan local d''urbanisme intercommunal'),
    ('POS','Plan d''occupation des sols'),
    ('CC','Carte communale'),
    ('PSMV','Plan de sauvegarde et de mise en valeur'); 

-- ################################################################# Domaine valeur - lt_typeref #############################################

-- Table: m_urbanisme_doc_cnig2017.lt_typeref

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_typeref;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_typeref
(
  code character varying(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_typeref_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_typeref
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_typeref TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typeref TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_typeref TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_typeref
  IS 'Liste des valeurs de l''attribut typeref de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typeref.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typeref.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_cnig2017.lt_typeref(
            code, valeur)
    VALUES
    ('01','PCI'),
    ('02','BD Parcellaire'),
    ('03','RPCU'),
    ('04','Référentiel local');


-- ################################################################# Domaine valeur - lt_nomproc #############################################

-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------
-- Cette table a été implémentéé en prenant en compte pour chaque procédure associée à un numéro, de tous les cas possibles de 1 à 9 (au besoin ajouter des cas)
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc_cnig2017.lt_nomproc

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_nomproc;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_nomproc
(
  code character varying(3) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_nomproc_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_nomproc
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_nomproc TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_nomproc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_nomproc TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_nomproc
  IS 'Liste des valeurs de l''attribut Nom de la procédure de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_nomproc.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_nomproc.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_cnig2017.lt_nomproc(
            code, valeur)
    VALUES
    ('RNU','Commune soumise au RNU'),
    ('E','Elaboration'),
    ('MC','Mise en compatibilité'),
    ('MJ','Mise à jour'),
    ('M','Modification de droit commun'),
    ('MS','Modification simplifiée'),
    ('R','Révision'),
    ('RS','Révision simplifiée'),
    ('A','Abrogation');


-- ################################################################# Domaine valeur - lt_typezone #############################################

-- Table: m_urbanisme_doc_cnig2017.lt_typezone

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_typezone;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_typezone
(
  code character varying(3) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_typezone_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_typezone
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_typezone TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typezone TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_typezone TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_typezone
  IS 'Liste des valeurs de l''attribut typezone de la donnée zone_urba';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typezone.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typezone.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_cnig2017.lt_typezone(
            code, valeur)
    VALUES
    ('U','Urbaine'),
    ('AUc','A urbaniser'),
    ('AUs','A urbaniser bloquée'),
    ('A','Agricole'),
    ('N','Naturel et forestière');

-- ################################################################# Domaine valeur - lt_destdomi #############################################

-- Table: m_urbanisme_doc_cnig2017.lt_destdomi

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_destdomi;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_destdomi
(
  code character (2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_destdomi_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_destdomi
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_destdomi TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_destdomi TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_destdomi TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_destdomi
  IS 'Liste des valeurs de l''attribut destdomi de la donnée zone_urba';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_destdomi.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_destdomi.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_cnig2017.lt_destdomi(
            code, valeur)
    VALUES
    ('00','Sans objet ou non encore définie dans le règlement'),
    ('01','Habitat'),
    ('02','Activité'),
    ('03','Destination mixte habitat/activité'),
    ('04','Loisirs et tourisme'),
    ('05','Equipement'),
    ('07','Activité agricole'),
    ('08','Espace naturel'),
    ('09','Espace remarquable'),
    ('10','Secteur de carrière'),
    ('99','Autre');


-- ################################################################# Domaine valeur - lt_typesect #############################################


-- Table: m_urbanisme_doc_cnig2017.lt_typesect

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_typesect;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_typesect
(
  code character varying(2) NOT NULL, -- Code
  valeur character varying(100) NOT NULL, -- Valeur
  CONSTRAINT lt_typesect_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_typesect
  OWNER TO sig_create;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_typesect TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typesect TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_typesect TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_typesect
  IS 'Liste des valeurs de l''attribut typesect de la donnée zone_urba';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typesect.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typesect.valeur IS 'Valeur';


INSERT INTO m_urbanisme_doc_cnig2017.lt_typesect(
            code, valeur)
    VALUES
    ('ZZ','Non concerné'),
    ('01','Secteur ouvert à la construction'),
    ('02','Secteur réservé aux activités'),
    ('03','Secteur non ouvert à la construction, sauf exceptions prévues par la loi'),
    ('99','Zone non couverte par la carte communale');

-- ################################################################# Domaine valeur - lt_libsect #############################################

-- Table: m_urbanisme_doc_cnig2017.lt_libsect

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_libsect;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_libsect
(
  code character varying(3) NOT NULL,
  valeur character varying(100) NOT NULL,
  CONSTRAINT lt_libsect_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_libsect
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_libsect TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_libsect TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_libsect TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_libsect
  IS 'Liste des valeurs de l''attribut libelle à saisir pour la carte communale (convention de libellé pour l''affichage cartographique)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_libsect.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_libsect.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_cnig2017.lt_libsect(
            code, valeur)
    VALUES
    ('ZC','Secteur ouvert à la construction'),
    ('ZCa','Secteur réservé aux activités'),
    ('ZnC','Secteur non ouvert à la construction, sauf exceptions prévues par la loi'),
    ('RNU','Zone non couverte par la carte communale (soumise au Règlement National de l''Urbanisme');


-- ################################################################# Domaine valeur - lt_typepsc #############################################

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------
-- La liste de valeurs des prescriptions est celle fournie par le modèle, et contient dans une seule table le code et sous-code (une clé étrangère composéea été créée)
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc_cnig2017.lt_typepsc

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_typepsc;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_typepsc
(
  code character(2) NOT NULL,
  sous_code character varying(2) NOT NULL,
  valeur character varying(254) NOT NULL,
  ref_leg character varying(80),
  ref_reg character varying(80),
  CONSTRAINT lt_typepsc_pkey PRIMARY KEY (code,sous_code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_typepsc
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_typepsc TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typepsc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_typepsc TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_typepsc
  IS 'Liste des valeurs de l''attribut typepsc de la donnée prescription_surf, prescription_lin et prescription_pct';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typepsc.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typepsc.sous_code IS 'Sous code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typepsc.valeur IS 'Valeur';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typepsc.ref_leg IS 'Références législatives du code de l''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typepsc.ref_reg IS 'Références réglementaires du code de l''urbanisme';

INSERT INTO m_urbanisme_doc_cnig2017.lt_typepsc(
            code, sous_code, valeur, ref_leg, ref_reg)
    VALUES
    ('01','00','Espace boisé classé','L113-1','R151-31 1°'),
    ('01','01','Espace boisé classé à protéger ou conserver','L113-1','R151-31 1°'),
    ('01','02','Espace boisé classé à créer','L113-1','R151-31 1°'),
    ('01','03','Espace boisé classé significatif au titre de la loi littoral','L121-27',null),
    ('02','00','Limitations de la constructibilité pour des raisons environnementales, de risques,d''intérêt général',null,'R151-31 2° et R151-34 1°'),
    ('02','01','Secteur avec interdiction de constructibilité pour des raisons environnementales,de risques, d''intérêt général',null,'R151-31 2°'),
    ('02','02','Secteur avec conditions spéciales de constructibilité pour des raisons environnementales, de risques, d''intérêt général',null,'R151-34 1°'),
    ('03','00','Secteur avec disposition de reconstruction / démolition','L151-10','R151-34 3°'),
    ('03','01','Secteur dans lequel la reconstruction à l''identique d''un bâtiment détruit par un sinistre n''est pas autorisée',null,'R161-7'),
    ('03','02','Interdiction de restauration de bâtiment dont il reste l''essentiel des murs porteurs','L111-23',null),
    ('04','00','Périmètre issu des PDU sur obligation de stationnement','L151-47 dernier alinéa',null),
    ('05','00','Emplacement réservé','L151-41 1° à 3°','R151-48 2°,R151-50 1°,R151-34 4°,R151-43 3°'),
    ('05','01','Emplacement réservé aux voies publiques','L151-41 1°','R151-48 2°'),
    ('05','02','Emplacement réservé aux ouvrages publics','L151-41 1°','R151-50 1°'),
    ('05','03','Emplacement réservé aux installations d''intérêt général','L151-41 2°','R151-34 4°'),
    ('05','04','Emplacement réservé aux espaces verts/continuités écologiques','L151-41 3°','R151-43 3°'),
    ('05','05','Emplacement réservé logement social/mixité sociale','L151-41 4°','R151-38 1°'),
    ('05','06','Servitude de localisation des voies, ouvrages publics, installations d''intérêt général et espaces verts en zone U ou AU','L151-41 dernier alinéa',null),
    ('05','07','Secteur de projet en attente d''un projet d''aménagement global','L151-41 5°','R151-32'),
    ('06','06','Secteur à densité maximale pour les reconstructions ou aménagements de bâtiments existants','Abrogé','Abrogé'),
    ('07','00','Patrimoine bâti, paysager ou éléments de paysages à protéger pour des motifs d''ordre culturel, historique, architectural ou écologique','L151-19 et L151-23','R151-41 3° et R151-43 5°'),
    ('07','01','Patrimoine bâti à protéger pour des motifs d''ordre culturel, historique, architectural','L151-19','R151-41 3°'),
    ('07','02','Patrimoine paysager à protéger pour des motifs d''ordre culturel, historique, architectural','L151-19','R151-41 3°'),
    ('07','03','Patrimoine paysager correspondant à un espacer boisé à protéger pour des motifs d''ordre culturel, historique, architectural','L151-19','R151-41 3°'),
    ('07','04','Éléments de paysage, (sites et secteurs) à préserver pour des motifs d''ordre écologique','L151-23','R151-43 5°'),
    ('07','05','Éléments de paysage correspondant à un espace boisé, (sites et secteurs) à préserver pour des motifs d''ordre écologique','L151-23 al.1','R151-43 5°'),
    ('08','00','Terrain cultivé ou non bâti à protéger en zone urbaine','L151-23 al. 2','R151-43 6°'),
    ('13','00','Zone à aménager en vue de la pratique du ski','L151-38 al. 2','R151-48 3°'),
    ('14','00','Secteur de plan de masse',null,'R151-40'),
    ('15','00','Règles d''implantation des constructions','L151-17 et L151-18 ?','R151-39 dernier alinéa'),
    ('15','01','Implantation des constructions par rapport aux voies et aux emprises publiques','L151-18',null),
    ('15','02','Implantation des constructions par rapport aux limites séparatives latérales','L151-18',null),
    ('15','03','Implantation des constructions par rapport aux limites des fonds de parcelles','L151-18 ?',null),
    ('15','98','Implantation alternative des constructions','L151-17',null),
    ('16','00','Constructions et installations nécessaires à des équipements collectifs','L151-11 1°',null),
    ('16','01','Bâtiment susceptible de changer de destination','L151-11 2°',null),
    ('16','02','Bâtiments d''habitation existants pouvant faire l''objet d’extensions ou d’annexes','L151-12',null),
    ('16','03','Secteur de taille et de capacité d''accueil limitées (STECAL)','L151-13',null),
    ('17','00','Secteur à programme de logements mixité sociale en zone U et AU','L151-15','R151-38 3°'),
    ('18','00','Secteur comportant des orientations d''aménagement et de programmation (OAP)','L151-6 et L151-7',null),
    ('18','01','OAP de projet (sans règlement)','L151-6 et L151-7','R151-8'),
    ('18','02','OAP entrées de ville','L151-6 et L151-7 1°','R151-6'),
    ('18','03','OAP relatives à la réhabilitation, la restructuration, la mise en valeur ou l''aménagement','L.151-7 4°',null),
    ('18','04','OAP d''adaptation des périmètres de transports collectifs','L151-7 6°',null),
    ('18','05','OAP patrimoniales, architecturales et écologiques','L151-6 et L151-7','R151-7'),
    ('18','06','OAP relatives à l''habitat','L151-6 ou L151-46',null),
    ('18','07','OAP comprenant des dispositions relatives à l''équipement commercial et artisanal','L151-6 2e alinéa ou L151-7 2°',null),
    ('18','08','OAP relatives aux transports et aux déplacements','L151-6 ou L151-47',null),
    ('19','00','Secteur protégé en raison de la richesse du sol et du sous-sol',null,'R.151-34 2°'),
    ('20','00','Secteur à transfert de constructibilité en zone N','L151-25','R151-36'),
    ('22','00','Diversité commerciale à protéger ou à développer','L151-16','R151-37 4°'),
    ('22','01','Diversité commerciale à protéger','L151-16','R151-37 4°'),
    ('22','02','Diversité commerciale à développer','L151-16','R151-37 4°'),
    ('22','03','Linéaire commercial protégé','L151-16','R151-37 4°'),
    ('22','04','Linéaire commercial protégé renforcé','L151-16','R151-37 4°'),
    ('23','00','Secteur avec taille minimale des logements en zone U et AU','L151-14','R151-38 2°'),
    ('24','00','Voies, chemins, transport public à conserver et à créer','L151-38','R151-48 1°'),
    ('24','01','Voies de circulation à créer, modifier ou conserver','L151-38','R151-48 1°'),
    ('24','02','Voies de circulation à modifier','L151-38','R151-48 1°'),
    ('24','03','Voies de circulation à créer','L151-38','R151-48 1°'),
    ('24','04','Voies de circulation à conserver','L151-38','R151-48 1°'),
    ('25','00','Eléments de continuité écologique et trame verte et bleue','L151-23 al. 2','R151-43 4° et R151-43-8°'),
    ('26','00','Secteur de performance énergétique','L151-21','R151-42 1°'),
    ('26','01','Secteur de performance énergétique renforcé','L151-21','R151-42 2°'),
    ('27','00','Secteur d’aménagement numérique','L151-40','R151-50 2°'),
    ('28','00','Conditions de desserte',null,' R151-47 1° et 2°'),
    ('28','01','Conditions permettant une bonne desserte des terrains par les services publics de collecte des déchets',null,'R151-47 2°'),
    ('29','00','Secteur avec densité minimale de construction',null,'R151-39 2e alinéa'),
    ('29','01','Secteur avec densité minimale de construction à proximité des transports collectifs','L151-26',null),
    ('30','00','Majoration des volumes constructibles',null,'R151-37 2°'),
    ('30','01','Majoration des volumes constructibles pour l''habitation','L151-28 1°','R151-37 5°'),
    ('30','02','Majoration des volumes constructibles pour les programmes comportant des logements locatifs sociaux','L151-28 2°','R151-37 2°'),
    ('30','03','Majoration des volumes constructibles pour exemplarité énergétique ou environnementale','L151-28 3°','R151-42 3°'),
    ('30','04','Majoration des volumes constructibles pour les programmes comportant des logements intermédiaires','L151-28 4°','R151-37 7°'),
    ('31','00','Espaces remarquables du littoral','L121-23','R121-4 1° à 8°'),
    ('31','01','Dunes, landes côtières, plages et lidos, estrans, falaises et abords','L121-23','R121-4 1°'),
    ('31','02','Forêts et zones boisées proches du rivage de la mer et des plans d''eau intérieurs d''une superficie supérieure à 1 000 hectares','L121-23','R121-4 2°'),
    ('31','03','Ilots inhabités','L121-23','R121-4 3°'),
    ('31','04','Parties naturelles des estuaires, des rias ou abers et des caps','L121-23','R121-4 4°'),
    ('31','05','Marais, vasières, tourbières, plans d''eau, les zones humides et milieux temporairement immergés','L121-23','R121-4 5°'),
    ('31','06','Milieux abritant des concentrations naturelles d''espèces animales ou végétales','L121-23','R121-4 6°'),
    ('31','07','Parties naturelles des sites inscrits ou classés','L121-23','R121-4 7°'),
    ('31','08','Formations géologiques','L121-23','R121-4 8°'),
    ('32','00','Exclusion protection de plans d''eau de faible importance','L122-12','R122-2'),
    ('33','00','Secteur de dérogation aux protections des rives des plans d''eau en zone de montagne','L122-14 1°',null),
    ('34','00','Espaces, paysage et milieux caractéristiques du patrimoine naturel et culturel montagnard à préserver','L122-9°',null),
    ('35','00','Terres nécessaires au maintien et au développement des activités agricoles, pastorales et forestières à préserver','L122-10',null),
    ('36','00','Mixité des destinations ou sous-destinations',null,'R151-37 1°'),
    ('37','00','Règles différenciées entre le rez-de-chaussée et les étages supérieurs des constructions',null,'R151-37 3°'),
    ('37','01','Règles différenciées pour le rez-de-chaussée en raison des risques inondations',null,'R151-42 4°'),
    ('37','02','Règles différenciées pour mixité sociale et fonctionnelle',null,'R151-37 1° et 3°'),
    ('38','00','Emprise au sol',null,'R151-39'),
    ('38','01','Emprise au sol minimale',null,'R151-39 2e alinéa'),
    ('38','02','Emprise au sol maximale',null,'R151-39 1er alinéa'),
    ('38','97','Emprise au sol règles qualitatives',null,'R151-39 dernier alinéa'),
    ('38','98','Emprise au sol règles alternatives',null,'R151-41 1°'),
    ('39','00','Hauteur',null,'R151-39'),
    ('39','01','Hauteur minimale',null,'R151-39 2e alinéa'),
    ('39','02','Hauteur maximale',null,'R151-39 1er alinéa'),
    ('39','97','Hauteur règles qualitatives',null,'R151-39 dernier alinéa'),
    ('39','98','Hauteur règles alternatives',null,'R151-41 1°'),
    ('40','00','Volumétrie',null,'R151-39'),
    ('40','01','Volumétrie minimale',null,null),
    ('40','02','Volumétrie maximale',null,null),
    ('40','97','Règles volumétriques qualitatives',null,'R151-39 dernier alinéa'),
    ('40','98','Règles volumétriques alternatives',null,'R151-41 1°'),
    ('41','00','Aspect extérieur','L151-18','R151-41 2°'),
    ('41','01','Aspect extérieur façades','L151-18','R151-41 2°'),
    ('41','02','Aspect extérieur toitures','L151-18','R151-41 2°'),
    ('41','03','Aspect extérieur clôtures','L151-18','R151-41 2°'),
    ('41','98','Aspect extérieur règles alternatives',null,'R151-13'),
    ('42','00','Coefficient de biotope par surface','L151-22','R151-43 1°'),
    ('43','00','Réalisation d''espaces libres, plantations, aires de jeux et de loisir',null,'R151-43 2° et 8°'),
    ('43','01','Réalisation d''espaces libres',null,'R151-43 2°'),
    ('43','02','Réalisation d''aires de jeux et de loisirs',null,'R151-43 2°'),
    ('43','03','Réglementation des plantations',null,'R151-43 8°'),
    ('44','00','Stationnement',null,null),
    ('44','01','Stationnement minimal','L151-30 à L151-37',null),
    ('44','02','Stationnement maximal','L151-30 à L151-37','R151-45 3°'),
    ('44','03','Caractéristiques et type de stationnement',null,'R151-45 1°'),
    ('44','04','Minoration des règles de stationnement',null,'R151-45 2°'),
    ('44','98','Stationnement règles alternatives',null,'R151-13'),
    ('45','00','Zone d''aménagement concerté (surface de plancher, destination)','L151-27',null),
    ('46','00','Constructibilité espace boisé antérieur au 20ème siècle','L151-20',null),
    ('47','00','Desserte par les réseaux','L151-39','R151-49'),
    ('47','01','Réseaux publics d''eau','L151-39','R151-49'),
    ('47','02','Réseaux publics d''électricité','L151-39','R151-49'),
    ('47','03','Réseaux publics d''assainissement','L151-39','R151-49'),
    ('47','04','Conditions de réalisation d''un assainissement non collectif','L151-39','R151-49'),
    ('47','05','Infrastructures et réseaux de communications électroniques','L151-39','R151-49 3°'),
    ('48','00','Mesures pour limiter l''imperméabilisation des sols',null,'R151-49 2°'),
    ('48','01','Installations nécessaires à la gestion des eaux pluviales et du ruissellement',null,'R151-43 7° et R151-49 2°'),
    ('49','00','Opération d''ensemble imposée en zone AU',null,'R151-20'),
    ('49','01','Urbanisation par opération d''ensemble',null,'R151-20 2'),
    ('49','02','Urbanisation conditionnée à la réalisation des équipements internes à la zone',null,'R151-20 2'),
    ('50','00','Interdiction types d''activités, destinations, sous-destinations','L151-9','R151-30'),
    ('51','00','Autorisation sous conditions types d''activités, destinations, sous-destinations','L151-9','R151-33'),
    ('99','00','Autre',null,'R151-27 à R151-29'),
    ('99','01','Autre : affectation des sols et destination des constructions','L151-9 à L151-10','R151-30 à R151-36'),
    ('99','02','Autre : zones naturelles, agricoles ou forestières','L151-11 à L151-13','R151-17 à R151-26'),
    ('99','03','Autre : mixité sociale et fonctionnelle en zones urbaines ou à urbaniser','L151-14 à L151-16','R151-37 à R151-38'),
    ('99','04','Autre : qualité du cadre de vie','L151-17 à L151-25',null),
    ('99','05','Autre : Qualité urbaine, architecturale, environnementale et paysagère',null,'R151-41 à R151-42'),
    ('99','06','Autre : Traitement environnemental et paysager des espaces non bâtis et abords des constructions',null,'R151-43'),
    ('99','07','Autre : densité','L151-26 à L151-29-1',null),
    ('99','08','Autre : équipements, réseaux et emplacements réservés','L151-38 à L151-42','R151-47 à R151-50'),
    ('99','09','Autre : plan local d''urbanisme tenant lieu de programme local de l''habitat et de plan de déplacements urbains','L151-44 à L151-48','R151-54 à R151-55'),
    ('99','10','Autre : plan local d''urbanisme tenant lieu de programme de déplacements urbains',null,'R151-54 à R151-55');


-- ################################################################# Domaine valeur - lt_typeinf #############################################

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------
-- La liste de valeurs des informations est celle fournie par le modèle, et contient dans une seule table le code et sous-code (une clé étrangère composéea été créée)
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc_cnig2017.lt_typeinf

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_typeinf;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_typeinf
(
  code character(2) NOT NULL,
  sous_code character varying(2) NOT NULL,
  valeur character varying(254) NOT NULL,
  ref_leg character varying(80),
  ref_reg character varying(80),
  CONSTRAINT lt_typeinf_pkey PRIMARY KEY (code,sous_code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_typeinf
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_typeinf TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typeinf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_typeinf TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_typeinf
  IS 'Liste des valeurs de l''attribut typeinf de la donnée info_surf, info_lin et info_pct';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typeinf.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typeinf.sous_code IS 'Sous code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typeinf.valeur IS 'Valeur';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typeinf.ref_leg IS 'Références législatives du code de l''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typeinf.ref_reg IS 'Références réglementaires du code de l''urbanisme';

INSERT INTO m_urbanisme_doc_cnig2017.lt_typeinf(
            code, sous_code, valeur, ref_leg, ref_reg)
    VALUES
	('01','00','Anciennement « Secteur sauvegardé » puis « Site patrimonial remarquable » supprimé car il correspond à une SUP','Abrogé','Abrogé'),
	('02','00','Zone d''aménagement concerté','Livre III code de l''urbanisme','R151-52 8°'),
	('03','00','Zone de préemption dans un espace naturel et sensible (Attention : information facultative non exigée par la loi)','L215-1 du code de l''urbanisme','Pas de référence pour annexion'),
	('04','00','Périmètre de droit de préemption urbain',null,'R151-52 7°'),
	('04','01','Périmètre de droit de préemption urbain renforcé',null,null),
	('05','00','Zone d''aménagement différé',null,'R151-52 7°'),
	('07','00','Périmètre de développement prioritaire économie d''énergie',null,'R151-53 1°'),
	('08','00','Périmètre forestier : interdiction ou réglementation des plantations (code rural et de la pêche maritime), plantations à réaliser et semis d''essence forestière',null,'R151-53 2°'),
	('09','00','Périmètre minier de concession pour l''exploitation ou le stockage',null,'R151-53 3°'),
	('10','00','Zone de recherche et d''exploitation de carrière',null,'R151-53 4°'),
	('11','00','Périmètre des zones délimitées - divisions foncières soumises à déclaration préalable',null,'R151-52 4°'),
	('12','00','Périmètre de sursis à statuer',null,'R151-52 13°'),
	('13','00','Secteur de programme d''aménagement d''ensemble',null,'R151-52 9°'),
	('14','00','Périmètre de voisinage d''infrastructure de transport terrestre',null,'R151-53 5°'),
	('15','00','les Zones Agricoles Protégées abrogées car traitées en SUP A9','Abrogé','Abrogé'),
	('16','00','Site archéologique (Attention : information facultative non exigée par la loi)','L522-5 2e alinéa du code du patrimoine sans obligation pour le PLU',null),
	('17','00','Zone à risque d''exposition au plomb',null,'R151-53 6°'),
	('19','01','Zone d''assainissement collectif/non collectif, eaux usées/eaux pluviales, schéma de réseaux eau et assainissement, systèmes d''élimination des déchets',null,'R151-53 8° (zone)'),
	('19','02','Emplacements traitement eaux et déchets',null,'R151-53 8° (emplacement)'),
	('20','00','Règlement local de publicité','L581-14 code de l''environnement','R151-53 11°'),
	('21','00','Projet de plan de prévention des risques','L562-2 code de l’environnement','R151-53 9°'),
	('22','00','Protection des rives des plans d''eau en zone de montagne','L122-12',null),
	('23','00','Arrêté du préfet coordonnateur de massif',null,'R151-52 6°'),
	('25','00','Périmètre de protection des espaces agricoles et naturels périurbain',null,'R151-52 3°'),
	('26','00','Lotissement','Abrogé','Abrogé'),
	('27','00','Plan d''exposition au bruit des aérodromes',null,'R151-52 2°'),
	('30','00','Périmètre projet urbain partenarial',null,'R151-52 12°'),
	('31','00','Périmètre patrimoniaux d''exclusion des matériaux et énergies renouvelables pris par délibération','L151-17 2°','R151-52 1°'),
	('32','00','Secteur de taxe d''aménagement',null,'R151-52 10°'),
	('33','00','Droit de préemption commercial (Attention : information facultative non exigée par la loi)','L 214-1','Aucune base pour report en annexe PLU - R 214-1 et 2'),
	('34','00','Périmètre d''opération d''intérêt national (Attention : information facultative non exigée par la loi)','L102-12','Aucune base pour report en annexe PLU – R102-3'),
	('35','00','Périmètre de secteur affecté par un seuil minimal de densité',null,'R151-52 11°'),
	('36','00','Schémas d''aménagement de plage',null,'R151-52 5°'),
	('37','00','Bois ou forêts relevant du régime forestier',null,'R151-53 7°'),
	('38','00','Secteurs d''information sur les sols',null,'R151-53 10°'),
	('39','00','Périmètres de projets AFUP (dans lesquels les propriétaires fonciers sont incités à se regrouper en AFU de projet et les AFU de projet à mener leurs opérations de façon concertée)','L322-13','R151-52 14°'),
	('98','00','Périmètre d''annulation partielle',null,null),
	('99','00','Autre périmètre, secteur, plan, document, site, projet, espace',null,null),
	('99','01','Autre relevant de la loi littoral',null,null),
	('99','02','Autre relevant de la loi montagne',null,null);




-- ####################################################################################################################################################
-- ###                                                  DOMAINES DE VALEURS SPECIFIQUE PNR-OLV                                                      ###
-- ####################################################################################################################################################




-- COMMENT GB : ----------------------------------------------------------------------------------------------------------------------------
-- A décommenter pour la création de la structure des tables des domaines de valeurs spécifiques PNR-OLV
-- les noms de champs dans les tables de valeurs ont été modifiés pour plus cohérence (code, valeur)
-- A vérifier par le PNR et OLV avant intégration
-- -----------------------------------------------------------------------------------------------------------------------------------------

-- ################################################################# Domaine valeur - lt_dispon #############################################

-- Table: m_urbanisme_doc_cnig2017.lt_dispon

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_dispon;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.lt_dispon
-- (
--   code character(2) NOT NULL, -- Code
--   valeur character varying(254) NOT NULL, -- Valeur
--   CONSTRAINT lt_dispon_prkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.lt_dispon
--   OWNER TO sig_create;
-- GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_dispon TO edit_sig;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_dispon TO create_sig;
-- GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_dispon TO read_sig;

-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_dispon
--   IS 'Liste des valeurs de l''attribut l_dispon de la donnée doc_urba_doc';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_dispon.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_dispon.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc_cnig2017.lt_dispon(
--             code, valeur)
--     VALUES
--     ('00','Aucun document numérique'),
--     ('10','Document disponible sur CD'),
--     ('11','Document disponible sur CD et codifié selon proposition du standard CNIG'),
--     ('20','Document disponible sur serveur'),
--     ('21','Document disponible sur serveur et codifié selon proposition du standard CNIG'),
--     ('30','Document dispnible en ligne'),
--     ('31','Document disponible en ligne et codifié selon proposition du standard CNIG'),
--     ('40','Règlement disponible en lien avec le zonage (accès réservé)'),
--     ('50','Tous les documents sont disponibles sur serveur, en ligne et règlement en lien avec le zonage'),
--     ('51','Tous les documents sont disponibles sur serveur, en ligne et règlement en lien avec le zonage et codifié selon proposition du standard CNIG');


-- ################################################################# Domaine valeur - lt_dispop #############################################

-- Table: m_urbanisme_doc_cnig2017.lt_dispop

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_dispop;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.lt_dispop
-- (
--   code character(2) NOT NULL, -- Code
--   valeur character varying(254) NOT NULL, -- Valeur
--   CONSTRAINT lt_dispop_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.lt_dispop
--   OWNER TO sig_create;
-- GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_dispop TO edit_sig;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_dispop TO create_sig;
-- GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_dispop TO read_sig;

-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_dispop
--   IS 'Liste des valeurs de l''attribut l_dispop de la donnée doc_urba_doc';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_dispop.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_dispop.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc_cnig2017.lt_dispop(
--             code, valeur)
--     VALUES
--     ('00','Aucun document papier'),
--     ('10','Une partie du document (la plupart du temps le rapport de présentation, padd, règlement écrit et graphique)'),
--     ('20','Tout le document');


-- ################################################################# Domaine valeur - lt_l_themapatnat #############################################

-- Table: m_urbanisme_doc_cnig2017.lt_l_themapatnat

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_l_themapatnat;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.lt_l_themapatnat
-- (
--   code character varying(10) NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_thema_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.lt_l_themapatnat
--   OWNER TO sig_create;
-- GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_l_themapatnat TO edit_sig;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_l_themapatnat TO create_sig;
-- GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_l_themapatnat TO read_sig;

-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_l_themapatnat
--   IS 'Liste des valeurs de l''attribut l_thema de la donnée zone_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_themapatnat.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_themapatnat.valeur IS 'Valeur';
-- 
-- 
-- INSERT INTO m_urbanisme_doc_cnig2017.lt_l_themapatnat(
--             code, valeur)
--     VALUES
--     ('aucun','aucun'),
--     ('CE','Corridor ecologique'),
--     ('N2000','Natura 2000'),
--     ('Paysage','Paysage'),
--     ('ZH','Zones humides');


-- ################################################################# Domaine valeur - lt_l_vigipatnat #############################################

-- Table: m_urbanisme_doc_cnig2017.lt_l_vigipatnat

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_l_vigipatnat;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.lt_l_vigipatnat
-- (
--   code character varying(10) NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_vigilance_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.lt_l_vigipatnat
--   OWNER TO sig_create;
-- GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_l_vigipatnat TO edit_sig;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_l_vigipatnat TO create_sig;
-- GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_l_vigipatnat TO read_sig;

-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_l_vigipatnat
--   IS 'Liste des valeurs de l''attribut l_vigilance de la donnée zone_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_vigipatnat.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_vigipatnat.valeur IS 'Valeur';
-- 
-- 
-- INSERT INTO m_urbanisme_doc_cnig2017.lt_l_vigipatnat(
--             code, valeur)
--     VALUES
--     ('oui','oui'),
--     ('non','non');


-- ################################################################# Domaine valeur - lt_l_pecpatnat #############################################

-- Table: m_urbanisme_doc_cnig2017.lt_l_pecpatnat

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_l_pecpatnat;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.lt_l_pecpatnat
-- (
--   code character varying(50) NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_pec_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.lt_l_pecpatnat
--   OWNER TO sig_create;
-- GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_l_pecpatnat TO edit_sig;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_l_pecpatnat TO create_sig;
-- GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_l_pecpatnat TO read_sig;

-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_l_pecpatnat
--   IS 'Liste des valeurs de l''attribut l_prisencompte de la donnée doc_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_pecpatnat.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_pecpatnat.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc_cnig2017.lt_l_pecpatnat(
--             code, valeur)
--     VALUES
--     ('diagnostic','dans diagnostic'),
--     ('non concerne','non concerné'),
--     ('PADD','dans PADD'),
--     ('pas de prise en compte','pas de prise en compte'),
--     ('Reglement','dans la réglement');



-- ################################################################# Domaine valeur - lt_l_nspatnat #############################################


-- Table: m_urbanisme_doc_cnig2017.lt_l_nspatnat

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_l_nspatnat;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.lt_l_nspatnat
-- (
--   code bigint NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_nsynt_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.lt_l_nspatnat
--   OWNER TO sig_create;
-- GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.lt_l_nspatnat TO edit_sig;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_l_nspatnat TO create_sig;
-- GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.lt_l_nspatnat TO read_sig;

-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_l_nspatnat
--   IS 'Liste des valeurs de l''attribut l_notesynth de la donnée doc_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_nspatnat.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_nspatnat.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc_cnig2017.lt_l_nspatnat(
--             code, valeur)
--     VALUES
--     ('0','non renseigné'),
--     ('1','peu satisfaisant'),
--     ('2','correct'),
--     ('3','satisfaisant');


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                               TABLES METIERS DOCUMENTS D'URBANISME (hors standard CNIG spécifique ARC)                                       ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ########################################################################## table an_ads_commune #######################################################

-- Table: m_urbanisme_doc_cnig2017.an_ads_commune

-- DROP TABLE m_urbanisme_doc_cnig2017.an_ads_commune;

CREATE TABLE m_urbanisme_doc_cnig2017.an_ads_commune
(
  insee character(5) NOT NULL, -- Code INSEE
  docurba boolean, -- Présence d'un document d'urbanisme (PLUi,PLU,POS,CC)
  ads_arc boolean, -- Gestion de l'ADS par l'ARC
  l_rev character varying(30), -- Information sur la révision en cours ou non du document d'urbanisme
  l_daterev timestamp without time zone, -- Date de prescripiton de la révision
  CONSTRAINT an_doc_commune_pkey PRIMARY KEY (insee)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.an_ads_commune
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.an_ads_commune TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_ads_commune TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.an_ads_commune TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.an_ads_commune
  IS 'Donnée source sur l''état de l''ADS ARC sur les communes';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_ads_commune.insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_ads_commune.docurba IS 'Présence d''un document d''urbanisme (PLUi,PLU,POS,CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_ads_commune.ads_arc IS 'Gestion de l''ADS par l''ARC';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_ads_commune.l_rev IS 'Information sur la révision en cours ou non du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_ads_commune.l_daterev IS 'Date de prescripiton de la révision';

-- ########################################################################## table geo_p_zone_pau #######################################################

-- Sequence: m_urbanisme_doc_cnig2017.idpau_seq

-- DROP SEQUENCE m_urbanisme_doc_cnig2017.idpau_seq;

CREATE SEQUENCE m_urbanisme_doc_cnig2017.idpau_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 99999999999999999
  START 167
  CACHE 1;
ALTER TABLE m_urbanisme_doc_cnig2017.idpau_seq
  OWNER TO sig_create;
GRANT ALL ON SEQUENCE m_urbanisme_doc_cnig2017.idpau_seq TO sig_create;
GRANT SELECT, USAGE ON SEQUENCE m_urbanisme_doc_cnig2017.idpau_seq TO public;



-- Table: m_urbanisme_doc_cnig2017.geo_p_zone_pau

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau
(
  idpau integer NOT NULL DEFAULT nextval('m_urbanisme_doc_cnig2017.idpau_seq'::regclass), -- Identifiant géographique
  date_sai timestamp without time zone, -- Date de saisie des données
  date_maj timestamp without time zone, -- Date de mise à jour
  op_sai character varying(50), -- Opérateur de saisie
  org_sai character varying(100), -- Organisme de saisie
  insee character varying(5), -- Code Insee de la commune
  commune character varying(100), -- Libellé de la commune
  src_geom character varying(2) DEFAULT '00'::character varying, -- Référentiel spatila utilisé pour la saisie
  sup_m2 double precision, -- Surface brute de l'objet en m²
  l_type character varying(50), -- Type de bâti intégré à la PAU
  l_statut boolean DEFAULT true, -- Prise en compte de la PAU (oui : en RNU, non : documents d'urbaniusme en vigieur)
  geom geometry(MultiPolygon,2154), -- Champ contenant la géométrie des objets
  CONSTRAINT geo_p_zone_pau_pkey PRIMARY KEY (idpau),
  CONSTRAINT geo_p_zone_pau_srcgeom_fkey FOREIGN KEY (src_geom)
      REFERENCES r_objet.lt_src_geom (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau
  IS 'Table géométriquer contenant la délimitation des PAU (partie à urbaniser) dans le cadre d''une commune en RNU';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_pau.idpau IS 'Identifiant géographique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_pau.date_sai IS 'Date de saisie des données';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_pau.date_maj IS 'Date de mise à jour';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_pau.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_pau.org_sai IS 'Organisme de saisie';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_pau.insee IS 'Code Insee de la commune';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_pau.commune IS 'Libellé de la commune';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_pau.src_geom IS 'Référentiel spatila utilisé pour la saisie';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_pau.sup_m2 IS 'Surface brute de l''objet en m²';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_pau.l_type IS 'Type de bâti intégré à la PAU';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_pau.l_statut IS 'Prise en compte de la PAU (oui : en RNU, non : documents d''urbaniusme en vigieur)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_pau.geom IS 'Champ contenant la géométrie des objets';


-- Index: m_urbanisme_doc_cnig2017.geo_p_zone_pau_geom_idx

-- DROP INDEX m_urbanisme_doc_cnig2017.geo_p_zone_pau_geom_idx;

CREATE INDEX geo_p_zone_pau_geom_idx
  ON m_urbanisme_doc_cnig2017.geo_p_zone_pau
  USING gist
  (geom);


-- Trigger: t_t1_pau_inseecommune on m_urbanisme_doc_cnig2017.geo_p_zone_pau

-- DROP TRIGGER t_t1_pau_inseecommune ON m_urbanisme_doc_cnig2017.geo_p_zone_pau;

CREATE TRIGGER t_t1_pau_inseecommune
  BEFORE INSERT
  ON m_urbanisme_doc_cnig2017.geo_p_zone_pau
  FOR EACH ROW
  EXECUTE PROCEDURE public.r_commune_s();

-- Trigger: t_t2_pau_insert_date_sai on m_urbanisme_doc_cnig2017.geo_p_zone_pau

-- DROP TRIGGER t_t2_pau_insert_date_sai ON m_urbanisme_doc_cnig2017.geo_p_zone_pau;

CREATE TRIGGER t_t2_pau_insert_date_sai
  BEFORE INSERT
  ON m_urbanisme_doc_cnig2017.geo_p_zone_pau
  FOR EACH ROW
  EXECUTE PROCEDURE public.r_timestamp_sai();

-- Trigger: t_t3_pau_update_date_maj on m_urbanisme_doc_cnig2017.geo_p_zone_pau

-- DROP TRIGGER t_t3_pau_update_date_maj ON m_urbanisme_doc_cnig2017.geo_p_zone_pau;

CREATE TRIGGER t_t3_pau_update_date_maj
  BEFORE UPDATE
  ON m_urbanisme_doc_cnig2017.geo_p_zone_pau
  FOR EACH ROW
  EXECUTE PROCEDURE public.r_timestamp_maj();

-- Trigger: t_t4_pau_surface on m_urbanisme_doc_cnig2017.geo_p_zone_pau

-- DROP TRIGGER t_t4_pau_surface ON m_urbanisme_doc_cnig2017.geo_p_zone_pau;

CREATE TRIGGER t_t4_pau_surface
  BEFORE INSERT OR UPDATE
  ON m_urbanisme_doc_cnig2017.geo_p_zone_pau
  FOR EACH ROW
  EXECUTE PROCEDURE public.r_sup_m2_maj();



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                  TABLES METIERS DOCUMENTS D'URBANISME                                                        ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ####################################################################################################################################################
-- ###                                                  	  MODE PRODUCTION                                                                   ###
-- ####################################################################################################################################################


-- ########################################################################## table an_doc_urba #######################################################

-- Table: m_urbanisme_doc_cnig2017.an_doc_urba

-- DROP TABLE m_urbanisme_doc_cnig2017.an_doc_urba;

CREATE TABLE m_urbanisme_doc_cnig2017.an_doc_urba
(
  idurba character varying(30) NOT NULL, -- identifiant
  typedoc character varying(4) NOT NULL, -- Type du document concerné
  etat character varying(2) NOT NULL, -- Etat juridique du document
  nomproc character varying(10), -- Etat juridique du document
  l_nomprocn integer, -- n° d'ordre de la procédure
  datappro character varying(8), -- Date d'approbation
  datefin character varying(8), -- date de fin de validité
  siren character varying(9), -- Code SIREN de l'intercommunalité si elle est MO du document d'urbanisme
  nomreg character varying(80), -- Nom du fichier de règlement
  urlreg character varying(254), -- URL ou URI du fichier du règlement
  nomplan character varying(80), -- Nom du fichier du plan scanné
  urlplan character varying(254), -- URL ou URI du fichier du plan scanné
  urlpe character varying(254), -- Lien d'accès à l'archive zip comprenant l'ensemble des pièces écrites
  siteweb character varying(254), -- Site web du service d'accès
  typeref character varying(2), -- Type de référentiel utilisé
  dateref character varying(8), -- Date du référentiel de saisie
  l_meta character varying(254), -- Lien http vers la fiche de metadonnées
  l_moa_proc character varying(80), -- Maitre d'ouvrage de la procédure
  l_moe_proc character varying(80), -- Maitre d'oeuvre de la procédure
  l_moa_dmat character varying(80), -- Maitre d'ouvrage de la dématérialisation
  l_moe_dmat character varying(80), -- Maitre d'oeuvre de la dématérialisation
  l_observ character varying(254), -- Observations
  l_parent integer, -- Identification des documents parents pour recherche des historiques entre version de documents (1 pour le premier document (élaboration, modif, mise à jour), 2 pour la révision (révision n°1, modif, mise à jour), 3 pour le 2nd révisoon (révision n°2, modif, mise à jour), ...)
  CONSTRAINT an_doc_urba_pkey PRIMARY KEY (idurba)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_urba
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba
  IS 'Donnée alphanumerique de référence des documents d''urbanisme en projet ou ayant été approuvés';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.typedoc IS 'Type du document concerné';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.datappro IS 'Date d''approbation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.datefin IS 'date de fin de validité';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.siren IS 'Code SIREN de l''intercommunalité';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.etat IS 'Etat juridique du document';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.nomproc IS 'Codage de la version du document concerné';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.l_nomprocn IS 'N° d''ordre de la procédure';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.nomreg IS 'Nom du fichier de règlement';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.urlreg IS 'URL ou URI du fichier du règlement';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.nomplan IS 'Nom du fichier du plan scanné';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.urlplan IS 'URL ou URI du fichier du plan scanné';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.urlpe IS 'Lien d''accès à l''archive zip comprenant l''ensemble des pièces écrites';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.siteweb IS 'Site web du service d''accès';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.typeref IS 'Type de référentiel utilisé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.dateref IS 'Date du référentiel de saisie';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.l_meta IS 'Lien http vers la fiche de métadonnées';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.l_moa_proc IS 'Maitre d''ouvrage de la procédure';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.l_moe_proc IS 'Maitre d''oeuvre de la procédure';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.l_moa_dmat IS 'Maitre d''ouvrage de la dématérialisation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.l_moe_dmat IS 'Maitre d''oeuvre de la dématérialisation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba.l_parent IS 'Identification des documents parents pour recherche des historiques entre version de documents (1 pour le premier document (élaboration, modif, mise à jour), 2 pour la révision (révision n°1, modif, mise à jour), 3 
  pour le 2nd révisoon (révision n°2, modif, mise à jour), ...)';


-- ########################################################################## table an_doc_urba_com #######################################################


-- Table: m_urbanisme_doc_cnig2017.an_doc_urba_com

-- DROP TABLE m_urbanisme_doc_cnig2017.an_doc_urba_com;

CREATE TABLE m_urbanisme_doc_cnig2017.an_doc_urba_com
(
  idurba character varying(30) NOT NULL, -- identifiant
  insee character varying(5) NOT NULL -- code insee de la commune 
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_urba_com
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_com TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_com TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_com TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_com
  IS 'Donnée alphanumerique d''appartenance d''une commune à une procédure définie';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_com.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_com.insee IS 'Code insee de la commune';


-- ########################################################################### table geo_p_zone_urba #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_p_zone_urba

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba
(
  idzone character varying(10) NOT NULL, -- Identifiant unique de zone
  libelle character varying(12) NOT NULL, -- Nom court de la zone
  libelong character varying(254), -- Nom complet de la zone
  typezone character varying(3) NOT NULL, -- Type de la zone
  nomfic character varying(80), -- Nom du fichier contenant le réglement complet
  urlfic character varying(254), -- URL ou URI du fichier du règlement complet
  l_nomfic character varying(80), -- Nom du fichier contenant le règlement de la zone
  l_urlfic character varying(254), -- URL ou URI du fichier du règlement de la zone
  idurba character varying(30) NOT NULL, -- identifiant
  datvalid character varying(8), -- Date de validation (aaaammjj)
  typesect character varying(2) DEFAULT 'ZZ'::character varying, -- Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)
  fermreco character varying(3) NOT NULL DEFAULT 'non', -- Secteur fermé à la reconstruction (uniquement pour la carte communale)
  l_destdomi character varying(2) NOT NULL, -- Vocation de la zone
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_surf_cal numeric NOT NULL, -- Surface calculée de la zone en ha
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_zone_urba_pkey PRIMARY KEY (idzone)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba
  IS 'Donnée géographique contenant les zonages des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.idzone IS 'Identifiant unique de zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.libelle IS 'Nom court de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.libelong IS 'Nom complet de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.typezone IS 'Type de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.l_destdomi IS 'Vocation de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.typesect IS 'Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.fermreco IS 'Secteur fermé à la reconstruction (uniquement pour la carte communale)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.l_surf_cal IS 'Surface calculée de la zone en ha';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.nomfic IS 'Nom du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.urlfic IS 'URL ou URI du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.l_nomfic IS 'Nom du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.l_urlfic IS 'URL ou URI du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba.idurba IS 'Identifiant du document d''urbanisme';


-- ########################################################################### geo_p_prescription_surf #######################################################

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mettre en commentaire la création du champ geom1 et la ligne de commentaire par les partenaires si pas utilisé
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc_cnig2017.geo_p_prescription_surf

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf
(
  idpsc character varying(10) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_nature character varying(254), -- Nature / vocation
  l_bnfcr character varying(80), -- Bénéficiaire
  l_numero character varying(10), -- Numéro
  l_surf_txt character varying(30), -- Superficie littérale
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  geom1 geometry(MultiPolygon,2154), -- Géométrie de l''objet avec un buffer de -0.5 pour calcul de la vue xapps_an_vmr_prescription pour GEO.Champ mis à jour en automatique par un trigger à l''insertion, mise à jour du champ geom
  CONSTRAINT geo_p_prescription_surf_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf
  IS 'Donnée géographique contenant les prescriptions surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.idpsc IS 'Identifiant unique de prescription surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf.geom1 IS 'Géométrie de l''objet avec un buffer de -0.5 pour calcul de la vue an_vmr_prescription pour GEO.Champ mis à jour en automatique par un trigger à l''insertion, mise à jour du champ geom';


-- ########################################################################### geo_p_prescription_lin #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_p_prescription_lin

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin
(
  idpsc character varying(10) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_nature character varying(254), -- Nature / vocation
  l_bnfcr character varying(80), -- Bénéficiaire
  l_numero character varying(10), -- Numéro
  l_surf_txt character varying(30), -- Superficie littérale
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(Multilinestring,2154), -- Géométrie de l'objet
  geom1 geometry(MultiPolygon,2154), -- Géométrie de l''objet avec un buffer de -0.01 pour calcul de la vue xapps_an_vmr_prescription pour GEO.Champ mis à jour en automatique par un trigger à l''insertion, mise à jour du champ geom
  CONSTRAINT geo_p_prescription_lin_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin
  IS 'Donnée géographique contenant les prescriptions linéaires des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.idpsc IS 'Identifiant unique de prescription linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin.geom1 IS 'Géométrie de l''objet avec un buffer de -0.5 pour calcul de la vue an_vmr_prescription pour GEO.Champ mis à jour en automatique par un trigger à l''insertion, mise à jour du champ geom';

-- ########################################################################### geo_p_prescription_pct #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_p_prescription_pct

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct
(
  idpsc character varying(10) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_nature character varying(254), -- Nature / vocation
  l_bnfcr character varying(80), -- Bénéficiaire
  l_numero character varying(10), -- Numéro
  l_surf_txt character varying(30), -- Superficie littérale
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPoint,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_prescription_pct_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct
  IS 'Donnée géographique contenant les prescriptions ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.idpsc IS 'Identifiant unique de prescription ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct.geom IS 'Géométrie de l''objet';


-- ################################################################################ geo_p_info_surf ##########################################################

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mettre en commentaire la création du champ geom1 et la ligne de commentaire par les partenaires si pas utilisé
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc_cnig2017.geo_p_info_surf

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf
(
  idinf character varying(10) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_dateins character(8), -- Date d'instauration
  l_bnfcr character varying(80), -- Bénéficiaire
  l_datdlg character(8), -- Date de délégation
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  geom1 geometry(MultiPolygon,2154), -- Géométrie de l'objet avec un buffer de -0.5 pour calcul de la vue an_vmr_p_information pour GEO. Champ mis à jour en automatique par un trigger à l'insertion, mise à jour du champ geom
  CONSTRAINT geo_p_info_surf_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf
  IS 'Donnée géographique contenant les informations surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.idinf IS 'Identifiant unique de l''information surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.geom1 IS 'Géométrie de l''objet avec un buffer de -0.5 pour calcul de la vue an_vmr_p_information pour GEO. Champ mis à jour en automatique par un trigger à l''insertion, mise à jour du champ geom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf.idurba IS 'Identifiant du document d''urbanisme';

-- ################################################################################ geo_p_info_lin ##########################################################

-- Table: m_urbanisme_doc_cnig2017.geo_p_info_lin

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin
(
  idinf character varying(10) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_dateins character(8), -- Date d'instauration
  l_bnfcr character varying(80), -- Bénéficiaire
  l_datdlg character(8), -- Date de délégation
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiLineString,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_info_lin_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin
  IS 'Donnée géographique contenant les informations linéaires des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.idinf IS 'Identifiant unique de l''information linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin.idurba IS 'Identifiant du document d''urbanisme';


-- ################################################################################ geo_p_info_pct ##########################################################

-- Table: m_urbanisme_doc_cnig2017.geo_p_info_pct

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct
(
  idinf character varying(10) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_dateins character(8), -- Date d'instauration
  l_bnfcr character varying(80), -- Bénéficiaire
  l_datdlg character(8), -- Date de délégation
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(Multipoint,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_info_pct_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct
  IS 'Donnée géographique contenant les informations ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.idinf IS 'Identifiant unique de l''information ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_p_habillage_surf #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_p_habillage_surf

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_surf
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_habillage_surf_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_surf
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_surf TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_surf TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_surf
  IS 'Donnée géographique contenant l''habillage surfacique des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_surf.idhab IS 'Identifiant unique de l''habillage surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_surf.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_surf.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_surf.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_surf.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_p_habillage_lin #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_p_habillage_lin

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_lin
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiLineString,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_habillage_lin_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_lin
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_lin TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_lin TO read_sig;


COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_lin
  IS 'Donnée géographique contenant l''habillage linéaire des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_lin.idhab IS 'Identifiant unique de l''habillage linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_lin.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_lin.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_lin.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_lin.idurba IS 'Identifiant du document d''urbanisme';



-- ######################################################################## geo_p_habillage_pct #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_p_habillage_pct

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_pct
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiPoint,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_habillage_pct_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_pct
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_pct TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_pct TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_pct
  IS 'Donnée géographique contenant l''habillage ponctuel des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_pct.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_pct.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_pct.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_pct.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_p_habillage_txt #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_p_habillage_txt

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage ponctuel
  natecr character varying(40) NOT NULL, -- Nature de l'écriture
  txt character varying(80) NOT NULL, -- Texte de l'écriture
  police character varying(40), -- Police de l'écriture
  taille integer, -- Taille de l'écriture
  style character varying(40), -- Style de l'écriture
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  angle integer, -- Angle de l'écriture exprimé en degré, par rapport à l'horizontale, dans le sens trigonométrique
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiPoint,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_habillage_txt_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt
  IS 'Donnée géographique contenant l''habillage textuel des documents d''urbanisme locaux (PLUi, PLU, POS) sous la forme de ponctuels';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt.natecr IS 'Nature de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt.txt IS 'Texte de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt.police IS 'Police de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt.taille IS 'Taille de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt.style IS 'Style de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt.angle IS 'Angle de l''écriture exprimé en degré, par rapport à l''horizontale, dans le sens trigonométrique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';


-- ####################################################################################################################################################
-- ###                                                  	     MODE ARCHIVE                                                                   ###
-- ####################################################################################################################################################


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Certaines tables archives de l'ARC contiennent une clé primaire autre que l'ID...., nommé gid pour des raisons de modifications éventuelles des données. Ce champ est accompagné d'une séquence générée après la migration des données
-- Les autres tables n'ont pas de clé primaires identifiées (suppression de la clé sur l'id....)
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- ########################################################################### table geo_a_zone_urba #######################################################

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mettre en commentaire la création du champ gid et la ligne de commentaire par les partenaires si pas utilisé
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc_cnig2017.geo_a_zone_urba

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba
(
  idzone character varying(10) NOT NULL, -- Identifiant unique de zone
  libelle character varying(12), -- Nom court de la zone
  libelong character varying(254), -- Nom complet de la zone
  typezone character varying(3) NOT NULL, -- Type de la zone
  nomfic character varying(80), -- Nom du fichier du règlement complet
  urlfic character varying(254), -- URL ou URI du fichier du règlement complet
  l_nomfic character varying(80), -- Nom du fichier du règlement de la zone
  l_urlfic character varying(254), -- URL ou URI du fichier du règlement de la zone
  idurba character varying(30) NOT NULL, -- identifiant
  datvalid character varying(8), -- Date de validation (aaaammjj)
  typesect character varying(2) DEFAULT 'ZZ'::character varying, -- Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)
  fermreco character varying(3) NOT NULL DEFAULT 'non', -- Secteur fermé à la reconstruction (uniquement pour la carte communale)
  l_destdomi character varying(2) NOT NULL, -- Vocation de la zone
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_surf_cal numeric, -- Surface calculée de la zone en ha
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  gid integer NOT NULL, -- Identifiant unique spécifique à l'ARC
  CONSTRAINT geo_a_zone_urba_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba
  IS '(archive) Donnée géographique contenant les zonages des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.idzone IS 'Identifiant unique de zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.libelle IS 'Nom court de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.libelong IS 'Nom complet de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.typezone IS 'Type de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.l_destdomi IS 'Vocation de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.typesect IS 'Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.fermreco IS 'Secteur fermé à la reconstruction (uniquement pour la carte communale)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.l_surf_cal IS 'Surface calculée de la zone en ha';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.nomfic IS 'Nom du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.urlfic IS 'URL ou URI du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.l_nomfic IS 'Nom du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.l_urlfic IS 'URL ou URI du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba.gid IS 'Identifiant unique spécifique à l''ARC';



-- ########################################################################### geo_a_prescription_surf #######################################################

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mettre en commentaire la création du champ geom1 et gid et la ligne de commentaire par les partenaires si pas utilisé
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc_cnig2017.geo_a_prescription_surf

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf
(
  idpsc character varying(10) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_nature character varying(254), -- Nature / vocation
  l_bnfcr character varying(80), -- Bénéficiaire
  l_numero character varying(10), -- Numéro
  l_surf_txt character varying(30), -- Superficie littérale
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  gid integer NOT NULL, -- Identifiant unique spécifique à l'ARC
  CONSTRAINT geo_a_prescription_surf_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf
  IS '(archive) Donnée géographique contenant les prescriptions surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.idpsc IS 'Identifiant unique de prescription surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf.gid IS 'Identifiant unique spécifique à l''ARC';



-- ########################################################################### geo_a_prescription_lin #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_a_prescription_lin

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin
(
  idpsc character varying(10) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_nature character varying(254), -- Nature / vocation
  l_bnfcr character varying(80), -- Bénéficiaire
  l_numero character varying(10), -- Numéro
  l_surf_txt character varying(30), -- Superficie littérale
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(Multilinestring,2154) -- Géométrie de l'objet
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin
  IS '(archive) Donnée géographique contenant les prescriptions linéaires des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.idpsc IS 'Identifiant unique de prescription linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin.geom IS 'Géométrie de l''objet';


-- ########################################################################### geo_a_prescription_pct #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_a_prescription_pct

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct
(
  idpsc character varying(10) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_nature character varying(254), -- Nature / vocation
  l_bnfcr character varying(80), -- Bénéficiaire
  l_numero character varying(10), -- Numéro
  l_surf_txt character varying(30), -- Superficie littérale
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPoint,2154) -- Géométrie de l'objet
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct
  IS '(archive) Donnée géographique contenant les prescriptions ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.idpsc IS 'Identifiant unique de prescription ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct.geom IS 'Géométrie de l''objet';


-- ################################################################################ geo_a_info_surf ##########################################################

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mettre en commentaire la création du champ geom1 et gid et la ligne de commentaire par les partenaires si pas utilisé
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc_cnig2017.geo_a_info_surf

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf
(
  idinf character varying(10) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_dateins character(8), -- Date d'instauration
  l_bnfcr character varying(80), -- Bénéficiaire
  l_datdlg character(8), -- Date de délégation
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  gid integer NOT NULL, --Identifiant unique spécifique à l'ARC
  CONSTRAINT geo_a_info_surf_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf TO read_sig;
  
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf
  IS '(archive) Donnée géographique contenant les informations surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.idinf IS 'Identifiant unique de l''information surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf.gid IS 'Identifiant unique spécifique à l''ARC';

-- ################################################################################ geo_a_info_lin ##########################################################

-- Table: m_urbanisme_doc_cnig2017.geo_a_info_lin

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin
(
  idinf character varying(10) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_dateins character(8), -- Date d'instauration
  l_bnfcr character varying(80), -- Bénéficiaire
  l_datdlg character(8), -- Date de délégation
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiLineString,2154) -- Géométrie de l'objet
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin
  IS '(archive) Donnée géographique contenant les informations linéaires des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.idinf IS 'Identifiant unique de l''information linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin.idurba IS 'Identifiant du document d''urbanisme';


-- ################################################################################ geo_a_info_pct ##########################################################

-- Table: m_urbanisme_doc_cnig2017.geo_a_info_pct

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct
(
  idinf character varying(10) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_dateins character(8), -- Date d'instauration
  l_bnfcr character varying(80), -- Bénéficiaire
  l_datdlg character(8), -- Date de délégation
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(Multipoint,2154) -- Géométrie de l'objet
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct
  IS '(archive) Donnée géographique contenant les informations ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.idinf IS 'Identifiant unique de l''information ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_a_habillage_surf #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_a_habillage_surf

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_surf
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE 
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiPolygon,2154) -- Géométrie de l'objet
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_surf
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_surf TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_surf TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_surf
  IS '(archive) Donnée géographique contenant l''habillage surfacique des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_surf.idhab IS 'Identifiant unique de l''habillage surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_surf.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_surf.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_surf.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_surf.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_a_habillage_lin #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_a_habillage_lin

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_lin
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiLineString,2154) -- Géométrie de l'objet
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_lin
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_lin TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_lin TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_lin
  IS '(archive) Donnée géographique contenant l''habillage linéaire des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_lin.idhab IS 'Identifiant unique de l''habillage linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_lin.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_lin.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_lin.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXE (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_lin.idurba IS 'Identifiant du document d''urbanisme';



-- ######################################################################## geo_a_habillage_pct #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_a_habillage_pct

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_pct
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme hexa (#000000)
  geom geometry(MultiPoint,2154) -- Géométrie de l'objet
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_pct
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_pct TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_pct TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_pct
  IS '(archive) Donnée géographique contenant l''habillage ponctuel des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_pct.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_pct.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_pct.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_pct.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_a_habillage_txt #######################################################

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mettre en commentaire la création du champ gid et la ligne de commentaire par les partenaires si pas utilisé
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc_cnig2017.geo_a_habillage_txt

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_txt;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_txt
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage ponctuel
  natecr character varying(40) NOT NULL, -- Nature de l'écriture
  txt character varying(80) NOT NULL, -- Texte de l'écriture
  police character varying(40), -- Police de l'écriture
  taille integer, -- Taille de l'écriture
  style character varying(40), -- Style de l'écriture
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  angle integer, -- Angle de l'écriture exprimé en degré, par rapport à l'horizontale, dans le sens trigonométrique
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE 
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiPoint,2154), -- Géométrie de l'objet
  gid integer NOT NULL, -- Identifant unique pour l'ARC
  CONSTRAINT geo_a_habillage_txt_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_txt
  IS '(archive) Donnée géographique contenant l''habillage textuel des documents d''urbanisme locaux (PLUi, PLU, POS) sous la forme de ponctuels';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt.natecr IS 'Nature de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt.txt IS 'Texte de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt.police IS 'Police de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt.taille IS 'Taille de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt.style IS 'Style de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt.angle IS 'Angle de l''écriture exprimé en degré, par rapport à l''horizontale, dans le sens trigonométrique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt.gid IS 'Identifiant unique pour l''ARC';



-- ####################################################################################################################################################
-- ###                                                 	      MODE TEST (pré-production)                                                            ###
-- ####################################################################################################################################################

-- ########################################################################### table geo_t_zone_urba #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_t_zone_urba

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba
(
  idzone character varying(10) NOT NULL, -- Identifiant unique de zone
  libelle character varying(12), -- Nom court de la zone
  libelong character varying(254), -- Nom complet de la zone
  typezone character varying(3) NOT NULL, -- Type de la zone
  nomfic character varying(80), -- Nom du fichier du règlement complet
  urlfic character varying(254), -- URL ou URI du fichier du règlement complet
  l_nomfic character varying(80), -- Nom du fichier du règlement de la zone
  l_urlfic character varying(254), -- URL ou URI du fichier du règlement de la zone
  idurba character varying(30), -- identifiant
  datvalid character varying(8), -- Date de validation (aaaammjj)
  typesect character varying(2) DEFAULT 'ZZ'::character varying, -- Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)
  fermreco character varying(3) NOT NULL DEFAULT 'non', -- Secteur fermé à la reconstruction (uniquement pour la carte communale)
  l_destdomi character varying(2) NOT NULL, -- Vocation de la zone
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_surf_cal numeric NOT NULL, -- Surface calculée de la zone en ha
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_zone_urba_pkey PRIMARY KEY (idzone)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba
  IS '(test) Donnée géographique contenant les zonages des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.idzone IS 'Identifiant unique de zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.libelle IS 'Nom court de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.libelong IS 'Nom complet de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.typezone IS 'Type de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.l_destdomi IS 'Vocation de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.typesect IS 'Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.fermreco IS 'Secteur fermé à la reconstruction (uniquement pour la carte communale)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.l_surf_cal IS 'Surface calculée de la zone en ha';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.nomfic IS 'Nom du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.urlfic IS 'URL ou URI du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.l_nomfic IS 'Nom du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.l_urlfic IS 'URL ou URI du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba.idurba IS 'Identifiant du document d''urbanisme';


-- ########################################################################### geo_t_prescription_surf #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_t_prescription_surf

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf
(
  idpsc character varying(10) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30), -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_nature character varying(254), -- Nature / vocation
  l_bnfcr character varying(80), -- Bénéficiaire
  l_numero character varying(10), -- Numéro
  l_surf_txt character varying(30), -- Superficie littérale
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_prescription_surf_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf
  IS '(test) Donnée géographique contenant les prescriptions surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.idpsc IS 'Identifiant unique de prescription surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf.geom IS 'Géométrie de l''objet';


-- ########################################################################### geo_t_prescription_lin #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_t_prescription_lin

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin
(
  idpsc character varying(10) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30), -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_nature character varying(254), -- Nature / vocation
  l_bnfcr character varying(80), -- Bénéficiaire
  l_numero character varying(10), -- Numéro
  l_surf_txt character varying(30), -- Superficie littérale
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(Multilinestring,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_prescription_lin_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin
  IS '(test) Donnée géographique contenant les prescriptions linéaires des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.idpsc IS 'Identifiant unique de prescription linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin.geom IS 'Géométrie de l''objet';


-- ########################################################################### geo_t_prescription_pct #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_t_prescription_pct

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct
(
  idpsc character varying(10) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30), -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_nature character varying(254), -- Nature / vocation
  l_bnfcr character varying(80), -- Bénéficiaire
  l_numero character varying(10), -- Numéro
  l_surf_txt character varying(30), -- Superficie littérale
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPoint,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_prescription_pct_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct
  IS '(test) Donnée géographique contenant les prescriptions ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.idpsc IS 'Identifiant unique de prescription ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct.geom IS 'Géométrie de l''objet';


-- ################################################################################ geo_t_info_surf ##########################################################

-- Table: m_urbanisme_doc_cnig2017.geo_t_info_surf

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf
(
  idinf character varying(10) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30), -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_dateins character(8), -- Date d'instauration
  l_bnfcr character varying(80), -- Bénéficiaire
  l_datdlg character(8), -- Date de délégation
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_info_surf_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf
  IS 'test) Donnée géographique contenant les informations surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.idinf IS 'Identifiant unique de l''information surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf.idurba IS 'Identifiant du document d''urbanisme';

-- ################################################################################ geo_t_info_lin ##########################################################

-- Table: m_urbanisme_doc_cnig2017.geo_t_info_lin

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin
(
  idinf character varying(10) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30), -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_dateins character(8), -- Date d'instauration
  l_bnfcr character varying(80), -- Bénéficiaire
  l_datdlg character(8), -- Date de délégation
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiLineString,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_info_lin_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin
  IS '(test) Donnée géographique contenant les informations linéaires des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.idinf IS 'Identifiant unique de l''information linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin.idurba IS 'Identifiant du document d''urbanisme';


-- ################################################################################ geo_t_info_pct ##########################################################

-- Table: m_urbanisme_doc_cnig2017.geo_t_info_pct

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct
(
  idinf character varying(10) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30), -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(80), -- Nom
  l_dateins character(8), -- Date d'instauration
  l_bnfcr character varying(80), -- Bénéficiaire
  l_datdlg character(8), -- Date de délégation
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(Multipoint,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_info_pct_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct
OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct
  IS '(test) Donnée géographique contenant les informations ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.idinf IS 'Identifiant unique de l''information ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_t_habillage_surf #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_t_habillage_surf

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_surf
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30), -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_habillage_surf_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_surf
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_surf TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_surf TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_surf
  IS '(test) Donnée géographique contenant l''habillage surfacique des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_surf.idhab IS 'Identifiant unique de l''habillage surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_surf.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_surf.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_surf.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_surf.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_t_habillage_lin #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_t_habillage_lin

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_lin
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30), -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiLineString,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_habillage_lin_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_lin
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_lin TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_lin TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_lin
  IS '(test) Donnée géographique contenant l''habillage linéaire des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_lin.idhab IS 'Identifiant unique de l''habillage linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_lin.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_lin.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_lin.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_lin.idurba IS 'Identifiant du document d''urbanisme';



-- ######################################################################## geo_t_habillage_pct #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_t_habillage_pct

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_pct
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30), -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiPoint,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_habillage_pct_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_pct
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_pct TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_pct TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_pct
  IS '(test) Donnée géographique contenant l''habillage ponctuel des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_pct.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_pct.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_pct.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_pct.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_t_habillage_txt #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_t_habillage_txt

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_txt;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_txt
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage ponctuel
  natecr character varying(40) NOT NULL, -- Nature de l'écriture
  txt character varying(80) NOT NULL, -- Texte de l'écriture
  police character varying(40), -- Police de l'écriture
  taille integer, -- Taille de l'écriture
  style character varying(40), -- Style de l'écriture
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  angle integer, -- Angle de l'écriture exprimé en degré, par rapport à l'horizontale, dans le sens trigonométrique
  idurba character varying(30), -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiPoint,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_habillage_txt_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_txt
  OWNER TO sig_create;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_txt TO edit_sig;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_txt TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_txt TO read_sig;

COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_txt
  IS '(test) Donnée géographique contenant l''habillage textuel des documents d''urbanisme locaux (PLUi, PLU, POS) sous la forme de ponctuels';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt.natecr IS 'Nature de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt.txt IS 'Texte de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt.police IS 'Police de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt.taille IS 'Taille de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt.style IS 'Style de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt.angle IS 'Angle de l''écriture exprimé en degré, par rapport à l''horizontale, dans le sens trigonométrique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';



-- ####################################################################################################################################################
-- ###                                         		  TABLES SPECIFIQUES AU PNR ET OLV                                                          ###
-- ####################################################################################################################################################




-- COMMENT GB : ----------------------------------------------------------------------------------------------------------------------------
-- A décommenter pour la création de la structure des tables spécifiques et intégration du champ l_datmaj dans les tables principales
-- A vérifier par le PNR et OLV avant intégration (à décommenter pour intégrer le processus)
-- -----------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc_cnig2017.an_doc_urba_doc

-- DROP TABLE m_urbanisme_doc_cnig2017.an_doc_urba_doc;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.an_doc_urba_doc
-- (
--   idurba character varying(30) NOT NULL, -- identifiant du document d'urbanisme
--   l_gest character varying(1), -- Type d'organisme qui gère la donnée dans la base (intégration et/ou mise à jour)
--   l_dispon character varying(2), -- Niveau de disponibilité le plus élevé des documents numériques
--   l_dispop character varying(2), -- Niveau de disponibilité le plus élevé des documents papiers
--   l_datproc character varying(8), -- date de lancement de la procédure
--   l_observ character varying(254), -- observation
--   CONSTRAINT idurba_prkey PRIMARY KEY (idurba)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_urba_doc
--   OWNER TO sig_create;
-- GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_doc TO edit_sig;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_doc TO create_sig;
-- GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_doc TO read_sig;

-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_doc
--   IS 'Donnée alphanumérique sur la disponibilité des documents numériques ou papiers à Oise-la-Vallée ou au Parc naturel régional Oise-Pays de France, le gestionnaire des données dans la base';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_doc.idurba IS 'identifiant du document d''urbanisme';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_doc.l_gest IS 'Type d''organisme qui gère la donnée dans la base (intégration et/ou mise à jour)';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_doc.l_dispon IS 'Niveau de disponibilité le plus élevé des documents numériques';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_doc.l_dispop IS 'Niveau de disponibilité le plus élevé des documents papiers';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_doc.l_datproc IS 'date de lancement de la procédure';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_doc.l_observ IS 'observation';



-- permet d’identifier les zonages prenant en compte l’existence d’un enjeux patrimoine naturel
-- Table: m_urbanisme_doc_cnig2017.an_zone_patnat

-- DROP TABLE m_urbanisme_doc_cnig2017.an_zone_patnat;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.an_zone_patnat
-- (
--   idzone character varying(10), -- fait le lien avec le zonage concerné
--   l_thema character varying(50), -- précise la procédure ou l outil reglementaire principal utilisé pour intégrer les enjeux de patrimoine naturel
--   l_vigilance character varying(3), -- type booléen permet de signaler les zonages nécessitant une vigilance particulière sur la prise en compte réelle des enjeux de patrimoine naturel (oui/non)
--   l_remarque character varying(255), -- permet de préciser toutes informations utiles
--   id_z_patnat serial NOT NULL, -- identifiant unique
--   CONSTRAINT pkey_id_z_patnat PRIMARY KEY (id_z_patnat)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_zone_patnat
--   OWNER TO sig_create;
-- GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.an_zone_patnat TO edit_sig;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_zone_patnat TO create_sig;
-- GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.an_zone_patnat TO read_sig;

-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.an_zone_patnat
--   IS 'permet de gérer l''intégration des enjeux de patrimoine naturel dans les PLU';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_zone_patnat.idzone IS 'fait le lien avec le zonage concerné';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_zone_patnat.l_thema IS 'précise la procédure ou l outil reglementaire principal utilisé pour intégrer les enjeux de patrimoine naturel';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_zone_patnat.l_vigilance IS 'type booléen permet de signaler les zonages nécessitant une vigilance particulière sur la prise en compte réelle des enjeux de patrimoine naturel (oui/non)';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_zone_patnat.l_remarque IS 'permet de préciser toutes informations utiles ';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_zone_patnat.id_z_patnat IS 'identifiant unique';


-- permet de juger de la prise en compte global des enjeux patrimoine naturel par le document d’urbanisme 
-- Table: m_urbanisme_doc_cnig2017.an_doc_patnat

-- DROP TABLE m_urbanisme_doc_cnig2017.an_doc_patnat;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.an_doc_patnat
-- (
--   idurba character varying(30), -- fait le lien avec le document concerné
--   l_prisencompte character varying(150), -- précise le niveau de prise en compte des enjeux de patrimoine naturel par le PLU
--   l_notesynth bigint, -- note globale pour apprecier la prise en compte des enjeux (de 1 à 4)
--   l_comment character varying(255), -- permet de préciser toutes informations utiles
--   id_d_patnat serial NOT NULL, -- identifiant unique
--   CONSTRAINT pkey_id_d_patnat PRIMARY KEY (id_d_patnat)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_patnat
--   OWNER TO sig_create;
-- GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.an_doc_patnat TO edit_sig;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_doc_patnat TO create_sig;
-- GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.an_doc_patnat TO read_sig;

-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.an_doc_patnat
--   IS 'permet de gérer intégration des enjeux de patrimoine naturel dans les PLU';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_patnat.idurba IS 'fait le lien avec le document concerné';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_patnat.l_prisencompte IS 'précise le niveau de prise en compte des enjeux de patrimoine naturel par le PLU';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_patnat.l_notesynth IS 'note globale pour apprecier la prise en compte des enjeux (de 1 à 4)';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_patnat.l_comment IS 'permet de préciser toutes informations utiles ';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_patnat.id_d_patnat IS 'identifiant unique';


-- création de la table permettant de noter les différents changements réalisés sur la base (qui, quand, pourquoi)
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.an_suivi_maj
-- (
--   l_structure character varying(100) DEFAULT 'NR'::character varying, -- nom de la structure
--   l_operateur character varying(100) DEFAULT 'NR'::character varying, -- nom de la personne responsable des modifications
--   l_comment text DEFAULT 'NR'::text, -- précision concernant les modifications réalisés
--   idmaj serial NOT NULL, -- identifiant unique
--   l_datmaj timestamp without time zone DEFAULT now(),
--   CONSTRAINT pkey_id_z_idmaj PRIMARY KEY (idmaj)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_suivi_maj
--   OWNER TO sig_create;
-- GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_urbanisme_doc_cnig2017.an_suivi_maj TO edit_sig;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_suivi_maj TO create_sig;
-- GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.an_suivi_maj TO read_sig;

-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.an_suivi_maj
--   IS 'table permettant de noter toute modification sur la base (données et structure)';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_suivi_maj.l_structure IS 'nom de la structure ';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_suivi_maj.l_operateur IS 'nom de la personne responsable des modifications';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_suivi_maj.l_comment IS 'précision concernant les modifications réalisées';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_suivi_maj.idmaj IS 'identifiant unique';


-- ajout du champ l_datmaj dans la structure existante

-- création du champs l_datmaj chargé de conserver la date de la dernière modification effectuée
-- 
-- alter table m_urbanisme_doc_cnig2017.geo_t_habillage_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_prescription_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_info_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_prescription_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.an_doc_patnat add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.an_doc_urba_doc add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_habillage_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_habillage_txt add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_habillage_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_habillage_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.an_doc_urba add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_zone_urba add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.an_zone_patnat add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_habillage_txt add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.an_doc_urba_com add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_info_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_habillage_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_prescription_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_habillage_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_habillage_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_info_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_prescription_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_prescription_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_info_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_info_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_info_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_prescription_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_zone_urba add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_zone_urba add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_habillage_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_prescription_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_prescription_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_prescription_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_habillage_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_habillage_txt add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_info_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_info_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_info_surf add column l_datmaj timestamp ;


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                           FKEY (clé étrangère)                                                               ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- Table: m_urbanisme_doc_cnig2017.an_doc_urba

ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_urba
ADD CONSTRAINT lt_etat_fkey FOREIGN KEY (etat)
      REFERENCES m_urbanisme_doc_cnig2017.lt_etat (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typedoc_fkey FOREIGN KEY (typedoc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typedoc (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typeref_fkey FOREIGN KEY (typeref)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeref (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_nomproc_fkey FOREIGN KEY (nomproc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_nomproc (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_p_zone_urba

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba
ADD CONSTRAINT lt_typezone_fkey FOREIGN KEY (typezone)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typezone (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_destdomi_fkey FOREIGN KEY (l_destdomi)
      REFERENCES m_urbanisme_doc_cnig2017.lt_destdomi (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typesect_fkey FOREIGN KEY (typesect)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typesect (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_p_prescription_surf

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf
ADD CONSTRAINT lt_typepsc_surf_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_p_prescription_lin

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin
ADD CONSTRAINT lt_typepsc_lin_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_p_prescription_pct

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct
ADD CONSTRAINT lt_typepsc_pct_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_p_info_surf

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf
ADD CONSTRAINT lt_typeinf_surf_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc_cnig2017.geo_p_info_lin

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin
ADD CONSTRAINT lt_typeinf_lin_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_p_info_pct

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct
ADD CONSTRAINT lt_typeinf_pct_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

    
-- Table: m_urbanisme_doc_cnig2017.geo_a_zone_urba

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba
ADD CONSTRAINT lt_typezone_fkey FOREIGN KEY (typezone)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typezone (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_destdomi_fkey FOREIGN KEY (l_destdomi)
      REFERENCES m_urbanisme_doc_cnig2017.lt_destdomi (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typesect_fkey FOREIGN KEY (typesect)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typesect (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_a_prescription_surf

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf
ADD CONSTRAINT lt_typepsc_surf_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_a_prescription_lin

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin
ADD CONSTRAINT lt_typepsc_lin_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_a_prescription_pct

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct
ADD CONSTRAINT lt_typepsc_pct_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_a_info_surf

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf
ADD CONSTRAINT lt_typeinf_surf_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc_cnig2017.geo_a_info_lin

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin
ADD CONSTRAINT lt_typeinf_lin_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_a_info_pct

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct
ADD CONSTRAINT lt_typeinf_pct_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;  


-- Table: m_urbanisme_doc_cnig2017.geo_t_zone_urba

ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba
ADD CONSTRAINT lt_typezone_fkey FOREIGN KEY (typezone)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typezone (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_destdomi_fkey FOREIGN KEY (l_destdomi)
      REFERENCES m_urbanisme_doc_cnig2017.lt_destdomi (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typesect_fkey FOREIGN KEY (typesect)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typesect (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_t_prescription_surf

ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf
ADD CONSTRAINT lt_typepsc_surf_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_t_prescription_lin

ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin
ADD CONSTRAINT lt_typepsc_lin_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_t_prescription_pct

ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct
ADD CONSTRAINT lt_typepsc_pct_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_t_info_surf

ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf
ADD CONSTRAINT lt_typeinf_surf_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc_cnig2017.geo_t_info_lin

ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin
ADD CONSTRAINT lt_typeinf_lin_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.geo_t_info_pct

ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct
ADD CONSTRAINT lt_typeinf_pct_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;  


-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Clé étrangère des tables spécifiques métiers au PNR et OLV
-- A décommenter pour intégration (à vérifier au préalable par le PNR et OLV)
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Table: m_urbanisme_doc_cnig2017.an_doc_urba_doc
-- 
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_urba_doc
-- ADD CONSTRAINT dispon_fkey FOREIGN KEY (l_dispon)
--       REFERENCES m_urbanisme_doc_cnig2017.lt_dispon (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION,
-- ADD CONSTRAINT dispop_fkey FOREIGN KEY (l_dispop)
--       REFERENCES m_urbanisme_doc_cnig2017.lt_dispop (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc_cnig2017.an_zone_patnat
-- 
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_zone_patnat
--   ADD CONSTRAINT lt_l_themapatnat_fkey FOREIGN KEY (l_thema)
--       REFERENCES m_urbanisme_doc_cnig2017.lt_l_themapatnat (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;
-- 
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_zone_patnat
--   ADD CONSTRAINT lt_l_vigipatnat_fkey FOREIGN KEY (l_vigilance)
--       REFERENCES m_urbanisme_doc_cnig2017.lt_l_vigipatnat (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_cnig2017.an_doc_patnat
-- 
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_patnat
--   ADD CONSTRAINT lt_l_pecpatnat_fkey FOREIGN KEY (l_prisencompte)
--       REFERENCES m_urbanisme_doc_cnig2017.lt_l_pecpatnat (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;

-- ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_patnat
--   ADD CONSTRAINT lt_l_nspatnat_fkey FOREIGN KEY (l_notesynth)
--       REFERENCES m_urbanisme_doc_cnig2017.lt_l_nspatnat (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                           MIGRATION DES DONNEES                                                              ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Les requêtes SQL d'intégration des données spécifiques au PNR et OLV n'ont pas été réalisées, à charge de chaque partenaires de les créer :
-- Pour le PNR et OLV :
--			. intégrer dans les requêtes existantes pour les tables du modèle (production, archive et test) le champ l_datemaj
--			. créer les requêtes d'intégration (à partir des exemples ci-dessous) pour les tables spécifiques aux PNR et OLV
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration des tables hors standard CNIG spécifique ARC (geo_p_zone_pau et an_ads_commune
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.an_ads_commune (insee,docurba,ads_arc,l_rev,l_daterev)
SELECT insee,docurba,ads_arc,l_rev,l_daterev FROM m_urbanisme_doc.an_ads_commune;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau DISABLE TRIGGER t_t1_pau_inseecommune;
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau DISABLE TRIGGER t_t2_pau_insert_date_sai;
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau DISABLE TRIGGER t_t3_pau_update_date_maj;
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau DISABLE TRIGGER t_t4_pau_surface;

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_zone_pau (idpau,date_sai,date_maj,op_sai,org_sai,insee,commune,src_geom,sup_m2,l_type,l_statut,geom)
SELECT idpau,date_sai,date_maj,op_sai,org_sai,insee,commune,src_geom,sup_m2,l_type,l_statut,geom FROM m_urbanisme_doc.geo_p_zone_pau;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau ENABLE TRIGGER t_t1_pau_inseecommune;
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau ENABLE TRIGGER t_t2_pau_insert_date_sai;
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau ENABLE TRIGGER t_t3_pau_update_date_maj;
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_zone_pau ENABLE TRIGGER t_t4_pau_surface;

-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table an_doc_urba
-- Prise en compte de l'implémentation de l'idurba
-- Réaffectation de la codification des versions (ATTENTION : le champ l_version doit-être nettoyée avant la migration pour contenir les valeurs présentes dans ce code, sinon il faut l'adapter
-- Implémentation du champ urlpe par reconstruction du lien (ATTENTION : modifier l'adresse par chaque organisme pour ces communes)
-- Formatage de la dateref au 1er janvier de l'année si une année a été renseignée (le modèle contraint un format de date et non-null, le non-null n'a pas été pris en compte dans la table (à l'export il le faudra)
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO m_urbanisme_doc_cnig2017.an_doc_urba (idurba,typedoc,etat,nomproc,l_nomprocn,datappro,datefin,siren,nomreg,urlreg,nomplan,urlplan,urlpe,siteweb,typeref,dateref,l_meta,l_moa_proc,l_moe_proc,l_moa_dmat,l_moe_dmat,l_observ,l_parent) 
SELECT
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
left(idurba,5) || '_' || typedoc || '_' || CASE WHEN (datappro is not null or datappro <> '' ) THEN right(datappro,8) ELSE '99999999' END as idurba,
typedoc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- gestion de l'état 09:caduc 
-- spécifique ARC ==> pour la migration intégration du mot caduc pour les procédures concernées dans la champ l_observ de la table an_doc_urba avant la migration.
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CASE WHEN l_observ like '%caduc%' THEN '09' ELSE etat END as etat,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- réaffectation des noms de procédures selon la nouvelle codification (pour la migration harmoniser à la main le champ l_version et modifier le code ci-dessous au besoin)
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CASE 
	WHEN l_version = 'Commune soumise au RNU' THEN 'RNU'
	WHEN l_version = 'élaboration'  THEN 'E'
	WHEN l_version like 'mise à jour%'  THEN 'MJ'
	WHEN l_version like 'mise en compatibilité%'  THEN 'MC'
	WHEN l_version like 'modification simplifiée%'  THEN 'MS'
	WHEN l_version like 'modification n°%' THEN 'M'
	WHEN l_version like 'révision%'  THEN 'R'
	WHEN l_version like 'révision simplifiée%'  THEN 'RS'
        WHEN l_version = 'abrogé'  THEN 'A'
ELSE l_version
END AS nomproc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- récupération du numéro d'ordre de la procédure (pour la migration harmoniser à la main le champ l_version et modifier le code ci-dessous au besoin)
-- adapter les numéros en fonction des cas des chaque partenaire (ici prévu 10 procédures).A l'ARC relevé jusqu'à 8 n° d'ordre pour une même procédure.
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CASE 
	WHEN l_version like '%n°1'  THEN 1
	WHEN l_version like '%n°2'  THEN 2
	WHEN l_version like '%n°3'  THEN 3
	WHEN l_version like '%n°4'  THEN 4
	WHEN l_version like '%n°5'  THEN 5
	WHEN l_version like '%n°6'  THEN 6
	WHEN l_version like '%n°7'  THEN 7
        WHEN l_version like '%n°8'  THEN 8
	WHEN l_version like '%n°9'  THEN 9
        WHEN l_version like '%n°10'  THEN 10
ELSE null
END AS l_nomprocn,
datappro,
datefin,
siren,
nomreg,
urlreg,
nomplan,
urlplan,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- pour les documents (hors RNU) implémentation du champ urlpe avec le lien interne de téléchargement de chaque organisme (à modifier selon les cas)
CASE WHEN l_version <> 'Commune soumise au RNU' and (nomreg is not null or nomreg <> '') THEN
'http://geo.compiegnois.fr/documents/metiers/urba/docurba/' || left(idurba,5) || '_' || typedoc || '_' || right(datappro,8) || '.zip'
ELSE null END as urlpe,
siteweb,
typeref,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- affectation d'une date cohérente sur 8 caractères pour le référentiel si la date est saisie sur 4 caractères (à adapter éventuellement par les partenaires)
CASE 
	WHEN (dateref is not null or dateref <> '') and (length(dateref) = 4) THEN dateref || '0101'
ELSE dateref
END AS dateref,
l_meta,
l_moa_proc,
l_moe_proc,
l_moa_dmat,
l_moe_dmat,
l_observ,
l_parent
FROM m_urbanisme_doc.an_doc_urba
WHERE idurba <> '6064720180517';


-- gestion de l'insertion de l'idurba de Trosly-Breuil (2 procédures approuvées le même jour)
-- procédure d'élaboration
INSERT INTO m_urbanisme_doc_cnig2017.an_doc_urba (idurba,typedoc,etat,nomproc,l_nomprocn,datappro,datefin,siren,nomreg,urlreg,nomplan,urlplan,urlpe,siteweb,typeref,dateref,l_meta,l_moa_proc,l_moe_proc,l_moa_dmat,l_moe_dmat,l_observ,l_parent) 
SELECT
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
'60647_PLU_20180517_1' as idurba,
'PLU' as typedoc,
'05' as etat,
'E' as nomproc,
null AS l_nomprocn,
'20180517',
'20180517',
siren,
'60647_reglement_20180517.pdf' as nomreg,
null as urlreg,
null as nomplan,
null as urlplan,
'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60647_PLU_20180517_1.zip' as urlpe,
null as siteweb,
'01' as typeref,
'20170101' AS dateref,
'http://geo.compiegnois.fr/geosource/srv/fre/catalog.search#/metadata/9508bee6-395a-4d99-b344-7bffe5671f35' as l_meta,
'Commune de Trosly-Breuil' as l_moa_proc,
'MT Projets' as l_moe_proc,
'Agglomération de la Région de Compiègne' as l_moa_dmat,
'Agglomération de la Région de Compiègne' as l_moe_dmat,
null as l_observ,
2 as l_parent
FROM m_urbanisme_doc.an_doc_urba
WHERE idurba = '6064720180517';

-- procédure de modiciation n°1
INSERT INTO m_urbanisme_doc_cnig2017.an_doc_urba (idurba,typedoc,etat,nomproc,l_nomprocn,datappro,datefin,siren,nomreg,urlreg,nomplan,urlplan,urlpe,siteweb,typeref,dateref,l_moa_proc,l_moe_proc,l_moa_dmat,l_moe_dmat,l_observ,l_parent) 
SELECT
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
'60647_PLU_20180517_2' as idurba,
'PLU' as typedoc,
'03' as etat,
'MS' as nomproc,
1 AS l_nomprocn,
'20180517' as datappro,
null as datefin,
null as siren,
'60647_reglement_20180517.pdf' as nomreg,
null as urlreg,
null as nomplan,
null as urlplan,
'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60647_PLU_20180517_2.zip' as urlpe,
null as siteweb,
'01' as typeref,
'20170101' AS dateref,
'Commune de Trosly-Breuil' as l_moa_proc,
'MT Projets' as l_moe_proc,
'Agglomération de la Région de Compiègne' as l_moa_dmat,
'Agglomération de la Région de Compiègne' as l_moe_dmat,
null as l_observ,
2 as l_parent
FROM m_urbanisme_doc.an_doc_urba
WHERE idurba = '6064720180517';


-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table an_doc_urba_com
-- Prise en compte de l'implémentation de l'idurba
-- Suppression du champ l_secteur
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.an_doc_urba_com (idurba,insee) 
SELECT idurba,left(idurba,5) from m_urbanisme_doc_cnig2017.an_doc_urba where etat='03' and typedoc <> 'RNU';



-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_p_zone_urba
-- Prise en compte de l'implémentation de l'idurba
-- Intégration du changement de codification des types de zone pour les secteur s Nh, Nd et Ah en N et A
-- Mise en champ libre des champs (Insee, destdomi)
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_zone_urba (idzone,libelle,libelong,typezone,nomfic,urlfic,idurba,datvalid,typesect,fermreco,l_destdomi,l_insee,l_surf_cal,l_observ,geom)
SELECT 
replace(idzone,'Z0','ZO') as idzone,
libelle,
libelong,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- réaffectation des valeurs de typezone
CASE
	WHEN (typezone = 'Nh' or typezone='Nd') THEN 'N'
	WHEN typezone = 'Ah' THEN 'A'
ELSE
	typezone
END as typezone,
nomfic,
CASE WHEN insee='60647' THEN replace(urlfic,'60647_PLU_20180517','60647_PLU_20180517_2')
ELSE urlfic END as urlfic,

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
CASE WHEN insee ='60647' THEN '60647_PLU_20180517_2' ELSE
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_zone_urba.insee || geo_p_zone_urba.datappro ) || '_' || datappro END as idurba,
datvalid,
typesect,
CASE WHEN fermreco = false THEN 'non'::character varying ELSE 'oui'::character varying END fermreco,
destdomi,
insee,
l_surf_cal,
l_observ,
geom
FROM m_urbanisme_doc.geo_p_zone_urba;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_p_prescription_surf
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des prescriptions (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC. Chaque organisme doit adapté
-- cette grille en fonction des cas supplémentaires présents dans ces données
-- Le champ geom1 est spécifique à l'ARC, il peut-être mise en commentaire pour les autres organismes ou supprimé
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_prescription_surf (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom,geom1)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration des types de spécifications qui ont évolué (ATTENTION : a adapté ici par chaque organisme selon ces données)
CASE
	WHEN typepsc = '09' THEN '05'
	WHEN typepsc = '11' THEN '15'
	WHEN typepsc = '12' THEN '05' 
	WHEN typepsc = '21' THEN '05'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration des sous-codes de spécifications qui ont évolué (ATTENTION : a adapté ici par chaque organisme selon ces données)
CASE
	WHEN l_typepsc2 = '01-03' THEN '00'
	WHEN typepsc = '02' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN l_typepsc2 = '05-02' THEN '01'
	WHEN l_typepsc2 = '05-06' THEN '04'
	WHEN l_typepsc2 = '05-03' THEN '00'
	WHEN l_typepsc2 = '05-01' THEN '04'
	WHEN l_typepsc2 = '05-04' THEN '01'
        WHEN typepsc = '05' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN l_typepsc2 = '05-05' THEN '01'
	WHEN l_typepsc2 = '07-08' THEN '02'
	WHEN l_typepsc2 = '07-09' THEN '04'
	WHEN l_typepsc2 = '07-04' THEN '03'
	WHEN l_typepsc2 = '07-05' THEN '01'
	WHEN l_typepsc2 = '07-07' THEN '01'
	WHEN l_typepsc2 = '07-02' THEN '01'
	WHEN l_typepsc2 = '07-03' THEN '00'
	WHEN l_typepsc2 = '07-10' THEN '00'
	WHEN l_typepsc2 = '07-01' THEN '02'
        WHEN typepsc = '07' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN typepsc = '08' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN typepsc = '09' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '05'
        WHEN l_typepsc2 = '11-05' THEN '00'
        WHEN l_typepsc2 = '11-06' THEN '00'
        WHEN l_typepsc2 = '11-04' THEN '00'
        WHEN l_typepsc2 = '11-01' THEN '01'
        WHEN typepsc = '12' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '07'
	WHEN typepsc = '15' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
	WHEN typepsc = '16' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
	WHEN typepsc = '17' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '18' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '19' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '21' THEN '06'
	WHEN l_typepsc2 = '24-01' THEN '01'
	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 END as stypepsc,
nomfic,
CASE WHEN insee='60647' THEN replace(urlfic,'60647_PLU_20180517','60647_PLU_20180517_2') ELSE urlfic END as urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
CASE WHEN insee='60647' THEN '60647_PLU_20180517_2' ELSE
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_prescription_surf.insee || geo_p_prescription_surf.datappro ) || '_' || datappro 
END as idurba,
datvalid,
insee,
l_nom,
l_nature,
l_bnfcr,
l_numero,
l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- A mettre en commentaire ou à supprimer pour les partenaires si n'utilisent pas cet attribut spécifique à l'ARC
geom1
FROM m_urbanisme_doc.geo_p_prescription_surf;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_p_prescription_lin
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des prescriptions (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC. Chaque organisme doit adapté
-- cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_prescription_lin (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom,geom1)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration des types de spécifications qui ont évolué (ATTENTION : a adapté ici par chaque organisme selon ces données)
CASE
	WHEN typepsc = '11' and l_typepsc2 <> '11-07' and l_typepsc2 <> '11-08' THEN '15'
        WHEN typepsc = '11' and l_typepsc2 = '11-07' THEN '39'
	WHEN typepsc = '11' and l_typepsc2 = '11-08' THEN '41'
 	WHEN typepsc = '21' THEN '05'
	WHEN typepsc = '99' and l_typepsc2 = '99-01' THEN '41'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration des sous-codes de spécifications qui ont évolué (ATTENTION : a adapté ici par chaque organisme selon ces données)
CASE
        WHEN typepsc = '05' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN l_typepsc2 = '05-03' THEN '00'
	WHEN l_typepsc2 = '05-05' THEN '01'
 	WHEN l_typepsc2 = '07-05' THEN '01'
 	WHEN l_typepsc2 = '07-01' THEN '02'
 	WHEN l_typepsc2 = '07-02' THEN '01'
 	WHEN l_typepsc2 = '07-03' THEN '00'
 	WHEN l_typepsc2 = '07-10' THEN '00'
 	WHEN l_typepsc2 = '07-11' THEN '04'
        WHEN typepsc = '07' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '11-05' THEN '00'
        WHEN l_typepsc2 = '11-01' THEN '01'
        WHEN l_typepsc2 = '11-08' THEN '00'
        WHEN l_typepsc2 = '11-09' THEN '00'
        WHEN l_typepsc2 = '11-03' THEN '03'
        WHEN l_typepsc2 = '11-02' THEN '01'
        WHEN l_typepsc2 = '11-07' THEN '00'
 	WHEN typepsc = '15' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN typepsc = '19' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '21-02' THEN '06'
        WHEN l_typepsc2 = '21-01' THEN '06'
 	WHEN l_typepsc2 = '24-01' THEN '01'
 	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN l_typepsc2 = '99-02' THEN '00'
 	WHEN l_typepsc2 = '99-01' THEN '03'

 END as stypepsc,
nomfic,
CASE WHEN insee='60647' THEN replace(urlfic,'60647_PLU_20180517','60647_PLU_20180517_2') ELSE urlfic END as urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
CASE WHEN insee='60647' THEN '60647_PLU_20180517_2' ELSE
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_prescription_lin.insee || geo_p_prescription_lin.datappro ) || '_' || datappro END as idurba,
datvalid,
insee,
l_nom,
l_nature,
l_bnfcr,
l_numero,
l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom,
geom1
FROM m_urbanisme_doc.geo_p_prescription_lin ;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_p_prescription_pct
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des prescriptions (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC. Chaque organisme doit adapté
-- cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_prescription_pct (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration des types de spécifications qui ont évolué (ATTENTION : a adapté ici par chaque organisme selon ces données)
CASE
	WHEN typepsc = '11' and l_typepsc2 <> '11-07' and l_typepsc2 <> '11-08' THEN '15'
        WHEN typepsc = '11' and l_typepsc2 = '11-07' THEN '39'
	WHEN typepsc = '11' and l_typepsc2 = '11-08' THEN '41'
  	WHEN typepsc = '21' THEN '05'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration des sous-codes de spécifications qui ont évolué (ATTENTION : a adapté ici par chaque organisme selon ces données)
CASE
 	WHEN l_typepsc2 = '07-01' THEN '02'
 	WHEN l_typepsc2 = '07-08' THEN '02'
 	WHEN l_typepsc2 = '07-09' THEN '04'
   	WHEN l_typepsc2 = '07-05' THEN '01'
   	WHEN l_typepsc2 = '07-02' THEN '01'
   	WHEN l_typepsc2 = '07-11' THEN '04'
	WHEN l_typepsc2 = '07-06' THEN '01'
        WHEN typepsc = '07' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '11-07' THEN '00'
 	WHEN typepsc = '16' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
 	WHEN typepsc = '19' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '21-03' THEN '06'
   	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 END as stypepsc,
nomfic,
CASE WHEN insee='60647' THEN replace(urlfic,'60647_PLU_20180517','60647_PLU_20180517_2') ELSE urlfic END as urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
CASE WHEN insee='60647' THEN '60647_PLU_20180517_2' ELSE
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_prescription_pct.insee || geo_p_prescription_pct.datappro ) || '_' || datappro END as idurba,
datvalid,
insee,
l_nom,
l_nature,
l_bnfcr,
l_numero,
l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom
FROM m_urbanisme_doc.geo_p_prescription_pct;



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_p_info_surf
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des informations (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC (sur le Pays Compiégnois).
-- Chaque organisme doit adapté cette grille en fonction des cas supplémentaires présents dans ces données
-- Le champ geom1 est spécifique à l'ARC, il peut être mis en commentaire par les autres organismes
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_info_surf (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom,geom1)
SELECT 
idinf,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration des types de informations qui ont évolué (ATTENTION : a adapté ici par chaque organisme selon ces données)
CASE
	WHEN typeinf = '' THEN ''

ELSE
typeinf END  as typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration des sous-codes de informations qui ont évolué (ATTENTION : a adapté ici par chaque organisme selon ces données)
CASE
	WHEN l_typeinf2 = '04-01' THEN '00'
        WHEN typeinf = '02' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
        WHEN typeinf = '03' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '05' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '14' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '16' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '19' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '01'
        WHEN l_typeinf2 = '16-01' THEN '00'
	WHEN l_typeinf2 = '16-02' THEN '00'
	WHEN l_typeinf2 = '19-04' THEN '02'
	WHEN l_typeinf2 = '19-09' THEN '01'
	WHEN l_typeinf2 = '19-08' THEN '01'
	WHEN typeinf = '99' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN l_typeinf2 = '99-01' THEN '00'
 END as stypeinf,
nomfic,
CASE WHEN insee='60647' THEN replace(urlfic,'60647_PLU_20180517','60647_PLU_20180517_2') ELSE urlfic END as urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
CASE WHEN insee='60647' THEN '60647_PLU_20180517_2' ELSE
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_info_surf.insee || geo_p_info_surf.datappro ) || '_' || datappro END as idurba,
datvalid,
insee,
l_nom,
l_dateins,
l_bnfcr,
l_datdlg,
l_gen, 
l_valrecul, 
l_typrecul, 
l_observ,
geom,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- A commenter ou à supprimer par les partenaires si non utilisé (spécifique ARC)
geom1
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration des informations sauf celles qui basculent en prescription
FROM m_urbanisme_doc.geo_p_info_surf WHERE typeinf <> '06' and typeinf <> '18';



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration des données informations vers les données prescriptions (06 info vers 03 00 psc)
-- ATTENTION : certaines informations sont reversées dans les prescriptions dans le nouveau modèle CNIG. Ici n'est présent que les cas rencontrés pour les donnes de l'ARC sur le Pays Compiègnois.
-- Chaque organisme adapté le code ci-après en fonction de ces données
-- Chaque basculement génère une requête de migration, pour l'ARC, 2 requêtes dupliquées et adaptées
-- Le champ geom1 peut-être mise en commentaire ou supprimer par les partanries (spécifique ARC)
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_prescription_surf (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom,geom1)
SELECT
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition d'un idenfiant IDZONE pour la prescription en reprenant la suite de l'ordre existant
insee || 'PS' ||
		CASE WHEN (select length((max(right(idpsc,3))::integer+1)::character varying) from m_urbanisme_doc.geo_p_prescription_surf where insee = geo_p_info_surf.insee) = 0
			THEN ('00' || (select max(right(idpsc,3))::integer+(select right(idinf,3)::integer from m_urbanisme_doc.geo_p_info_surf i where i.idinf = geo_p_info_surf.idinf) from m_urbanisme_doc.geo_p_prescription_surf where insee = geo_p_info_surf.insee))::character varying
		WHEN (select length((max(right(idpsc,3))::integer+1)::character varying) from m_urbanisme_doc.geo_p_prescription_surf where insee = geo_p_info_surf.insee) = 1
			THEN  ('00' || (select max(right(idpsc,3))::integer+(select right(idinf,3)::integer from m_urbanisme_doc.geo_p_info_surf i where i.idinf = geo_p_info_surf.idinf) from m_urbanisme_doc.geo_p_prescription_surf where insee = geo_p_info_surf.insee))::character varying
		WHEN (select length((max(right(idpsc,3))::integer+1)::character varying) from m_urbanisme_doc.geo_p_prescription_surf where insee = geo_p_info_surf.insee) = 2
			THEN ('0' || (select max(right(idpsc,3))::integer+(select right(idinf,3)::integer from m_urbanisme_doc.geo_p_info_surf i where i.idinf = geo_p_info_surf.idinf) from m_urbanisme_doc.geo_p_prescription_surf where insee = geo_p_info_surf.insee))::character varying
		ELSE
			((select max(right(idpsc,3))::integer+1 from m_urbanisme_doc.geo_p_prescription_surf where insee = geo_p_info_surf.insee))::character varying
END as idpsc,
'Secteur avec disposition de reconstruction / démolition'::character varying as libelle,
txt,
'03'::character varying as typepsc,
'00'::character varying as stypepsc,
nomfic,
CASE WHEN insee='60647' THEN replace(urlfic,'60647_PLU_20180517','60647_PLU_20180517_2') ELSE urlfic END as urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
CASE WHEN insee='60647' THEN '60647_PLU_20180517_2' ELSE
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_info_surf.insee || geo_p_info_surf.datappro ) || '_' || datappro END as idurba,
datvalid,
insee,
l_nom,
''::character varying as l_nature,
l_bnfcr,
''::character varying as l_numero,
''::character varying as l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mettre en commantaire ou à supprimer par les partenaires si pas utilisé (spécifique ARC)
geom1
FROM m_urbanisme_doc.geo_p_info_surf where typeinf = '06';


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration information vers prescription (18 info vers 31 05 psc)
-- ATTENTION : certaines informations sont reversées dans les prescriptions dans le nouveau modèle CNIG. Ici n'est présent que les cas rencontrés pour les donnes de l'ARC sur le Pays Compiègnois.
-- Chaque organisme adapté le code ci-après en fonction de ces données
-- Chaque basculement génère une requête de migration, pour l'ARC, 2 requêtes dupliquées et adaptées
-- -- Le champ geom1 peut-être mise en commentaire ou supprimer par les partanries (spécifique ARC)
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_prescription_surf (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom,geom1)
SELECT 
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition d'un idenfiant IDZONE pour la prescription en reprenant la suite de l'ordre existant
insee || 'PS' ||
		CASE WHEN (select length((max(right(idpsc,3))::integer+1)::character varying) from m_urbanisme_doc.geo_p_prescription_surf where insee = geo_p_info_surf.insee) = 0
			THEN ('00' || (select max(right(idpsc,3))::integer+(select right(idinf,3)::integer from m_urbanisme_doc.geo_p_info_surf i where i.idinf = geo_p_info_surf.idinf) from m_urbanisme_doc.geo_p_prescription_surf where insee = geo_p_info_surf.insee))::character varying
		WHEN (select length((max(right(idpsc,3))::integer+1)::character varying) from m_urbanisme_doc.geo_p_prescription_surf where insee = geo_p_info_surf.insee) = 1
			THEN  ('00' || (select max(right(idpsc,3))::integer+(select right(idinf,3)::integer from m_urbanisme_doc.geo_p_info_surf i where i.idinf = geo_p_info_surf.idinf) from m_urbanisme_doc.geo_p_prescription_surf where insee = geo_p_info_surf.insee))::character varying
		WHEN (select length((max(right(idpsc,3))::integer+1)::character varying) from m_urbanisme_doc.geo_p_prescription_surf where insee = geo_p_info_surf.insee) = 2
			THEN ('0' || (select max(right(idpsc,3))::integer+(select right(idinf,3)::integer from m_urbanisme_doc.geo_p_info_surf i where i.idinf = geo_p_info_surf.idinf) from m_urbanisme_doc.geo_p_prescription_surf where insee = geo_p_info_surf.insee))::character varying
		ELSE
			((select max(right(idpsc,3))::integer+1 from m_urbanisme_doc.geo_p_prescription_surf where insee = geo_p_info_surf.insee))::character varying
END as idpsc,
'Marais, vasières, tourbières, plans d''eau, les zones humides et milieux temporairement immergés'::character varying as libelle,
txt,
'31'::character varying as typepsc,
'05'::character varying as stypepsc,
nomfic,
CASE WHEN insee='60647' THEN replace(urlfic,'60647_PLU_20180517','60647_PLU_20180517_2') ELSE urlfic END as urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
CASE WHEN insee='60647' THEN '60647_PLU_20180517_2' ELSE
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_info_surf.insee || geo_p_info_surf.datappro ) || '_' || datappro END as idurba,
datvalid,
insee,
l_nom,
''::character varying as l_nature,
l_bnfcr,
''::character varying as l_numero,
''::character varying as l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mettre en commantaire ou à supprimer par les partenaires si pas utilisé (spécifique ARC)
geom1
FROM m_urbanisme_doc.geo_p_info_surf where typeinf = '18';



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_p_info_lin
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des informations (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC (sur le Pays Compiégnois).
-- Chaque organisme doit adapté cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_info_lin (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idinf,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration des types de informations qui ont évolué (ATTENTION : a adapté ici par chaque organisme selon ces données)
CASE
	WHEN typeinf = '' THEN ''

ELSE
typeinf END  as typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration des sous-codes de informations qui ont évolué (ATTENTION : a adapté ici par chaque organisme selon ces données)
CASE
	WHEN typeinf = '99' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN l_typeinf2 = '99-04' THEN '00'
	WHEN l_typeinf2 = '99-05' THEN '00'
 END as stypeinf,
nomfic,
CASE WHEN insee='60647' THEN replace(urlfic,'60647_PLU_20180517','60647_PLU_20180517_2') ELSE urlfic END as urlfic,
-- recomposition du champ idurba
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
CASE WHEN insee='60647' THEN '60647_PLU_20180517_2' ELSE
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_info_lin.insee || geo_p_info_lin.datappro ) || '_' || datappro END as idurba,
datvalid,
insee,
l_nom,
l_dateins,
l_bnfcr,
l_datdlg,
l_gen, 
l_valrecul, 
l_typrecul, 
l_observ,
geom
FROM m_urbanisme_doc.geo_p_info_lin;



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_p_info_pct
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des informations (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC (sur le Pays Compiégnois).
-- Chaque organisme doit adapté cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_info_pct (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idinf,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration des types de informations qui ont évolué (ATTENTION : a adapté ici par chaque organisme selon ces données)
CASE
	WHEN typeinf = '' THEN ''

ELSE
typeinf END  as typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration des sous-codes de informations qui ont évolué (ATTENTION : a adapté ici par chaque organisme selon ces données)
CASE
 	WHEN l_typeinf2 = '19-04' THEN '02'
 	WHEN typeinf = '99' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
 END as stypeinf,
nomfic,
CASE WHEN insee='60647' THEN replace(urlfic,'60647_PLU_20180517','60647_PLU_20180517_2') ELSE urlfic END as urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
CASE WHEN insee='60647' THEN '60647_PLU_20180517_2' ELSE
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_info_pct.insee || geo_p_info_pct.datappro ) || '_' || datappro END as idurba,
datvalid,
insee,
l_nom,
l_dateins,
l_bnfcr,
l_datdlg,
l_gen, 
l_valrecul, 
l_typrecul, 
l_observ,
geom
FROM m_urbanisme_doc.geo_p_info_pct;



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_p_habillage_surf
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Intégration du nouveau champ couleur et l_couleur
-- ATTENTION : gestion du champ NATTRAC pour la migration car peut contenir (cas à l'ARC) des informations à migrer notamment code et info en prescription. Si les partenaires ne sont pas concernés, supprimés
-- de la requête cette partie et remplacé simplement par le nom du champ
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_habillage_surf (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
SELECT 
idhab,
-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- pas de cas particulier à l'ARC devant être migré pour le champ nattrac
nattrac,
''::character varying(11) as couleur,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
CASE WHEN insee='60647' THEN '60647_PLU_20180517_2' ELSE
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_habillage_surf.insee || geo_p_habillage_surf.datappro ) || '_' || datappro END as idurba,
insee,
''::character varying(7) as l_couleur,
geom
FROM m_urbanisme_doc.geo_p_habillage_surf;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_p_habillage_lin
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Intégration du nouveau champ couleur et l_couleur
-- ATTENTION : gestion du champ NATTRAC pour la migration car peut contenir (cas à l'ARC) des informations à migrer notamment code et info en prescription. Si les partenaires ne sont pas concernés, supprimés
-- de la requête cette partie et remplacé simplement par le nom du champ
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_habillage_lin (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
SELECT 
idhab,
-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- cas particulier à l'ARC devant être migré pour le champ nattrac
CASE 
WHEN nattrac = 'PRESCRIPTION_LIN_11' THEN 'PRESCRIPTION_LIN_15'
WHEN nattrac = 'PRESCRIPTION_LIN_21' THEN 'PRESCRIPTION_LIN_05'
WHEN nattrac = 'PRESCRIPTION_SURF_11' THEN 'PRESCRIPTION_SURF_15'
WHEN nattrac = 'PRESCRIPTION_SURF_12' THEN 'PRESCRIPTION_SURF_05'
WHEN nattrac = 'PRESCRIPTION_SURF_21' THEN 'PRESCRIPTION_SURF_05'

ELSE nattrac END as nattrac,
''::character varying(11) as couleur,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
CASE WHEN insee='60647' THEN '60647_PLU_20180517_2' ELSE
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_habillage_lin.insee || geo_p_habillage_lin.datappro ) || '_' || datappro END as idurba,
insee,
''::character varying(7) as l_couleur,
geom
FROM m_urbanisme_doc.geo_p_habillage_lin;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_p_habillage_pct
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Intégration du nouveau champ couleur et l_couleur
-- ATTENTION : gestion du champ NATTRAC pour la migration car peut contenir (cas à l'ARC) des informations à migrer notamment code et info en prescription. Si les partenaires ne sont pas concernés, supprimés
-- de la requête cette partie et remplacé simplement par le nom du champ
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_habillage_pct (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
SELECT 
idhab,
-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- pas de cas particulier à l'ARC devant être migré pour le champ nattrac
nattrac,
''::character varying(11) as couleur,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
CASE WHEN insee='60647' THEN '60647_PLU_20180517_2' ELSE
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_habillage_pct.insee || geo_p_habillage_pct.datappro ) || '_' || datappro END as idurba,
insee,
''::character varying(7) as l_couleur,
geom
FROM m_urbanisme_doc.geo_p_habillage_pct;



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_p_habillage_txt
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Intégration du nouveau champ couleur
-- ATTENTION : gestion du champ NATECR pour la migration car peut contenir (cas à l'ARC) des informations à migrer notamment code et info en prescription. Si les partenaires ne sont pas concernés, supprimés
-- de la requête cette partie et remplacé simplement par le nom du champ
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_habillage_txt (idhab,natecr,txt,police,taille,style,couleur,angle,idurba,l_insee,l_couleur,geom)
SELECT 
idhab,
-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- cas particulier à l'ARC devant être migré pour le champ natecr
CASE 
WHEN natecr = 'PRESCRIPTION_LIN_11' THEN 'PRESCRIPTION_LIN_15'
WHEN natecr = 'PRESCRIPTION_LIN_21' THEN 'PRESCRIPTION_LIN_05'
WHEN natecr = 'PRESCRIPTION_SURF_11' THEN 'PRESCRIPTION_SURF_15'
WHEN natecr = 'PRESCRIPTION_SURF_12' THEN 'PRESCRIPTION_SURF_05'
WHEN natecr = 'PRESCRIPTION_SURF_21' THEN 'PRESCRIPTION_SURF_05'
ELSE natecr END as natecr,
txt,
police,
taille,
style,
''::character varying(11) as couleur,
angle,
-- recomposition du champ idurba
CASE WHEN insee='60647' THEN '60647_PLU_20180517_2' ELSE
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_habillage_txt.insee || geo_p_habillage_txt.datappro ) || '_' || datappro END as idurba,
insee,
''::character varying(7) as l_couleur,
geom
FROM m_urbanisme_doc.geo_p_habillage_txt;


-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_a_zone_urba
-- Prise en compte de l'implémentation de l'idurba
-- Intégration du changement de codification des types de zone pour les secteur s Nh, Nd et Ah en N et A
-- Mise en champ libre du  champ (Insee,destdomi)
-- Intégration du champ GID (à supprimer pour les organismes ne le gértant pas ici)
-- Création de la séquence sur le champ GID et modification du champ GID intégrant la séquence (peut-être mise en commentaire par les partenaires si non utilisée)
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_zone_urba (idzone,libelle,libelong,typezone,nomfic,urlfic,idurba,datvalid,typesect,fermreco,l_destdomi,l_insee,l_surf_cal,l_observ,geom,gid)
SELECT 
replace(idzone,'Z0','ZO') as idzone,
libelle,
libelong,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration du champ typezone
CASE
	WHEN (typezone = 'Nh' or typezone='Nd') THEN 'N'
	WHEN typezone = 'Ah' THEN 'A'
ELSE
	typezone
END as typezone,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_a_zone_urba.insee || geo_a_zone_urba.datappro ) || '_' || datappro as idurba,
datvalid,
typesect,
CASE WHEN fermreco = false THEN 'non'::character varying ELSE 'oui'::character varying END fermreco,
destdomi,
insee,
l_surf_cal,
l_observ,
geom,
gid
FROM m_urbanisme_doc.geo_a_zone_urba;

--insertion procédure élaboration de Trosly-Breuil même jour que la modification simplifiée n°1
INSERT INTO m_urbanisme_doc_cnig2017.geo_a_zone_urba (idzone,libelle,libelong,typezone,nomfic,urlfic,idurba,datvalid,typesect,fermreco,l_destdomi,l_insee,l_surf_cal,l_observ,geom,gid)
SELECT 
idzone,
libelle,
libelong,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- migration du champ typezone
CASE
	WHEN (typezone = 'Nh' or typezone='Nd') THEN 'N'
	WHEN typezone = 'Ah' THEN 'A'
ELSE
	typezone
END as typezone,
nomfic,
replace(urlfic,'60647_PLU_20180517','60647_PLU_20180517_1') as urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
'60647_PLU_20180517_1' as idurba,
'20180517',
typesect,
CASE WHEN fermreco = false THEN 'non'::character varying ELSE 'oui'::character varying END fermreco,
destdomi,
insee,
l_surf_cal,
l_observ,
geom,
nextval('m_urbanisme_doc.geo_a_zone_urba_gid_seq'::regclass)
FROM m_urbanisme_doc.geo_p_zone_urba WHERE insee='60647';


-- Sequence: m_urbanisme_doc_cnig2017.geo_a_zone_urba_gid_seq
-- DROP SEQUENCE m_urbanisme_doc_cnig2017.geo_a_zone_urba_gid_seq;

CREATE SEQUENCE m_urbanisme_doc_cnig2017.geo_a_zone_urba_gid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 4811
  CACHE 1;
ALTER SEQUENCE m_urbanisme_doc_cnig2017.geo_a_zone_urba_gid_seq
    OWNER TO sig_create;
GRANT ALL ON SEQUENCE m_urbanisme_doc_cnig2017.geo_a_zone_urba_gid_seq TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_cnig2017.geo_a_zone_urba_gid_seq TO PUBLIC;


ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba ALTER COLUMN gid SET DEFAULT nextval('m_urbanisme_doc_cnig2017.geo_a_zone_urba_gid_seq'::regclass);


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_a_prescription_surf
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des prescriptions (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC. Chaque organisme doit adapté
-- cette grille en fonction des cas supplémentaires présents dans ces données
-- Intégration du champ GID (à supprimer pour les organismes ne le gértant pas ici)
-- Création de la séquence sur le champ GID et modification du champ GID intégrant la séquence (peut-être mis en commentaire par les partenaires si non utilisées)
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_prescription_surf (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom,gid)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription _surf
CASE
	WHEN typepsc = '09' THEN '05'
	WHEN typepsc = '11' THEN '15'
	WHEN typepsc = '12' THEN '05' 
	WHEN typepsc = '21' THEN '05'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription _surf
CASE
	WHEN l_typepsc2 = '01-03' THEN '00'
	WHEN typepsc = '01' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '02' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN l_typepsc2 = '05-02' THEN '01'
	WHEN l_typepsc2 = '05-06' THEN '04'
	WHEN l_typepsc2 = '05-03' THEN '00'
	WHEN l_typepsc2 = '05-01' THEN '04'
	WHEN l_typepsc2 = '05-04' THEN '01'
        WHEN typepsc = '05' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN l_typepsc2 = '05-05' THEN '01'
	WHEN l_typepsc2 = '07-08' THEN '02'
	WHEN l_typepsc2 = '07-04' THEN '03'
	WHEN l_typepsc2 = '07-03' THEN '00'
	WHEN l_typepsc2 = '07-10' THEN '00'
	WHEN l_typepsc2 = '07-01' THEN '02'
	WHEN l_typepsc2 = '07-05' THEN '01'
	WHEN l_typepsc2 = '07-07' THEN '01'
	WHEN l_typepsc2 = '07-02' THEN '01'
        WHEN typepsc = '07' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN typepsc = '08' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN typepsc = '09' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '05'
        WHEN l_typepsc2 = '11-05' THEN '00'
        WHEN l_typepsc2 = '11-06' THEN '00'
        WHEN l_typepsc2 = '11-07' THEN '00'
        WHEN l_typepsc2 = '11-04' THEN '00'
        WHEN l_typepsc2 = '11-01' THEN '01'
        WHEN typepsc = '12' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '07'
	WHEN typepsc = '14' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '15' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
	WHEN typepsc = '16' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
	WHEN typepsc = '17' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '18' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN typepsc = '19' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '21' THEN '06'
        WHEN l_typepsc2 = '21-02' THEN '06'
        WHEN l_typepsc2 = '21-01' THEN '06'
	WHEN l_typepsc2 = '21-03' THEN '06'
	WHEN l_typepsc2 = '24-01' THEN '01'
	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 END as stypepsc,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_a_prescription_surf.insee || geo_a_prescription_surf.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
l_nature,
l_bnfcr,
l_numero,
l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom,
gid
FROM m_urbanisme_doc.geo_a_prescription_surf;

-- insertion de l'élaboration du PLU de Trosly approuvée le même jour que la modification simplifiée n°1
INSERT INTO m_urbanisme_doc_cnig2017.geo_a_prescription_surf (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom,gid)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription _surf
CASE
	WHEN typepsc = '09' THEN '05'
	WHEN typepsc = '11' THEN '15'
	WHEN typepsc = '12' THEN '05' 
	WHEN typepsc = '21' THEN '05'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription _surf
CASE
	WHEN l_typepsc2 = '01-03' THEN '00'
	WHEN typepsc = '01' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '02' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN l_typepsc2 = '05-02' THEN '01'
	WHEN l_typepsc2 = '05-06' THEN '04'
	WHEN l_typepsc2 = '05-03' THEN '00'
	WHEN l_typepsc2 = '05-01' THEN '04'
	WHEN l_typepsc2 = '05-04' THEN '01'
        WHEN typepsc = '05' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN l_typepsc2 = '05-05' THEN '01'
	WHEN l_typepsc2 = '07-08' THEN '02'
	WHEN l_typepsc2 = '07-04' THEN '03'
	WHEN l_typepsc2 = '07-03' THEN '00'
	WHEN l_typepsc2 = '07-10' THEN '00'
	WHEN l_typepsc2 = '07-01' THEN '02'
	WHEN l_typepsc2 = '07-05' THEN '01'
	WHEN l_typepsc2 = '07-07' THEN '01'
	WHEN l_typepsc2 = '07-02' THEN '01'
        WHEN typepsc = '07' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN typepsc = '08' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN typepsc = '09' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '05'
        WHEN l_typepsc2 = '11-05' THEN '00'
        WHEN l_typepsc2 = '11-06' THEN '00'
        WHEN l_typepsc2 = '11-07' THEN '00'
        WHEN l_typepsc2 = '11-04' THEN '00'
        WHEN l_typepsc2 = '11-01' THEN '01'
        WHEN typepsc = '12' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '07'
	WHEN typepsc = '14' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '15' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
	WHEN typepsc = '16' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
	WHEN typepsc = '17' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '18' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN typepsc = '19' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '21' THEN '06'
        WHEN l_typepsc2 = '21-02' THEN '06'
        WHEN l_typepsc2 = '21-01' THEN '06'
	WHEN l_typepsc2 = '21-03' THEN '06'
	WHEN l_typepsc2 = '24-01' THEN '01'
	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 END as stypepsc,
nomfic,
replace(urlfic,'60647_PLU_20180517','60647_PLU_20180517_1') as urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
'60647_PLU_20180517_1' as idurba,
'20180517',
insee,
l_nom,
l_nature,
l_bnfcr,
l_numero,
l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom,
nextval('m_urbanisme_doc.geo_a_prescription_surf_gid_seq'::regclass)
FROM m_urbanisme_doc.geo_p_prescription_surf WHERE insee='60647';


-- Sequence: m_urbanisme_doc_cnig2017.geo_a_prescription_surf_gid_seq

-- DROP SEQUENCE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_gid_seq;

CREATE SEQUENCE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_gid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 7586
  CACHE 1;
ALTER SEQUENCE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_gid_seq
    OWNER TO sig_create;
GRANT ALL ON SEQUENCE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_gid_seq TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_gid_seq TO PUBLIC;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf ALTER COLUMN gid SET DEFAULT nextval('m_urbanisme_doc_cnig2017.geo_a_prescription_surf_gid_seq'::regclass);


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_a_prescription_lin
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des prescriptions (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC. Chaque organisme doit adapté
-- cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO m_urbanisme_doc_cnig2017.geo_a_prescription_lin (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription_lin
CASE
	WHEN typepsc = '11' and l_typepsc2 <> '11-07' and l_typepsc2 <> '11-08' THEN '15'
        WHEN typepsc = '11' and l_typepsc2 = '11-07' THEN '39'
	WHEN typepsc = '11' and l_typepsc2 = '11-08' THEN '41'
 	WHEN typepsc = '21' THEN '05'
	WHEN typepsc = '99' and l_typepsc2 = '99-01' THEN '41'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription_lin
CASE
        WHEN typepsc = '05' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN l_typepsc2 = '05-05' THEN '01'
	WHEN l_typepsc2 = '05-04' THEN '01'
 	WHEN l_typepsc2 = '07-05' THEN '01'
 	WHEN l_typepsc2 = '07-02' THEN '01'
 	WHEN l_typepsc2 = '07-03' THEN '00'
 	WHEN l_typepsc2 = '07-10' THEN '00'
 	WHEN l_typepsc2 = '07-11' THEN '04'
        WHEN typepsc = '07' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '11-05' THEN '00'
        WHEN l_typepsc2 = '11-01' THEN '01'
        WHEN l_typepsc2 = '11-08' THEN '00'
        WHEN l_typepsc2 = '11-09' THEN '00'
        WHEN l_typepsc2 = '11-03' THEN '03'
        WHEN l_typepsc2 = '11-02' THEN '01'
        WHEN l_typepsc2 = '11-07' THEN '00'
 	WHEN typepsc = '15' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN typepsc = '19' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '21-02' THEN '06'
        WHEN l_typepsc2 = '21-01' THEN '06'
	WHEN l_typepsc2 = '21-03' THEN '06'
 	WHEN l_typepsc2 = '24-01' THEN '01'
 	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN l_typepsc2 = '99-02' THEN '00'
 	WHEN l_typepsc2 = '99-01' THEN '03'
 END as stypepsc,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_a_prescription_lin.insee || geo_a_prescription_lin.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
l_nature,
l_bnfcr,
l_numero,
l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom
FROM m_urbanisme_doc.geo_a_prescription_lin;


-- insertion de l'élaboration du PLU de Trosly approuvée le même jour que la modification simplifiée n°1

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_prescription_lin (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription_lin
CASE
	WHEN typepsc = '11' and l_typepsc2 <> '11-07' and l_typepsc2 <> '11-08' THEN '15'
        WHEN typepsc = '11' and l_typepsc2 = '11-07' THEN '39'
	WHEN typepsc = '11' and l_typepsc2 = '11-08' THEN '41'
 	WHEN typepsc = '21' THEN '05'
	WHEN typepsc = '99' and l_typepsc2 = '99-01' THEN '41'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription_lin
CASE
        WHEN typepsc = '05' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN l_typepsc2 = '05-05' THEN '01'
	WHEN l_typepsc2 = '05-04' THEN '01'
 	WHEN l_typepsc2 = '07-05' THEN '01'
 	WHEN l_typepsc2 = '07-02' THEN '01'
 	WHEN l_typepsc2 = '07-03' THEN '00'
 	WHEN l_typepsc2 = '07-10' THEN '00'
 	WHEN l_typepsc2 = '07-11' THEN '04'
        WHEN typepsc = '07' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '11-05' THEN '00'
        WHEN l_typepsc2 = '11-01' THEN '01'
        WHEN l_typepsc2 = '11-08' THEN '00'
        WHEN l_typepsc2 = '11-09' THEN '00'
        WHEN l_typepsc2 = '11-03' THEN '03'
        WHEN l_typepsc2 = '11-02' THEN '01'
        WHEN l_typepsc2 = '11-07' THEN '00'
 	WHEN typepsc = '15' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN typepsc = '19' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '21-02' THEN '06'
        WHEN l_typepsc2 = '21-01' THEN '06'
	WHEN l_typepsc2 = '21-03' THEN '06'
 	WHEN l_typepsc2 = '24-01' THEN '01'
 	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN l_typepsc2 = '99-02' THEN '00'
 	WHEN l_typepsc2 = '99-01' THEN '03'
 END as stypepsc,
nomfic,
replace(urlfic,'60647_PLU_20180517','60647_PLU_20180517_1') as urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
'60647_PLU_20180517_1' as idurba,
'20180517',
insee,
l_nom,
l_nature,
l_bnfcr,
l_numero,
l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom
FROM m_urbanisme_doc.geo_p_prescription_lin WHERE insee='60647';

-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_a_prescription_pct
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des prescriptions (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC. Chaque organisme doit adapté
-- cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_prescription_pct (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription_pct
CASE
	WHEN typepsc = '11' and l_typepsc2 <> '11-07' and l_typepsc2 <> '11-08' THEN '15'
        WHEN typepsc = '11' and l_typepsc2 = '11-07' THEN '39'
	WHEN typepsc = '11' and l_typepsc2 = '11-08' THEN '41'
  	WHEN typepsc = '21' THEN '05'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription_pct
CASE
 	WHEN l_typepsc2 = '07-01' THEN '02'
 	WHEN l_typepsc2 = '07-08' THEN '02'
   	WHEN l_typepsc2 = '07-05' THEN '01'
   	WHEN l_typepsc2 = '07-06' THEN '01'
   	WHEN l_typepsc2 = '07-02' THEN '01'
   	WHEN l_typepsc2 = '07-11' THEN '04'
        WHEN typepsc = '07' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '11-07' THEN '00'
 	WHEN typepsc = '16' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
 	WHEN typepsc = '19' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '21' THEN '06'
        WHEN l_typepsc2 = '21-03' THEN '06'
   	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 END as stypepsc,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_a_prescription_pct.insee || geo_a_prescription_pct.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
l_nature,
l_bnfcr,
l_numero,
l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom
FROM m_urbanisme_doc.geo_a_prescription_pct;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_a_info_surf
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des informations (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC (sur le Pays Compiégnois).
-- Chaque organisme doit adapté cette grille en fonction des cas supplémentaires présents dans ces données
-- Intégration du champ GID (à supprimer pour les organismes ne le gértant pas ici)
-- Création de la séquence sur le champ GID et modification du champ GID intégrant la séquence (à commenter ou supprimer par les partenaires si non tulisés)
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_info_surf (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom,gid)
SELECT 
idinf,
libelle,
txt,
typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_info_surf
CASE
	WHEN typeinf = '04' THEN '00'
        WHEN typeinf = '02' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
        WHEN typeinf = '03' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '05' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '08' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '10' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '14' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '16' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN l_typeinf2 = '16-02' THEN '00'
	WHEN l_typeinf2 = '16-01' THEN '00'
	WHEN l_typeinf2 = '16-03' THEN '00'
	WHEN typeinf = '19' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '01'
	WHEN l_typeinf2 = '19-04' THEN '02'
	WHEN l_typeinf2 = '19-09' THEN '01'
	WHEN l_typeinf2 = '19-08' THEN '01'
	WHEN typeinf = '99' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN l_typeinf2 = '99-01' THEN '00'
 END as stypeinf,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_a_info_surf.insee || geo_a_info_surf.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
l_dateins,
l_bnfcr,
l_datdlg,
l_gen, 
l_valrecul, 
l_typrecul, 
l_observ,
geom,
gid
FROM m_urbanisme_doc.geo_a_info_surf
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- non intégration des informations qui sont basculées en prescription
WHERE typeinf <> '06' and typeinf <> '18';

-- insertion de l'élaboration du PLU de Trosly approuvée le même jour que la modification simplifiée n°1
INSERT INTO m_urbanisme_doc_cnig2017.geo_a_info_surf (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom,gid)
SELECT 
idinf,
libelle,
txt,
typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_info_surf
CASE
	WHEN typeinf = '04' THEN '00'
        WHEN typeinf = '02' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
        WHEN typeinf = '03' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '05' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '08' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '10' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '14' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '16' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN l_typeinf2 = '16-02' THEN '00'
	WHEN l_typeinf2 = '16-03' THEN '00'
	WHEN typeinf = '19' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '01'
	WHEN l_typeinf2 = '19-04' THEN '02'
	WHEN l_typeinf2 = '19-09' THEN '01'
	WHEN l_typeinf2 = '19-08' THEN '01'
	WHEN typeinf = '99' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN l_typeinf2 = '99-01' THEN '00'
 END as stypeinf,
nomfic,
replace(urlfic,'60647_PLU_20180517','60647_PLU_20180517_1') as urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
'60647_PLU_20180517_1' as idurba,
'20180517',
insee,
l_nom,
l_dateins,
l_bnfcr,
l_datdlg,
l_gen, 
l_valrecul, 
l_typrecul, 
l_observ,
geom,
nextval('m_urbanisme_doc.geo_a_info_surf_gid_seq'::regclass)
FROM m_urbanisme_doc.geo_p_info_surf WHERE insee='60647';




-- Sequence: m_urbanisme_doc_cnig2017.geo_a_info_surf_gid_seq

-- DROP SEQUENCE m_urbanisme_doc_cnig2017.geo_a_info_surf_gid_seq;

CREATE SEQUENCE m_urbanisme_doc_cnig2017.geo_a_info_surf_gid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 782
  CACHE 1;
ALTER SEQUENCE m_urbanisme_doc_cnig2017.geo_a_info_surf_gid_seq
    OWNER TO sig_create;
GRANT ALL ON SEQUENCE m_urbanisme_doc_cnig2017.geo_a_info_surf_gid_seq TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_cnig2017.geo_a_info_surf_gid_seq TO PUBLIC;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf ALTER COLUMN gid SET DEFAULT nextval('m_urbanisme_doc_cnig2017.geo_a_info_surf_gid_seq'::regclass);



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration des données informations vers les données prescriptions (06 info vers 03 00 psc)
-- ATTENTION : certaines informations sont reversées dans les prescriptions dans le nouveau modèle CNIG. Ici n'est présent que les cas rencontrés pour les donnes de l'ARC sur le Pays Compiègnois.
-- Chaque organisme adapté le code ci-après en fonction de ces données
-- Chaque basculement génère une requête de migration, pour l'ARC, 2 requêtes dupliquées et adaptées
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_prescription_surf (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ici incrémentation du n° des informations migrées en prescription en ajoutant à chaque ligne le dernier n° des données de prescription relevés dans la base pour la commune concernée (ici +33 pour la seule commune concernée 60070=Bienville)
-- à adapter par les partenaires
insee || 'PS' || (right(idinf,3)::integer)+33 as idpsc,
'Secteur avec disposition de reconstruction / démolition'::character varying as libelle,
txt,
'03'::character varying as typepsc,
'00'::character varying as stypepsc,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recompostion de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_a_info_surf.insee || geo_a_info_surf.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
''::character varying as l_nature,
l_bnfcr,
''::character varying as l_numero,
''::character varying as l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom
FROM m_urbanisme_doc.geo_a_info_surf 
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- basculement de l'information en prescription
WHERE typeinf = '06';



-- -- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- Migration information vers prescription (18 info vers 31 05 psc)
-- -- ATTENTION : certaines informations sont reversées dans les prescriptions dans le nouveau modèle CNIG. Ici n'est présent que les cas rencontrés pour les donnes de l'ARC sur le Pays Compiègnois.
-- -- Chaque organisme adapté le code ci-après en fonction de ces données
-- -- Chaque basculement génère une requête de migration, pour l'ARC, 2 requêtes dupliquées et adaptées
-- -- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_prescription_surf (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- pas de communes concernées pour l'ARC ici
insee || 'PS' || (right(idinf,3)::integer)+1 as idpsc,
'Marais, vasières, tourbières, plans d''eau, les zones humides et milieux temporairement immergés'::character varying as libelle,
txt,
'31'::character varying as typepsc,
'05'::character varying as stypepsc,
nomfic,
urlfic,
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_a_info_surf.insee || geo_a_info_surf.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
''::character varying as l_nature,
l_bnfcr,
''::character varying as l_numero,
''::character varying as l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom
FROM m_urbanisme_doc.geo_a_info_surf 
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- basculement de l'information en prescription
WHERE typeinf = '18';


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_a_info_lin
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des informations (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC (sur le Pays Compiégnois).
-- Chaque organisme doit adapté cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_info_lin (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idinf,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_info_lin
CASE
	WHEN typeinf = '' THEN ''

ELSE
typeinf END  as typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_info_lin
CASE
	WHEN typeinf = '99' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN l_typeinf2 = '99-04' THEN '00'
	WHEN l_typeinf2 = '99-05' THEN '00'
 END as stypeinf,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recompositon de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_a_info_lin.insee || geo_a_info_lin.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
l_dateins,
l_bnfcr,
l_datdlg,
l_gen, 
l_valrecul, 
l_typrecul, 
l_observ,
geom
FROM m_urbanisme_doc.geo_a_info_lin;



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_a_info_pct (pas de cas sur les données de l'ARC)
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre des champs (Insee, datappro)
-- Migration des anciens vers les nouveaux codes et sous-code des informations (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC (sur le Pays Compiégnois).
-- Chaque organisme doit adapté cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_info_pct (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idinf,
libelle,
txt,
typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_info_pct
CASE
 	WHEN l_typeinf2 = '19-04' THEN '02'
 	WHEN typeinf = '99' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
 END as stypeinf,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_a_info_pct.insee || geo_a_info_pct.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
l_dateins,
l_bnfcr,
l_datdlg,
l_gen, 
l_valrecul, 
l_typrecul, 
l_observ,
geom
FROM m_urbanisme_doc.geo_a_info_pct;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_a_habillage_surf
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Intégration du nouveau champ couleur et l_couleur
-- ATTENTION : gestion du champ NATTRAC pour la migration car peut contenir (cas à l'ARC) des informations à migrer notamment code et info en prescription. Si les partenaires ne sont pas concernés, supprimés
-- de la requête cette partie et remplacé simplement par le nom du champ
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_habillage_surf (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
SELECT 
idhab,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- pas de cas particulier à l'ARC pour la gestion du champ nattrac à la migration
nattrac,
''::character varying(11) as couleur,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_a_habillage_surf.insee || geo_a_habillage_surf.datappro ) || '_' || datappro as idurba,
insee,
''::character varying(7) as l_couleur,
geom
FROM m_urbanisme_doc.geo_a_habillage_surf;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_a_habillage_lin
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Intégration du nouveau champ couleur et l_couleur
-- ATTENTION : gestion du champ NATTRAC pour la migration car peut contenir (cas à l'ARC) des informations à migrer notamment code et info en prescription. Si les partenaires ne sont pas concernés, supprimés
-- de la requête cette partie et remplacé simplement par le nom du champ
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_habillage_lin (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
SELECT 
idhab,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- cas particulier à l'ARC pour la gestion du champ nattrac à la migration
CASE
WHEN nattrac='PRESCRIPTION_LIN-11' THEN 'PRESCRIPTION_LIN-15'
WHEN nattrac='PRESCRIPTION_LIN-21' THEN 'PRESCRIPTION_LIN-05'
WHEN nattrac='PRESCRIPTION_SURF-11' THEN 'PRESCRIPTION_SURF-15'
WHEN nattrac='PRESCRIPTION_SURF-21' THEN 'PRESCRIPTION_SURF-05'
ELSE nattrac END as nattrac,
''::character varying(11) as couleur,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_a_habillage_lin.insee || geo_a_habillage_lin.datappro ) || '_' || datappro as idurba,
insee,
''::character varying(7) as l_couleur,
geom
FROM m_urbanisme_doc.geo_a_habillage_lin;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_a_habillage_pct
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Intégration du nouveau champ couleur
-- ATTENTION : gestion du champ NATTRAC pour la migration car peut contenir (cas à l'ARC) des informations à migrer notamment code et info en prescription. Si les partenaires ne sont pas concernés, supprimés
-- de la requête cette partie et remplacé simplement par le nom du champ
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_habillage_pct (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
SELECT 
idhab,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- pas de cas particulier à l'ARC pour la gestion du champ nattrac à la migration
nattrac,
''::character varying(11) as couleur,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_a_habillage_pct.insee || geo_a_habillage_pct.datappro ) || '_' || datappro as idurba,
insee,
''::character varying(7) as l_couleur,
geom
FROM m_urbanisme_doc.geo_a_habillage_pct;



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_a_habillage_txt
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Intégration du nouveau champ couleur et l_couleur
-- Création d'une séquence sur le champ GID (à supprimer par les partenaires si non utilisée)
-- ATTENTION : gestion du champ NATECR pour la migration car peut contenir (cas à l'ARC) des informations à migrer notamment code et info en prescription. Si les partenaires ne sont pas concernés, supprimés
-- de la requête cette partie et remplacé simplement par le nom du champ
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_habillage_txt (idhab,natecr,txt,police,taille,style,couleur,angle,idurba,l_insee,l_couleur,geom,gid)
SELECT 
idhab,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- cas particulier à l'ARC pour la gestion du champ natecr à la migration
CASE
WHEN natecr='PRESCRIPTION_LIN-11' THEN 'PRESCRIPTION_LIN-15'
WHEN natecr='PRESCRIPTION_LIN-21' THEN 'PRESCRIPTION_LIN-05'
WHEN natecr='PRESCRIPTION_SURF-11' THEN 'PRESCRIPTION_SURF-15'
WHEN natecr='PRESCRIPTION_SURF-21' THEN 'PRESCRIPTION_SURF-05'
ELSE natecr END as natecr,
txt,
police,
taille,
style,
''::character varying(11) as couleur,
angle,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_a_habillage_txt.insee || geo_a_habillage_txt.datappro ) || '_' || datappro as idurba,
insee,
''::character varying(7) as l_couleur,
geom,
gid
FROM m_urbanisme_doc.geo_a_habillage_txt;


-- insertion de l'élaboration de Trolsy approuvée le même jour que la modification simplifiée n°1
INSERT INTO m_urbanisme_doc_cnig2017.geo_a_habillage_txt (idhab,natecr,txt,police,taille,style,couleur,angle,idurba,l_insee,l_couleur,geom,gid)
SELECT 
idhab,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- cas particulier à l'ARC pour la gestion du champ natecr à la migration
CASE
WHEN natecr='PRESCRIPTION_LIN-11' THEN 'PRESCRIPTION_LIN-15'
WHEN natecr='PRESCRIPTION_LIN-21' THEN 'PRESCRIPTION_LIN-05'
WHEN natecr='PRESCRIPTION_SURF-11' THEN 'PRESCRIPTION_SURF-15'
WHEN natecr='PRESCRIPTION_SURF-21' THEN 'PRESCRIPTION_SURF-05'
ELSE natecr END as natecr,
txt,
police,
taille,
style,
''::character varying(11) as couleur,
angle,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
'60647_PLU_20180517_1' as idurba,
insee,
''::character varying(7) as l_couleur,
geom,
nextval('m_urbanisme_doc.geo_a_habillage_txt_gid_seq'::regclass)
FROM m_urbanisme_doc.geo_p_habillage_txt WHERE insee='60647';



-- Sequence: m_urbanisme_doc_cnig2017.geo_a_habillage_txt_gid_seq


-- DROP SEQUENCE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_habillage_txt_gid_seq;

CREATE SEQUENCE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_gid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 8573
  CACHE 1;
ALTER SEQUENCE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_gid_seq
    OWNER TO sig_create;
GRANT ALL ON SEQUENCE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_gid_seq TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_gid_seq TO PUBLIC;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_txt ALTER COLUMN gid SET DEFAULT nextval('m_urbanisme_doc_cnig2017.geo_a_habillage_txt_gid_seq'::regclass);


-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_t_zone_urba
-- Prise en compte de l'implémentation de l'idurba
-- Intégration du changement de codification des types de zone pour les secteur s Nh, Nd et Ah en N et A
-- Mise en champ libre des champs (Insee, destdomi)
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_zone_urba (idzone,libelle,libelong,typezone,nomfic,urlfic,idurba,datvalid,typesect,fermreco,l_destdomi,l_insee,l_surf_cal,l_observ,geom)
SELECT 
replace(idzone,'Z0','ZO') as idzone,
libelle,
libelong,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- basculement du champ typezone
CASE
	WHEN (typezone = 'Nh' or typezone='Nd') THEN 'N'
	WHEN typezone = 'Ah' THEN 'A'
ELSE
	typezone
END as typezone,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_t_zone_urba.insee || geo_t_zone_urba.datappro ) || '_' || datappro as idurba,
datvalid,
typesect,
CASE WHEN fermreco = false THEN 'non'::character varying ELSE 'oui'::character varying END fermreco,
destdomi,
insee,
l_surf_cal,
l_observ,
geom
FROM m_urbanisme_doc.geo_t_zone_urba;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_t_prescription_surf
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des prescriptions (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC. Chaque organisme doit adapté
-- cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_prescription_surf (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_surf
CASE
	WHEN typepsc = '09' THEN '05'
	WHEN typepsc = '11' THEN '15'
	WHEN typepsc = '12' THEN '05' 
	WHEN typepsc = '21' THEN '05'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_surf
CASE
	WHEN l_typepsc2 = '01-03' THEN '00'
	WHEN typepsc = '02' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN l_typepsc2 = '05-02' THEN '01'
	WHEN l_typepsc2 = '05-06' THEN '04'
	WHEN l_typepsc2 = '05-03' THEN '00'
	WHEN l_typepsc2 = '05-01' THEN '04'
	WHEN l_typepsc2 = '05-04' THEN '01'
        WHEN typepsc = '05' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN l_typepsc2 = '05-05' THEN '01'
	WHEN l_typepsc2 = '07-08' THEN '02'
	WHEN l_typepsc2 = '07-04' THEN '03'
	WHEN l_typepsc2 = '07-05' THEN '01'
	WHEN l_typepsc2 = '07-07' THEN '01'
	WHEN l_typepsc2 = '07-02' THEN '01'
        WHEN typepsc = '07' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN typepsc = '08' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN typepsc = '09' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '05'
        WHEN l_typepsc2 = '11-05' THEN '00'
        WHEN l_typepsc2 = '11-06' THEN '00'
        WHEN l_typepsc2 = '11-04' THEN '00'
        WHEN l_typepsc2 = '11-01' THEN '01'
        WHEN typepsc = '12' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '07'
	WHEN typepsc = '15' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
	WHEN typepsc = '16' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
	WHEN typepsc = '17' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '18' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN typepsc = '19' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '21' THEN '06'
        WHEN l_typepsc2 = '21-01' THEN '06'
	WHEN l_typepsc2 = '24-01' THEN '01'
	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 END as stypepsc,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_t_prescription_surf.insee || geo_t_prescription_surf.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
l_nature,
l_bnfcr,
l_numero,
l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom
FROM m_urbanisme_doc.geo_t_prescription_surf;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_t_prescription_lin
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des prescriptions (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC. Chaque organisme doit adapté
-- cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_prescription_lin (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_lin
CASE
	WHEN typepsc = '11' and l_typepsc2 <> '11-07' and l_typepsc2 <> '11-08' THEN '15'
        WHEN typepsc = '11' and l_typepsc2 = '11-07' THEN '39'
	WHEN typepsc = '11' and l_typepsc2 = '11-08' THEN '41'
 	WHEN typepsc = '21' THEN '05'
	WHEN typepsc = '99' and l_typepsc2 = '99-01' THEN '41'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_lin
CASE
        WHEN typepsc = '05' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN l_typepsc2 = '05-05' THEN '01'
 	WHEN l_typepsc2 = '07-05' THEN '01'
 	WHEN l_typepsc2 = '07-02' THEN '01'
 	WHEN l_typepsc2 = '07-03' THEN '00'
 	WHEN l_typepsc2 = '07-10' THEN '00'
 	WHEN l_typepsc2 = '07-11' THEN '04'
        WHEN typepsc = '07' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '11-05' THEN '00'
        WHEN l_typepsc2 = '11-01' THEN '01'
        WHEN l_typepsc2 = '11-08' THEN '00'
        WHEN l_typepsc2 = '11-09' THEN '00'
        WHEN l_typepsc2 = '11-03' THEN '03'
        WHEN l_typepsc2 = '11-02' THEN '01'
        WHEN l_typepsc2 = '11-07' THEN '00'
 	WHEN typepsc = '15' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN typepsc = '19' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '21-02' THEN '06'
        WHEN l_typepsc2 = '21-01' THEN '06'
 	WHEN l_typepsc2 = '24-01' THEN '01'
 	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN l_typepsc2 = '99-02' THEN '00'
 	WHEN l_typepsc2 = '99-01' THEN '03'
 END as stypepsc,
nomfic,
urlfic,
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_t_prescription_lin.insee || geo_t_prescription_lin.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
l_nature,
l_bnfcr,
l_numero,
l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom
FROM m_urbanisme_doc.geo_t_prescription_lin;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_t_prescription_pct
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des prescriptions (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC. Chaque organisme doit adapté
-- cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_prescription_pct (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_pct
CASE
	WHEN typepsc = '11' and l_typepsc2 <> '11-07' and l_typepsc2 <> '11-08' THEN '15'
        WHEN typepsc = '11' and l_typepsc2 = '11-07' THEN '39'
	WHEN typepsc = '11' and l_typepsc2 = '11-08' THEN '41'
  	WHEN typepsc = '21' THEN '05'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_pct
CASE
 	WHEN l_typepsc2 = '07-01' THEN '02'
 	WHEN l_typepsc2 = '07-08' THEN '02'
   	WHEN l_typepsc2 = '07-05' THEN '01'
        WHEN l_typepsc2 = '07-06' THEN '01'
   	WHEN l_typepsc2 = '07-02' THEN '01'
   	WHEN l_typepsc2 = '07-11' THEN '04'
        WHEN typepsc = '07' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '11-07' THEN '00'
 	WHEN typepsc = '16' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
 	WHEN typepsc = '19' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '21-03' THEN '06'
   	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 END as stypepsc,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_t_prescription_pct.insee || geo_t_prescription_pct.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
l_nature,
l_bnfcr,
l_numero,
l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom
FROM m_urbanisme_doc.geo_t_prescription_pct;



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_t_info_surf
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des informations (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC (sur le Pays Compiégnois).
-- Chaque organisme doit adapté cette grille en fonction des cas supplémentaires présents dans ces données
-- Le champ geom1 est spécifique à l'ARC, il peut être mis en commentaire par les autres organismes
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_info_surf (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idinf,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_info_surf
CASE
	WHEN typeinf = '' THEN ''

ELSE
typeinf END  as typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_info_surf
CASE
	WHEN l_typeinf2 = '04-01' THEN '00'
        WHEN typeinf = '02' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
        WHEN typeinf = '03' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '05' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '14' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '16' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN typeinf = '19' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '01'
	WHEN l_typeinf2 = '19-04' THEN '02'
	WHEN l_typeinf2 = '19-09' THEN '01'
	WHEN l_typeinf2 = '19-08' THEN '01'
	WHEN typeinf = '99' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN l_typeinf2 = '99-01' THEN '00'
 END as stypeinf,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_t_info_surf.insee || geo_t_info_surf.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
l_dateins,
l_bnfcr,
l_datdlg,
l_gen, 
l_valrecul, 
l_typrecul, 
l_observ,
geom
FROM m_urbanisme_doc.geo_t_info_surf 
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Non prise en compte des informations basculées en prescription
WHERE typeinf <> '06' and typeinf <> '18';



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration des données informations vers les données prescriptions (06 info vers 03 00 psc)
-- ATTENTION : certaines informations sont reversées dans les prescriptions dans le nouveau modèle CNIG. Ici n'est présent que les cas rencontrés pour les donnes de l'ARC sur le Pays Compiègnois.
-- Chaque organisme adapté le code ci-après en fonction de ces données
-- Chaque basculement génère une requête de migration, pour l'ARC, 2 requêtes dupliquées et adaptées
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Pas de cas relevé pour les procédures en cours à l'ARC
INSERT INTO m_urbanisme_doc_cnig2017.geo_t_prescription_surf (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_surf
insee || 'PS' ||
		CASE WHEN (select length((max(right(idpsc,3))::integer+1)::character varying) from m_urbanisme_doc.geo_t_prescription_surf where insee = geo_t_info_surf.insee) = 0
			THEN ('00' || (select max(right(idpsc,3))::integer+(select right(idinf,3)::integer from m_urbanisme_doc.geo_t_info_surf i where i.idinf = geo_t_info_surf.idinf) from m_urbanisme_doc.geo_t_prescription_surf where insee = geo_t_info_surf.insee))::character varying
		WHEN (select length((max(right(idpsc,3))::integer+1)::character varying) from m_urbanisme_doc.geo_t_prescription_surf where insee = geo_t_info_surf.insee) = 1
			THEN  ('00' || (select max(right(idpsc,3))::integer+(select right(idinf,3)::integer from m_urbanisme_doc.geo_t_info_surf i where i.idinf = geo_t_info_surf.idinf) from m_urbanisme_doc.geo_t_prescription_surf where insee = geo_t_info_surf.insee))::character varying
		WHEN (select length((max(right(idpsc,3))::integer+1)::character varying) from m_urbanisme_doc.geo_t_prescription_surf where insee = geo_t_info_surf.insee) = 2
			THEN ('0' || (select max(right(idpsc,3))::integer+(select right(idinf,3)::integer from m_urbanisme_doc.geo_t_info_surf i where i.idinf = geo_t_info_surf.idinf) from m_urbanisme_doc.geo_t_prescription_surf where insee = geo_t_info_surf.insee))::character varying
		ELSE
			((select max(right(idpsc,3))::integer+1 from m_urbanisme_doc.geo_t_prescription_surf where insee = geo_t_info_surf.insee))::character varying
END as idpsc,
'Secteur avec disposition de reconstruction / démolition'::character varying as libelle,
txt,
'03'::character varying as typepsc,
'00'::character varying as stypepsc,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_t_info_surf.insee || geo_t_info_surf.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
''::character varying as l_nature,
l_bnfcr,
''::character varying as l_numero,
''::character varying as l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom
FROM m_urbanisme_doc.geo_t_info_surf 
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- uniquement l'information 06
WHERE typeinf = '06';


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration information vers prescription (18 info vers 31 05 psc)
-- ATTENTION : certaines informations sont reversées dans les prescriptions dans le nouveau modèle CNIG. Ici n'est présent que les cas rencontrés pour les donnes de l'ARC sur le Pays Compiègnois.
-- Chaque organisme adapté le code ci-après en fonction de ces données
-- Chaque basculement génère une requête de migration, pour l'ARC, 2 requêtes dupliquées et adaptées
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- pas de cas relevé dans les procédures en cours à l'ARC
INSERT INTO m_urbanisme_doc_cnig2017.geo_t_prescription_surf (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_surf
insee || 'PS' ||
		CASE WHEN (select length((max(right(idpsc,3))::integer+1)::character varying) from m_urbanisme_doc.geo_t_prescription_surf where insee = geo_t_info_surf.insee) = 0
			THEN ('00' || (select max(right(idpsc,3))::integer+(select right(idinf,3)::integer from m_urbanisme_doc.geo_t_info_surf i where i.idinf = geo_t_info_surf.idinf) from m_urbanisme_doc.geo_t_prescription_surf where insee = geo_t_info_surf.insee))::character varying
		WHEN (select length((max(right(idpsc,3))::integer+1)::character varying) from m_urbanisme_doc.geo_t_prescription_surf where insee = geo_t_info_surf.insee) = 1
			THEN  ('00' || (select max(right(idpsc,3))::integer+(select right(idinf,3)::integer from m_urbanisme_doc.geo_t_info_surf i where i.idinf = geo_t_info_surf.idinf) from m_urbanisme_doc.geo_t_prescription_surf where insee = geo_t_info_surf.insee))::character varying
		WHEN (select length((max(right(idpsc,3))::integer+1)::character varying) from m_urbanisme_doc.geo_t_prescription_surf where insee = geo_t_info_surf.insee) = 2
			THEN ('0' || (select max(right(idpsc,3))::integer+(select right(idinf,3)::integer from m_urbanisme_doc.geo_t_info_surf i where i.idinf = geo_t_info_surf.idinf) from m_urbanisme_doc.geo_t_prescription_surf where insee = geo_t_info_surf.insee))::character varying
		ELSE
			((select max(right(idpsc,3))::integer+1 from m_urbanisme_doc.geo_t_prescription_surf where insee = geo_t_info_surf.insee))::character varying
END as idpsc,
'Marais, vasières, tourbières, plans d''eau, les zones humides et milieux temporairement immergés'::character varying as libelle,
txt,
'31'::character varying as typepsc,
'05'::character varying as stypepsc,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_t_info_surf.insee || geo_t_info_surf.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
''::character varying as l_nature,
l_bnfcr,
''::character varying as l_numero,
''::character varying as l_surf_txt,
l_gen,
l_valrecul,
l_typrecul,
l_observ,
geom
FROM m_urbanisme_doc.geo_t_info_surf 
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- uniquement information 18
WHERE typeinf = '18';



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_t_info_lin
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre des champs (Insee, datappro)
-- Migration des anciens vers les nouveaux codes et sous-code des informations (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC (sur le Pays Compiégnois).
-- Chaque organisme doit adapté cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_info_lin (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idinf,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_info_lin
CASE
	WHEN typeinf = '' THEN ''

ELSE
typeinf END  as typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_info_lin
CASE
	WHEN typeinf = '99' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN l_typeinf2 = '99-04' THEN '00'
	WHEN l_typeinf2 = '99-05' THEN '00'
 END as stypeinf,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_t_info_lin.insee || geo_t_info_lin.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
l_dateins,
l_bnfcr,
l_datdlg,
l_gen, 
l_valrecul, 
l_typrecul, 
l_observ,
geom
FROM m_urbanisme_doc.geo_t_info_lin;



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_t_info_pct
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre des champs (Insee, datappro)
-- Migration des anciens vers les nouveaux codes et sous-code des informations (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC (sur le Pays Compiégnois).
-- Chaque organisme doit adapté cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_info_pct (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idinf,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_info_pct
CASE
	WHEN typeinf = '' THEN ''

ELSE
typeinf END  as typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_info_pct
CASE
 	WHEN l_typeinf2 = '19-04' THEN '02'
 	WHEN typeinf = '99' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
 END as stypeinf,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_t_info_pct.insee || geo_t_info_pct.datappro ) || '_' || datappro as idurba,
datvalid,
insee,
l_nom,
l_dateins,
l_bnfcr,
l_datdlg,
l_gen, 
l_valrecul, 
l_typrecul, 
l_observ,
geom
FROM m_urbanisme_doc.geo_t_info_pct;



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_t_habillage_surf
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Intégration du nouveau champ couleur et l_couleur
-- ATTENTION : gestion du champ NATTRAC pour la migration car peut contenir (cas à l'ARC) des informations à migrer notamment code et info en prescription. Si les partenaires ne sont pas concernés, supprimés
-- de la requête cette partie et remplacé simplement par le nom du champ
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_habillage_surf (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
SELECT 
idhab,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- pas de cas particulier à l'ARC pour le champ nattrac pour la migration
nattrac,
''::character varying(11) as couleur,
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_t_habillage_surf.insee || geo_t_habillage_surf.datappro ) || '_' || datappro as idurba,
insee,
''::character varying(7) as l_couleur,
geom
FROM m_urbanisme_doc.geo_t_habillage_surf;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_t_habillage_lin
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Intégration du nouveau champ couleur et l_couleur
-- ATTENTION : gestion du champ NATTRAC pour la migration car peut contenir (cas à l'ARC) des informations à migrer notamment code et info en prescription. Si les partenaires ne sont pas concernés, supprimés
-- de la requête cette partie et remplacé simplement par le nom du champ
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_habillage_lin (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
SELECT 
idhab,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- cas particulier à l'ARC pour le champ nattrac pour la migration
CASE
WHEN nattrac='PRESCRIPTION_LIN-11' THEN 'PRESCRIPTION_LIN-15'
WHEN nattrac='PRESCRIPTION_SURF-11' THEN 'PRESCRIPTION_SURF-15'
ELSE nattrac END as nattrac,
''::character varying(11) as couleur,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_t_habillage_lin.insee || geo_t_habillage_lin.datappro ) || '_' || datappro as idurba,
insee,
''::character varying(7) as l_couleur,
geom
FROM m_urbanisme_doc.geo_t_habillage_lin;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_t_habillage_pct
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Intégration du nouveau champ couleur et l_couleur
-- ATTENTION : gestion du champ NATTRAC pour la migration car peut contenir (cas à l'ARC) des informations à migrer notamment code et info en prescription. Si les partenaires ne sont pas concernés, supprimés
-- de la requête cette partie et remplacé simplement par le nom du champ
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_habillage_pct (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
SELECT 
idhab,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- pas de cas particulier à l'ARC pour le champ nattrac pour la migration
nattrac,
''::character varying(11) as couleur,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_t_habillage_pct.insee || geo_t_habillage_pct.datappro ) || '_' || datappro as idurba,
insee,
''::character varying(7) as l_couleur,
geom
FROM m_urbanisme_doc.geo_t_habillage_pct;



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_t_habillage_txt
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Intégration du nouveau champ couleur et l_couleur
-- ATTENTION : gestion du champ NATECR pour la migration car peut contenir (cas à l'ARC) des informations à migrer notamment code et info en prescription. Si les partenaires ne sont pas concernés, supprimés
-- de la requête cette partie et remplacé simplement par le nom du champ
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_habillage_txt (idhab,natecr,txt,police,taille,style,couleur,angle,idurba,l_insee,l_couleur,geom)
SELECT 
idhab,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- cas particulier à l'ARC pour le champ natecr pour la migration
CASE
WHEN natecr='PRESCRIPTION_LIN-11' THEN 'PRESCRIPTION_LIN-15'
WHEN natecr='PRESCRIPTION_SURF-11' THEN 'PRESCRIPTION_SURF-15'
ELSE natecr END as natecr,
txt,
police,
taille,
style,
''::character varying(11) as couleur,
angle,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_t_habillage_txt.insee || geo_t_habillage_txt.datappro ) || '_' || datappro as idurba,
insee,
''::character varying(7) as l_couleur,
geom
FROM m_urbanisme_doc.geo_t_habillage_txt;


-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Mise à jour des liens des fichiers nomfic et urlfic suite à l'intégration du sous-code de la prescription ou de l'information dans le nom
-- du fichier. 
-- ATTENTION : il faut gérer se renommage également au niveau des noms dde fichier PDF dans les répertoires
-- cette mise à jour est adaptée au typepsc rencontré à l'ARC (à adapter par les partenaires suivants ces casde psc)
-- ----------------------------------------------------------------------------------------------------------------------------------------------------


-- PRESCRIPTION (production)
-- SURFACIQUE
UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_surf set nomfic = 
CASE
WHEN nomfic like '%_05_%' THEN replace(nomfic,'_05_', '_' || typepsc || '_' || '00' || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_05_%' THEN replace(urlfic,'_05_', '_' || typepsc || '_' || '00' || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_surf set nomfic = 
CASE
WHEN nomfic like '%_07_%' THEN replace(nomfic,'_07_', '_' || typepsc || '_' || '01' || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_07_%' THEN replace(urlfic,'_07_', '_' || typepsc || '_' || '01' || '_')
ELSE
urlfic
END;
					   
-- gestion des infos passant en prescription
UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_surf set nomfic = 
CASE
WHEN nomfic = '60125_info_surf_06_20170707.pdf' THEN '60125_prescription_surf_03_00_20170707.pdf'
ELSE
nomfic
END,
urlfic = 
CASE
WHEN nomfic = '60125_info_surf_06_20170707.pdf' THEN replace(urlfic,'60125_info_surf_06_20170707.pdf', '60125_prescription_surf_03_00_20170707.pdf')
ELSE
urlfic
END;

-- LINEAIRE
UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_lin set nomfic = 
CASE
WHEN nomfic like '%_24_%' THEN replace(nomfic,'_24_', '_' || typepsc || '_' || stypepsc || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_24_%' THEN replace(urlfic,'_24_', '_' || typepsc || '_' || stypepsc || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_lin set nomfic = 
CASE
WHEN nomfic like '%_11_%' THEN replace(nomfic,'_11_', '_' || typepsc || '_' || stypepsc || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_11_%' THEN replace(urlfic,'_11_', '_' || typepsc || '_' || stypepsc || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_lin set nomfic = 
CASE
WHEN nomfic like '%_07_%' THEN replace(nomfic,'_07_', '_' || typepsc || '_' || '01' || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_07_%' THEN replace(urlfic,'_07_', '_' || typepsc || '_' || '01' || '_')
ELSE
urlfic
END;

-- PONCTUELLE
UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_pct set nomfic = 
CASE
WHEN nomfic like '%_07_%' THEN replace(nomfic,'_07_', '_' || typepsc || '_' || stypepsc || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_07_%' THEN replace(urlfic,'_07_', '_' || typepsc || '_' || stypepsc || '_')
ELSE
urlfic
END;

-- PRESCRIPTION (test)
-- SURFACIQUE
UPDATE m_urbanisme_doc_cnig2017.geo_t_prescription_surf set nomfic = 
CASE
WHEN nomfic like '%_05_%' THEN replace(nomfic,'_05_', '_' || typepsc || '_' || '00' || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_05_%' THEN replace(urlfic,'_05_', '_' || typepsc || '_' || '00' || '_')
ELSE
urlfic
END;

-- LINEAIRE
-- (pas de cas à l'ARC)
-- PONCTUELLE
UPDATE m_urbanisme_doc_cnig2017.geo_t_prescription_pct set nomfic = 
CASE
WHEN nomfic like '%_07_%' THEN replace(nomfic,'_07_', '_' || typepsc || '_' || '01' || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_07_%' THEN replace(urlfic,'_07_', '_' || typepsc || '_' || '01' || '_')
ELSE
urlfic
END;

-- PRESCRIPTION (archive)
-- SURFACIQUE
				   
					   
UPDATE m_urbanisme_doc_cnig2017.geo_a_prescription_surf set nomfic = 
CASE
WHEN nomfic like '%_05_%' THEN replace(nomfic,'_05_', '_' || typepsc || '_' || '00' || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_05_%' THEN replace(urlfic,'_05_', '_' || typepsc || '_' || '00' || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_a_prescription_surf set nomfic = 
CASE
WHEN nomfic like '%_14_%' THEN replace(nomfic,'_14_', '_' || typepsc || '_' || stypepsc || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_14_%' THEN replace(urlfic,'_14_', '_' || typepsc || '_' || stypepsc || '_')
ELSE
urlfic
END;

-- LINEAIRE
UPDATE m_urbanisme_doc_cnig2017.geo_a_prescription_lin set nomfic = 
CASE
WHEN nomfic like '%_11_%' THEN replace(nomfic,'_11_', '_' || typepsc || '_' || stypepsc || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_11_%' THEN replace(urlfic,'_11_', '_' || typepsc || '_' || stypepsc || '_')
ELSE
urlfic
END;
					   
UPDATE m_urbanisme_doc_cnig2017.geo_a_prescription_lin set nomfic = 
CASE
WHEN nomfic like '%_05_%' THEN replace(nomfic,'_05_', '_' || typepsc || '_' || '00' || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_05_%' THEN replace(urlfic,'_05_', '_' || typepsc || '_' || '00' || '_')
ELSE
urlfic
END;

-- PONCTUELLE
UPDATE m_urbanisme_doc_cnig2017.geo_a_prescription_pct set nomfic = 
CASE
WHEN nomfic like '%_07_%' THEN replace(nomfic,'_07_', '_' || typepsc || '_' || '00' || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_07_%' THEN replace(urlfic,'_07_', '_' || typepsc || '_' || '00' || '_')
ELSE
urlfic
END;

-- INFORMATION (production)
-- SURFACIQUE
					   
UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf set nomfic = 
CASE
WHEN nomfic like '%_02_%' THEN replace(nomfic,'_02_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_02_%' THEN replace(urlfic,'_02_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf set nomfic = 
CASE
WHEN nomfic like '%_04_%' THEN replace(nomfic,'_04_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_04_%' THEN replace(urlfic,'_04_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf set nomfic = 
CASE
WHEN nomfic like '%_05_%' THEN replace(nomfic,'_05_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_05_%' THEN replace(urlfic,'_05_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf set nomfic = 
CASE
WHEN nomfic like '%_14_%' THEN replace(nomfic,'_14_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_14_%' THEN replace(urlfic,'_14_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf set nomfic = 
CASE
WHEN nomfic like '%_19_%' THEN replace(nomfic,'_19_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_19_%' THEN replace(urlfic,'_19_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END			   
;
					   
UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf set nomfic = 
CASE
WHEN nomfic = '60125_info_surf_19_01_19_01_20170707.pdf' THEN '60125_info_surf_19_01_20170707.pdf'
ELSE
nomfic
END,
urlfic =
CASE
WHEN urlfic like '%60125_info_surf_19_01_19_01_20170707.pdf' 
THEN replace(urlfic,'60125_info_surf_19_01_19_01_20170707.pdf', '60125_info_surf_19_01_20170707.pdf')
ELSE
urlfic
END;
					   
				   
UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf set nomfic = 
CASE
WHEN nomfic like '%_99_%' THEN replace(nomfic,'_99_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_99_%' THEN replace(urlfic,'_99_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END;
					   
-- LINEAIRE
-- pas de cas à l'arc

-- SURFACIQUE
UPDATE m_urbanisme_doc_cnig2017.geo_t_info_surf set nomfic = 
CASE
WHEN nomfic like '%_04_%' THEN replace(nomfic,'_04_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_04_%' THEN replace(urlfic,'_04_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END;
				   
-- LINEAIRE
-- (pas de cas à l'ARC)

-- SURFACIQUE
UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf set nomfic = 
CASE
WHEN nomfic like '%_02_%' THEN replace(nomfic,'_02_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_02_%' THEN replace(urlfic,'_02_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf set nomfic = 
CASE
WHEN nomfic like '%_04_%' THEN replace(nomfic,'_04_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_04_%' THEN replace(urlfic,'_04_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf set nomfic = 
CASE
WHEN nomfic like '%_05_%' THEN replace(nomfic,'_05_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_05_%' THEN replace(urlfic,'_05_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf set nomfic = 
CASE
WHEN nomfic like '%_10_%' THEN replace(nomfic,'_10_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_10_%' THEN replace(urlfic,'_10_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf set nomfic = 
CASE
WHEN nomfic like '%_14_%' THEN replace(nomfic,'_14_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_14_%' THEN replace(urlfic,'_14_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf set nomfic = 
CASE
WHEN nomfic like '%_16_%' THEN replace(nomfic,'_16_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_16_%' THEN replace(urlfic,'_16_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf set nomfic = 
CASE
WHEN nomfic like '%_19_%' THEN replace(nomfic,'_19_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_19_%' THEN replace(urlfic,'_19_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf set nomfic = 
CASE
WHEN nomfic like '%_99_%' THEN replace(nomfic,'_99_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
nomfic
END,
urlfic = 
CASE
WHEN urlfic like '%_99_%' THEN replace(urlfic,'_99_', '_' || typeinf || '_' || stypeinf || '_')
ELSE
urlfic
END;

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf set nomfic = 
CASE
WHEN nomfic = '60125_info_surf_19_01_19_01_20170323.pdf' THEN '60125_info_surf_19_01_20170323.pdf'
ELSE
nomfic
END,
urlfic =
CASE
WHEN urlfic like '%60125_info_surf_19_01_19_01_20170323.pdf' 
THEN replace(urlfic,'60125_info_surf_19_01_19_01_20170323.pdf', '60125_info_surf_19_01_20170323.pdf')
ELSE
urlfic
END;

-- LINEAIRE
-- pas de cas à l'arc



-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Mise à jour des liens des fichiers nomfic et urlfic pour les règlements de ZAC (uniquement pour l'ARC)
-- ----------------------------------------------------------------------------------------------------------------------------------------------------

-- Table PRODUCTION
UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf set 
nomfic = '60023_info_surf_02_00_20171221.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60023_POS_20171221/Pieces_ecrites/4_Annexes/60023_info_surf_02_00_20171221.pdf'
WHERE nomfic = 'reglement_ZI_Armancourt_20001002.pdf';
					   
UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf set 
nomfic = '60665_info_surf_02_00_1_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_1_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Prairie_19990706.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf set 
nomfic = '60665_info_surf_02_00_2_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_2_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Jaux-Venette_19860725.pdf' AND left(idinf,5) = '60665';

UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf set 
nomfic = '60665_info_surf_02_00_3_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_3_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Camp_du_Roy_19960126.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf set 
nomfic = '60325_info_surf_02_00_20140307.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60325_PLU_20140307/Pieces_ecrites/4_Annexes/60325_info_surf_02_00_20140307.pdf'
WHERE nomfic = 'reglement_ZAC_Jaux-Venette_19860725.pdf' AND left(idinf,5) = '60325';

-- Table ARCHIVE
UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf set 
nomfic = '60023_info_surf_02_00_20171221.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60023_POS_20171221/Pieces_ecrites/4_Annexes/60023_info_surf_02_00_20171221.pdf'
WHERE nomfic = 'reglement_ZI_Armancourt_20001002.pdf';
					   
UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf set 
nomfic = '60665_info_surf_02_00_1_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_1_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Prairie_19990706.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf set 
nomfic = '60665_info_surf_02_00_2_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_2_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Jaux-Venette_19860725.pdf' AND left(idinf,5) = '60665';

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf set 
nomfic = '60665_info_surf_02_00_3_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_3_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Camp_du_Roy_19960126.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf set 
nomfic = '60325_info_surf_02_00_20140307.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60325_PLU_20140307/Pieces_ecrites/4_Annexes/60325_info_surf_02_00_20140307.pdf'
WHERE nomfic = 'reglement_ZAC_Jaux-Venette_19860725.pdf' AND left(idinf,5) = '60325';

-- Table TEST
UPDATE m_urbanisme_doc_cnig2017.geo_t_info_surf set 
nomfic = '60023_info_surf_02_00_20171221.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60023_POS_20171221/Pieces_ecrites/4_Annexes/60023_info_surf_02_00_20171221.pdf'
WHERE nomfic = 'reglement_ZI_Armancourt_20001002.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_t_info_surf set 
nomfic = '60665_info_surf_02_00_1_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_1_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Prairie_19990706.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_t_info_surf set 
nomfic = '60665_info_surf_02_00_2_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_2_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Jaux-Venette_19860725.pdf' AND left(idinf,5) = '60665';

UPDATE m_urbanisme_doc_cnig2017.geo_t_info_surf set 
nomfic = '60665_info_surf_02_00_3_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_3_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Camp_du_Roy_19960126.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_t_info_surf set 
nomfic = '60325_info_surf_02_00_20140307.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60325_PLU_20140307/Pieces_ecrites/4_Annexes/60325_info_surf_02_00_20140307.pdf'
WHERE nomfic = 'reglement_ZAC_Jaux-Venette_19860725.pdf' AND left(idinf,5) = '60325';




-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     TRIGGER                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ####################################################### FONCTION TRIGGER - update_geom #############################################################

-- COMMENT GB : ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Cette fonction est spécifique à l'ARC et permet de calculer le champ geom1 (doit-être mis en commentaire pour l'intégration par les autres organismes
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Function: m_urbanisme_doc_cnig2017.an_doc_urba_null()

-- DROP FUNCTION m_urbanisme_doc_cnig2017.an_doc_urba_null();

CREATE OR REPLACE FUNCTION m_urbanisme_doc_cnig2017.an_doc_urba_null()
  RETURNS trigger AS
$BODY$BEGIN
	update m_urbanisme_doc_cnig2017.an_doc_urba set datefin=null where datefin='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set nomproc=null where nomproc='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set l_meta=null where l_meta='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set l_moa_proc=null where l_moa_proc='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set l_moe_proc=null where l_moe_proc='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set l_moa_dmat=null where l_moa_dmat='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set l_moe_dmat=null where l_moe_dmat='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set l_observ=null where l_observ='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set nomreg=null where nomreg='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set urlreg=null where urlreg='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set nomplan=null where nomplan='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set urlplan=null where urlplan='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set urlpe=null where urlpe='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set siteweb=null where siteweb='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set dateref=null where dateref='';
RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc_cnig2017.an_doc_urba_null()
  OWNER TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.an_doc_urba_null() TO public;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.an_doc_urba_null() TO create_sig;

COMMENT ON FUNCTION m_urbanisme_doc_cnig2017.an_doc_urba_null() IS 'Fonction remplaçant les '' par null lors de la mise à jour ou de l''insertion via le module web de gestion PNR/OLV';


-- Trigger: t_t1_r_null_an_doc_urba on m_urbanisme_doc_cnig2017.an_doc_urba

-- DROP TRIGGER t_t1_r_null_an_doc_urba ON m_urbanisme_doc_cnig2017.an_doc_urba;

CREATE TRIGGER t_t1_r_null_an_doc_urba
  AFTER INSERT OR UPDATE
  ON m_urbanisme_doc_cnig2017.an_doc_urba
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc_cnig2017.an_doc_urba_null();


-- Function: m_urbanisme_doc_cnig2017.m_geom1_prescription_surf()

-- DROP FUNCTION m_urbanisme_doc_cnig2017.m_geom1_prescription_surf();

CREATE OR REPLACE FUNCTION m_urbanisme_doc_cnig2017.m_geom1_prescription_surf()
  RETURNS trigger AS
$BODY$BEGIN

 UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_surf SET geom1 = st_multi(st_buffer(geom,-0.5));


RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc_cnig2017.m_geom1_prescription_surf()
  OWNER TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_geom1_prescription_surf() TO public;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_geom1_prescription_surf() TO create_sig;


-- Trigger: update_geom on m_urbanisme_doc_cnig2017.geo_p_prescription_surf

-- DROP TRIGGER update_geom ON m_urbanisme_doc_cnig2017.geo_p_prescription_surf;

CREATE TRIGGER update_geom
  AFTER INSERT OR UPDATE OF geom
  ON m_urbanisme_doc_cnig2017.geo_p_prescription_surf
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc_cnig2017.m_geom1_prescription_surf();


-- Function: m_urbanisme_doc_cnig2017.m_geom1_information_surf()

-- DROP FUNCTION m_urbanisme_doc_cnig2017.m_geom1_information_surf();

CREATE OR REPLACE FUNCTION m_urbanisme_doc_cnig2017.m_geom1_information_surf()
  RETURNS trigger AS
$BODY$BEGIN

 UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf SET geom1 = st_multi(st_buffer(geom,-0.5));
 UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf SET geom1 = st_multi(st_buffer(geom,-1.5)) where typeinf || stypeinf='0400';


RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc_cnig2017.m_geom1_information_surf()
  OWNER TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_geom1_information_surf() TO public;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_geom1_information_surf() TO create_sig;


-- Trigger: update_geom on m_urbanisme_doc_cnig2017.geo_p_info_surf

-- DROP TRIGGER update_geom ON m_urbanisme_doc_cnig2017.geo_p_info_surf;

CREATE TRIGGER update_geom
  AFTER INSERT OR UPDATE OF geom
  ON m_urbanisme_doc_cnig2017.geo_p_info_surf
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc_cnig2017.m_geom1_information_surf();

-- Function: m_urbanisme_doc_cnig2017.m_geom1_prescription_surf()

-- DROP FUNCTION m_urbanisme_doc_cnig2017.m_geom1_prescription_surf();

CREATE OR REPLACE FUNCTION m_urbanisme_doc_cnig2017.m_geom1_prescription_lin()
  RETURNS trigger AS
$BODY$BEGIN

 UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_lin SET geom1 = st_multi(st_buffer(geom,0.01,'endcap=flat join=round'));


RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc_cnig2017.m_geom1_prescription_lin()
  OWNER TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_geom1_prescription_lin() TO public;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_geom1_prescription_lin() TO create_sig;


CREATE TRIGGER t_t1_update_geom
  AFTER INSERT OR UPDATE OF geom
  ON m_urbanisme_doc_cnig2017.geo_p_prescription_lin
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc_cnig2017.m_geom1_prescription_lin();


-- ####################################################### FONCTION TRIGGER - m_l_surf_cal_ha ##################################################

-- Function: m_urbanisme_doc_cnig2017.m_l_surf_cal_ha()

-- DROP FUNCTION m_urbanisme_doc_cnig2017.m_l_surf_cal_ha();

CREATE OR REPLACE FUNCTION m_urbanisme_doc_cnig2017.m_l_surf_cal_ha()
  RETURNS trigger AS
$BODY$BEGIN
NEW.l_surf_cal=round(cast(st_area(new.geom)/10000 as numeric),2);
RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc_cnig2017.m_l_surf_cal_ha()
  OWNER TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_l_surf_cal_ha() TO public;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_l_surf_cal_ha() TO create_sig;
										       
COMMENT ON FUNCTION m_urbanisme_doc_cnig2017.m_l_surf_cal_ha() IS 'Fonction dont l''objet est de mettre à jour la superficie calculée en ha du champ l_surf_cal des zones urba';

-- Trigger: l_surface on m_urbanisme_doc_cnig2017.geo_p_zone_urba

-- DROP TRIGGER l_surface ON m_urbanisme_doc_cnig2017.geo_p_zone_urba

CREATE TRIGGER l_surf_cal
  BEFORE INSERT OR UPDATE OF geom
  ON m_urbanisme_doc_cnig2017.geo_p_zone_urba
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc_cnig2017.m_l_surf_cal_ha();


-- Trigger: l_surface on m_urbanisme_doc_cnig2017.geo_t_zone_urba

-- DROP TRIGGER l_surface ON m_urbanisme_doc_cnig2017.geo_t_zone_urba;

CREATE TRIGGER l_surf_cal
  BEFORE INSERT OR UPDATE OF geom
  ON m_urbanisme_doc_cnig2017.geo_t_zone_urba
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc_cnig2017.m_l_surf_cal_ha();



-- ####################################################################################################################################################
-- ###                                                             TRIGGER SPECIFIQUE PNR-OLV                                                       ###
-- ####################################################################################################################################################

-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Ils n'ont pas été intégrés ici, à recréer à partir du fichier DDU12_etendu_V1.sql et éventuellement à adapter par le PNR et OLV
-- ----------------------------------------------------------------------------------------------------------------------------------------------------



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                           VUES (spécifiques PNR-OLV)                                                         ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Elles n'ont pas été intégrés ici, à recréer à partir du fichier DDU12_etendu_V1.sql et éventuellement à adapter par le PNR et OLV
-- ----------------------------------------------------------------------------------------------------------------------------------------------------


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                          ROLES (spécifiques PNR-OLV)                                                         ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Ils n'ont pas été intégrés ici, à recréer à partir du fichier DDU12_etendu_V1.sql et éventuellement à adapter par le PNR et OLV
-- ----------------------------------------------------------------------------------------------------------------------------------------------------



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                           VUES (spécifiques ARC)                                                             ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Vue de contrôle simple sur le nombre d''objets par table avant et après migration. Seules les tables geo_p_info_surf et geo_p_prescription_surf 
-- peuvent avoir un décompte différent suite à la migration d''informations vers prescriptions
-- Cette vue nous permet de vérifier simplement que le nombre d'objet est bien identique après migration. Reste ensuite à vérifier que la migration
-- c'est bien passée au niveau du contenu des données (à chacun de vérifier surtout pour les informations et prescriptions par rapport à la grille de
-- correspondance)
-- Cette vue peut-être supprimée manuellement après tous les contrôles et validation effectuée par chaque partenaire
-- ----------------------------------------------------------------------------------------------------------------------------------------------------

-- View: m_urbanisme_doc_cnig2017.an_v_controle

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_v_controle;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.an_v_controle AS 
 SELECT 'an_doc_urba'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.an_doc_urba
UNION ALL
 SELECT 'an_doc_urba'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.an_doc_urba
UNION ALL
 SELECT 'an_doc_urba_com'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.an_doc_urba_com
UNION ALL
 SELECT 'an_doc_urba_com'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.an_doc_urba_com
UNION ALL
 SELECT 'geo_a_habillage_lin'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_a_habillage_lin
UNION ALL
 SELECT 'geo_a_habillage_lin'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_a_habillage_lin
UNION ALL
 SELECT 'geo_a_habillage_pct'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_a_habillage_pct
UNION ALL
 SELECT 'geo_a_habillage_pct'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_a_habillage_pct
UNION ALL
 SELECT 'geo_a_habillage_surf'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_a_habillage_surf
UNION ALL
 SELECT 'geo_a_habillage_surf'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_a_habillage_surf
UNION ALL
 SELECT 'geo_a_habillage_txt'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_a_habillage_txt
UNION ALL
 SELECT 'geo_a_habillage_txt'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_a_habillage_txt
UNION ALL
 SELECT 'geo_a_info_lin'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_a_info_lin
UNION ALL
 SELECT 'geo_a_info_lin'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_a_info_lin
UNION ALL
 SELECT 'geo_a_info_pct'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_a_info_pct
UNION ALL
 SELECT 'geo_a_info_pct'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_a_info_pct
UNION ALL
 SELECT 'geo_a_info_surf'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_a_info_surf
UNION ALL
 SELECT 'geo_a_info_surf'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_a_info_surf
UNION ALL
 SELECT 'geo_a_prescription_lin'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_a_prescription_lin
UNION ALL
 SELECT 'geo_a_prescription_lin'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_a_prescription_lin
UNION ALL
 SELECT 'geo_a_prescription_pct'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_a_prescription_pct
UNION ALL
 SELECT 'geo_a_prescription_pct'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_a_prescription_pct
UNION ALL
 SELECT 'geo_a_prescription_surf'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_a_prescription_surf
UNION ALL
 SELECT 'geo_a_prescription_surf'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_a_prescription_surf
UNION ALL
 SELECT 'geo_a_zone_urba'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_a_zone_urba
UNION ALL
 SELECT 'geo_a_zone_urba'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_a_zone_urba
UNION ALL
 SELECT 'geo_p_habillage_lin'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_p_habillage_lin
UNION ALL
 SELECT 'geo_p_habillage_lin'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_p_habillage_lin
UNION ALL
 SELECT 'geo_p_habillage_pct'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_p_habillage_pct
UNION ALL
 SELECT 'geo_p_habillage_pct'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_p_habillage_pct
UNION ALL
 SELECT 'geo_p_habillage_surf'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_p_habillage_surf
UNION ALL
 SELECT 'geo_p_habillage_surf'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_p_habillage_surf
UNION ALL
 SELECT 'geo_p_habillage_txt'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_p_habillage_txt
UNION ALL
 SELECT 'geo_p_habillage_txt'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_p_habillage_txt
UNION ALL
 SELECT 'geo_p_info_lin'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_p_info_lin
UNION ALL
 SELECT 'geo_p_info_lin'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_p_info_lin
UNION ALL
 SELECT 'geo_p_info_pct'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_p_info_pct
UNION ALL
 SELECT 'geo_p_info_pct'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_p_info_pct
UNION ALL
 SELECT 'geo_p_info_surf'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_p_info_surf
UNION ALL
 SELECT 'geo_p_info_surf'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_p_info_surf
UNION ALL
 SELECT 'geo_p_prescription_lin'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_p_prescription_lin
UNION ALL
 SELECT 'geo_p_prescription_lin'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_p_prescription_lin
UNION ALL
 SELECT 'geo_p_prescription_pct'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_p_prescription_pct
UNION ALL
 SELECT 'geo_p_prescription_pct'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_p_prescription_pct
UNION ALL
 SELECT 'geo_p_prescription_surf'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_p_prescription_surf
UNION ALL
 SELECT 'geo_p_prescription_surf'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_p_prescription_surf
UNION ALL
 SELECT 'geo_p_zone_urba'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_p_zone_urba
UNION ALL
 SELECT 'geo_p_zone_urba'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_p_zone_urba
UNION ALL
 SELECT 'geo_t_habillage_lin'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_t_habillage_lin
UNION ALL
 SELECT 'geo_t_habillage_lin'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_t_habillage_lin
UNION ALL
 SELECT 'geo_t_habillage_pct'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_t_habillage_pct
UNION ALL
 SELECT 'geo_t_habillage_pct'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_t_habillage_pct
UNION ALL
 SELECT 'geo_t_habillage_surf'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_t_habillage_surf
UNION ALL
 SELECT 'geo_t_habillage_surf'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_t_habillage_surf
UNION ALL
 SELECT 'geo_t_habillage_txt'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_t_habillage_txt
UNION ALL
 SELECT 'geo_t_habillage_txt'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_t_habillage_txt
UNION ALL
 SELECT 'geo_t_info_lin'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_t_info_lin
UNION ALL
 SELECT 'geo_t_info_lin'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_t_info_lin
UNION ALL
 SELECT 'geo_t_info_pct'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_t_info_pct
UNION ALL
 SELECT 'geo_t_info_pct'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_t_info_pct
UNION ALL
 SELECT 'geo_t_info_surf'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_t_info_surf
UNION ALL
 SELECT 'geo_t_info_surf'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_t_info_surf
UNION ALL
 SELECT 'geo_t_prescription_lin'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_t_prescription_lin
UNION ALL
 SELECT 'geo_t_prescription_lin'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_t_prescription_lin
UNION ALL
 SELECT 'geo_t_prescription_pct'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_t_prescription_pct
UNION ALL
 SELECT 'geo_t_prescription_pct'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_t_prescription_pct
UNION ALL
 SELECT 'geo_t_prescription_surf'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_t_prescription_surf
UNION ALL
 SELECT 'geo_t_prescription_surf'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_t_prescription_surf
UNION ALL
 SELECT 'geo_t_zone_urba'::text AS nom_table,
    '2014'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc.geo_t_zone_urba
UNION ALL
 SELECT 'geo_t_zone_urba'::text AS nom_table,
    '2017'::text AS standard,
    count(*) AS count
   FROM m_urbanisme_doc_cnig2017.geo_t_zone_urba;

ALTER TABLE m_urbanisme_doc_cnig2017.an_v_controle
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_v_controle TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.an_v_controle TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.an_v_controle TO edit_sig;

COMMENT ON VIEW m_urbanisme_doc_cnig2017.an_v_controle
  IS 'Vue de contrôle simple sur le nombre d''objets par table avant et après migration. Seules les tables geo_p_info_surf et geo_p_prescription_surf peuvent avoir un décompte différent suite à la migration d''informations vers prescriptions';
 
-- -- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- -- A mettre en commentaire par les partenaires avant intégration
-- -- ----------------------------------------------------------------------------------------------------------------------------------------------------

-- View: m_urbanisme_doc_cnig2017.an_v_docurba_arcba

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_v_docurba_arcba;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.an_v_docurba_arcba AS 
 SELECT an_doc_urba.idurba,
    "substring"(an_doc_urba.idurba::text, 1, 5) AS insee,
    geo_osm_commune.commune,
    an_doc_urba.typedoc,
    an_doc_urba.datappro,
    lt_nomproc.valeur ||
    CASE WHEN an_doc_urba.l_nomprocn is null THEN '' ELSE ' n° ' || an_doc_urba.l_nomprocn END as procedure,
    lt_etat.valeur as etat
   FROM m_urbanisme_doc_cnig2017.an_doc_urba,
    m_urbanisme_doc_cnig2017.lt_etat,
    r_osm.geo_osm_commune,
    r_osm.geo_vm_osm_epci,
    m_urbanisme_doc_cnig2017.lt_nomproc
  WHERE lt_etat.code = an_doc_urba.etat AND lt_nomproc.code = an_doc_urba.nomproc AND "substring"(an_doc_urba.idurba::text, 1, 5) = geo_osm_commune.insee::text AND st_intersects(st_centroid(geo_osm_commune.geom), geo_vm_osm_epci.geom) 
  AND geo_vm_osm_epci.cepci::text = '200067965'::text
  ORDER BY an_doc_urba.idurba;

ALTER TABLE m_urbanisme_doc_cnig2017.an_v_docurba_arcba
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_arcba TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_arcba TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_arcba TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.an_v_docurba_arcba
  IS 'Vue ARC simplifiée de la table an_doc_urba à usage interne.
Ajout nom de la commune et du libellé de l''état du document';

-- View: m_urbanisme_doc_cnig2017.an_v_docurba_cclo

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_v_docurba_cclo;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.an_v_docurba_cclo AS 
 SELECT an_doc_urba.idurba,
    "substring"(an_doc_urba.idurba::text, 1, 5) AS insee,
    geo_osm_commune.commune,
    an_doc_urba.typedoc,
    an_doc_urba.datappro,
    lt_nomproc.valeur ||
    CASE WHEN an_doc_urba.l_nomprocn is null THEN '' ELSE ' n° ' || an_doc_urba.l_nomprocn END as procedure,
    lt_etat.valeur as etat
   FROM m_urbanisme_doc_cnig2017.an_doc_urba,
    m_urbanisme_doc_cnig2017.lt_etat,
    r_osm.geo_osm_commune,
    r_osm.geo_vm_osm_epci,
    m_urbanisme_doc_cnig2017.lt_nomproc
  WHERE lt_etat.code = an_doc_urba.etat AND lt_nomproc.code = an_doc_urba.nomproc AND "substring"(an_doc_urba.idurba::text, 1, 5) = geo_osm_commune.insee::text AND st_intersects(st_centroid(geo_osm_commune.geom), geo_vm_osm_epci.geom) AND geo_vm_osm_epci.cepci::text = '246000749'::text
  ORDER BY an_doc_urba.idurba;

ALTER TABLE m_urbanisme_doc_cnig2017.an_v_docurba_cclo
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_cclo TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_cclo TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_cclo TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.an_v_docurba_cclo
  IS 'Vue CCLO simplifiée de la table an_doc_urba à usage interne.
Ajout nom de la commune et du libellé de l''état du document';


-- View: m_urbanisme_doc_cnig2017.an_v_docurba_ccpe

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_v_docurba_ccpe;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.an_v_docurba_ccpe AS 
 SELECT an_doc_urba.idurba,
    "substring"(an_doc_urba.idurba::text, 1, 5) AS insee,
    geo_osm_commune.commune,
    an_doc_urba.typedoc,
    an_doc_urba.datappro,
    lt_nomproc.valeur ||
    CASE WHEN an_doc_urba.l_nomprocn is null THEN '' ELSE ' n° ' || an_doc_urba.l_nomprocn END as procedure,
    lt_etat.valeur as etat
   FROM m_urbanisme_doc_cnig2017.an_doc_urba,
    m_urbanisme_doc_cnig2017.lt_etat,
    r_osm.geo_osm_commune,
    r_osm.geo_vm_osm_epci,
    m_urbanisme_doc_cnig2017.lt_nomproc
  WHERE lt_etat.code = an_doc_urba.etat AND lt_nomproc.code = an_doc_urba.nomproc AND "substring"(an_doc_urba.idurba::text, 1, 5) = geo_osm_commune.insee::text AND st_intersects(st_centroid(geo_osm_commune.geom), geo_vm_osm_epci.geom) AND geo_vm_osm_epci.cepci::text = '246000897'::text
  ORDER BY an_doc_urba.idurba;

ALTER TABLE m_urbanisme_doc_cnig2017.an_v_docurba_ccpe
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_ccpe TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_ccpe TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_ccpe TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.an_v_docurba_ccpe
  IS 'Vue CCPE simplifiée de la table an_doc_urba à usage interne.
Ajout nom de la commune et du libellé de l''état du document';


-- View: m_urbanisme_doc_cnig2017.an_v_docurba_valide

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_v_docurba_valide;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.an_v_docurba_valide AS 
 SELECT "substring"(an_doc_urba.idurba::text, 1, 5) AS insee,
    an_doc_urba.typedoc,
    to_date(an_doc_urba.datappro::text, 'YYYYMMDD'::text) AS datappro,
    lt_nomproc.valeur ||
    CASE WHEN an_doc_urba.l_nomprocn is null THEN '' ELSE ' n° ' || an_doc_urba.l_nomprocn END as l_version
   FROM m_urbanisme_doc_cnig2017.an_doc_urba, m_urbanisme_doc_cnig2017.lt_nomproc 
  WHERE an_doc_urba.nomproc=lt_nomproc.code AND an_doc_urba.etat = '03'::bpchar
  ORDER BY "substring"(an_doc_urba.idurba::text, 1, 5);

ALTER TABLE m_urbanisme_doc_cnig2017.an_v_docurba_valide
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_valide TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_valide TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_valide TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.an_v_docurba_valide
  IS 'Liste des documents d''urbanisme valide sur les communes du Pays Compiégnois';



-- -- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- -- A partir d'ici changer la destination des vues lors de la mise en production dans x_apps.xapps
-- DECOMMENTER ICI LES VUES APPLICATIVES COMMENTEES POUR LES REINITIALISER DANS LE SCHEMA X_APPS UNE FOIS LE SCHEMA m_urbanisme_doc_cnig2017 renommé en m_urbanisme_doc
-- -- ----------------------------------------------------------------------------------------------------------------------------------------------------


/* POUR LES VUES APPLICATIVES - LES TESTER EN LES LANCANT DANS UNE FENETRE SSL SANS LES REFRAICHIR AVANT DE LES REFRAICHIR, CF SCRIPT D'INIT OU DEPUIS LES SCHEMAS X_APPS ou X_APPS_PUBLIC */

-- View: m_urbanisme_doc_cnig2017.geo_v_docurba

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_docurba;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_docurba AS 
 SELECT "substring"(u.idurba::text, 1, 5) AS insee,
    a.libgeo AS commune,
    u.typedoc,
    c.geom
   FROM m_urbanisme_doc_cnig2017.an_doc_urba u,
    r_osm.geo_osm_commune c,
    r_administratif.an_geo a
  WHERE a.insee::text = c.insee::text AND "substring"(u.idurba::text, 1, 5) = c.insee::text AND (a.epci::text = '200067965'::text OR a.epci::text = '246000897'::text OR a.epci::text = '246000749'::text) AND u.etat = '03'::bpchar
  ORDER BY a.libgeo;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_docurba
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_docurba TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_docurba TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_docurba TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_docurba
  IS 'Vue géographique présentant le types de document d''urbanisme valide par commune du Pays COmpiégnois';


-- View: m_urbanisme_doc_cnig2017.geo_v_p_habillage_lin_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_habillage_lin_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_habillage_lin_arc AS 
 SELECT geo_p_habillage_lin.idhab,
    geo_p_habillage_lin.nattrac,
    geo_p_habillage_lin.idurba,
    geo_p_habillage_lin.l_insee,
    right(geo_p_habillage_lin.idurba,8) as l_datappro,
    geo_p_habillage_lin.geom
   FROM m_urbanisme_doc_cnig2017.geo_p_habillage_lin
  WHERE geo_p_habillage_lin.l_insee::text = '60023'::text OR geo_p_habillage_lin.l_insee::text = '60070'::text OR geo_p_habillage_lin.l_insee::text = '60151'::text OR geo_p_habillage_lin.l_insee::text = '60156'::text 
  OR geo_p_habillage_lin.l_insee::text = '60159'::text OR geo_p_habillage_lin.l_insee::text = '60323'::text OR geo_p_habillage_lin.l_insee::text = '60325'::text OR geo_p_habillage_lin.l_insee::text = '60326'::text 
  OR geo_p_habillage_lin.l_insee::text = '60337'::text OR geo_p_habillage_lin.l_insee::text = '60338'::text OR geo_p_habillage_lin.l_insee::text = '60382'::text OR geo_p_habillage_lin.l_insee::text = '60402'::text 
  OR geo_p_habillage_lin.l_insee::text = '60579'::text OR geo_p_habillage_lin.l_insee::text = '60597'::text OR geo_p_habillage_lin.l_insee::text = '60665'::text OR geo_p_habillage_lin.l_insee::text = '60674'::text 
  OR geo_p_habillage_lin.l_insee::text = '60067'::text OR geo_p_habillage_lin.l_insee::text = '60068'::text OR geo_p_habillage_lin.l_insee::text = '60447'::text OR geo_p_habillage_lin.l_insee::text = '60578'::text 
  OR geo_p_habillage_lin.l_insee::text = '60600'::text OR geo_p_habillage_lin.l_insee::text = '60667'::text;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_lin_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_lin_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_lin_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_lin_arc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_habillage_lin_arc
  IS 'Vue géographique des habillages linéaires PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc_cnig2017.geo_v_p_habillage_surf_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_habillage_surf_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_habillage_surf_arc AS 
 SELECT geo_p_habillage_surf.idhab,
    geo_p_habillage_surf.nattrac,
    geo_p_habillage_surf.couleur,
    geo_p_habillage_surf.idurba,
    geo_p_habillage_surf.l_insee,
    right(geo_p_habillage_surf.idurba,8) as l_datappro,
    geo_p_habillage_surf.geom
   FROM m_urbanisme_doc_cnig2017.geo_p_habillage_surf
  WHERE geo_p_habillage_surf.l_insee::text = '60023'::text OR geo_p_habillage_surf.l_insee::text = '60070'::text OR geo_p_habillage_surf.l_insee::text = '60151'::text OR geo_p_habillage_surf.l_insee::text = '60156'::text 
  OR geo_p_habillage_surf.l_insee::text = '60159'::text OR geo_p_habillage_surf.l_insee::text = '60323'::text OR geo_p_habillage_surf.l_insee::text = '60325'::text OR geo_p_habillage_surf.l_insee::text = '60326'::text 
  OR geo_p_habillage_surf.l_insee::text = '60337'::text OR geo_p_habillage_surf.l_insee::text = '60338'::text OR geo_p_habillage_surf.l_insee::text = '60382'::text OR geo_p_habillage_surf.l_insee::text = '60402'::text 
  OR geo_p_habillage_surf.l_insee::text = '60579'::text OR geo_p_habillage_surf.l_insee::text = '60597'::text OR geo_p_habillage_surf.l_insee::text = '60665'::text OR geo_p_habillage_surf.l_insee::text = '60674'::text 
  OR geo_p_habillage_surf.l_insee::text = '60067'::text OR geo_p_habillage_surf.l_insee::text = '60068'::text OR geo_p_habillage_surf.l_insee::text = '60447'::text OR geo_p_habillage_surf.l_insee::text = '60578'::text 
  OR geo_p_habillage_surf.l_insee::text = '60600'::text OR geo_p_habillage_surf.l_insee::text = '60667'::text;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_surf_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_surf_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_surf_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_surf_arc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_habillage_surf_arc
  IS 'Vue géographique des habillages surfaciques PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

										       
-- View: m_urbanisme_doc_cnig2017.geo_v_p_habillage_pct_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_habillage_pct_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_habillage_pct_arc AS 
 SELECT geo_p_habillage_pct.idhab,
    geo_p_habillage_pct.nattrac,
    geo_p_habillage_pct.couleur,
    geo_p_habillage_pct.idurba,
    geo_p_habillage_pct.l_insee,
    right(geo_p_habillage_pct.idurba,8) as l_datappro,
    geo_p_habillage_pct.geom
   FROM m_urbanisme_doc_cnig2017.geo_p_habillage_pct
  WHERE geo_p_habillage_pct.l_insee::text = '60023'::text OR geo_p_habillage_pct.l_insee::text = '60070'::text OR geo_p_habillage_pct.l_insee::text = '60151'::text OR geo_p_habillage_pct.l_insee::text = '60156'::text 
  OR geo_p_habillage_pct.l_insee::text = '60159'::text OR geo_p_habillage_pct.l_insee::text = '60323'::text OR geo_p_habillage_pct.l_insee::text = '60325'::text OR geo_p_habillage_pct.l_insee::text = '60326'::text 
  OR geo_p_habillage_pct.l_insee::text = '60337'::text OR geo_p_habillage_pct.l_insee::text = '60338'::text OR geo_p_habillage_pct.l_insee::text = '60382'::text OR geo_p_habillage_pct.l_insee::text = '60402'::text 
  OR geo_p_habillage_pct.l_insee::text = '60579'::text OR geo_p_habillage_pct.l_insee::text = '60597'::text OR geo_p_habillage_pct.l_insee::text = '60665'::text OR geo_p_habillage_pct.l_insee::text = '60674'::text 
  OR geo_p_habillage_pct.l_insee::text = '60067'::text OR geo_p_habillage_pct.l_insee::text = '60068'::text OR geo_p_habillage_pct.l_insee::text = '60447'::text OR geo_p_habillage_pct.l_insee::text = '60578'::text 
  OR geo_p_habillage_pct.l_insee::text = '60600'::text OR geo_p_habillage_pct.l_insee::text = '60667'::text;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_pct_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_pct_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_pct_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_pct_arc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_habillage_surf_arc
  IS 'Vue géographique des habillages ponctuels PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

										       
-- View: m_urbanisme_doc_cnig2017.geo_v_p_habillage_txt_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_habillage_txt_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_habillage_txt_arc AS 
 SELECT geo_p_habillage_txt.idhab,
    geo_p_habillage_txt.natecr,
    geo_p_habillage_txt.txt,
    geo_p_habillage_txt.police,
    geo_p_habillage_txt.taille,
    geo_p_habillage_txt.style,
    geo_p_habillage_txt.angle,
    geo_p_habillage_txt.couleur,
    geo_p_habillage_txt.idurba,
    geo_p_habillage_txt.l_couleur,
    geo_p_habillage_txt.l_insee,
    right(geo_p_habillage_txt.idurba,8) as l_datappro,
    geo_p_habillage_txt.geom
   FROM m_urbanisme_doc_cnig2017.geo_p_habillage_txt
  WHERE geo_p_habillage_txt.l_insee::text = '60023'::text OR geo_p_habillage_txt.l_insee::text = '60070'::text OR geo_p_habillage_txt.l_insee::text = '60151'::text OR geo_p_habillage_txt.l_insee::text = '60156'::text 
  OR geo_p_habillage_txt.l_insee::text = '60159'::text OR geo_p_habillage_txt.l_insee::text = '60323'::text OR geo_p_habillage_txt.l_insee::text = '60325'::text OR geo_p_habillage_txt.l_insee::text = '60326'::text 
  OR geo_p_habillage_txt.l_insee::text = '60337'::text OR geo_p_habillage_txt.l_insee::text = '60338'::text OR geo_p_habillage_txt.l_insee::text = '60382'::text OR geo_p_habillage_txt.l_insee::text = '60402'::text 
  OR geo_p_habillage_txt.l_insee::text = '60579'::text OR geo_p_habillage_txt.l_insee::text = '60597'::text OR geo_p_habillage_txt.l_insee::text = '60665'::text OR geo_p_habillage_txt.l_insee::text = '60674'::text 
  OR geo_p_habillage_txt.l_insee::text = '60067'::text OR geo_p_habillage_txt.l_insee::text = '60068'::text OR geo_p_habillage_txt.l_insee::text = '60447'::text OR geo_p_habillage_txt.l_insee::text = '60578'::text 
  OR geo_p_habillage_txt.l_insee::text = '60600'::text OR geo_p_habillage_txt.l_insee::text = '60667'::text;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_txt_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_txt_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_txt_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_txt_arc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_habillage_txt_arc
  IS 'Vue géographique des habillages textuels PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc_cnig2017.geo_v_p_info_pct_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_info_pct_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_info_pct_arc AS 
 SELECT geo_p_info_pct.idinf,
    lt_typeinf.valeur as libelle,
    geo_p_info_pct.txt,
    geo_p_info_pct.typeinf,
    geo_p_info_pct.stypeinf,
    geo_p_info_pct.idurba,
    geo_p_info_pct.l_nom,
    geo_p_info_pct.l_dateins,
    geo_p_info_pct.l_bnfcr,
    geo_p_info_pct.l_datdlg,
    geo_p_info_pct.l_gen,
    geo_p_info_pct.l_valrecul,
    geo_p_info_pct.l_typrecul,
    geo_p_info_pct.l_observ,
    geo_p_info_pct.nomfic,
    geo_p_info_pct.urlfic,
    geo_p_info_pct.l_insee,
    right(geo_p_info_pct.idurba,8) as l_datappro,
    geo_p_info_pct.datvalid,
    geo_p_info_pct.geom
   FROM m_urbanisme_doc_cnig2017.geo_p_info_pct, m_urbanisme_doc_cnig2017.lt_typeinf
  WHERE geo_p_info_pct.typeinf || geo_p_info_pct.stypeinf = lt_typeinf.code || lt_typeinf.sous_code and (geo_p_info_pct.l_insee::text = '60023'::text OR geo_p_info_pct.l_insee::text = '60070'::text OR geo_p_info_pct.l_insee::text = '60151'::text 
  OR geo_p_info_pct.l_insee::text = '60156'::text 
  OR geo_p_info_pct.l_insee::text = '60159'::text OR geo_p_info_pct.l_insee::text = '60323'::text OR geo_p_info_pct.l_insee::text = '60325'::text OR geo_p_info_pct.l_insee::text = '60326'::text 
  OR geo_p_info_pct.l_insee::text = '60337'::text OR geo_p_info_pct.l_insee::text = '60338'::text OR geo_p_info_pct.l_insee::text = '60382'::text OR geo_p_info_pct.l_insee::text = '60402'::text 
  OR geo_p_info_pct.l_insee::text = '60579'::text OR geo_p_info_pct.l_insee::text = '60597'::text OR geo_p_info_pct.l_insee::text = '60665'::text OR geo_p_info_pct.l_insee::text = '60674'::text 
  OR geo_p_info_pct.l_insee::text = '60067'::text OR geo_p_info_pct.l_insee::text = '60068'::text OR geo_p_info_pct.l_insee::text = '60447'::text OR geo_p_info_pct.l_insee::text = '60578'::text 
  OR geo_p_info_pct.l_insee::text = '60600'::text OR geo_p_info_pct.l_insee::text = '60667'::text);

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_pct_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_pct_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_pct_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_pct_arc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_info_pct_arc
  IS 'Vue géographique des informations ponctuelles PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- View: m_urbanisme_doc_cnig2017.geo_v_p_info_lin_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_info_lin_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_info_lin_arc AS 
 SELECT geo_p_info_lin.idinf,
    lt_typeinf.valeur as libelle,
    geo_p_info_lin.txt,
    geo_p_info_lin.typeinf,
    geo_p_info_lin.stypeinf,
    geo_p_info_lin.idurba,
    geo_p_info_lin.l_nom,
    geo_p_info_lin.l_dateins,
    geo_p_info_lin.l_bnfcr,
    geo_p_info_lin.l_datdlg,
    geo_p_info_lin.l_gen,
    geo_p_info_lin.l_valrecul,
    geo_p_info_lin.l_typrecul,
    geo_p_info_lin.l_observ,
    geo_p_info_lin.nomfic,
    geo_p_info_lin.urlfic,
    geo_p_info_lin.l_insee,
    right(geo_p_info_lin.idurba,8) as l_datappro,
    geo_p_info_lin.datvalid,
    geo_p_info_lin.geom
   FROM m_urbanisme_doc_cnig2017.geo_p_info_lin, m_urbanisme_doc_cnig2017.lt_typeinf
  WHERE geo_p_info_lin.typeinf || geo_p_info_lin.stypeinf = lt_typeinf.code || lt_typeinf.sous_code and (geo_p_info_lin.l_insee::text = '60023'::text OR geo_p_info_lin.l_insee::text = '60070'::text OR geo_p_info_lin.l_insee::text = '60151'::text OR geo_p_info_lin.l_insee::text = '60156'::text 
  OR geo_p_info_lin.l_insee::text = '60159'::text OR geo_p_info_lin.l_insee::text = '60323'::text OR geo_p_info_lin.l_insee::text = '60325'::text OR geo_p_info_lin.l_insee::text = '60326'::text 
  OR geo_p_info_lin.l_insee::text = '60337'::text OR geo_p_info_lin.l_insee::text = '60338'::text OR geo_p_info_lin.l_insee::text = '60382'::text OR geo_p_info_lin.l_insee::text = '60402'::text 
  OR geo_p_info_lin.l_insee::text = '60579'::text OR geo_p_info_lin.l_insee::text = '60597'::text OR geo_p_info_lin.l_insee::text = '60665'::text OR geo_p_info_lin.l_insee::text = '60674'::text 
  OR geo_p_info_lin.l_insee::text = '60067'::text OR geo_p_info_lin.l_insee::text = '60068'::text OR geo_p_info_lin.l_insee::text = '60447'::text OR geo_p_info_lin.l_insee::text = '60578'::text 
  OR geo_p_info_lin.l_insee::text = '60600'::text OR geo_p_info_lin.l_insee::text = '60667'::text);

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_lin_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_lin_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_lin_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_lin_arc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_info_lin_arc
  IS 'Vue géographique des informations linéaires PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc_cnig2017.geo_v_p_info_surf_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_info_surf_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_info_surf_arc AS 
 SELECT geo_p_info_surf.idinf,
    lt_typeinf.valeur as libelle,
    geo_p_info_surf.txt,
    geo_p_info_surf.typeinf,
    geo_p_info_surf.stypeinf,
    geo_p_info_surf.idurba,
    geo_p_info_surf.l_nom,
    geo_p_info_surf.l_dateins,
    geo_p_info_surf.l_bnfcr,
    geo_p_info_surf.l_datdlg,
    geo_p_info_surf.l_gen,
    geo_p_info_surf.l_valrecul,
    geo_p_info_surf.l_typrecul,
    geo_p_info_surf.l_observ,
    geo_p_info_surf.nomfic,
    geo_p_info_surf.urlfic,
    geo_p_info_surf.l_insee,
    right(geo_p_info_surf.idurba,8) as l_datappro,
    geo_p_info_surf.datvalid,
    geo_p_info_surf.geom
   FROM m_urbanisme_doc_cnig2017.geo_p_info_surf, m_urbanisme_doc_cnig2017.lt_typeinf
  WHERE geo_p_info_surf.typeinf || geo_p_info_surf.stypeinf = lt_typeinf.code || lt_typeinf.sous_code and (geo_p_info_surf.l_insee::text = '60023'::text OR geo_p_info_surf.l_insee::text = '60070'::text OR geo_p_info_surf.l_insee::text = '60151'::text OR geo_p_info_surf.l_insee::text = '60156'::text 
  OR geo_p_info_surf.l_insee::text = '60159'::text OR geo_p_info_surf.l_insee::text = '60323'::text OR geo_p_info_surf.l_insee::text = '60325'::text OR geo_p_info_surf.l_insee::text = '60326'::text 
  OR geo_p_info_surf.l_insee::text = '60337'::text OR geo_p_info_surf.l_insee::text = '60338'::text OR geo_p_info_surf.l_insee::text = '60382'::text OR geo_p_info_surf.l_insee::text = '60402'::text 
  OR geo_p_info_surf.l_insee::text = '60579'::text OR geo_p_info_surf.l_insee::text = '60597'::text OR geo_p_info_surf.l_insee::text = '60665'::text OR geo_p_info_surf.l_insee::text = '60674'::text 
  OR geo_p_info_surf.l_insee::text = '60067'::text OR geo_p_info_surf.l_insee::text = '60068'::text OR geo_p_info_surf.l_insee::text = '60447'::text OR geo_p_info_surf.l_insee::text = '60578'::text 
  OR geo_p_info_surf.l_insee::text = '60600'::text OR geo_p_info_surf.l_insee::text = '60667'::text);

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_surf_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_surf_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_surf_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_surf_arc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_info_surf_arc
  IS 'Vue géographique des informations surfaciques PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- View: m_urbanisme_doc_cnig2017.geo_v_p_prescription_lin_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_prescription_lin_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_prescription_lin_arc AS 
 SELECT geo_p_prescription_lin.idpsc,
    lt_typepsc.valeur as libelle,
    geo_p_prescription_lin.txt,
    geo_p_prescription_lin.typepsc,
    geo_p_prescription_lin.stypepsc,
    geo_p_prescription_lin.idurba,									       
    geo_p_prescription_lin.l_nom,
    geo_p_prescription_lin.l_nature,
    geo_p_prescription_lin.l_bnfcr,
    geo_p_prescription_lin.l_numero,
    geo_p_prescription_lin.l_surf_txt,
    geo_p_prescription_lin.l_gen,
    geo_p_prescription_lin.l_valrecul,
    geo_p_prescription_lin.l_typrecul,
    geo_p_prescription_lin.l_observ,
    geo_p_prescription_lin.nomfic,
    geo_p_prescription_lin.urlfic,
    geo_p_prescription_lin.l_insee,
    right(geo_p_prescription_lin.idurba,8) as l_datappro,
    geo_p_prescription_lin.datvalid,
    geo_p_prescription_lin.geom
   FROM m_urbanisme_doc_cnig2017.geo_p_prescription_lin, m_urbanisme_doc_cnig2017.lt_typepsc
  WHERE  geo_p_prescription_lin.typepsc || geo_p_prescription_lin.stypepsc = lt_typepsc.code || lt_typepsc.sous_code and (geo_p_prescription_lin.l_insee::text = '60023'::text OR geo_p_prescription_lin.l_insee::text = '60070'::text OR geo_p_prescription_lin.l_insee::text = '60151'::text OR geo_p_prescription_lin.l_insee::text = '60156'::text 
   OR geo_p_prescription_lin.l_insee::text = '60159'::text OR geo_p_prescription_lin.l_insee::text = '60323'::text OR geo_p_prescription_lin.l_insee::text = '60325'::text OR geo_p_prescription_lin.l_insee::text = '60326'::text 
   OR geo_p_prescription_lin.l_insee::text = '60337'::text OR geo_p_prescription_lin.l_insee::text = '60338'::text OR geo_p_prescription_lin.l_insee::text = '60382'::text OR geo_p_prescription_lin.l_insee::text = '60402'::text 
   OR geo_p_prescription_lin.l_insee::text = '60579'::text OR geo_p_prescription_lin.l_insee::text = '60597'::text OR geo_p_prescription_lin.l_insee::text = '60665'::text OR geo_p_prescription_lin.l_insee::text = '60674'::text 
   OR geo_p_prescription_lin.l_insee::text = '60067'::text OR geo_p_prescription_lin.l_insee::text = '60068'::text OR geo_p_prescription_lin.l_insee::text = '60447'::text OR geo_p_prescription_lin.l_insee::text = '60578'::text 
   OR geo_p_prescription_lin.l_insee::text = '60600'::text OR geo_p_prescription_lin.l_insee::text = '60667'::text);

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_lin_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_lin_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_lin_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_lin_arc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_prescription_lin_arc
  IS 'Vue géographique des prescriptions linéaires PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc_cnig2017.geo_v_p_prescription_pct_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_prescription_pct_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_prescription_pct_arc AS 
 SELECT geo_p_prescription_pct.idpsc,
    lt_typepsc.valeur as libelle,
    geo_p_prescription_pct.txt,
    geo_p_prescription_pct.typepsc,
    geo_p_prescription_pct.stypepsc,
    geo_p_prescription_pct.idurba,
    geo_p_prescription_pct.l_nom,
    geo_p_prescription_pct.l_nature,
    geo_p_prescription_pct.l_bnfcr,
    geo_p_prescription_pct.l_numero,
    geo_p_prescription_pct.l_surf_txt,
    geo_p_prescription_pct.l_gen,
    geo_p_prescription_pct.l_valrecul,
    geo_p_prescription_pct.l_typrecul,
    geo_p_prescription_pct.l_observ,
    geo_p_prescription_pct.nomfic,
    geo_p_prescription_pct.urlfic,
    geo_p_prescription_pct.l_insee,
    right(geo_p_prescription_pct.idurba,8) as l_datappro,
    geo_p_prescription_pct.datvalid,
    geo_p_prescription_pct.geom
   FROM m_urbanisme_doc_cnig2017.geo_p_prescription_pct, m_urbanisme_doc_cnig2017.lt_typepsc
  WHERE geo_p_prescription_pct.typepsc || geo_p_prescription_pct.stypepsc = lt_typepsc.code || lt_typepsc.sous_code and (geo_p_prescription_pct.l_insee::text = '60023'::text OR geo_p_prescription_pct.l_insee::text = '60070'::text OR geo_p_prescription_pct.l_insee::text = '60151'::text OR geo_p_prescription_pct.l_insee::text = '60156'::text 
OR geo_p_prescription_pct.l_insee::text = '60159'::text OR geo_p_prescription_pct.l_insee::text = '60323'::text OR geo_p_prescription_pct.l_insee::text = '60325'::text OR geo_p_prescription_pct.l_insee::text = '60326'::text 
OR geo_p_prescription_pct.l_insee::text = '60337'::text OR geo_p_prescription_pct.l_insee::text = '60338'::text OR geo_p_prescription_pct.l_insee::text = '60382'::text OR geo_p_prescription_pct.l_insee::text = '60402'::text 
OR geo_p_prescription_pct.l_insee::text = '60579'::text OR geo_p_prescription_pct.l_insee::text = '60597'::text OR geo_p_prescription_pct.l_insee::text = '60665'::text OR geo_p_prescription_pct.l_insee::text = '60674'::text 
OR geo_p_prescription_pct.l_insee::text = '60067'::text OR geo_p_prescription_pct.l_insee::text = '60068'::text OR geo_p_prescription_pct.l_insee::text = '60447'::text OR geo_p_prescription_pct.l_insee::text = '60578'::text 
OR geo_p_prescription_pct.l_insee::text = '60600'::text OR geo_p_prescription_pct.l_insee::text = '60667'::text);

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_pct_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_pct_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_pct_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_pct_arc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_prescription_pct_arc
  IS 'Vue géographique des prescriptions ponctuelles PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc_cnig2017.geo_v_p_prescription_surf_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_prescription_surf_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_prescription_surf_arc AS 
 SELECT geo_p_prescription_surf.idpsc,
    lt_typepsc.valeur as libelle,
    geo_p_prescription_surf.txt,
    geo_p_prescription_surf.typepsc,
    geo_p_prescription_surf.stypepsc,
    geo_p_prescription_surf.idurba,
    geo_p_prescription_surf.l_nom,
    geo_p_prescription_surf.l_nature,
    geo_p_prescription_surf.l_bnfcr,
    geo_p_prescription_surf.l_numero,
    geo_p_prescription_surf.l_surf_txt,
    geo_p_prescription_surf.l_gen,
    geo_p_prescription_surf.l_valrecul,
    geo_p_prescription_surf.l_typrecul,
    geo_p_prescription_surf.l_observ,
    geo_p_prescription_surf.nomfic,
    geo_p_prescription_surf.urlfic,
    geo_p_prescription_surf.l_insee,
    right(geo_p_prescription_surf.idurba,8) as l_datappro,
    geo_p_prescription_surf.datvalid,
    geo_p_prescription_surf.geom
   FROM m_urbanisme_doc_cnig2017.geo_p_prescription_surf, m_urbanisme_doc_cnig2017.lt_typepsc
  WHERE geo_p_prescription_surf.typepsc || geo_p_prescription_surf.stypepsc = lt_typepsc.code || lt_typepsc.sous_code and (geo_p_prescription_surf.l_insee::text = '60023'::text OR geo_p_prescription_surf.l_insee::text = '60070'::text OR geo_p_prescription_surf.l_insee::text = '60151'::text OR geo_p_prescription_surf.l_insee::text = '60156'::text 
OR geo_p_prescription_surf.l_insee::text = '60159'::text OR geo_p_prescription_surf.l_insee::text = '60323'::text OR geo_p_prescription_surf.l_insee::text = '60325'::text OR geo_p_prescription_surf.l_insee::text = '60326'::text 
OR geo_p_prescription_surf.l_insee::text = '60337'::text OR geo_p_prescription_surf.l_insee::text = '60338'::text OR geo_p_prescription_surf.l_insee::text = '60382'::text OR geo_p_prescription_surf.l_insee::text = '60402'::text 
OR geo_p_prescription_surf.l_insee::text = '60579'::text OR geo_p_prescription_surf.l_insee::text = '60597'::text OR geo_p_prescription_surf.l_insee::text = '60665'::text OR geo_p_prescription_surf.l_insee::text = '60674'::text 
OR geo_p_prescription_surf.l_insee::text = '60067'::text OR geo_p_prescription_surf.l_insee::text = '60068'::text OR geo_p_prescription_surf.l_insee::text = '60447'::text OR geo_p_prescription_surf.l_insee::text = '60578'::text 
OR geo_p_prescription_surf.l_insee::text = '60600'::text OR geo_p_prescription_surf.l_insee::text = '60667'::text);

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_surf_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_surf_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_surf_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_surf_arc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_prescription_surf_arc
  IS 'Vue géographique des prescriptions surfaciques PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc_cnig2017.geo_v_p_zone_urba_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_zone_urba_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_zone_urba_arc AS 
 SELECT geo_p_zone_urba.idzone,
    geo_p_zone_urba.libelle,
    geo_p_zone_urba.libelong,
    geo_p_zone_urba.typezone,
    geo_p_zone_urba.idurba,
    geo_p_zone_urba.l_destdomi,
    geo_p_zone_urba.l_surf_cal,
    geo_p_zone_urba.l_observ,
    geo_p_zone_urba.nomfic,
    geo_p_zone_urba.urlfic,
    geo_p_zone_urba.l_insee,
    right(geo_p_zone_urba.idurba,8) as l_datappro,
    geo_p_zone_urba.datvalid,
    geo_p_zone_urba.geom,
    geo_p_zone_urba.typesect,
    geo_p_zone_urba.fermreco
   FROM m_urbanisme_doc_cnig2017.geo_p_zone_urba
  WHERE geo_p_zone_urba.l_insee::text = '60023'::text OR geo_p_zone_urba.l_insee::text = '60070'::text OR geo_p_zone_urba.l_insee::text = '60151'::text OR geo_p_zone_urba.l_insee::text = '60156'::text 
OR geo_p_zone_urba.l_insee::text = '60159'::text OR geo_p_zone_urba.l_insee::text = '60323'::text OR geo_p_zone_urba.l_insee::text = '60325'::text OR geo_p_zone_urba.l_insee::text = '60326'::text 
OR geo_p_zone_urba.l_insee::text = '60337'::text OR geo_p_zone_urba.l_insee::text = '60338'::text OR geo_p_zone_urba.l_insee::text = '60382'::text OR geo_p_zone_urba.l_insee::text = '60402'::text 
OR geo_p_zone_urba.l_insee::text = '60579'::text OR geo_p_zone_urba.l_insee::text = '60597'::text OR geo_p_zone_urba.l_insee::text = '60665'::text OR geo_p_zone_urba.l_insee::text = '60674'::text 
OR geo_p_zone_urba.l_insee::text = '60067'::text OR geo_p_zone_urba.l_insee::text = '60068'::text OR geo_p_zone_urba.l_insee::text = '60447'::text OR geo_p_zone_urba.l_insee::text = '60578'::text 
OR geo_p_zone_urba.l_insee::text = '60600'::text OR geo_p_zone_urba.l_insee::text = '60667'::text;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_p_zone_urba_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_zone_urba_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_zone_urba_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_zone_urba_arc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_zone_urba_arc
  IS 'Vue géographique des zonages PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc_cnig2017.geo_v_urbreg_ads_commune

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_urbreg_ads_commune;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_urbreg_ads_commune AS 
 SELECT c.commune,
    a.insee,
    a.docurba,
    a.ads_arc,
    c.lib_epci,
    c.geom
   FROM r_osm.geo_v_osm_commune_apc c
     JOIN m_urbanisme_doc_cnig2017.an_ads_commune a ON a.insee = c.insee::bpchar
  ORDER BY a.insee;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_urbreg_ads_commune
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_urbreg_ads_commune TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_urbreg_ads_commune TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_urbreg_ads_commune TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_urbreg_ads_commune
  IS 'Vue géographique sur l''état de l''ADS par l''ARC sur les communes du pays compiégnois';



-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Création des index
-- ----------------------------------------------------------------------------------------------------------------------------------------------------

CREATE INDEX geo_p_habillage_lin_geom_idx
  ON m_urbanisme_doc_cnig2017.geo_p_habillage_lin
  USING gist
  (geom);

CREATE INDEX geo_p_habillage_pct_geom_idx
  ON m_urbanisme_doc_cnig2017.geo_p_habillage_pct
  USING gist
  (geom);

CREATE INDEX geo_p_habillage_surf_geom_idx
  ON m_urbanisme_doc_cnig2017.geo_p_habillage_surf
  USING gist
  (geom);

CREATE INDEX geo_p_habillage_txt_geom_idx
  ON m_urbanisme_doc_cnig2017.geo_p_habillage_txt
  USING gist
  (geom);

CREATE INDEX geo_p_info_lin_geom_idx
  ON m_urbanisme_doc_cnig2017.geo_p_info_lin
  USING gist
  (geom);

CREATE INDEX geo_p_info_pct_geom_idx
  ON m_urbanisme_doc_cnig2017.geo_p_info_pct
  USING gist
  (geom);

CREATE INDEX geo_p_info_surf_geom1_idx
  ON m_urbanisme_doc_cnig2017.geo_p_info_surf
  USING gist
  (geom1);

CREATE INDEX geo_p_info_surf_geom_idx
  ON m_urbanisme_doc_cnig2017.geo_p_info_surf
  USING gist
  (geom);

CREATE INDEX geo_p_zone_urba_geom_idx
  ON m_urbanisme_doc_cnig2017.geo_p_zone_urba
  USING gist
  (geom);

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                   VUES ETUDE PLUi (spécifiques ARC)                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- View: m_urbanisme_doc_cnig2017.geo_v_t_habillage_surf_pluiarc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_t_habillage_surf_pluiarc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_t_habillage_surf_pluiarc AS 
 SELECT geo_t_habillage_surf.idhab,
    geo_t_habillage_surf.nattrac,
    geo_t_habillage_surf.couleur,
    geo_t_habillage_surf.idurba,
    geo_t_habillage_surf.l_insee,
    right(geo_t_habillage_surf.idurba,8) as l_datappro,
    geo_t_habillage_surf.geom
   FROM m_urbanisme_doc_cnig2017.geo_t_habillage_surf
  WHERE idurba = '200067965_PLUI_00000000';

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_surf_pluiarc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_surf_pluiarc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_surf_pluiarc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_surf_pluiarc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_t_habillage_surf_pluiarc
  IS 'Vue géographique des habillages surfaciques PLUi de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';

										       
-- View: m_urbanisme_doc_cnig2017.geo_v_t_habillage_pct_pluiarc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_t_habillage_pct_pluiarc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_t_habillage_pct_pluiarc AS 
 SELECT geo_t_habillage_pct.idhab,
    geo_t_habillage_pct.nattrac,
    geo_t_habillage_pct.couleur,
    geo_t_habillage_pct.idurba,
    geo_t_habillage_pct.l_insee,
    right(geo_t_habillage_pct.idurba,8) as l_datappro,
    geo_t_habillage_pct.geom
   FROM m_urbanisme_doc_cnig2017.geo_t_habillage_pct
  WHERE idurba = '200067965_PLUI_00000000';

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_pct_pluiarc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_pct_pluiarc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_pct_pluiarc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_pct_pluiarc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_t_habillage_pct_pluiarc
  IS 'Vue géographique des habillages ponctuels PLUi de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';

										       
-- View: m_urbanisme_doc_cnig2017.geo_v_t_habillage_lin_pluiarc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_t_habillage_lin_pluiarc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_t_habillage_lin_pluiarc AS 
 SELECT geo_t_habillage_lin.idhab,
    geo_t_habillage_lin.nattrac,
	geo_t_habillage_lin.idurba,
    geo_t_habillage_lin.l_insee,
    right(geo_t_habillage_lin.idurba,8) as l_datappro,
    geo_t_habillage_lin.geom
   FROM m_urbanisme_doc_cnig2017.geo_t_habillage_lin
  WHERE idurba = '200067965_PLUI_00000000';

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_lin_pluiarc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_lin_pluiarc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_lin_pluiarc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_lin_pluiarc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_t_habillage_lin_pluiarc
  IS 'Vue géographique des habillages linéaires en mode test du PLUi de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';


-- View: m_urbanisme_doc_cnig2017.geo_v_t_habillage_txt_pluiarc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_t_habillage_txt_pluiarc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_t_habillage_txt_pluiarc AS 
 SELECT geo_t_habillage_txt.idhab,
    geo_t_habillage_txt.natecr,
    geo_t_habillage_txt.txt,
    geo_t_habillage_txt.police,
    geo_t_habillage_txt.taille,
    geo_t_habillage_txt.style,
    geo_t_habillage_txt.angle,
    geo_t_habillage_txt.couleur,
	geo_t_habillage_txt.idurba,
    geo_t_habillage_txt.l_couleur,
    geo_t_habillage_txt.l_insee,
    right(geo_t_habillage_txt.idurba,8) as l_datappro,
    geo_t_habillage_txt.geom
   FROM m_urbanisme_doc_cnig2017.geo_t_habillage_txt
  WHERE idurba = '200067965_PLUI_00000000';

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_txt_pluiarc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_txt_pluiarc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_txt_pluiarc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_habillage_txt_pluiarc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_t_habillage_txt_pluiarc
  IS 'Vue géographique des habillages textuels en mode test du PLUi pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';


-- View: m_urbanisme_doc_cnig2017.geo_v_t_info_pct_pluiarc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_t_info_pct_pluiarc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_t_info_pct_pluiarc AS 
 SELECT geo_t_info_pct.idinf,
    lt_typeinf.valeur as libelle,
    geo_t_info_pct.txt,
    geo_t_info_pct.typeinf,
    geo_t_info_pct.stypeinf,
	geo_t_info_pct.idurba,
    geo_t_info_pct.l_nom,
    geo_t_info_pct.l_dateins,
    geo_t_info_pct.l_bnfcr,
    geo_t_info_pct.l_datdlg,
    geo_t_info_pct.l_gen,
    geo_t_info_pct.l_valrecul,
    geo_t_info_pct.l_typrecul,
    geo_t_info_pct.l_observ,
    geo_t_info_pct.nomfic,
    geo_t_info_pct.urlfic,
    geo_t_info_pct.l_insee,
    right(geo_t_info_pct.idurba,8) as l_datappro,
    geo_t_info_pct.datvalid,
    geo_t_info_pct.geom
   FROM m_urbanisme_doc_cnig2017.geo_t_info_pct, m_urbanisme_doc_cnig2017.lt_typeinf
  WHERE geo_t_info_pct.typeinf || geo_t_info_pct.stypeinf = lt_typeinf.code || lt_typeinf.sous_code AND idurba = '200067965_PLUI_00000000';

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_t_info_pct_pluiarc
OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_info_pct_pluiarc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_info_pct_pluiarc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_info_pct_pluiarc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_t_info_pct_pluiarc
  IS 'Vue géographique des informations ponctuelles en mode test du PLUi de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';

-- View: m_urbanisme_doc_cnig2017.geo_v_t_info_lin_pluiarc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_t_info_lin_pluiarc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_t_info_lin_pluiarc AS 
 SELECT geo_t_info_lin.idinf,
    lt_typeinf.valeur as libelle,
    geo_t_info_lin.txt,
    geo_t_info_lin.typeinf,
    geo_t_info_lin.stypeinf,
	geo_t_info_lin.idurba,
    geo_t_info_lin.l_nom,
    geo_t_info_lin.l_dateins,
    geo_t_info_lin.l_bnfcr,
    geo_t_info_lin.l_datdlg,
    geo_t_info_lin.l_gen,
    geo_t_info_lin.l_valrecul,
    geo_t_info_lin.l_typrecul,
    geo_t_info_lin.l_observ,
    geo_t_info_lin.nomfic,
    geo_t_info_lin.urlfic,
    geo_t_info_lin.l_insee,
    right(geo_t_info_lin.idurba,8) as l_datappro,
    geo_t_info_lin.datvalid,
    geo_t_info_lin.geom
   FROM m_urbanisme_doc_cnig2017.geo_t_info_lin, m_urbanisme_doc_cnig2017.lt_typeinf
  WHERE geo_t_info_lin.typeinf || geo_t_info_lin.stypeinf = lt_typeinf.code || lt_typeinf.sous_code 
and idurba = '200067965_PLUI_00000000';

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_t_info_lin_pluiarc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_info_lin_pluiarc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_info_lin_pluiarc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_info_lin_pluiarc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_t_info_lin_pluiarc
  IS 'Vue géographique des informations linéaires mode test du PLUi de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';


-- View: m_urbanisme_doc_cnig2017.geo_v_t_info_surf_pluiarc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_t_info_surf_pluiarc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_t_info_surf_pluiarc AS 
 SELECT geo_t_info_surf.idinf,
    lt_typeinf.valeur as libelle,
    geo_t_info_surf.txt,
    geo_t_info_surf.typeinf,
    geo_t_info_surf.stypeinf,
	geo_t_info_surf.idurba,
    geo_t_info_surf.l_nom,
    geo_t_info_surf.l_dateins,
    geo_t_info_surf.l_bnfcr,
    geo_t_info_surf.l_datdlg,
    geo_t_info_surf.l_gen,
    geo_t_info_surf.l_valrecul,
    geo_t_info_surf.l_typrecul,
    geo_t_info_surf.l_observ,
    geo_t_info_surf.nomfic,
    geo_t_info_surf.urlfic,
    geo_t_info_surf.l_insee,
    right(geo_t_info_surf.idurba,8) as l_datappro,
    geo_t_info_surf.datvalid,
    geo_t_info_surf.geom
   FROM m_urbanisme_doc_cnig2017.geo_t_info_surf, m_urbanisme_doc_cnig2017.lt_typeinf
  WHERE geo_t_info_surf.typeinf || geo_t_info_surf.stypeinf = lt_typeinf.code || lt_typeinf.sous_code 
and idurba = '200067965_PLUI_00000000';

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_t_info_surf_pluiarc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_info_surf_pluiarc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_info_surf_pluiarc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_info_surf_pluiarc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_t_info_surf_pluiarc
  IS 'Vue géographique des informations surfaciques en mode test du PLUi de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';

-- View: m_urbanisme_doc_cnig2017.geo_v_t_prescription_lin_pluiarc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_t_prescription_lin_pluiarc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_t_prescription_lin_pluiarc AS 
 SELECT geo_t_prescription_lin.idpsc,
    lt_typepsc.valeur as libelle,
    geo_t_prescription_lin.txt,
    geo_t_prescription_lin.typepsc,
    geo_t_prescription_lin.stypepsc,
	geo_t_prescription_lin.idurba,
    geo_t_prescription_lin.l_nom,
    geo_t_prescription_lin.l_nature,
    geo_t_prescription_lin.l_bnfcr,
    geo_t_prescription_lin.l_numero,
    geo_t_prescription_lin.l_surf_txt,
    geo_t_prescription_lin.l_gen,
    geo_t_prescription_lin.l_valrecul,
    geo_t_prescription_lin.l_typrecul,
    geo_t_prescription_lin.l_observ,
    geo_t_prescription_lin.nomfic,
    geo_t_prescription_lin.urlfic,
    geo_t_prescription_lin.l_insee,
    right(geo_t_prescription_lin.idurba,8) as l_datappro,
    geo_t_prescription_lin.datvalid,
    geo_t_prescription_lin.geom
   FROM m_urbanisme_doc_cnig2017.geo_t_prescription_lin, m_urbanisme_doc_cnig2017.lt_typepsc
  WHERE  geo_t_prescription_lin.typepsc || geo_t_prescription_lin.stypepsc = lt_typepsc.code || lt_typepsc.sous_code 
and idurba = '200067965_PLUI_00000000';

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_t_prescription_lin_pluiarc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_prescription_lin_pluiarc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_prescription_lin_pluiarc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_prescription_lin_pluiarc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_t_prescription_lin_pluiarc
  IS 'Vue géographique des prescriptions linéaires en mode test du PLUi l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';


-- View: m_urbanisme_doc_cnig2017.geo_v_t_prescription_pct_pluiarc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_t_prescription_pct_pluiarc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_t_prescription_pct_pluiarc AS 
 SELECT geo_t_prescription_pct.idpsc,
    lt_typepsc.valeur as libelle,
    geo_t_prescription_pct.txt,
    geo_t_prescription_pct.typepsc,
    geo_t_prescription_pct.stypepsc,
	geo_t_prescription_pct.idurba,
    geo_t_prescription_pct.l_nom,
    geo_t_prescription_pct.l_nature,
    geo_t_prescription_pct.l_bnfcr,
    geo_t_prescription_pct.l_numero,
    geo_t_prescription_pct.l_surf_txt,
    geo_t_prescription_pct.l_gen,
    geo_t_prescription_pct.l_valrecul,
    geo_t_prescription_pct.l_typrecul,
    geo_t_prescription_pct.l_observ,
    geo_t_prescription_pct.nomfic,
    geo_t_prescription_pct.urlfic,
    geo_t_prescription_pct.l_insee,
    right(geo_t_prescription_pct.idurba,8) as l_datappro,
    geo_t_prescription_pct.datvalid,
    geo_t_prescription_pct.geom
   FROM m_urbanisme_doc_cnig2017.geo_t_prescription_pct, m_urbanisme_doc_cnig2017.lt_typepsc
  WHERE geo_t_prescription_pct.typepsc || geo_t_prescription_pct.stypepsc = lt_typepsc.code || lt_typepsc.sous_code 
  and idurba = '200067965_PLUI_00000000';

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_t_prescription_pct_pluiarc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_prescription_pct_pluiarc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_prescription_pct_pluiarc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_prescription_pct_pluiarc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_t_prescription_pct_pluiarc
  IS 'Vue géographique des prescriptions ponctuelles en mode test du PLUide l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';


-- View: m_urbanisme_doc_cnig2017.geo_v_t_prescription_surf_pluiarc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_t_prescription_surf_pluiarc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_t_prescription_surf_pluiarc AS 
 SELECT geo_t_prescription_surf.idpsc,
    lt_typepsc.valeur as libelle,
    geo_t_prescription_surf.txt,
    geo_t_prescription_surf.typepsc,
    geo_t_prescription_surf.stypepsc,
	geo_t_prescription_surf.idurba,
    geo_t_prescription_surf.l_nom,
    geo_t_prescription_surf.l_nature,
    geo_t_prescription_surf.l_bnfcr,
    geo_t_prescription_surf.l_numero,
    geo_t_prescription_surf.l_surf_txt,
    geo_t_prescription_surf.l_gen,
    geo_t_prescription_surf.l_valrecul,
    geo_t_prescription_surf.l_typrecul,
    geo_t_prescription_surf.l_observ,
    geo_t_prescription_surf.nomfic,
    geo_t_prescription_surf.urlfic,
    geo_t_prescription_surf.l_insee,
    right(geo_t_prescription_surf.idurba,8) as l_datappro,
    geo_t_prescription_surf.datvalid,
    geo_t_prescription_surf.geom
   FROM m_urbanisme_doc_cnig2017.geo_t_prescription_surf, m_urbanisme_doc_cnig2017.lt_typepsc
  WHERE geo_t_prescription_surf.typepsc || geo_t_prescription_surf.stypepsc = lt_typepsc.code || lt_typepsc.sous_code
  and idurba = '200067965_PLUI_00000000';

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_t_prescription_surf_pluiarc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_prescription_surf_pluiarc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_prescription_surf_pluiarc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_prescription_surf_pluiarc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_t_prescription_surf_pluiarc
  IS 'Vue géographique des prescriptions surfaciques en mode test du PLUi de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';


-- View: m_urbanisme_doc_cnig2017.geo_v_t_zone_urba_pluiarc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_t_zone_urba_pluiarc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_t_zone_urba_pluiarc AS 
 SELECT geo_t_zone_urba.idzone,
    geo_t_zone_urba.libelle,
    geo_t_zone_urba.libelong,
    geo_t_zone_urba.typezone,
	geo_t_zone_urba.idurba,
    geo_t_zone_urba.l_destdomi,
    geo_t_zone_urba.l_surf_cal,
    geo_t_zone_urba.l_observ,
    geo_t_zone_urba.nomfic,
    geo_t_zone_urba.urlfic,
    geo_t_zone_urba.l_insee,
    right(geo_t_zone_urba.idurba,8) as l_datappro,
    geo_t_zone_urba.datvalid,
    geo_t_zone_urba.geom,
    geo_t_zone_urba.typesect,
    geo_t_zone_urba.fermreco
   FROM m_urbanisme_doc_cnig2017.geo_t_zone_urba
  WHERE idurba = '200067965_PLUI_00000000';

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_t_zone_urba_pluiarc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_zone_urba_pluiarc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_zone_urba_pluiarc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_zone_urba_pluiarc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_t_zone_urba_pluiarc
  IS 'Vue géographique des zonages PLUi en mode test sur l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';



-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Mise à jour éventuelle des '' dans les champs à blanc après la migration des données
-- ----------------------------------------------------------------------------------------------------------------------------------------------------

update m_urbanisme_doc_cnig2017.geo_a_habillage_lin set couleur=null where couleur='';
update m_urbanisme_doc_cnig2017.geo_a_habillage_txt set couleur=null where couleur='';
update m_urbanisme_doc_cnig2017.geo_a_habillage_surf set couleur=null where couleur='';
update m_urbanisme_doc_cnig2017.geo_a_habillage_pct set couleur=null where couleur='';

update m_urbanisme_doc_cnig2017.geo_a_habillage_lin set l_couleur=null where l_couleur='';
update m_urbanisme_doc_cnig2017.geo_a_habillage_txt set l_couleur=null where l_couleur='';
update m_urbanisme_doc_cnig2017.geo_a_habillage_surf set l_couleur=null where l_couleur='';
update m_urbanisme_doc_cnig2017.geo_a_habillage_pct set l_couleur=null where l_couleur='';

update m_urbanisme_doc_cnig2017.geo_a_prescription_pct set nomfic=null where nomfic='';
update m_urbanisme_doc_cnig2017.geo_a_prescription_pct set urlfic=null where urlfic='';

update m_urbanisme_doc_cnig2017.geo_p_habillage_lin set couleur=null where couleur='';
update m_urbanisme_doc_cnig2017.geo_p_habillage_txt set couleur=null where couleur='';
update m_urbanisme_doc_cnig2017.geo_p_habillage_surf set couleur=null where couleur='';
update m_urbanisme_doc_cnig2017.geo_p_habillage_pct set couleur=null where couleur='';

update m_urbanisme_doc_cnig2017.geo_p_habillage_lin set l_couleur=null where l_couleur='';
update m_urbanisme_doc_cnig2017.geo_p_habillage_txt set l_couleur=null where l_couleur='';
update m_urbanisme_doc_cnig2017.geo_p_habillage_surf set l_couleur=null where l_couleur='';
update m_urbanisme_doc_cnig2017.geo_p_habillage_pct set l_couleur=null where l_couleur='';

update m_urbanisme_doc_cnig2017.geo_p_prescription_lin set nomfic=null where nomfic='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_lin set urlfic=null where urlfic='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_lin set l_bnfcr=null where l_bnfcr='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_lin set l_numero=null where l_numero='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_lin set l_surf_txt=null where l_surf_txt='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_lin set l_gen=null where l_gen='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_lin set l_valrecul=null where l_valrecul='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_lin set l_typrecul=null where l_typrecul='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_lin set l_observ=null where l_observ='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_lin set txt=null where txt='';

update m_urbanisme_doc_cnig2017.geo_p_prescription_surf set nomfic=null where nomfic='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_surf set urlfic=null where urlfic='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_surf set l_bnfcr=null where l_bnfcr='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_surf set l_numero=null where l_numero='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_surf set l_surf_txt=null where l_surf_txt='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_surf set l_gen=null where l_gen='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_surf set l_valrecul=null where l_valrecul='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_surf set l_typrecul=null where l_typrecul='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_surf set l_observ=null where l_observ='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_surf set txt=null where txt='';

update m_urbanisme_doc_cnig2017.geo_t_prescription_pct set nomfic=null where nomfic='';
update m_urbanisme_doc_cnig2017.geo_t_prescription_pct set urlfic=null where urlfic='';

update m_urbanisme_doc_cnig2017.geo_p_prescription_pct set nomfic=null where nomfic='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_pct set urlfic=null where urlfic='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_pct set l_bnfcr=null where l_bnfcr='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_pct set l_numero=null where l_numero='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_pct set l_surf_txt=null where l_surf_txt='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_pct set l_gen=null where l_gen='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_pct set l_valrecul=null where l_valrecul='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_pct set l_typrecul=null where l_typrecul='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_pct set l_observ=null where l_observ='';
update m_urbanisme_doc_cnig2017.geo_p_prescription_pct set txt=null where txt='';

update m_urbanisme_doc_cnig2017.geo_p_zone_urba set l_observ=null where l_observ='';

update m_urbanisme_doc_cnig2017.geo_t_habillage_lin set couleur=null where couleur='';
update m_urbanisme_doc_cnig2017.geo_t_habillage_txt set couleur=null where couleur='';
update m_urbanisme_doc_cnig2017.geo_t_habillage_surf set couleur=null where couleur='';
update m_urbanisme_doc_cnig2017.geo_t_habillage_pct set couleur=null where couleur='';

update m_urbanisme_doc_cnig2017.geo_t_habillage_lin set l_couleur=null where l_couleur='';
update m_urbanisme_doc_cnig2017.geo_t_habillage_txt set l_couleur=null where l_couleur='';
update m_urbanisme_doc_cnig2017.geo_t_habillage_surf set l_couleur=null where l_couleur='';
update m_urbanisme_doc_cnig2017.geo_t_habillage_pct set l_couleur=null where l_couleur='';


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FIN DE LA TRANSACTION : si tu s'est bien passé, l'ensemble des requêtes sont écrites en base, si non  message d'erreur pour indiquer le problème mais rien ne s'est exécutée en base. ATTENTION : pour relancer
-- le script il faut faire un rollback (bouton en haut à droite à côté du ? pour les intégration via la fenêtre SQL de PGAdmin)
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
COMMIT;
