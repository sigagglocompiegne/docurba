-- ############################################################################################ SUIVI CODE SQL ###################################################################################################

-- 2018/01/16 : GB / initialisation du script SQL de création de la nouvelle structure de données suite au nouveau standard CNIG de décembre 2017
--		GB / ATTENTION : les tables et liste de domaine (ou valeur), ..... spécifiques au PNR et à OLV ont été mis en commentaire dans ce script mais adaptée au modèle
--		GB / Reste à la charge de chaque partenaire d'adapter ce script à sa situation

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

-- IMPORTANT : lors de la mise en production il faut remplacer m_urbanisme_doc_cnig2017 par m_urbanisme_doc ,mettre en commentaire lacréation du schéma et décommenter la partie de DROP IF EXISTS ou ALTER TABLE qui suivent
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- COMMENT GB : ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- IMPORTANT : Mettre en commentaire pour la mise en production
DROP SCHEMA IF EXISTS m_urbanisme_doc_cnig2017 CASCADE;
CREATE SCHEMA m_urbanisme_doc_cnig2017
  AUTHORIZATION postgres;

GRANT ALL ON SCHEMA m_urbanisme_doc_cnig2017 TO postgres;

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON SCHEMA m_urbanisme_doc_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON SCHEMA m_urbanisme_doc_cnig2017
  IS 'Schéma contenant les données métiers relatives aux documents d''urbanisme du nouveau modèle CNIG2017 pour test';


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------
-- RENOMMAGE DES ANCIENNES TABLES DU MODELES EN _CNIG2014 (hors table spécifique PNR-OLV)
-- Sera utilisé ici pour la migration définitive afin de garder une trace des anciennes données (pourront être supprimé par la suite)
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.an_doc_urba rename to an_doc_urba_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.an_doc_urba_com rename to an_doc_urba_com_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_habillage_lin rename to geo_a_habillage_lin_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_habillage_pct rename to geo_a_habillage_pct_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_habillage_surf rename to geo_a_habillage_surf_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_habillage_txt rename to geo_a_habillage_txt_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_info_lin rename to geo_a_info_lin_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_info_pct rename to geo_a_info_pct_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_info_surf rename to geo_a_info_surf_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_prescription_lin rename to geo_a_prescription_lin_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_prescription_pct rename to geo_a_prescription_pct_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_prescription_surf rename to geo_a_prescription_surf_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_zone_urba rename to geo_a_zone_urba_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_habillage_lin rename to geo_p_habillage_lin_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_habillage_pct rename to geo_p_habillage_pct_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_habillage_surf rename to geo_p_habillage_surf_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_habillage_txt rename to geo_p_habillage_txt_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_info_lin rename to geo_p_info_lin_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_info_pct rename to geo_p_info_pct_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_info_surf rename to geo_p_info_surf_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_prescription_lin rename to geo_p_prescription_lin_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_prescription_pct rename to geo_p_prescription_pct_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_prescription_surf rename to geo_p_prescription_surf_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_zone_urba rename to geo_p_zone_urba_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_habillage_lin rename to geo_t_habillage_lin_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_habillage_pct rename to geo_t_habillage_pct_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_habillage_surf rename to geo_t_habillage_surf_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_habillage_txt rename to geo_t_habillage_txt_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_info_lin rename to geo_t_info_lin_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_info_pct rename to geo_t_info_pct_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_info_surf rename to geo_t_info_surf_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_prescription_lin rename to geo_t_prescription_lin_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_prescription_pct rename to geo_t_prescription_pct_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_prescription_surf rename to geo_t_prescription_surf_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_zone_urba rename to geo_t_zone_urba_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_destdomi rename to lt_destdomi_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_etat rename to lt_etat_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_l_secteur rename to lt_l_secteur_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_typedoc rename to lt_typedoc_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_typeinf rename to lt_typeinf_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_l_typeinf2 rename to lt_l_typeinf2_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_typepsc rename to lt_typepsc_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_l_typepsc2 rename to lt_l_typepsc2_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_typeref rename to lt_typeref_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_typesect rename to lt_typesect_cnig2014;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_typezone rename to lt_typezone_cnig2014;

ALTER SEQUENCE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_habillage_txt_gid_seq rename to geo_a_habillage_txt_gid_seq_cnig2014;
ALTER SEQUENCE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_info_surf_gid_seq rename to geo_a_info_surf_gid_seq_cnig2014;
ALTER SEQUENCE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_prescription_surf_gid_seq rename to geo_a_prescription_surf_gid_seq_cnig2014;
ALTER SEQUENCE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_zone_urba_gid_seq rename to geo_a_zone_urba_gid_seq_cnig2014;



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  DOMAINES DE VALEURS                                                         ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################




-- COMMENT GB : --------------------------------------------------------------------------------------
-- Création des domaines de valeurs avant les tables nécessaires pour la création des clés étrangères
-- ---------------------------------------------------------------------------------------------------

-- ################################################################# Domaine valeur - lt_etat #############################################

-- Table: m_urbanisme_doc_cnig2017.lt_etat_cnig2017

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_etat_cnig2017;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_etat_cnig2017
(
  code character(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_etat_cnig2017_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_etat_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_etat_cnig2017 TO postgres;

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_etat_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_etat_cnig2017
  IS 'Liste des valeurs de l''attribut état de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_etat_cnig2017.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_etat_cnig2017.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_cnig2017.lt_etat_cnig2017(
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

-- Table: m_urbanisme_doc.lt_typedoc

-- DROP TABLE m_urbanisme_doc.lt_typedoc;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_typedoc_cnig2017
(
  code character varying(4) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_typedoc_cnig2017_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_typedoc_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typedoc_cnig2017 TO postgres;

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typedoc_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_typedoc_cnig2017
  IS 'Liste des valeurs de l''attribut état de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typedoc_cnig2017.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typedoc_cnig2017.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_cnig2017.lt_typedoc_cnig2017(
            code, valeur)
    VALUES
    ('RNU','Règlement national de l''urbanisme'),
    ('PLU','Plan local d''urbanisme'),
    ('PLUI','Plan local d''urbanisme intercommunal'),
    ('POS','Plan d''occupation des sols'),
    ('CC','Carte communale'),
    ('PSMV','Plan de sauvegarde et de mise en valeur'); 

-- ################################################################# Domaine valeur - lt_typeref #############################################

-- Table: m_urbanisme_doc.lt_typeref

-- DROP TABLE m_urbanisme_doc.lt_typeref;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_typeref_cnig2017
(
  code character varying(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_typeref_cnig2017_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_typeref_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typeref_cnig2017 TO postgres;

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typeref_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_typeref_cnig2017
  IS 'Liste des valeurs de l''attribut typeref de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typeref_cnig2017.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typeref_cnig2017.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_cnig2017.lt_typeref_cnig2017(
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

-- Table: m_urbanisme_doc.lt_nomproc

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_nomproc;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_nomproc_cnig2017
(
  code character varying(3) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_nomproc_cnig2017_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_nomproc_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_nomproc_cnig2017 TO postgres;

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_nomproc_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_nomproc_cnig2017
  IS 'Liste des valeurs de l''attribut Nom de la procédure de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_nomproc_cnig2017.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_nomproc_cnig2017.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_cnig2017.lt_nomproc_cnig2017(
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

-- Table: m_urbanisme_doc.lt_typezone

-- DROP TABLE m_urbanisme_doc.lt_typezone;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_typezone_cnig2017
(
  code character varying(3) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_typezone_cnig2017_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_typezone_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typezone_cnig2017 TO postgres;

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typezone_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_typezone_cnig2017
  IS 'Liste des valeurs de l''attribut typezone de la donnée zone_urba';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typezone_cnig2017.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typezone_cnig2017.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_cnig2017.lt_typezone_cnig2017(
            code, valeur)
    VALUES
    ('U','Urbaine'),
    ('AUc','A urbaniser'),
    ('AUs','A urbaniser bloquée'),
    ('A','Agricole'),
    ('N','Naturel et forestière');

-- ################################################################# Domaine valeur - lt_destdomi #############################################

-- Table: m_urbanisme_doc.lt_destdomi

-- DROP TABLE m_urbanisme_doc.lt_destdomi;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_destdomi_cnig2017
(
  code character (2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_destdomi_cnig2017_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_destdomi_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_destdomi_cnig2017 TO postgres;

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_destdomi_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_destdomi_cnig2017
  IS 'Liste des valeurs de l''attribut destdomi de la donnée zone_urba';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_destdomi_cnig2017.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_destdomi_cnig2017.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_cnig2017.lt_destdomi_cnig2017(
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


-- Table: m_urbanisme_doc.lt_typesect

-- DROP TABLE m_urbanisme_doc.lt_typesect;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_typesect_cnig2017
(
  code character varying(2) NOT NULL, -- Code
  valeur character varying(100) NOT NULL, -- Valeur
  CONSTRAINT lt_typesect_cnig2017_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_typesect_cnig2017
  OWNER TO postgres;

GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typesect_cnig2017 TO postgres WITH GRANT OPTION;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typesect_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_typesect_cnig2017
  IS 'Liste des valeurs de l''attribut typesect de la donnée zone_urba';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typesect_cnig2017.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typesect_cnig2017.valeur IS 'Valeur';


INSERT INTO m_urbanisme_doc_cnig2017.lt_typesect_cnig2017(
            code, valeur)
    VALUES
    ('ZZ','Non concerné'),
    ('01','Secteur ouvert à la construction'),
    ('02','Secteur réservé aux activités'),
    ('03','Secteur non ouvert à la construction, sauf exceptions prévues par la loi'),
    ('99','Zone non couverte par la carte communale');

-- ################################################################# Domaine valeur - lt_libsect #############################################

-- Table: m_urbanisme_doc.lt_libsect

-- DROP TABLE m_urbanisme_doc.lt_libsect;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_libsect_cnig2017
(
  code character varying(3) NOT NULL,
  valeur character varying(100) NOT NULL,
  CONSTRAINT lt_libsect_cnig2017_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_libsect_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_libsect_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_libsect_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_libsect_cnig2017
  IS 'Liste des valeurs de l''attribut libelle à saisir pour la carte communale (convention de libellé pour l''affichage cartographique)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_libsect_cnig2017.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_libsect_cnig2017.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_cnig2017.lt_libsect_cnig2017(
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

-- Table: m_urbanisme_doc.lt_typepsc

-- DROP TABLE m_urbanisme_doc.lt_typepsc;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017
(
  code character(2) NOT NULL,
  sous_code character varying(2) NOT NULL,
  valeur character varying(254) NOT NULL,
  ref_leg character varying(80),
  ref_reg character varying(80),
  CONSTRAINT lt_typepsc_cnig2017_pkey PRIMARY KEY (code,sous_code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017
  IS 'Liste des valeurs de l''attribut typepsc de la donnée prescription_surf, prescription_lin et prescription_pct';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017.sous_code IS 'Sous code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017.valeur IS 'Valeur';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017.ref_leg IS 'Références législatives du code de l''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017.ref_reg IS 'Références réglementaires du code de l''urbanisme';

INSERT INTO m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017(
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

-- Table: m_urbanisme_doc.lt_typeinf

-- DROP TABLE m_urbanisme_doc.lt_typeinf;

CREATE TABLE m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017
(
  code character(2) NOT NULL,
  sous_code character varying(2) NOT NULL,
  valeur character varying(254) NOT NULL,
  ref_leg character varying(80),
  ref_reg character varying(80),
  CONSTRAINT lt_typeinf_cnig2017_pkey PRIMARY KEY (code,sous_code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017
  IS 'Liste des valeurs de l''attribut typeinf de la donnée info_surf, info_lin et info_pct';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017.sous_code IS 'Sous code';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017.valeur IS 'Valeur';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017.ref_leg IS 'Références législatives du code de l''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017.ref_reg IS 'Références réglementaires du code de l''urbanisme';

INSERT INTO m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017(
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

-- Table: m_urbanisme_doc.lt_dispon

-- DROP TABLE m_urbanisme_doc.lt_dispon;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.lt_dispon_cnig2017
-- (
--   code character(2) NOT NULL, -- Code
--   valeur character varying(254) NOT NULL, -- Valeur
--   CONSTRAINT lt_dispon_prkey_cnig2017 PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.lt_dispon_cnig2017
--   OWNER TO postgres;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_dispon_cnig2017 TO postgres WITH GRANT OPTION;
-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_dispon_cnig2017
--   IS 'Liste des valeurs de l''attribut l_dispon de la donnée doc_urba_doc';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_dispon_cnig2017.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_dispon_cnig2017.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc_cnig2017.lt_dispon_cnig2017(
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

-- Table: m_urbanisme_doc.lt_dispop

-- DROP TABLE m_urbanisme_doc.lt_dispop;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.lt_dispop_cnig2017
-- (
--   code character(2) NOT NULL, -- Code
--   valeur character varying(254) NOT NULL, -- Valeur
--   CONSTRAINT lt_dispop_pkey_cnig2017 PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.lt_dispop_cnig2017
--   OWNER TO postgres;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_dispop_cnig2017 TO postgres WITH GRANT OPTION;
-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_dispop_cnig2017
--   IS 'Liste des valeurs de l''attribut l_dispop de la donnée doc_urba_doc';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_dispop_cnig2017.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_dispop_cnig2017.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc_cnig2017.lt_dispop_cnig2017(
--             code, valeur)
--     VALUES
--     ('00','Aucun document papier'),
--     ('10','Une partie du document (la plupart du temps le rapport de présentation, padd, règlement écrit et graphique)'),
--     ('20','Tout le document');


-- ################################################################# Domaine valeur - lt_l_themapatnat #############################################

-- Table: m_urbanisme_doc.lt_l_themapatnat

-- DROP TABLE m_urbanisme_doc.lt_l_themapatnat;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.lt_l_themapatnat_cnig2017
-- (
--   code character varying(10) NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_thema_pkey_cnig2017 PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.lt_l_themapatnat_cnig2017
--   OWNER TO postgres;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_l_themapatnat_cnig2017 TO postgres WITH GRANT OPTION;
-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_l_themapatnat_cnig2017
--   IS 'Liste des valeurs de l''attribut l_thema de la donnée zone_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_themapatnat_cnig2017.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_themapatnat_cnig2017.valeur IS 'Valeur';
-- 
-- 
-- INSERT INTO m_urbanisme_doc_cnig2017.lt_l_themapatnat_cnig2017(
--             code, valeur)
--     VALUES
--     ('aucun','aucun'),
--     ('CE','Corridor ecologique'),
--     ('N2000','Natura 2000'),
--     ('Paysage','Paysage'),
--     ('ZH','Zones humides');


-- ################################################################# Domaine valeur - lt_l_vigipatnat #############################################

-- Table: m_urbanisme_doc.lt_l_vigipatnat

-- DROP TABLE m_urbanisme_doc.lt_l_vigipatnat;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.lt_l_vigipatnat_cnig2017
-- (
--   code character varying(10) NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_vigilance_pkey_cnig2017 PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.lt_l_vigipatnat_cnig2017
--   OWNER TO postgres;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_l_vigipatnat_cnig2017 TO postgres WITH GRANT OPTION;
-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_l_vigipatnat_cnig2017
--   IS 'Liste des valeurs de l''attribut l_vigilance de la donnée zone_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_vigipatnat_cnig2017.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_vigipatnat_cnig2017.valeur IS 'Valeur';
-- 
-- 
-- INSERT INTO m_urbanisme_doc_cnig2017.lt_l_vigipatnat_cnig2017(
--             code, valeur)
--     VALUES
--     ('oui','oui'),
--     ('non','non');


-- ################################################################# Domaine valeur - lt_l_pecpatnat #############################################

-- Table: m_urbanisme_doc.lt_l_pecpatnat

-- DROP TABLE m_urbanisme_doc_cnig2017.lt_l_pecpatnat_cnig2017;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.lt_l_pecpatnat_cnig2017
-- (
--   code character varying(50) NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_pec_pkey_cnig2017 PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.lt_l_pecpatnat_cnig2017
--   OWNER TO postgres;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_l_pecpatnat_cnig2017 TO postgres WITH GRANT OPTION;
-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_l_pecpatnat_cnig2017
--   IS 'Liste des valeurs de l''attribut l_prisencompte de la donnée doc_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_pecpatnat_cnig2017.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_pecpatnat_cnig2017.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc_cnig2017.lt_l_pecpatnat_cnig2017(
--             code, valeur)
--     VALUES
--     ('diagnostic','dans diagnostic'),
--     ('non concerne','non concerné'),
--     ('PADD','dans PADD'),
--     ('pas de prise en compte','pas de prise en compte'),
--     ('Reglement','dans la réglement');



-- ################################################################# Domaine valeur - lt_l_nspatnat #############################################


-- Table: m_urbanisme_doc.lt_l_nspatnat

-- DROP TABLE m_urbanisme_doc.lt_l_nspatnat;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.lt_l_nspatnat_cnig2017
-- (
--   code bigint NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_nsynt_pkey_cnig2017 PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.lt_l_nspatnat_cnig2017
--   OWNER TO postgres;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.lt_l_nspatnat_cnig2017 TO postgres WITH GRANT OPTION;
-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.lt_l_nspatnat_cnig2017
--   IS 'Liste des valeurs de l''attribut l_notesynth de la donnée doc_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_nspatnat_cnig2017.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.lt_l_nspatnat_cnig2017.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc_cnig2017.lt_l_nspatnat_cnig2017(
--             code, valeur)
--     VALUES
--     ('0','non renseigné'),
--     ('1','peu satisfaisant'),
--     ('2','correct'),
--     ('3','satisfaisant');





-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                  TABLES METIERS DOCUMENTS D'URBANISME                                                        ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ####################################################################################################################################################
-- ###                                                  	  MODE PRODUCTION                                                                   ###
-- ####################################################################################################################################################


-- ########################################################################## table an_doc_urba #######################################################

-- Table: m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017

-- DROP TABLE m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017;

CREATE TABLE m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017
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
  l_moa_proc character varying(80), -- Maitre d'ouvrage de la procédure
  l_moe_proc character varying(80), -- Maitre d'oeuvre de la procédure
  l_moa_dmat character varying(80), -- Maitre d'ouvrage de la dématérialisation
  l_moe_dmat character varying(80), -- Maitre d'oeuvre de la dématérialisation
  l_observ character varying(254), -- Observations
  l_parent integer, -- Identification des documents parents pour recherche des historiques entre version de documents (1 pour le premier document (élaboration, modif, mise à jour), 2 pour la révision (révision n°1, modif, mise à jour), 3 pour le 2nd révisoon (révision n°2, modif, mise à jour), ...)
  CONSTRAINT an_doc_urba_cnig2017_pkey PRIMARY KEY (idurba)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017
  IS 'Donnée alphanumerique de référence des documents d''urbanisme en projet ou ayant été approuvés';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.typedoc IS 'Type du document concerné';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.datappro IS 'Date d''approbation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.datefin IS 'date de fin de validité';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.siren IS 'Code SIREN de l''intercommunalité';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.etat IS 'Etat juridique du document';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.nomproc IS 'Codage de la version du document concerné';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.l_nomprocn IS 'N° d''ordre de la procédure';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.nomreg IS 'Nom du fichier de règlement';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.urlreg IS 'URL ou URI du fichier du règlement';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.nomplan IS 'Nom du fichier du plan scanné';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.urlplan IS 'URL ou URI du fichier du plan scanné';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.urlpe IS 'Lien d''accès à l''archive zip comprenant l''ensemble des pièces écrites';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.siteweb IS 'Site web du service d''accès';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.typeref IS 'Type de référentiel utilisé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.dateref IS 'Date du référentiel de saisie';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.l_moa_proc IS 'Maitre d''ouvrage de la procédure';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.l_moe_proc IS 'Maitre d''oeuvre de la procédure';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.l_moa_dmat IS 'Maitre d''ouvrage de la dématérialisation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.l_moe_dmat IS 'Maitre d''oeuvre de la dématérialisation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017.l_parent IS 'Identification des documents parents pour recherche des historiques entre version de documents (1 pour le premier document (élaboration, modif, mise à jour), 2 pour la révision (révision n°1, modif, mise à jour), 3 
  pour le 2nd révisoon (révision n°2, modif, mise à jour), ...)';


-- ########################################################################## table an_doc_urba_com #######################################################


-- Table: m_urbanisme_doc_cnig2017.an_doc_urba_com

-- DROP TABLE m_urbanisme_doc_cnig2017.an_doc_urba_com;

CREATE TABLE m_urbanisme_doc_cnig2017.an_doc_urba_com_cnig2017
(
  idurba character varying(30) NOT NULL, -- identifiant
  insee character varying(5) NOT NULL -- code insee de la commune 
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_urba_com_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_com_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_com_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_com_cnig2017
  IS 'Donnée alphanumerique d''appartenance d''une commune à une procédure définie';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_com_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_com_cnig2017.insee IS 'Code insee de la commune';


-- ########################################################################### table geo_p_zone_urba #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_p_zone_urba

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017
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
  CONSTRAINT geo_p_zone_urba_cnig2017_pkey PRIMARY KEY (idzone)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017
  IS 'Donnée géographique contenant les zonages des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.idzone IS 'Identifiant unique de zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.libelle IS 'Nom court de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.libelong IS 'Nom complet de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.typezone IS 'Type de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.l_destdomi IS 'Vocation de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.typesect IS 'Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.fermreco IS 'Secteur fermé à la reconstruction (uniquement pour la carte communale)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.l_surf_cal IS 'Surface calculée de la zone en ha';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.nomfic IS 'Nom du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.urlfic IS 'URL ou URI du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.l_nomfic IS 'Nom du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.l_urlfic IS 'URL ou URI du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017.idurba IS 'Identifiant du document d''urbanisme';


-- ########################################################################### geo_p_prescription_surf #######################################################

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mettre en commentaire la création du champ geom1 et la ligne de commentaire par les partenaires si pas utilisé
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc.geo_p_prescription_surf

-- DROP TABLE m_urbanisme_doc.geo_p_prescription_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017
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
  geom1 geometry(MultiPolygon,2154), -- Géométrie de l''objet avec un buffer de -0.5 pour calcul de la vue an_vmr_prescription pour GEO.Champ mis à jour en automatique par un trigger à l''insertion, mise à jour du champ geom
  CONSTRAINT geo_p_prescription_surf_cnig2017_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017
  IS 'Donnée géographique contenant les prescriptions surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.idpsc IS 'Identifiant unique de prescription surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017.geom1 IS 'Géométrie de l''objet avec un buffer de -0.5 pour calcul de la vue an_vmr_prescription pour GEO.Champ mis à jour en automatique par un trigger à l''insertion, mise à jour du champ geom';


-- ########################################################################### geo_p_prescription_lin #######################################################

-- Table: m_urbanisme_doc.geo_p_prescription_lin

-- DROP TABLE m_urbanisme_doc.geo_p_prescription_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017
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
  CONSTRAINT geo_p_prescription_lin_cnig2017_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017
  IS 'Donnée géographique contenant les prescriptions linéaires des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.idpsc IS 'Identifiant unique de prescription linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017.geom IS 'Géométrie de l''objet';


-- ########################################################################### geo_p_prescription_pct #######################################################

-- Table: m_urbanisme_doc.geo_p_prescription_pct

-- DROP TABLE m_urbanisme_doc.geo_p_prescription_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017
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
  CONSTRAINT geo_p_prescription_pct_cnig2017_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017
  IS 'Donnée géographique contenant les prescriptions ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.idpsc IS 'Identifiant unique de prescription ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017.geom IS 'Géométrie de l''objet';


-- ################################################################################ geo_p_info_surf ##########################################################

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mettre en commentaire la création du champ geom1 et la ligne de commentaire par les partenaires si pas utilisé
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc.geo_p_info_surf

-- DROP TABLE m_urbanisme_doc.geo_p_info_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017
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
  CONSTRAINT geo_p_info_surf_cnig2017_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017
  IS 'Donnée géographique contenant les informations surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.idinf IS 'Identifiant unique de l''information surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.geom1 IS 'Géométrie de l''objet avec un buffer de -0.5 pour calcul de la vue an_vmr_p_information pour GEO. Champ mis à jour en automatique par un trigger à l''insertion, mise à jour du champ geom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017.idurba IS 'Identifiant du document d''urbanisme';

-- ################################################################################ geo_p_info_lin ##########################################################

-- Table: m_urbanisme_doc.geo_p_info_lin

-- DROP TABLE m_urbanisme_doc.geo_p_info_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017
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
  CONSTRAINT geo_p_info_lin_cnig2017_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017
  IS 'Donnée géographique contenant les informations linéaires des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.idinf IS 'Identifiant unique de l''information linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017.idurba IS 'Identifiant du document d''urbanisme';


-- ################################################################################ geo_p_info_pct ##########################################################

-- Table: m_urbanisme_doc.geo_p_info_pct

-- DROP TABLE m_urbanisme_doc.geo_p_info_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017
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
  CONSTRAINT geo_p_info_pct_cnig2017_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017
  IS 'Donnée géographique contenant les informations ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.idinf IS 'Identifiant unique de l''information ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_p_habillage_surf #######################################################

-- Table: m_urbanisme_doc.geo_p_habillage_surf

-- DROP TABLE m_urbanisme_doc.geo_p_habillage_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_habillage_surf_cnig2017_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017
  IS 'Donnée géographique contenant l''habillage surfacique des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017.idhab IS 'Identifiant unique de l''habillage surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_p_habillage_lin #######################################################

-- Table: m_urbanisme_doc.geo_p_habillage_lin

-- DROP TABLE m_urbanisme_doc.geo_p_habillage_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiLineString,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_habillage_lin_cnig2017_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017
  IS 'Donnée géographique contenant l''habillage linéaire des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017.idhab IS 'Identifiant unique de l''habillage linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017.idurba IS 'Identifiant du document d''urbanisme';



-- ######################################################################## geo_p_habillage_pct #######################################################

-- Table: m_urbanisme_doc.geo_p_habillage_pct

-- DROP TABLE m_urbanisme_doc.geo_p_habillage_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiLineString,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_habillage_pct_cnig2017_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017
  IS 'Donnée géographique contenant l''habillage ponctuel des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_p_habillage_txt #######################################################

-- Table: m_urbanisme_doc.geo_p_habillage_txt

-- DROP TABLE m_urbanisme_doc.geo_p_habillage_txt;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017
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
  CONSTRAINT geo_p_habillage_txt_cnig2017_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017
  IS 'Donnée géographique contenant l''habillage textuel des documents d''urbanisme locaux (PLUi, PLU, POS) sous la forme de ponctuels';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017.natecr IS 'Nature de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017.txt IS 'Texte de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017.police IS 'Police de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017.taille IS 'Taille de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017.style IS 'Style de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017.angle IS 'Angle de l''écriture exprimé en degré, par rapport à l''horizontale, dans le sens trigonométrique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';


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

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017
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
  CONSTRAINT geo_a_zone_urba_cnig2017_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017
  IS '(archive) Donnée géographique contenant les zonages des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.idzone IS 'Identifiant unique de zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.libelle IS 'Nom court de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.libelong IS 'Nom complet de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.typezone IS 'Type de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.l_destdomi IS 'Vocation de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.typesect IS 'Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.fermreco IS 'Secteur fermé à la reconstruction (uniquement pour la carte communale)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.l_surf_cal IS 'Surface calculée de la zone en ha';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.nomfic IS 'Nom du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.urlfic IS 'URL ou URI du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.l_nomfic IS 'Nom du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.l_urlfic IS 'URL ou URI du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017.gid IS 'Identifiant unique spécifique à l''ARC';



-- ########################################################################### geo_a_prescription_surf #######################################################

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mettre en commentaire la création du champ geom1 et gid et la ligne de commentaire par les partenaires si pas utilisé
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc.geo_a_prescription_surf

-- DROP TABLE m_urbanisme_doc.geo_a_prescription_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017
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
  CONSTRAINT geo_a_prescription_surf_cnig2017_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017
  IS '(archive) Donnée géographique contenant les prescriptions surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.idpsc IS 'Identifiant unique de prescription surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017.gid IS 'Identifiant unique spécifique à l''ARC';



-- ########################################################################### geo_a_prescription_lin #######################################################

-- Table: m_urbanisme_doc.geo_a_prescription_lin

-- DROP TABLE m_urbanisme_doc.geo_a_prescription_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017
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
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017
  IS '(archive) Donnée géographique contenant les prescriptions linéaires des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.idpsc IS 'Identifiant unique de prescription linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017.geom IS 'Géométrie de l''objet';


-- ########################################################################### geo_a_prescription_pct #######################################################

-- Table: m_urbanisme_doc.geo_a_prescription_pct

-- DROP TABLE m_urbanisme_doc.geo_a_prescription_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017
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
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017
  IS '(archive) Donnée géographique contenant les prescriptions ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.idpsc IS 'Identifiant unique de prescription ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017.geom IS 'Géométrie de l''objet';


-- ################################################################################ geo_a_info_surf ##########################################################

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mettre en commentaire la création du champ geom1 et gid et la ligne de commentaire par les partenaires si pas utilisé
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc.geo_a_info_surf

-- DROP TABLE m_urbanisme_doc.geo_a_info_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017
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
  CONSTRAINT geo_a_info_surf_cnig2017_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017
  IS '(archive) Donnée géographique contenant les informations surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.idinf IS 'Identifiant unique de l''information surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017.gid IS 'Identifiant unique spécifique à l''ARC';

-- ################################################################################ geo_a_info_lin ##########################################################

-- Table: m_urbanisme_doc.geo_a_info_lin

-- DROP TABLE m_urbanisme_doc.geo_a_info_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017
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
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017
  IS '(archive) Donnée géographique contenant les informations linéaires des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.idinf IS 'Identifiant unique de l''information linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017.idurba IS 'Identifiant du document d''urbanisme';


-- ################################################################################ geo_a_info_pct ##########################################################

-- Table: m_urbanisme_doc.geo_a_info_pct

-- DROP TABLE m_urbanisme_doc.geo_a_info_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017
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
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017
  IS '(archive) Donnée géographique contenant les informations ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.idinf IS 'Identifiant unique de l''information ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_a_habillage_surf #######################################################

-- Table: m_urbanisme_doc.geo_a_habillage_surf

-- DROP TABLE m_urbanisme_doc.geo_a_habillage_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017
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
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017
  IS '(archive) Donnée géographique contenant l''habillage surfacique des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017.idhab IS 'Identifiant unique de l''habillage surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_a_habillage_lin #######################################################

-- Table: m_urbanisme_doc.geo_a_habillage_lin

-- DROP TABLE m_urbanisme_doc.geo_a_habillage_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017
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
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017
  IS '(archive) Donnée géographique contenant l''habillage linéaire des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017.idhab IS 'Identifiant unique de l''habillage linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXE (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017.idurba IS 'Identifiant du document d''urbanisme';



-- ######################################################################## geo_a_habillage_pct #######################################################

-- Table: m_urbanisme_doc.geo_a_habillage_pct

-- DROP TABLE m_urbanisme_doc.geo_a_habillage_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme hexa (#000000)
  geom geometry(MultiLineString,2154) -- Géométrie de l'objet
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017
  IS '(archive) Donnée géographique contenant l''habillage ponctuel des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_a_habillage_txt #######################################################

-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mettre en commentaire la création du champ gid et la ligne de commentaire par les partenaires si pas utilisé
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc.geo_a_habillage_txt

-- DROP TABLE m_urbanisme_doc.geo_a_habillage_txt;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017
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
  CONSTRAINT geo_a_habillage_txt_cnig2017_pkey PRIMARY KEY (gid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017
  IS '(archive) Donnée géographique contenant l''habillage textuel des documents d''urbanisme locaux (PLUi, PLU, POS) sous la forme de ponctuels';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017.natecr IS 'Nature de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017.txt IS 'Texte de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017.police IS 'Police de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017.taille IS 'Taille de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017.style IS 'Style de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017.angle IS 'Angle de l''écriture exprimé en degré, par rapport à l''horizontale, dans le sens trigonométrique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017.gid IS 'Identifiant unique pour l''ARC';



-- ####################################################################################################################################################
-- ###                                                 	      MODE TEST (pré-production)                                                            ###
-- ####################################################################################################################################################

-- ########################################################################### table geo_t_zone_urba #######################################################

-- Table: m_urbanisme_doc_cnig2017.geo_t_zone_urba

-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017
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
  CONSTRAINT geo_t_zone_urba_cnig2017_pkey PRIMARY KEY (idzone)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017
  IS '(test) Donnée géographique contenant les zonages des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.idzone IS 'Identifiant unique de zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.libelle IS 'Nom court de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.libelong IS 'Nom complet de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.typezone IS 'Type de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.l_destdomi IS 'Vocation de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.typesect IS 'Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.fermreco IS 'Secteur fermé à la reconstruction (uniquement pour la carte communale)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.l_surf_cal IS 'Surface calculée de la zone en ha';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.nomfic IS 'Nom du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.urlfic IS 'URL ou URI du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.l_nomfic IS 'Nom du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.l_urlfic IS 'URL ou URI du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017.idurba IS 'Identifiant du document d''urbanisme';


-- ########################################################################### geo_t_prescription_surf #######################################################

-- Table: m_urbanisme_doc.geo_t_prescription_surf

-- DROP TABLE m_urbanisme_doc.geo_t_prescription_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017
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
  CONSTRAINT geo_t_prescription_surf_cnig2017_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017
  IS '(test) Donnée géographique contenant les prescriptions surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.idpsc IS 'Identifiant unique de prescription surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017.geom IS 'Géométrie de l''objet';


-- ########################################################################### geo_t_prescription_lin #######################################################

-- Table: m_urbanisme_doc.geo_t_prescription_lin

-- DROP TABLE m_urbanisme_doc.geo_t_prescription_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017
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
  CONSTRAINT geo_t_prescription_lin_cnig2017_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017
  IS '(test) Donnée géographique contenant les prescriptions linéaires des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.idpsc IS 'Identifiant unique de prescription linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017.geom IS 'Géométrie de l''objet';


-- ########################################################################### geo_t_prescription_pct #######################################################

-- Table: m_urbanisme_doc.geo_t_prescription_pct

-- DROP TABLE m_urbanisme_doc.geo_t_prescription_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017
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
  CONSTRAINT geo_t_prescription_pct_cnig2017_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017
  IS '(test) Donnée géographique contenant les prescriptions ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.idpsc IS 'Identifiant unique de prescription ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017.geom IS 'Géométrie de l''objet';


-- ################################################################################ geo_t_info_surf ##########################################################

-- Table: m_urbanisme_doc.geo_t_info_surf

-- DROP TABLE m_urbanisme_doc.geo_t_info_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017
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
  CONSTRAINT geo_t_info_surf_cnig2017_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017
  IS 'test) Donnée géographique contenant les informations surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.idinf IS 'Identifiant unique de l''information surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017.idurba IS 'Identifiant du document d''urbanisme';

-- ################################################################################ geo_t_info_lin ##########################################################

-- Table: m_urbanisme_doc.geo_t_info_lin

-- DROP TABLE m_urbanisme_doc.geo_t_info_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017
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
  CONSTRAINT geo_t_info_lin_cnig2017_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017
  IS '(test) Donnée géographique contenant les informations linéaires des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.idinf IS 'Identifiant unique de l''information linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017.idurba IS 'Identifiant du document d''urbanisme';


-- ################################################################################ geo_t_info_pct ##########################################################

-- Table: m_urbanisme_doc.geo_t_info_pct

-- DROP TABLE m_urbanisme_doc.geo_t_info_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017
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
  CONSTRAINT geo_t_info_pct_cnig2017_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017
  IS '(test) Donnée géographique contenant les informations ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.idinf IS 'Identifiant unique de l''information ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_t_habillage_surf #######################################################

-- Table: m_urbanisme_doc.geo_t_habillage_surf

-- DROP TABLE m_urbanisme_doc.geo_t_habillage_surf;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30), -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_habillage_surf_cnig2017_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017
  IS '(test) Donnée géographique contenant l''habillage surfacique des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017.idhab IS 'Identifiant unique de l''habillage surfacique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_t_habillage_lin #######################################################

-- Table: m_urbanisme_doc.geo_t_habillage_lin

-- DROP TABLE m_urbanisme_doc.geo_t_habillage_lin;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30), -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiLineString,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_habillage_lin_cnig2017_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017
  IS '(test) Donnée géographique contenant l''habillage linéaire des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017.idhab IS 'Identifiant unique de l''habillage linéaire';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017.idurba IS 'Identifiant du document d''urbanisme';



-- ######################################################################## geo_t_habillage_pct #######################################################

-- Table: m_urbanisme_doc.geo_t_habillage_pct

-- DROP TABLE m_urbanisme_doc.geo_t_habillage_pct;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30), -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(MultiLineString,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_habillage_pct_cnig2017_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017
  IS '(test) Donnée géographique contenant l''habillage ponctuel des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_t_habillage_txt #######################################################

-- Table: m_urbanisme_doc.geo_t_habillage_txt

-- DROP TABLE m_urbanisme_doc.geo_t_habillage_txt;

CREATE TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017
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
  CONSTRAINT geo_t_habillage_txt_cnig2017_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017 TO postgres;
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017 TO groupe_sig WITH GRANT OPTION;
COMMENT ON TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017
  IS '(test) Donnée géographique contenant l''habillage textuel des documents d''urbanisme locaux (PLUi, PLU, POS) sous la forme de ponctuels';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017.natecr IS 'Nature de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017.txt IS 'Texte de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017.police IS 'Police de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017.taille IS 'Taille de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017.style IS 'Style de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017.angle IS 'Angle de l''écriture exprimé en degré, par rapport à l''horizontale, dans le sens trigonométrique';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';



-- ####################################################################################################################################################
-- ###                                         		  TABLES SPECIFIQUES AU PNR ET OLV                                                          ###
-- ####################################################################################################################################################




-- COMMENT GB : ----------------------------------------------------------------------------------------------------------------------------
-- A décommenter pour la création de la structure des tables spécifiques et intégration du champ l_datmaj dans les tables principales
-- A vérifier par le PNR et OLV avant intégration (à décommenter pour intégrer le processus)
-- -----------------------------------------------------------------------------------------------------------------------------------------

-- Table: m_urbanisme_doc.an_doc_urba_doc

-- DROP TABLE m_urbanisme_doc.an_doc_urba_doc;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.an_doc_urba_doc_cnig2017
-- (
--   idurba character varying(30) NOT NULL, -- identifiant du document d'urbanisme
--   l_gest character varying(1), -- Type d'organisme qui gère la donnée dans la base (intégration et/ou mise à jour)
--   l_dispon character varying(2), -- Niveau de disponibilité le plus élevé des documents numériques
--   l_dispop character varying(2), -- Niveau de disponibilité le plus élevé des documents papiers
--   l_datproc character varying(8), -- date de lancement de la procédure
--   l_observ character varying(254), -- observation
--   CONSTRAINT idurba_prkey_cnig2017 PRIMARY KEY (idurba)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_urba_doc_cnig2017
--   OWNER TO postgres;
-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.an_doc_urba_doc_cnig2017
--   IS 'Donnée alphanumérique sur la disponibilité des documents numériques ou papiers à Oise-la-Vallée ou au Parc naturel régional Oise-Pays de France, le gestionnaire des données dans la base';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_doc_cnig2017.idurba IS 'identifiant du document d''urbanisme';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_doc_cnig2017.l_gest IS 'Type d''organisme qui gère la donnée dans la base (intégration et/ou mise à jour)';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_doc_cnig2017.l_dispon IS 'Niveau de disponibilité le plus élevé des documents numériques';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_doc_cnig2017.l_dispop IS 'Niveau de disponibilité le plus élevé des documents papiers';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_doc_cnig2017.l_datproc IS 'date de lancement de la procédure';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_urba_doc_cnig2017.l_observ IS 'observation';



-- permet d’identifier les zonages prenant en compte l’existence d’un enjeux patrimoine naturel
-- Table: m_urbanisme_doc.an_zone_patnat

-- DROP TABLE m_urbanisme_doc.an_zone_patnat;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.an_zone_patnat_cnig2017
-- (
--   idzone character varying(10), -- fait le lien avec le zonage concerné
--   l_thema character varying(50), -- précise la procédure ou l outil reglementaire principal utilisé pour intégrer les enjeux de patrimoine naturel
--   l_vigilance character varying(3), -- type booléen permet de signaler les zonages nécessitant une vigilance particulière sur la prise en compte réelle des enjeux de patrimoine naturel (oui/non)
--   l_remarque character varying(255), -- permet de préciser toutes informations utiles
--   id_z_patnat serial NOT NULL, -- identifiant unique
--   CONSTRAINT pkey_id_z_patnat_cnig2017 PRIMARY KEY (id_z_patnat)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_zone_patnat_cnig2017
--   OWNER TO olv;
-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.an_zone_patnat_cnig2017
--   IS 'permet de gérer l''intégration des enjeux de patrimoine naturel dans les PLU';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_zone_patnat_cnig2017.idzone IS 'fait le lien avec le zonage concerné';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_zone_patnat_cnig2017.l_thema IS 'précise la procédure ou l outil reglementaire principal utilisé pour intégrer les enjeux de patrimoine naturel';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_zone_patnat_cnig2017.l_vigilance IS 'type booléen permet de signaler les zonages nécessitant une vigilance particulière sur la prise en compte réelle des enjeux de patrimoine naturel (oui/non)';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_zone_patnat_cnig2017.l_remarque IS 'permet de préciser toutes informations utiles ';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_zone_patnat_cnig2017.id_z_patnat IS 'identifiant unique';


-- permet de juger de la prise en compte global des enjeux patrimoine naturel par le document d’urbanisme 
-- Table: m_urbanisme_doc.an_doc_patnat

-- DROP TABLE m_urbanisme_doc.an_doc_patnat;
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.an_doc_patnat_cnig2017
-- (
--   idurba character varying(30), -- fait le lien avec le document concerné
--   l_prisencompte character varying(150), -- précise le niveau de prise en compte des enjeux de patrimoine naturel par le PLU
--   l_notesynth bigint, -- note globale pour apprecier la prise en compte des enjeux (de 1 à 4)
--   l_comment character varying(255), -- permet de préciser toutes informations utiles
--   id_d_patnat serial NOT NULL, -- identifiant unique
--   CONSTRAINT pkey_id_d_patnat_cnig2017 PRIMARY KEY (id_d_patnat)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_patnat_cnig2017
--   OWNER TO olv;
-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.an_doc_patnat_cnig2017
--   IS 'permet de gérer intégration des enjeux de patrimoine naturel dans les PLU';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_patnat_cnig2017.idurba IS 'fait le lien avec le document concerné';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_patnat_cnig2017.l_prisencompte IS 'précise le niveau de prise en compte des enjeux de patrimoine naturel par le PLU';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_patnat_cnig2017.l_notesynth IS 'note globale pour apprecier la prise en compte des enjeux (de 1 à 4)';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_patnat_cnig2017.l_comment IS 'permet de préciser toutes informations utiles ';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_doc_patnat_cnig2017.id_d_patnat IS 'identifiant unique';


-- création de la table permettant de noter les différents changements réalisés sur la base (qui, quand, pourquoi)
-- 
-- CREATE TABLE m_urbanisme_doc_cnig2017.an_suivi_maj_cnig2017
-- (
--   l_structure character varying(100) DEFAULT 'NR'::character varying, -- nom de la structure
--   l_operateur character varying(100) DEFAULT 'NR'::character varying, -- nom de la personne responsable des modifications
--   l_comment text DEFAULT 'NR'::text, -- précision concernant les modifications réalisés
--   idmaj serial NOT NULL, -- identifiant unique
--   l_datmaj timestamp without time zone DEFAULT now(),
--   CONSTRAINT pkey_id_z_idmaj_cnig2017 PRIMARY KEY (idmaj)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_suivi_maj_cnig2017
--   OWNER TO olv;
-- GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_suivi_maj_cnig2017 TO olv;
-- GRANT SELECT, UPDATE, INSERT, DELETE, REFERENCES, TRIGGER ON TABLE m_urbanisme_doc_cnig2017.an_suivi_maj_cnig2017 TO sig WITH GRANT OPTION;
-- GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.an_suivi_maj_cnig2017 TO public;
-- COMMENT ON TABLE m_urbanisme_doc_cnig2017.an_suivi_maj_cnig2017
--   IS 'table permettant de noter toute modification sur la base (données et structure)';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_suivi_maj_cnig2017.l_structure IS 'nom de la structure ';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_suivi_maj_cnig2017.l_operateur IS 'nom de la personne responsable des modifications';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_suivi_maj_cnig2017.l_comment IS 'précision concernant les modifications réalisées';
-- COMMENT ON COLUMN m_urbanisme_doc_cnig2017.an_suivi_maj_cnig2017.idmaj IS 'identifiant unique';


-- ajout du champ l_datmaj dans la structure existante

-- création du champs l_datmaj chargé de conserver la date de la dernière modification effectuée
-- 
-- alter table m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.an_doc_patnat_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.an_doc_urba_doc_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.an_doc_urb_cnig2017a add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.an_zone_patnat_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.an_doc_urba_com_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017 add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017 add column l_datmaj timestamp ;


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                           FKEY (clé étrangère)                                                               ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- Table: m_urbanisme_doc.an_doc_urba

ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017
ADD CONSTRAINT lt_etat_cnig2017_fkey FOREIGN KEY (etat)
      REFERENCES m_urbanisme_doc_cnig2017.lt_etat_cnig2017 (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typedoc_cnig2017_fkey FOREIGN KEY (typedoc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typedoc_cnig2017 (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typeref_cnig2017_fkey FOREIGN KEY (typeref)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeref_cnig2017 (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_nomproc_cnig2017_fkey FOREIGN KEY (nomproc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_nomproc_cnig2017 (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_p_zone_urba

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017
ADD CONSTRAINT lt_typezone_cnig2017_fkey FOREIGN KEY (typezone)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typezone_cnig2017 (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_destdomi_cnig2017_fkey FOREIGN KEY (l_destdomi)
      REFERENCES m_urbanisme_doc_cnig2017.lt_destdomi_cnig2017 (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typesect_cnig2017_fkey FOREIGN KEY (typesect)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typesect_cnig2017 (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_p_prescription_surf

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017
ADD CONSTRAINT lt_typepsc_surf_cnig2017_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_p_prescription_lin

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017
ADD CONSTRAINT lt_typepsc_lin_cnig2017_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_p_prescription_pct

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017
ADD CONSTRAINT lt_typepsc_pct_cnig2017_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_p_info_surf

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017
ADD CONSTRAINT lt_typeinf_surf_cnig2017_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc.geo_p_info_lin

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017
ADD CONSTRAINT lt_typeinf_lin_cnig2017_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_p_info_pct

ALTER TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017
ADD CONSTRAINT lt_typeinf_pct_cnig2017_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

    
-- Table: m_urbanisme_doc.geo_a_zone_urba

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017
ADD CONSTRAINT lt_typezone_cnig2017_fkey FOREIGN KEY (typezone)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typezone_cnig2017 (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_destdomi_cnig2017_fkey FOREIGN KEY (l_destdomi)
      REFERENCES m_urbanisme_doc_cnig2017.lt_destdomi_cnig2017 (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typesect_cnig2017_fkey FOREIGN KEY (typesect)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typesect_cnig2017 (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_a_prescription_surf

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017
ADD CONSTRAINT lt_typepsc_surf_cnig2017_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_a_prescription_lin

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017
ADD CONSTRAINT lt_typepsc_lin_cnig2017_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_a_prescription_pct

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017
ADD CONSTRAINT lt_typepsc_pct_cnig2017_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_a_info_surf

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017
ADD CONSTRAINT lt_typeinf_surf_cnig2017_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc.geo_a_info_lin

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017
ADD CONSTRAINT lt_typeinf_lin_cnig2017_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_a_info_pct

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017
ADD CONSTRAINT lt_typeinf_pct_cnig2017_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;  


-- Table: m_urbanisme_doc.geo_t_zone_urba

ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017
ADD CONSTRAINT lt_typezone_cnig2017_fkey FOREIGN KEY (typezone)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typezone_cnig2017 (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_destdomi_cnig2017_fkey FOREIGN KEY (l_destdomi)
      REFERENCES m_urbanisme_doc_cnig2017.lt_destdomi_cnig2017 (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typesect_cnig2017_fkey FOREIGN KEY (typesect)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typesect_cnig2017 (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_t_prescription_surf

ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017
ADD CONSTRAINT lt_typepsc_surf_cnig2017_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_t_prescription_lin

ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017
ADD CONSTRAINT lt_typepsc_lin_cnig2017_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_t_prescription_pct

ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017
ADD CONSTRAINT lt_typepsc_pct_cnig2017_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_t_info_surf

ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017
ADD CONSTRAINT lt_typeinf_surf_cnig2017_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc.geo_t_info_lin

ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017
ADD CONSTRAINT lt_typeinf_lin_cnig2017_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_t_info_pct

ALTER TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017
ADD CONSTRAINT lt_typeinf_pct_cnig2017_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017 (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;  


-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Clé étrangère des tables spécifiques métiers au PNR et OLV
-- A décommenter pour intégration (à vérifier au préalable par le PNR et OLV)
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Table: m_urbanisme_doc.an_doc_urba_doc
-- 
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_urba_doc_cnig2017
-- ADD CONSTRAINT dispon_fkey_cnig2017 FOREIGN KEY (l_dispon)
--       REFERENCES m_urbanisme_doc_cnig2017.lt_dispon_cnig2017 (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION,
-- ADD CONSTRAINT dispop_fkey_cnig2017 FOREIGN KEY (l_dispop)
--       REFERENCES m_urbanisme_doc_cnig2017.lt_dispop_cnig2017 (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc.an_zone_patnat
-- 
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_zone_patnat_cnig2017
--   ADD CONSTRAINT lt_l_themapatnat_fkey_cnig2017 FOREIGN KEY (l_thema)
--       REFERENCES m_urbanisme_doc_cnig2017.lt_l_themapatnat_cnig2017 (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;
-- 
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_zone_patnat_cnig2017
--   ADD CONSTRAINT lt_l_vigipatnat_fkey_cnig2017 FOREIGN KEY (l_vigilance)
--       REFERENCES m_urbanisme_doc_cnig2017.lt_l_vigipatnat_cnig2017 (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.an_doc_patnat
-- 
-- ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_patnat_cnig2017
--   ADD CONSTRAINT lt_l_pecpatnat_fkey_cnig2017 FOREIGN KEY (l_prisencompte)
--       REFERENCES m_urbanisme_doc_cnig2017.lt_l_pecpatnat_cnig2017 (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;

-- ALTER TABLE m_urbanisme_doc_cnig2017.an_doc_patnat_cnig2017
--   ADD CONSTRAINT lt_l_nspatnat_fkey_cnig2017 FOREIGN KEY (l_notesynth)
--       REFERENCES m_urbanisme_doc_cnig2017.lt_l_nspatnat_cnig2017 (code) MATCH SIMPLE
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
-- Migration de la table an_doc_urba
-- Prise en compte de l'implémentation de l'idurba
-- Réaffectation de la codification des versions (ATTENTION : le champ l_version doit-être nettoyée avant la migration pour contenir les valeurs présentes dans ce code, sinon il faut l'adapter
-- Implémentation du champ urlpe par reconstruction du lien (ATTENTION : modifier l'adresse par chaque organisme pour ces communes)
-- Formatage de la dateref au 1er janvier de l'année si une année a été renseignée (le modèle contraint un format de date et non-null, le non-null n'a pas été pris en compte dans la table (à l'export il le faudra)
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017 (idurba,typedoc,etat,nomproc,l_nomprocn,datappro,datefin,siren,nomreg,urlreg,nomplan,urlplan,urlpe,siteweb,typeref,dateref,l_moa_proc,l_moe_proc,l_moa_dmat,l_moe_dmat,l_observ,l_parent) 
SELECT
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
left(idurba,5) || '_' || typedoc || '_' || CASE WHEN (datappro is not null or datappro <> '' ) THEN right(datappro,8) ELSE '999999' END as idurba,
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
l_moa_proc,
l_moe_proc,
l_moa_dmat,
l_moe_dmat,
l_observ,
l_parent
FROM m_urbanisme_doc.an_doc_urba;


-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table an_doc_urba_com
-- Prise en compte de l'implémentation de l'idurba
-- Suppression du champ l_secteur
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.an_doc_urba_com_cnig2017 (idurba,insee) 
SELECT
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
left(idurba,5) || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where a.idurba = an_doc_urba_com.idurba) || '_' || right(idurba,8) as idurba,
insee
FROM m_urbanisme_doc.an_doc_urba_com;


-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_p_zone_urba
-- Prise en compte de l'implémentation de l'idurba
-- Intégration du changement de codification des types de zone pour les secteur s Nh, Nd et Ah en N et A
-- Mise en champ libre des champs (Insee, destdomi)
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017 (idzone,libelle,libelong,typezone,nomfic,urlfic,idurba,datvalid,typesect,fermreco,l_destdomi,l_insee,l_surf_cal,l_observ,geom)
SELECT 
idzone,
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
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_zone_urba.insee || geo_p_zone_urba.datappro ) || '_' || datappro as idurba,
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom,geom1)
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
	WHEN l_typepsc2 = '05-03' THEN '02'
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
	WHEN typepsc = '21' THEN '06'
	WHEN l_typepsc2 = '24-01' THEN '01'
	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 END as stypepsc,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_prescription_surf.insee || geo_p_prescription_surf.datappro ) || '_' || datappro as idurba,
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
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

 	WHEN l_typepsc2 = '07-05' THEN '01'
 	WHEN l_typepsc2 = '07-02' THEN '01'
 	WHEN l_typepsc2 = '07-03' THEN '04'
 	WHEN l_typepsc2 = '07-10' THEN '04'
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
        WHEN l_typepsc2 = '21-02' THEN '06'
        WHEN l_typepsc2 = '21-01' THEN '04'
 	WHEN l_typepsc2 = '24-01' THEN '01'
 	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN l_typepsc2 = '99-02' THEN '00'
 	WHEN l_typepsc2 = '99-01' THEN '06'
 END as stypepsc,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_prescription_lin.insee || geo_p_prescription_lin.datappro ) || '_' || datappro as idurba,
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
FROM m_urbanisme_doc.geo_p_prescription_lin ;


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_p_prescription_pct
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des prescriptions (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC. Chaque organisme doit adapté
-- cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
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
 	WHEN l_typepsc2 = '07-01' THEN '04'
 	WHEN l_typepsc2 = '07-08' THEN '02'
   	WHEN l_typepsc2 = '07-05' THEN '01'
   	WHEN l_typepsc2 = '07-02' THEN '01'
   	WHEN l_typepsc2 = '07-11' THEN '04'
	WHEN l_typepsc2 = '07-06' THEN '01'
        WHEN typepsc = '07' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '11-07' THEN '00'
 	WHEN typepsc = '16' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
        WHEN l_typepsc2 = '21-03' THEN '03'
   	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 END as stypepsc,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_prescription_pct.insee || geo_p_prescription_pct.datappro ) || '_' || datappro as idurba,
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom,geom1)
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
	WHEN l_typeinf2 = '19-04' THEN '02'
	WHEN l_typeinf2 = '19-09' THEN '01'
	WHEN l_typeinf2 = '19-08' THEN '01'
	WHEN typeinf = '99' and (l_typeinf2 ='' or l_typeinf2 is null) THEN '00'
	WHEN l_typeinf2 = '99-01' THEN '00'
 END as stypeinf,
nomfic,
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_info_surf.insee || geo_p_info_surf.datappro ) || '_' || datappro as idurba,
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom,geom1)
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
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_info_surf.insee || geo_p_info_surf.datappro ) || '_' || datappro as idurba,
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom,geom1)
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
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition de l'idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_info_surf.insee || geo_p_info_surf.datappro ) || '_' || datappro as idurba,
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017 (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom)
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
urlfic,
-- recomposition du champ idurba
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_info_lin.insee || geo_p_info_lin.datappro ) || '_' || datappro as idurba,
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017 (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom)
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
urlfic,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_info_pct.insee || geo_p_info_pct.datappro ) || '_' || datappro as idurba,
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017 (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
SELECT 
idhab,
-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- pas de cas particulier à l'ARC devant être migré pour le champ nattrac
nattrac,
''::character varying(11) as couleur,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_habillage_surf.insee || geo_p_habillage_surf.datappro ) || '_' || datappro as idurba,
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017 (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
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
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_habillage_lin.insee || geo_p_habillage_lin.datappro ) || '_' || datappro as idurba,
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017 (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
SELECT 
idhab,
-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- pas de cas particulier à l'ARC devant être migré pour le champ nattrac
nattrac,
''::character varying(11) as couleur,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- recomposition du champ idurba
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_habillage_pct.insee || geo_p_habillage_pct.datappro ) || '_' || datappro as idurba,
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017 (idhab,natecr,txt,police,taille,style,couleur,angle,idurba,l_insee,l_couleur,geom)
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
insee || '_' || (select typedoc from m_urbanisme_doc.an_doc_urba a where left(a.idurba,5) || a.datappro = geo_p_habillage_txt.insee || geo_p_habillage_txt.datappro ) || '_' || datappro as idurba,
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017 (idzone,libelle,libelong,typezone,nomfic,urlfic,idurba,datvalid,typesect,fermreco,l_destdomi,l_insee,l_surf_cal,l_observ,geom,gid)
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


-- Sequence: m_urbanisme_doc.geo_a_zone_urba_gid_seq
-- DROP SEQUENCE m_urbanisme_doc.geo_a_zone_urba_gid_seq;

CREATE SEQUENCE m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017_gid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 4434
  CACHE 1;
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017
  OWNER TO postgres;
GRANT ALL ON SEQUENCE m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017_gid_seq TO postgres;
GRANT ALL ON SEQUENCE m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017_gid_seq TO groupe_sig;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017 ALTER COLUMN gid SET DEFAULT nextval('m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017_gid_seq'::regclass);


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_a_prescription_surf
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des prescriptions (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC. Chaque organisme doit adapté
-- cette grille en fonction des cas supplémentaires présents dans ces données
-- Intégration du champ GID (à supprimer pour les organismes ne le gértant pas ici)
-- Création de la séquence sur le champ GID et modification du champ GID intégrant la séquence (peut-être mis en commentaire par les partenaires si non utilisées)
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom,gid)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription _surf_cnig2017
CASE
	WHEN typepsc = '09' THEN '05'
	WHEN typepsc = '11' THEN '15'
	WHEN typepsc = '12' THEN '05' 
	WHEN typepsc = '21' THEN '05'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription _surf_cnig2017
CASE
	WHEN l_typepsc2 = '01-03' THEN '00'
	WHEN typepsc = '01' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '02' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN l_typepsc2 = '05-02' THEN '01'
	WHEN l_typepsc2 = '05-06' THEN '04'
	WHEN l_typepsc2 = '05-03' THEN '02'
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
        WHEN l_typepsc2 = '11-07' THEN '00'
        WHEN l_typepsc2 = '11-04' THEN '00'
        WHEN l_typepsc2 = '11-01' THEN '01'
        WHEN typepsc = '12' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '07'
	WHEN typepsc = '14' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '15' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
	WHEN typepsc = '16' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
	WHEN typepsc = '17' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '18' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN typepsc = '21' THEN '06'
        WHEN l_typepsc2 = '21-02' THEN '06'
        WHEN l_typepsc2 = '21-01' THEN '04'
	WHEN l_typepsc2 = '21-03' THEN '03'
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


-- Sequence: m_urbanisme_doc.geo_a_prescription_surf_gid_seq

-- DROP SEQUENCE m_urbanisme_doc.geo_a_prescription_surf_gid_seq;

CREATE SEQUENCE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017_gid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 7156
  CACHE 1;
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017_gid_seq
  OWNER TO postgres;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017 ALTER COLUMN gid SET DEFAULT nextval('m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017_gid_seq'::regclass);


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_a_prescription_lin
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des prescriptions (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC. Chaque organisme doit adapté
-- cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription_lin_cnig2017
CASE
	WHEN typepsc = '11' and l_typepsc2 <> '11-07' and l_typepsc2 <> '11-08' THEN '15'
        WHEN typepsc = '11' and l_typepsc2 = '11-07' THEN '39'
	WHEN typepsc = '11' and l_typepsc2 = '11-08' THEN '41'
 	WHEN typepsc = '21' THEN '05'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription_lin_cnig2017
CASE

 	WHEN l_typepsc2 = '07-05' THEN '01'
 	WHEN l_typepsc2 = '07-02' THEN '01'
 	WHEN l_typepsc2 = '07-03' THEN '04'
 	WHEN l_typepsc2 = '07-10' THEN '04'
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
        WHEN l_typepsc2 = '21-02' THEN '06'
        WHEN l_typepsc2 = '21-01' THEN '04'
	WHEN l_typepsc2 = '21-03' THEN '03'
 	WHEN l_typepsc2 = '24-01' THEN '01'
 	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN l_typepsc2 = '99-02' THEN '00'
 	WHEN l_typepsc2 = '99-01' THEN '06'
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


-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_a_prescription_pct
-- Prise en compte de l'implémentation de l'idurba
-- Mise en champ libre du champ (Insee)
-- Migration des anciens vers les nouveaux codes et sous-code des prescriptions (ATTENTION : la grille de correspondance intégrée ici correspond au cas présent dans les données de l'ARC. Chaque organisme doit adapté
-- cette grille en fonction des cas supplémentaires présents dans ces données
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription_pct_cnig2017
CASE
	WHEN typepsc = '11' and l_typepsc2 <> '11-07' and l_typepsc2 <> '11-08' THEN '15'
        WHEN typepsc = '11' and l_typepsc2 = '11-07' THEN '39'
	WHEN typepsc = '11' and l_typepsc2 = '11-08' THEN '41'
  	WHEN typepsc = '21' THEN '05'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_prescription_pct_cnig2017
CASE
 	WHEN l_typepsc2 = '07-01' THEN '04'
 	WHEN l_typepsc2 = '07-08' THEN '02'
   	WHEN l_typepsc2 = '07-05' THEN '01'
   	WHEN l_typepsc2 = '07-02' THEN '01'
   	WHEN l_typepsc2 = '07-11' THEN '04'
        WHEN typepsc = '07' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '11-07' THEN '00'
 	WHEN typepsc = '16' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
	WHEN typepsc = '21' THEN '06'
        WHEN l_typepsc2 = '21-03' THEN '03'
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom,gid)
SELECT 
idinf,
libelle,
txt,
typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_info_surf_cnig2017
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


-- Sequence: m_urbanisme_doc.geo_a_info_surf_gid_seq

-- DROP SEQUENCE m_urbanisme_doc.geo_a_info_surf_gid_seq;

CREATE SEQUENCE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017_gid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 686
  CACHE 1;
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017_gid_seq
  OWNER TO postgres;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 ALTER COLUMN gid SET DEFAULT nextval('m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017_gid_seq'::regclass);



-- COMMENT GB : --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration des données informations vers les données prescriptions (06 info vers 03 00 psc)
-- ATTENTION : certaines informations sont reversées dans les prescriptions dans le nouveau modèle CNIG. Ici n'est présent que les cas rencontrés pour les donnes de l'ARC sur le Pays Compiègnois.
-- Chaque organisme adapté le code ci-après en fonction de ces données
-- Chaque basculement génère une requête de migration, pour l'ARC, 2 requêtes dupliquées et adaptées
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017 (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idinf,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_info_lin_cnig2017
CASE
	WHEN typeinf = '' THEN ''

ELSE
typeinf END  as typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_info_lin_cnig2017
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017 (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idinf,
libelle,
txt,
typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- même principe de migration que la table geo_p_info_pct_cnig2017
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017 (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017 (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017 (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017 (idhab,natecr,txt,police,taille,style,couleur,angle,idurba,l_insee,l_couleur,geom,gid)
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


-- Sequence: m_urbanisme_doc.geo_a_habillage_txt_gid_seq

-- DROP SEQUENCE m_urbanisme_doc.geo_a_habillage_txt_gid_seq;

CREATE SEQUENCE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017_gid_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 7817
  CACHE 1;
ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017_gid_seq
  OWNER TO postgres;
GRANT ALL ON SEQUENCE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017_gid_seq TO postgres;
GRANT ALL ON SEQUENCE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017_gid_seq TO groupe_sig;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017 ALTER COLUMN gid SET DEFAULT nextval('m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017_gid_seq'::regclass);


-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Migration de la table geo_t_zone_urba
-- Prise en compte de l'implémentation de l'idurba
-- Intégration du changement de codification des types de zone pour les secteur s Nh, Nd et Ah en N et A
-- Mise en champ libre des champs (Insee, destdomi)
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017 (idzone,libelle,libelong,typezone,nomfic,urlfic,idurba,datvalid,typesect,fermreco,l_destdomi,l_insee,l_surf_cal,l_observ,geom)
SELECT 
idzone,
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_surf_cnig2017
CASE
	WHEN typepsc = '09' THEN '05'
	WHEN typepsc = '11' THEN '15'
	WHEN typepsc = '12' THEN '05' 
	WHEN typepsc = '21' THEN '05'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_surf_cnig2017
CASE
	WHEN l_typepsc2 = '01-03' THEN '00'
	WHEN typepsc = '02' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
	WHEN l_typepsc2 = '05-02' THEN '01'
	WHEN l_typepsc2 = '05-06' THEN '04'
	WHEN l_typepsc2 = '05-03' THEN '02'
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
	WHEN typepsc = '21' THEN '06'
        WHEN l_typepsc2 = '21-01' THEN '04'
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_lin_cnig2017
CASE
	WHEN typepsc = '11' and l_typepsc2 <> '11-07' and l_typepsc2 <> '11-08' THEN '15'
        WHEN typepsc = '11' and l_typepsc2 = '11-07' THEN '39'
	WHEN typepsc = '11' and l_typepsc2 = '11-08' THEN '41'
 	WHEN typepsc = '21' THEN '05'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_lin_cnig2017
CASE

 	WHEN l_typepsc2 = '07-05' THEN '01'
 	WHEN l_typepsc2 = '07-02' THEN '01'
 	WHEN l_typepsc2 = '07-03' THEN '04'
 	WHEN l_typepsc2 = '07-10' THEN '04'
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
        WHEN l_typepsc2 = '21-02' THEN '06'
        WHEN l_typepsc2 = '21-01' THEN '04'
 	WHEN l_typepsc2 = '24-01' THEN '01'
 	WHEN typepsc = '25' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN typepsc = '99' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
 	WHEN l_typepsc2 = '99-02' THEN '00'
 	WHEN l_typepsc2 = '99-01' THEN '06'
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idpsc,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_pct_cnig2017
CASE
	WHEN typepsc = '11' and l_typepsc2 <> '11-07' and l_typepsc2 <> '11-08' THEN '15'
        WHEN typepsc = '11' and l_typepsc2 = '11-07' THEN '39'
	WHEN typepsc = '11' and l_typepsc2 = '11-08' THEN '41'
  	WHEN typepsc = '21' THEN '05'
ELSE
typepsc END  as typepsc,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_pct_cnig2017
CASE
 	WHEN l_typepsc2 = '07-01' THEN '04'
 	WHEN l_typepsc2 = '07-08' THEN '02'
   	WHEN l_typepsc2 = '07-05' THEN '01'
   	WHEN l_typepsc2 = '07-02' THEN '01'
   	WHEN l_typepsc2 = '07-11' THEN '04'
        WHEN typepsc = '07' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '00'
        WHEN l_typepsc2 = '11-07' THEN '00'
 	WHEN typepsc = '16' and (l_typepsc2 ='' or l_typepsc2 is null) THEN '01'
        WHEN l_typepsc2 = '21-03' THEN '03'
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017 (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idinf,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_info_surf_cnig2017
CASE
	WHEN typeinf = '' THEN ''

ELSE
typeinf END  as typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_info_surf_cnig2017
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
INSERT INTO m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_surf_cnig2017
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
INSERT INTO m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017 (idpsc,libelle,txt,typepsc,stypepsc,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_nature,l_bnfcr,l_numero,l_surf_txt,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_prescription_surf_cnig2017
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017 (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idinf,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_info_lin_cnig2017
CASE
	WHEN typeinf = '' THEN ''

ELSE
typeinf END  as typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_info_lin_cnig2017
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017 (idinf,libelle,txt,typeinf,stypeinf,nomfic,urlfic,idurba,datvalid,l_insee,l_nom,l_dateins,l_bnfcr,l_datdlg,l_gen,l_valrecul,l_typrecul,l_observ,geom)
SELECT 
idinf,
libelle,
txt,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_info_pct_cnig2017
CASE
	WHEN typeinf = '' THEN ''

ELSE
typeinf END  as typeinf,
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Même principe que geo_p_info_pct_cnig2017
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017 (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017 (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017 (idhab,nattrac,couleur,idurba,l_insee,l_couleur,geom)
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

INSERT INTO m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017 (idhab,natecr,txt,police,taille,style,couleur,angle,idurba,l_insee,l_couleur,geom)
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
UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017 set nomfic = 
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


-- LINEAIRE
UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017 set nomfic = 
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

-- PONCTUELLE
-- pas de cas à l'arc


-- INFORMATION (production)
-- SURFACIQUE
UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 set nomfic = 
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

UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 set nomfic = 
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

-- PONCTUELLE
-- pas de cas à l'arc

-- INFORMATION (test)
-- SURFACIQUE
UPDATE m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017 set nomfic = 
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

-- PONCTUELLE
-- pas de cas à l'arc

-- INFORMATION (archive)
-- SURFACIQUE
UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 set nomfic = 
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
UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 set nomfic = 
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

-- PONCTUELLE
-- pas de cas à l'arc



-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Mise à jour des liens des fichiers nomfic et urlfic pour les règlements de ZAC (uniquement pour l'ARC)
-- ----------------------------------------------------------------------------------------------------------------------------------------------------

-- Table PRODUCTION
UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 set 
nomfic = '60023_info_surf_02_00_20171221.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60023_POS_20171221/Pieces_ecrites/4_Annexes/60023_info_surf_02_00_20171221.pdf'
WHERE nomfic = 'reglement_ZI_Armancourt_20001002.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 set 
nomfic = '60665_info_surf_02_00_1_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_1_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Prairie_19990706.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 set 
nomfic = '60665_info_surf_02_00_2_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_2_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Jaux-Venette_19860725.pdf' AND left(idinf,5) = '60665';

UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 set 
nomfic = '60665_info_surf_02_00_3_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_3_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Camp_du_Roy_19960126.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 set 
nomfic = '60325_info_surf_02_00_20140307.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60325_PLU_20140307/Pieces_ecrites/4_Annexes/60325_info_surf_02_00_20140307.pdf'
WHERE nomfic = 'reglement_ZAC_Jaux-Venette_19860725.pdf' AND left(idinf,5) = '60325';

-- Table ARCHIVE
UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 set 
nomfic = '60023_info_surf_02_00_20171221.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60023_POS_20171221/Pieces_ecrites/4_Annexes/60023_info_surf_02_00_20171221.pdf'
WHERE nomfic = 'reglement_ZI_Armancourt_20001002.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 set 
nomfic = '60665_info_surf_02_00_1_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_1_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Prairie_19990706.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 set 
nomfic = '60665_info_surf_02_00_2_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_2_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Jaux-Venette_19860725.pdf' AND left(idinf,5) = '60665';

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 set 
nomfic = '60665_info_surf_02_00_3_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_3_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Camp_du_Roy_19960126.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 set 
nomfic = '60325_info_surf_02_00_20140307.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60325_PLU_20140307/Pieces_ecrites/4_Annexes/60325_info_surf_02_00_20140307.pdf'
WHERE nomfic = 'reglement_ZAC_Jaux-Venette_19860725.pdf' AND left(idinf,5) = '60325';

-- Table TEST
UPDATE m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017 set 
nomfic = '60023_info_surf_02_00_20171221.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60023_POS_20171221/Pieces_ecrites/4_Annexes/60023_info_surf_02_00_20171221.pdf'
WHERE nomfic = 'reglement_ZI_Armancourt_20001002.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017 set 
nomfic = '60665_info_surf_02_00_1_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_1_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Prairie_19990706.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017 set 
nomfic = '60665_info_surf_02_00_2_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_2_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Jaux-Venette_19860725.pdf' AND left(idinf,5) = '60665';

UPDATE m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017 set 
nomfic = '60665_info_surf_02_00_3_20141120.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60665_POS_20141120/Pieces_ecrites/4_Annexes/60665_info_surf_02_00_3_20141120.pdf'
WHERE nomfic = 'reglement_ZAC_Camp_du_Roy_19960126.pdf';

UPDATE m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017 set 
nomfic = '60325_info_surf_02_00_20140307.pdf',
urlfic = 'http://geo.compiegnois.fr/documents/metiers/urba/docurba/60325_PLU_20140307/Pieces_ecrites/4_Annexes/60325_info_surf_02_00_20140307.pdf'
WHERE nomfic = 'reglement_ZAC_Jaux-Venette_19860725.pdf' AND left(idinf,5) = '60325';


-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Mise à jour du répertoire contenant les prescriptions (4_Annexes par 3_Reglement)
-- ----------------------------------------------------------------------------------------------------------------------------------------------------

-- Table PRODUCTION
UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017 set 
urlfic = replace(urlfic,'4_Annexes','3_Reglement');

UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017 set 
urlfic = replace(urlfic,'4_Annexes','3_Reglement');

UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017 set 
urlfic = replace(urlfic,'4_Annexes','3_Reglement');


-- Table ARCHIVE
UPDATE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017 set 
urlfic = replace(urlfic,'4_Annexes','3_Reglement');

UPDATE m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017 set 
urlfic = replace(urlfic,'4_Annexes','3_Reglement');

UPDATE m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017 set 
urlfic = replace(urlfic,'4_Annexes','3_Reglement');


-- Table TEST
UPDATE m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017 set 
urlfic = replace(urlfic,'4_Annexes','3_Reglement');

UPDATE m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017 set 
urlfic = replace(urlfic,'4_Annexes','3_Reglement');

UPDATE m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017 set 
urlfic = replace(urlfic,'4_Annexes','3_Reglement');


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                      RENOMMAGE                                                               ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################



-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- RENNOMAGE DES NOUVELLES TABLES _CNIG2017 sans le suffixe (hors table spécifique PNR-OLV)
-- ----------------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.an_doc_urba_cnig2017 rename to an_doc_urba;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.an_doc_urba_com_cnig2017 rename to an_doc_urba_com;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2017 rename to geo_a_habillage_lin;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2017 rename to geo_a_habillage_pct;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2017 rename to geo_a_habillage_surf;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017 rename to geo_a_habillage_txt;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2017 rename to geo_a_info_lin;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2017 rename to geo_a_info_pct;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017 rename to geo_a_info_surf;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2017 rename to geo_a_prescription_lin;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2017 rename to geo_a_prescription_pct;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017 rename to geo_a_prescription_surf;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017 rename to geo_a_zone_urba;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2017 rename to geo_p_habillage_lin;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2017 rename to geo_p_habillage_pct;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2017 rename to geo_p_habillage_surf;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2017 rename to geo_p_habillage_txt;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2017 rename to geo_p_info_lin;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2017 rename to geo_p_info_pct;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2017 rename to geo_p_info_surf;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2017 rename to geo_p_prescription_lin;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2017 rename to geo_p_prescription_pct;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2017 rename to geo_p_prescription_surf;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2017 rename to geo_p_zone_urba;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2017 rename to geo_t_habillage_lin;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2017 rename to geo_t_habillage_pct;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2017 rename to geo_t_habillage_surf;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2017 rename to geo_t_habillage_txt;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2017 rename to geo_t_info_lin;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2017 rename to geo_t_info_pct;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2017 rename to geo_t_info_surf;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2017 rename to geo_t_prescription_lin;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2017 rename to geo_t_prescription_pct;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2017 rename to geo_t_prescription_surf;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2017 rename to geo_t_zone_urba;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_destdomi_cnig2017 rename to lt_destdomi;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_etat_cnig2017 rename to lt_etat;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_libsect_cnig2017 rename to lt_libsect;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_typedoc_cnig2017 rename to lt_typedoc;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_typeinf_cnig2017 rename to lt_typeinf;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_typepsc_cnig2017 rename to lt_typepsc;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_typeref_cnig2017 rename to lt_typeref;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_typesect_cnig2017 rename to lt_typesect;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_typezone_cnig2017 rename to lt_typezone;
ALTER TABLE IF EXISTS m_urbanisme_doc_cnig2017.lt_nomproc_cnig2017 rename to lt_nomproc;

-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Rennomage des séquences créées
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
ALTER SEQUENCE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2017_gid_seq rename to geo_a_habillage_txt_gid_seq;
ALTER SEQUENCE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2017_gid_seq rename to geo_a_info_surf_gid_seq;
ALTER SEQUENCE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2017_gid_seq rename to geo_a_prescription_surf_gid_seq;
ALTER SEQUENCE IF EXISTS m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2017_gid_seq rename to geo_a_zone_urba_gid_seq;


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     TRIGGER                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ####################################################### FONCTION TRIGGER - update_geom #############################################################

-- COMMENT GB : ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Cette fonction est spécifique à l'ARC et permet de calculer le champ geom1 (doit-être mis en commentaire pour l'intégration par les autres organismes
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Function: m_urbanisme_doc.an_doc_urba_null()

-- DROP FUNCTION m_urbanisme_doc.an_doc_urba_null();

CREATE OR REPLACE FUNCTION m_urbanisme_doc_cnig2017.an_doc_urba_null()
  RETURNS trigger AS
$BODY$BEGIN
	update m_urbanisme_doc_cnig2017.an_doc_urba set datefin=null where datefin='';
	update m_urbanisme_doc_cnig2017.an_doc_urba set nomproc=null where nomproc='';
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
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.an_doc_urba_null() TO postgres;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.an_doc_urba_null() TO public;
COMMENT ON FUNCTION m_urbanisme_doc_cnig2017.an_doc_urba_null() IS 'Fonction remplaçant les '' par null lors de la mise à jour ou de l''insertion via le module web de gestion PNR/OLV';


-- Trigger: t_t1_r_null_an_doc_urba on m_urbanisme_doc.an_doc_urba

-- DROP TRIGGER t_t1_r_null_an_doc_urba ON m_urbanisme_doc.an_doc_urba;

CREATE TRIGGER t_t1_r_null_an_doc_urba
  AFTER INSERT OR UPDATE
  ON m_urbanisme_doc_cnig2017.an_doc_urba
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc_cnig2017.an_doc_urba_null();


-- Function: m_urbanisme_doc.m_geom1_prescription_surf()

-- DROP FUNCTION m_urbanisme_doc.m_geom1_prescription_surf();

CREATE OR REPLACE FUNCTION m_urbanisme_doc_cnig2017.m_geom1_prescription_surf()
  RETURNS trigger AS
$BODY$BEGIN

 UPDATE m_urbanisme_doc_cnig2017.geo_p_prescription_surf SET geom1 = st_multi(st_buffer(geom,-0.5));


RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc_cnig2017.m_geom1_prescription_surf()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_geom1_prescription_surf() TO postgres;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_geom1_prescription_surf() TO groupe_sig;


-- Trigger: update_geom on m_urbanisme_doc.geo_p_prescription_surf

-- DROP TRIGGER update_geom ON m_urbanisme_doc.geo_p_prescription_surf;

CREATE TRIGGER update_geom
  AFTER INSERT OR UPDATE OF geom
  ON m_urbanisme_doc_cnig2017.geo_p_prescription_surf
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc_cnig2017.m_geom1_prescription_surf();


-- Function: m_urbanisme_doc.m_geom1_information_surf()

-- DROP FUNCTION m_urbanisme_doc.m_geom1_information_surf();

CREATE OR REPLACE FUNCTION m_urbanisme_doc_cnig2017.m_geom1_information_surf()
  RETURNS trigger AS
$BODY$BEGIN

 UPDATE m_urbanisme_doc_cnig2017.geo_p_info_surf SET geom1 = st_multi(st_buffer(geom,-0.5));


RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc_cnig2017.m_geom1_information_surf()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_geom1_information_surf() TO postgres;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_geom1_information_surf() TO groupe_sig;


-- Trigger: update_geom on m_urbanisme_doc.geo_p_info_surf

-- DROP TRIGGER update_geom ON m_urbanisme_doc.geo_p_info_surf;

CREATE TRIGGER update_geom
  AFTER INSERT OR UPDATE OF geom
  ON m_urbanisme_doc_cnig2017.geo_p_info_surf
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc_cnig2017.m_geom1_information_surf();


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
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_l_surf_cal_ha() TO public;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_l_surf_cal_ha() TO postgres;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_cnig2017.m_l_surf_cal_ha() TO groupe_sig WITH GRANT OPTION;
COMMENT ON FUNCTION m_urbanisme_doc_cnig2017.m_l_surf_cal_ha() IS 'Fonction dont l''objet est de mettre à jour la superficie calculée en ha du champ l_surf_cal des zones urba';

-- Trigger: l_surface on m_urbanisme_doc_cnig2017.geo_p_zone_urba

-- DROP TRIGGER l_surface ON m_urbanisme_doc_cnig2017.geo_p_zone_urba

CREATE TRIGGER l_surf_cal
  BEFORE INSERT OR UPDATE OF geom
  ON m_urbanisme_doc_cnig2017.geo_p_zone_urba
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc_cnig2017.m_l_surf_cal_ha();


-- Trigger: l_surface on m_urbanisme_doc.geo_t_zone_urba

-- DROP TRIGGER l_surface ON m_urbanisme_doc.geo_t_zone_urba;

CREATE TRIGGER l_surf_cal
  BEFORE INSERT OR UPDATE OF geom
  ON m_urbanisme_doc_cnig2017.geo_t_zone_urba
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc_cnig2017.m_l_surf_cal_ha();



-- ####################################################################################################################################################
-- ###                                                             TRIGGER SPECIFIQUE PNR-OLV                                                       ###
-- ####################################################################################################################################################

-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Ils n'ont pas été intégrés ici, à recréer à partir du fichier DDU_CNIG201712_etendu_V1.sql et éventuellement à adapter par le PNR et OLV
-- ----------------------------------------------------------------------------------------------------------------------------------------------------



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                           VUES (spécifiques PNR-OLV)                                                         ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Elles n'ont pas été intégrés ici, à recréer à partir du fichier DDU_CNIG201712_etendu_V1.sql et éventuellement à adapter par le PNR et OLV
-- ----------------------------------------------------------------------------------------------------------------------------------------------------


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                          ROLES (spécifiques PNR-OLV)                                                         ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Ils n'ont pas été intégrés ici, à recréer à partir du fichier DDU_CNIG201712_etendu_V1.sql et éventuellement à adapter par le PNR et OLV
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
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_v_controle TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_v_controle TO groupe_sig;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.an_v_controle
  IS 'Vue de contrôle simple sur le nombre d''objets par table avant et après migration. Seules les tables geo_p_info_surf et geo_p_prescription_surf peuvent avoir un décompte différent suite à la migration d''informations vers prescriptions';
 
-- -- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- -- A mettre en commentaire par les partenaires avant intégration
-- -- ----------------------------------------------------------------------------------------------------------------------------------------------------

-- View: m_urbanisme_doc.an_v_docurba_arcba

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
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_arcba TO postgres;
GRANT UPDATE, DELETE, REFERENCES, TRIGGER ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_arcba TO groupe_sig;
GRANT SELECT, INSERT ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_arcba TO groupe_sig WITH GRANT OPTION;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.an_v_docurba_arcba
  IS 'Vue ARC simplifiée de la table an_doc_urba à usage interne.
Ajout nom de la commune et du libellé de l''état du document';

-- View: m_urbanisme_doc.an_v_docurba_cclo

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
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_cclo TO postgres;
GRANT UPDATE, DELETE, REFERENCES, TRIGGER ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_cclo TO groupe_sig;
GRANT SELECT, INSERT ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_cclo TO groupe_sig WITH GRANT OPTION;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.an_v_docurba_cclo
  IS 'Vue CCLO simplifiée de la table an_doc_urba à usage interne.
Ajout nom de la commune et du libellé de l''état du document';


-- View: m_urbanisme_doc.an_v_docurba_ccpe

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
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_ccpe TO postgres;
GRANT UPDATE, DELETE, REFERENCES, TRIGGER ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_ccpe TO groupe_sig;
GRANT SELECT, INSERT ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_ccpe TO groupe_sig WITH GRANT OPTION;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.an_v_docurba_ccpe
  IS 'Vue CCPE simplifiée de la table an_doc_urba à usage interne.
Ajout nom de la commune et du libellé de l''état du document';


-- View: m_urbanisme_doc.an_v_docurba_valide

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_v_docurba_valide;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.an_v_docurba_valide AS 
 SELECT "substring"(an_doc_urba.idurba::text, 1, 5) AS insee,
    an_doc_urba.typedoc,
    to_date(an_doc_urba.datappro::text, 'YYYYMMDD'::text) AS datappro,
    lt_nomproc.valeur ||
    CASE WHEN an_doc_urba.l_nomprocn is null THEN '' ELSE ' n° ' || an_doc_urba.l_nomprocn END as procedure
   FROM m_urbanisme_doc_cnig2017.an_doc_urba, m_urbanisme_doc_cnig2017.lt_nomproc 
  WHERE an_doc_urba.nomproc=lt_nomproc.code AND an_doc_urba.etat = '03'::bpchar
  ORDER BY "substring"(an_doc_urba.idurba::text, 1, 5);

ALTER TABLE m_urbanisme_doc_cnig2017.an_v_docurba_valide
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_valide TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_v_docurba_valide TO groupe_sig;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.an_v_docurba_valide
  IS 'Liste des documents d''urbanisme valide sur les communes du Pays Compiégnois';



-- -- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- -- A partir d'ici changer la destination des vues lors de la mise en production dans x_apps.xapps
-- -- ----------------------------------------------------------------------------------------------------------------------------------------------------

-- Materialized View: m_urbanisme_doc.an_vmr_fichegeo_ruplu1_gdpublic

DROP MATERIALIZED VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu1_gdpublic;

CREATE MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu1_gdpublic AS 
 WITH req_par AS (
         SELECT "substring"(parcelle.parcelle, 5, 15) AS idu,
            '60'::text || "substring"(parcelle.parcelle, 8, 15) AS parcelle,
            '60'::text || parcelle.ccocom AS insee
           FROM r_cadastre.parcelle
        ), req_plu AS (
         SELECT "substring"(an_doc_urba.idurba::text, 1, 5) AS insee,
            to_char(an_doc_urba.datappro::timestamp without time zone, 'dd/mm/YYYY'::text) AS datappro,
            an_doc_urba.typedoc,
            '<font size=2>Ce terrain est soumis aux dispositions '::text ||
                CASE
                    WHEN an_doc_urba.typedoc::text = 'PLU'::text THEN (('du Plan Local d''Urbanisme de la commune de '::text || a.libgeo::text) || '.'::text) || '</font>'::text
                    WHEN an_doc_urba.typedoc::text = 'POS'::text THEN (('du Plan d''Occupation des Sol de la commune de '::text || a.libgeo::text) || '.'::text) || '</font>'::text
                    WHEN an_doc_urba.typedoc::text = 'CC'::text THEN (('de la Carte Communale de la commune de '::text || a.libgeo::text) || '.'::text) || '</font>'::text
                    WHEN an_doc_urba.typedoc::text = 'RNU'::text THEN 'du Réglèment National d''Urbanisme (RNU).</font>'::text
                    ELSE NULL::text
                END AS plu_1
           FROM m_urbanisme_doc_cnig2017.an_doc_urba,
            r_administratif.an_geo a
          WHERE a.insee::text = "substring"(an_doc_urba.idurba::text, 1, 5) AND an_doc_urba.etat = '03'::bpchar
        )
 SELECT row_number() OVER () AS gid,
    req_par.parcelle AS idu,
    req_par.insee,
    req_plu.plu_1
   FROM req_par
     LEFT JOIN req_plu ON req_par.insee = req_plu.insee
WITH DATA;

ALTER TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu1_gdpublic
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu1_gdpublic TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu1_gdpublic TO groupe_sig;
COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu1_gdpublic
  IS 'Vue matérialisée contenant les informations du type de document d''urbanisme pré-formatés pour la constitution de la fiche d''information Renseignements d''urbanisme Version imprimable dans GEO Gd Public';



-- Materialized View: m_urbanisme_doc.an_vmr_fichegeo_ruplu21_gdpublic

DROP MATERIALIZED VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu21_gdpublic;

CREATE MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu21_gdpublic AS 
 WITH req_par AS (
         SELECT "substring"(parcelle.parcelle, 5, 15) AS idu,
            '60'::text || "substring"(parcelle.parcelle, 8, 15) AS parcelle,
            '60'::text || parcelle.ccocom AS insee
           FROM r_cadastre.parcelle
        ), req_zac AS (
         SELECT "PARCELLE"."IDU" AS idu,
            'oui'::text AS zac,
            geo_p_info_surf.urlfic,
            geo_p_info_surf.l_nom
           FROM r_bg_edigeo."PARCELLE",
            m_urbanisme_doc_cnig2017.geo_p_info_surf
          WHERE (geo_p_info_surf.l_insee::text = '60402'::text OR geo_p_info_surf.l_insee::text = '60023'::text OR geo_p_info_surf.l_insee::text = '60665'::text AND geo_p_info_surf.idinf::text <> '60665IS007'::text) 
	  AND geo_p_info_surf.typeinf::text = '02'::text AND st_intersects("PARCELLE"."GEOM", geo_p_info_surf.geom1)
        )
 SELECT row_number() OVER () AS gid,
    req_par.parcelle AS idu,
    req_par.insee,
        CASE
            WHEN req_zac.zac = 'oui'::text THEN 'oui'::text
            ELSE 'non'::text
        END AS zac,
    req_zac.l_nom,
    req_zac.urlfic
   FROM req_par
     LEFT JOIN req_zac ON req_par.parcelle = req_zac.idu::text
WITH DATA;

ALTER TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu21_gdpublic
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu21_gdpublic TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu21_gdpublic TO groupe_sig;
COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu21_gdpublic
  IS 'Vue matérialisée contenant les informations de zonages pour les ZAC pré-formatés pour la constitution de la fiche d''information Renseignements d''urbanisme Version imprimable dans GEO Gd Public';

-- Materialized View: m_urbanisme_doc.an_vmr_fichegeo_ruplu3_gdpublic

DROP MATERIALIZED VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu3_gdpublic;

CREATE MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu3_gdpublic AS 
 WITH req_par AS (
         SELECT "substring"(parcelle.parcelle, 5, 15) AS idu,
            '60'::text || "substring"(parcelle.parcelle, 8, 15) AS parcelle,
            '60'::text || parcelle.ccocom AS insee
           FROM r_cadastre.parcelle,
            r_cadastre.geo_parcelle,
            r_osm.geo_osm_commune
          WHERE parcelle.parcelle = geo_parcelle.geo_parcelle AND geo_osm_commune.insee::text = ('60'::text || "substring"(parcelle.parcelle, 8, 3))
        ), req_ac1 AS (
         SELECT an_sup_geo.idu,
            'oui'::text AS mh
           FROM m_urbanisme_reg.an_sup_geo
          WHERE an_sup_geo.code::text = 'AC1'::text
          GROUP BY an_sup_geo.idu, an_sup_geo.code, an_sup_geo.libelle
        )
 SELECT row_number() OVER () AS gid,
    req_par.parcelle AS idu,
    req_par.insee,
        CASE
            WHEN req_ac1.mh = 'oui'::text THEN 'oui'::text
            ELSE 'non'::text
        END AS mh
   FROM req_par
     LEFT JOIN req_ac1 ON req_ac1.idu::text = req_par.parcelle
WITH DATA;

ALTER TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu3_gdpublic
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu3_gdpublic TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu3_gdpublic TO groupe_sig;
COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu3_gdpublic
  IS 'Vue matérialisée contenant les informations de présence d''un ou plusieurs MH sur la parcelle pour la constitution de la fiche d''information Renseignements d''urbanisme Version imprimable dans GEO Gd Public';

-- Materialized View: m_urbanisme_doc.an_vmr_fichegeo_ruplu4_gdpublic

DROP MATERIALIZED VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu4_gdpublic;

CREATE MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu4_gdpublic AS 
 WITH req_par AS (
         SELECT "substring"(parcelle.parcelle, 5, 15) AS idu,
            '60'::text || "substring"(parcelle.parcelle, 8, 15) AS parcelle,
            '60'::text || parcelle.ccocom AS insee
           FROM r_cadastre.parcelle
        ), req_ac4 AS (
         SELECT an_sup_ac4_geo_protect.idu,
                CASE
                    WHEN an_sup_ac4_geo_protect.message::text = 'Parcelle non concernée'::text THEN 'non'::text
                    WHEN an_sup_ac4_geo_protect.message::text = 'ZPPAUP de Compiègne (parcelle concernée mais sans bâtiment recensé)'::text THEN 'oui'::text
                    ELSE 'oui'::text
                END AS zppaup_peri,
                CASE
                    WHEN an_sup_ac4_geo_protect.message::text = 'ZPPAUP de Compiègne'::text THEN 'oui'::text
                    ELSE 'non'::text
                END AS zppaup_bati
           FROM m_urbanisme_reg.an_sup_ac4_geo_protect
        )
 SELECT row_number() OVER () AS gid,
    req_par.parcelle AS idu,
    req_par.insee,
    req_ac4.zppaup_peri,
    req_ac4.zppaup_bati
   FROM req_par
     LEFT JOIN req_ac4 ON req_ac4.idu::text = req_par.parcelle
WITH DATA;

ALTER TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu4_gdpublic
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu4_gdpublic TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu4_gdpublic TO groupe_sig;
COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu4_gdpublic
  IS 'Vue matérialisée contenant les informations de présence d''une ZPPAUP sur la parcelle pour la constitution de la fiche d''information Renseignements d''urbanisme Version imprimable dans GEO Gd Public';


-- Materialized View: m_urbanisme_doc.an_vmr_fichegeo_ruplu5_gdpublic

DROP MATERIALIZED VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu5_gdpublic;

CREATE MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu5_gdpublic AS 
 WITH req_par AS (
         SELECT "substring"(parcelle.parcelle, 5, 15) AS idu,
            '60'::text || "substring"(parcelle.parcelle, 8, 15) AS parcelle,
            '60'::text || parcelle.ccocom AS insee
           FROM r_cadastre.parcelle
        ), req_ppri AS (
         SELECT DISTINCT "PARCELLE"."IDU" as idu,
            'oui'::text AS ppri
           FROM r_bg_edigeo."PARCELLE",
            m_urbanisme_reg.geo_sup_pm1_ppri_projet_zonage
          WHERE st_intersects("PARCELLE"."GEOM", geo_sup_pm1_ppri_projet_zonage.geom)
        )
 SELECT row_number() OVER () AS gid,
    req_par.parcelle AS idu,
    req_par.insee,
        CASE
            WHEN req_ppri.ppri = 'oui'::text THEN 'oui'::text
            ELSE 'non'::text
        END AS ppri
   FROM req_par
     LEFT JOIN req_ppri ON req_ppri.idu::text = req_par.parcelle
WITH DATA;

ALTER TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu5_gdpublic
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu5_gdpublic TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu5_gdpublic TO groupe_sig;
COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu5_gdpublic
  IS 'Vue matérialisée contenant les informations de présence de l''aléa inondation (ppri projet) sur la parcelle pour la constitution de la fiche d''information Renseignements d''urbanisme Version imprimable dans GEO Gd Public';



-- Materialized View: m_urbanisme_doc.an_vmr_p_information

DROP MATERIALIZED VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_vmr_p_information;

CREATE MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_p_information AS 
 WITH r_p AS (
         WITH r_pct AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                        CASE
                            WHEN geo_p_info_pct.l_valrecul IS NOT NULL THEN (((lt_typeinf.valeur::text || chr(10)) || 'Valeur du recul : '::text) || geo_p_info_pct.l_valrecul::text)::character varying
                            ELSE CASE WHEN geo_p_info_pct.typeinf = '99' THEN lt_typeinf.valeur || ' : ' || geo_p_info_pct.libelle ELSE lt_typeinf.valeur END
                        END AS libelle,
                    geo_p_info_pct.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc_cnig2017.geo_p_info_pct, m_urbanisme_doc_cnig2017.lt_typeinf
                  WHERE geo_p_info_pct.typeinf || geo_p_info_pct.stypeinf = lt_typeinf.code || lt_typeinf.sous_code and st_intersects("PARCELLE"."GEOM", geo_p_info_pct.geom)
                ), r_lin AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                        CASE
                            WHEN geo_p_info_lin.l_valrecul IS NOT NULL THEN (((lt_typeinf.valeur::text || chr(10)) || 'Valeur du recul : '::text) || geo_p_info_lin.l_valrecul::text)::character varying
                            ELSE CASE WHEN geo_p_info_lin.typeinf = '99' THEN lt_typeinf.valeur || ' : ' || geo_p_info_lin.libelle ELSE lt_typeinf.valeur END
                        END AS libelle,
                    geo_p_info_lin.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc_cnig2017.geo_p_info_lin, m_urbanisme_doc_cnig2017.lt_typeinf
                  WHERE geo_p_info_lin.typeinf || geo_p_info_lin.stypeinf = lt_typeinf.code || lt_typeinf.sous_code and st_intersects("PARCELLE"."GEOM", geo_p_info_lin.geom)
                ), r_surf AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                        CASE
                            WHEN geo_p_info_surf.l_valrecul IS NOT NULL THEN (((lt_typeinf.valeur::text || chr(10)) || 'Valeur du recul : '::text) || geo_p_info_surf.l_valrecul::text)::character varying
			ELSE CASE WHEN geo_p_info_surf.typeinf = '99' THEN lt_typeinf.valeur || ' : ' || geo_p_info_surf.libelle ELSE lt_typeinf.valeur END
                        END AS libelle,
                    geo_p_info_surf.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc_cnig2017.geo_p_info_surf, m_urbanisme_doc_cnig2017.lt_typeinf
                  WHERE geo_p_info_surf.typeinf || geo_p_info_surf.stypeinf = lt_typeinf.code || lt_typeinf.sous_code and geo_p_info_surf.typeinf::text <> '04'::text and geo_p_info_surf.typeinf::text <> '05'::text AND st_intersects("PARCELLE"."GEOM", geo_p_info_surf.geom1)
                ), r_natura2000_zps AS (
                 SELECT p."IDU" AS idu,
                        CASE
                            WHEN zps.ztiquette IS NOT NULL THEN (('Site Natura2000 : '::text || zps.ztiquette::text) || chr(10)) || 'Remarque : les données présentées sont issues des modifications demandées (en 2010) et transmises (en 2013) à l''Union Européenne pour validation (en attente d''un retour)'::text
                            ELSE NULL::text
                        END AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_environnement.an_env_n2000_zps_m2010_geo zps
                  WHERE p."IDU"::text = zps.idu::text
                ), r_natura2000_sic AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                        CASE
                            WHEN geo_env_n2000_sic_m2010.nom_site IS NOT NULL THEN (('Site Natura2000 : SIC : '::text || geo_env_n2000_sic_m2010.nom_site::text) || chr(10)) || 'Remarque : les données présentées sont issues des modifications demandées (en 2010) et transmises (en 2013) à l''Union Européenne pour validation (en attente d''un retour)'::text
                            ELSE NULL::text
                        END AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_environnement.geo_env_n2000_sic_m2010
                  WHERE st_intersects("PARCELLE"."GEOM", geo_env_n2000_sic_m2010.geom)
                ), r_smoa AS (
                 SELECT p."IDU" AS idu,
                        CASE
                            WHEN zh.classement::text = 'PP'::text THEN 'Zone humide SMOA : zone potentiennement humide - nécessite une analyse de la végétation et du sol'::text
                            WHEN zh.classement::text = 'H'::text THEN 'Zone humide SMOA : zone humide avérée'::text
                            WHEN zh.classement::text = 'NZH'::text OR zh.classement::text = 'P'::text THEN 'Zone humide SMOA : zone potentiennement humide - nécessite une analyse du sol'::text
                            ELSE NULL::text
                        END AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_smoa.an_smoa_inv_zh_geo zh
                  WHERE p."IDU"::text = zh.idu::text
                ), r_sageba_zh AS (
                 SELECT DISTINCT "PARCELLE"."IDU" AS idu,
                    'Zone humide SAGEBA (V4) : Zone humide identifiée'::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_environnement.geo_env_sageba_zhv4
                  WHERE st_intersects("PARCELLE"."GEOM", geo_env_sageba_zhv4.geom)
                ), r_zico AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    'Zones Importantes pour la Conservation des Oiseaux (ZICO) : '::text || geo_env_zico.nom::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_environnement.geo_env_zico
                  WHERE st_intersects("PARCELLE"."GEOM", geo_env_zico.geom)
                ), r_znieff1 AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    'Zones Naturelles d''Intêret Ecologique, Faunistique et Floristique de type 1 (ZNIEFF) : '::text || geo_env_znieff1.nom::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_environnement.geo_env_znieff1
                  WHERE st_intersects("PARCELLE"."GEOM", geo_env_znieff1.geom)
                ), r_znieff2 AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    'Zones Naturelles d''Intêret Ecologique, Faunistique et Floristique de type 2 (ZNIEFF) : '::text || geo_env_znieff2.nom::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_environnement.geo_env_znieff2
                  WHERE st_intersects("PARCELLE"."GEOM", geo_env_znieff2.geom)
                ), r_zdh AS (
                 SELECT p."IDU" AS idu,
                    (('Zone à Dominante Humide (ZDH) - Agence : '::text || zdh.agence::text) || ', Type : '::text) || zdh.type::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_environnement.an_env_zdh_geo zdh
                  WHERE p."IDU"::text = zdh.idu::text
                ), r_apb AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    'Arrêté de protection de Biotope (APB) : '::text || geo_env_apb.nom::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_environnement.geo_env_apb
                  WHERE st_intersects("PARCELLE"."GEOM", geo_env_apb.geom)
                ), r_bgf AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    'Zones sensibles Grande Faune'::text AS libelle,
                    geo_env_inventairezonesensible.lienversfi AS urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_environnement.geo_env_inventairezonesensible
                  WHERE st_intersects("PARCELLE"."GEOM", geo_env_inventairezonesensible.geom)
                ), r_ens AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    'Espace naturel sensible (ENS) : '::text || geo_env_ens.intitule_localisation_lieudit AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_environnement.geo_env_ens
                  WHERE st_intersects("PARCELLE"."GEOM", geo_env_ens.geom)
                ), r_argile_moyenfort AS (
                 SELECT p."IDU" AS idu,
                    'Aléa de retrait-gonflement des argiles : '::text || a.alea::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_risque.an_risq_alea_retraitgonflement_argiles_geo a
                  WHERE p."IDU"::text = a.idu::text
                ), r_argile_faible AS (
                 SELECT p."IDU" AS idu,
                    'Aléa de retrait-gonflement des argiles : '::text || a.alea::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_risque.an_risq_alea_retraitgonflement_argiles_faible_geo a
                  WHERE p."IDU"::text = a.idu::text
                ), r_inv_patri AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    ('Inventaire des éléments du patrimoine bâti vernaculaire'::text || ' - '::text) || geo_inv_patrimoine_pct.l_descript::text AS libelle,
                    geo_inv_patrimoine_pct.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_reg.geo_inv_patrimoine_pct
                  WHERE st_intersects("PARCELLE"."GEOM", geo_inv_patrimoine_pct.geom2)
                ), r_zass AS (
                 SELECT p."IDU" AS idu,
                    'Zonage d''assainissement : '::text || z.zone::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_reseau_humide.an_eu_zonage_geo z
                  WHERE p."IDU"::text = z.idu::text
                ), r_rlp AS (
                 SELECT p."IDU" AS idu,
                    (('Règlement local de publicité : '::text || z.lib_zone::text) || ', approuvé le '::text) || to_char(to_date(z.datappro::text, 'YYYYMMDD'::text)::timestamp without time zone, 'DD-MM-YYYY'::text) AS libelle,
                    z.url_reg::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_urbanisme_reg.geo_rlp_zonage z
                  WHERE st_intersects(p."GEOM", z.geom1)
                ), r_proc AS (
                 SELECT p."IDU" AS idu,
                        CASE
                            WHEN z.date_crea::text IS NULL OR z.date_crea::text = ''::text THEN 'Procédure d''urbanisme (autre qu''une ZAC) : '::text || zl.proced_lib::text
                            ELSE (('Procédure d''urbanisme (autre qu''une ZAC) : '::text || zl.proced_lib::text) || ', créée le '::text) || to_char(to_date(z.date_crea::text, 'YYYYMMDD'::text)::timestamp without time zone, 'DD-MM-YYYY'::text)
                        END AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_urbanisme_reg.geo_vmr_proc z,
                    m_urbanisme_reg.lt_proced zl
                  WHERE z.z_proced::text = zl.z_proced::text AND z.z_proced::text <> '10'::text AND st_intersects(p."GEOM", z.geom1)
                )
         SELECT p."IDU" AS idu,
                CASE
                    WHEN r_pct.libelle IS NULL AND r_lin.libelle IS NULL AND r_surf.libelle IS NULL AND r_natura2000_zps.libelle IS NULL AND r_natura2000_sic.libelle IS NULL AND r_smoa.libelle IS NULL AND r_sageba_zh.libelle IS NULL AND r_zico.libelle IS NULL AND r_znieff1.libelle IS NULL AND r_znieff2.libelle IS NULL AND r_zdh.libelle IS NULL AND r_apb.libelle IS NULL AND r_bgf.libelle IS NULL AND r_ens.libelle IS NULL AND r_argile_moyenfort.libelle IS NULL AND r_argile_faible.libelle IS NULL AND r_inv_patri.libelle IS NULL AND r_zass.libelle IS NULL AND r_rlp.libelle IS NULL AND r_proc.libelle IS NULL THEN 'Aucune'::text
                    ELSE ''::text
                END AS libelle,
                CASE
                    WHEN r_pct.urlfic IS NULL AND r_lin.urlfic IS NULL AND r_surf.urlfic IS NULL AND r_natura2000_zps.urlfic IS NULL AND r_natura2000_sic.urlfic IS NULL AND r_smoa.urlfic IS NULL AND r_sageba_zh.urlfic IS NULL AND r_zico.urlfic IS NULL AND r_znieff1.urlfic IS NULL AND r_znieff2.urlfic IS NULL AND r_zdh.urlfic IS NULL AND r_apb.urlfic IS NULL AND r_bgf.urlfic IS NULL AND r_ens.urlfic IS NULL AND r_argile_moyenfort.urlfic IS NULL AND r_argile_faible.urlfic IS NULL AND r_inv_patri.urlfic IS NULL AND r_zass.urlfic IS NULL AND r_rlp.urlfic IS NULL AND r_proc.urlfic IS NULL THEN NULL::text
                    ELSE NULL::text
                END AS urlfic
           FROM r_bg_edigeo."PARCELLE" p
             LEFT JOIN r_pct ON p."IDU"::text = r_pct.idu::text
             LEFT JOIN r_lin ON p."IDU"::text = r_lin.idu::text
             LEFT JOIN r_surf ON p."IDU"::text = r_surf.idu::text
             LEFT JOIN r_natura2000_zps ON p."IDU"::text = r_natura2000_zps.idu::text
             LEFT JOIN r_natura2000_sic ON p."IDU"::text = r_natura2000_sic.idu::text
             LEFT JOIN r_smoa ON p."IDU"::text = r_smoa.idu::text
             LEFT JOIN r_sageba_zh ON p."IDU"::text = r_sageba_zh.idu::text
             LEFT JOIN r_zico ON p."IDU"::text = r_zico.idu::text
             LEFT JOIN r_znieff1 ON p."IDU"::text = r_znieff1.idu::text
             LEFT JOIN r_znieff2 ON p."IDU"::text = r_znieff2.idu::text
             LEFT JOIN r_zdh ON p."IDU"::text = r_zdh.idu::text
             LEFT JOIN r_apb ON p."IDU"::text = r_apb.idu::text
             LEFT JOIN r_bgf ON p."IDU"::text = r_bgf.idu::text
             LEFT JOIN r_ens ON p."IDU"::text = r_ens.idu::text
             LEFT JOIN r_argile_moyenfort ON p."IDU"::text = r_argile_moyenfort.idu::text
             LEFT JOIN r_argile_faible ON p."IDU"::text = r_argile_faible.idu::text
             LEFT JOIN r_inv_patri ON p."IDU"::text = r_inv_patri.idu::text
             LEFT JOIN r_zass ON p."IDU"::text = r_zass.idu::text
             LEFT JOIN r_rlp ON p."IDU"::text = r_rlp.idu::text
             LEFT JOIN r_proc ON p."IDU"::text = r_proc.idu::text
          WHERE r_pct.libelle IS NULL AND r_lin.libelle IS NULL AND r_surf.libelle IS NULL AND r_natura2000_zps.libelle IS NULL AND r_natura2000_sic.libelle IS NULL AND r_smoa.libelle IS NULL AND r_sageba_zh.libelle IS NULL AND r_zico.libelle IS NULL AND r_znieff1.libelle IS NULL AND r_znieff2.libelle IS NULL AND r_zdh.libelle IS NULL AND r_apb.libelle IS NULL AND r_bgf.libelle IS NULL AND r_ens.libelle IS NULL AND r_argile_moyenfort.libelle IS NULL AND r_argile_faible.libelle IS NULL AND r_inv_patri.libelle IS NULL AND r_zass.libelle IS NULL AND r_rlp.libelle IS NULL AND r_proc.libelle IS NULL
        UNION ALL
         SELECT r_pct.idu,
            r_pct.libelle,
            r_pct.urlfic
           FROM r_pct
        UNION ALL
         SELECT r_lin.idu,
            r_lin.libelle,
            r_lin.urlfic
           FROM r_lin
        UNION ALL
         SELECT r_surf.idu,
            r_surf.libelle,
            r_surf.urlfic
           FROM r_surf
        UNION ALL
         SELECT r_natura2000_zps.idu,
            r_natura2000_zps.libelle,
            r_natura2000_zps.urlfic
           FROM r_natura2000_zps
        UNION ALL
         SELECT r_natura2000_sic.idu,
            r_natura2000_sic.libelle,
            r_natura2000_sic.urlfic
           FROM r_natura2000_sic
        UNION ALL
         SELECT r_smoa.idu,
            r_smoa.libelle,
            r_smoa.urlfic
           FROM r_smoa
        UNION ALL
         SELECT r_sageba_zh.idu,
            r_sageba_zh.libelle,
            r_sageba_zh.urlfic
           FROM r_sageba_zh
        UNION ALL
         SELECT r_zico.idu,
            r_zico.libelle,
            r_zico.urlfic
           FROM r_zico
        UNION ALL
         SELECT r_znieff1.idu,
            r_znieff1.libelle,
            r_znieff1.urlfic
           FROM r_znieff1
        UNION ALL
         SELECT r_znieff2.idu,
            r_znieff2.libelle,
            r_znieff2.urlfic
           FROM r_znieff2
        UNION ALL
         SELECT r_zdh.idu,
            r_zdh.libelle,
            r_zdh.urlfic
           FROM r_zdh
        UNION ALL
         SELECT r_apb.idu,
            r_apb.libelle,
            r_apb.urlfic
           FROM r_apb
        UNION ALL
         SELECT r_bgf.idu,
            r_bgf.libelle,
            r_bgf.urlfic
           FROM r_bgf
        UNION ALL
         SELECT r_ens.idu,
            r_ens.libelle,
            r_ens.urlfic
           FROM r_ens
        UNION ALL
         SELECT r_argile_moyenfort.idu,
            r_argile_moyenfort.libelle,
            r_argile_moyenfort.urlfic
           FROM r_argile_moyenfort
        UNION ALL
         SELECT r_argile_faible.idu,
            r_argile_faible.libelle,
            r_argile_faible.urlfic
           FROM r_argile_faible
        UNION ALL
         SELECT r_inv_patri.idu,
            r_inv_patri.libelle,
            r_inv_patri.urlfic
           FROM r_inv_patri
        UNION ALL
         SELECT r_zass.idu,
            r_zass.libelle,
            r_zass.urlfic
           FROM r_zass
        UNION ALL
         SELECT r_rlp.idu,
            r_rlp.libelle,
            r_rlp.urlfic
           FROM r_rlp
        UNION ALL
         SELECT r_proc.idu,
            r_proc.libelle,
            r_proc.urlfic
           FROM r_proc
        )
 SELECT row_number() OVER () AS gid,
    r_p.idu,
    r_p.libelle,
    r_p.urlfic
   FROM r_p
WITH DATA;

ALTER TABLE m_urbanisme_doc_cnig2017.an_vmr_p_information
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_p_information TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_p_information TO groupe_sig;
COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_p_information
  IS E'Vue matérialisée formatant les données les données informations jugées utiles pour la fiche de renseignements d''urbanisme (fiche d''information de GEO).
ATTENTION : cette vue est reformatée à chaque mise à jour de cadastre dans FME (Y:\\Ressources\\4-Partage\\3-Procedures\\FME\\prod\\URB\\00_MAJ_COMPLETE_SUP_INFO_UTILES.fmw) afin de conserver le lien vers le bon schéma de cadastre suite au rennomage de ceux-ci durant l''intégration. Si cette vue est modifiée ici pensez à répercuter la mise à jour dans le trans former SQLExecutor.';

-- Index: m_urbanisme_doc.idx_an_vmr_p_information_idu

-- DROP INDEX m_urbanisme_doc.idx_an_vmr_p_information_idu;

CREATE INDEX idx_an_vmr_p_information_idu
  ON m_urbanisme_doc_cnig2017.an_vmr_p_information
  USING btree
  (idu COLLATE pg_catalog."default");


-- Materialized View: m_urbanisme_doc.an_vmr_p_information_dpu

DROP MATERIALIZED VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_vmr_p_information_dpu;

CREATE MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_p_information_dpu AS 
 WITH r_p AS (
         WITH r_surf AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    geo_p_info_surf.l_nom,
                    geo_p_info_surf.l_bnfcr,
                    geo_p_info_surf.l_dateins,
                    geo_p_info_surf.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc_cnig2017.geo_p_info_surf
                  WHERE geo_p_info_surf.typeinf::text = '04'::text AND st_intersects("PARCELLE"."GEOM", geo_p_info_surf.geom1)
                )
         SELECT p."IDU" AS idu,
            r_surf.l_nom,
            r_surf.l_bnfcr,
            r_surf.l_dateins,
            r_surf.urlfic
           FROM r_bg_edigeo."PARCELLE" p
             LEFT JOIN r_surf ON p."IDU"::text = r_surf.idu::text
        )
 SELECT row_number() OVER () AS gid,
    r_p.idu,
        CASE
            WHEN r_p.l_nom IS NULL OR r_p.l_nom::text = ''::text THEN 'La parcelle n''est pas concernée'::character varying
            ELSE r_p.l_nom
        END AS application,
        CASE
            WHEN r_p.l_bnfcr IS NULL OR r_p.l_bnfcr::text = ''::text THEN ''::character varying
            ELSE r_p.l_bnfcr
        END AS beneficiaire,
        CASE
            WHEN r_p.l_dateins IS NULL OR r_p.l_dateins = ''::bpchar THEN NULL::text
            ELSE to_char(to_date(r_p.l_dateins::text, 'YYYYMMDD'::text)::timestamp without time zone, 'DD-MM-YYYY'::text)
        END AS date_ins,
        CASE
            WHEN r_p.urlfic IS NULL OR r_p.urlfic::text = ''::text THEN NULL::character varying
            ELSE r_p.urlfic
        END AS urlfic
   FROM r_p
WITH DATA;

ALTER TABLE m_urbanisme_doc_cnig2017.an_vmr_p_information_dpu
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_p_information_dpu TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_p_information_dpu TO groupe_sig;
COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_p_information_dpu
  IS 'Vue matérialisée formatant les données les données des DPU pour la fiche de renseignements d''urbanisme (fiche d''information de GEO).
ATTENTION : cette vue est reformatée à chaque mise à jour de cadastre dans FME (Y:\Ressources\4-Partage\3-Procedures\FME\prod\URB\00_MAJ_COMPLETE_SUP_INFO_UTILES.fmw) 
afin de conserver le lien vers le bon schéma de cadastre suite au rennomage de ceux-ci durant l''intégration. Si cette vue est modifiée ici pensez à répercuter la mise à jour dans le trans former SQLExecutor.';


-- Materialized View: m_urbanisme_doc.an_vmr_p_prescription

DROP MATERIALIZED VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_vmr_p_prescription;

CREATE MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_p_prescription AS 
 WITH r_p AS (
         WITH r_pct AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                        CASE
                            WHEN geo_p_prescription_pct.l_nature IS NOT NULL THEN (((lt_typepsc.valeur::text || chr(10)) || 'Nature : '::text) || geo_p_prescription_pct.l_nature::text)::character varying
                            ELSE CASE WHEN geo_p_prescription_pct.typepsc = '99' THEN lt_typepsc.valeur || ' : ' || geo_p_prescription_pct.libelle ELSE lt_typepsc.valeur END
                        END AS libelle,
                    geo_p_prescription_pct.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc_cnig2017.geo_p_prescription_pct, m_urbanisme_doc_cnig2017.lt_typepsc
                  WHERE geo_p_prescription_pct.typepsc || geo_p_prescription_pct.stypepsc = lt_typepsc.code || lt_typepsc.sous_code and st_intersects("PARCELLE"."GEOM", geo_p_prescription_pct.geom)
                ), r_lin AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                        CASE
                            WHEN geo_p_prescription_lin.l_valrecul IS NOT NULL THEN (((lt_typepsc.valeur::text || chr(10)) || 'Valeur du recul : '::text) || geo_p_prescription_lin.l_valrecul::text)::character varying
                            ELSE CASE WHEN geo_p_prescription_lin.typepsc = '99' THEN lt_typepsc.valeur || ' : ' || geo_p_prescription_lin.libelle ELSE lt_typepsc.valeur END
                        END AS libelle,
                    geo_p_prescription_lin.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc_cnig2017.geo_p_prescription_lin, m_urbanisme_doc_cnig2017.lt_typepsc
                  WHERE geo_p_prescription_lin.typepsc || geo_p_prescription_lin.stypepsc = lt_typepsc.code || lt_typepsc.sous_code and st_intersects("PARCELLE"."GEOM", geo_p_prescription_lin.geom)
                ), r_surf AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                        CASE
                            WHEN geo_p_prescription_surf.l_nature IS NOT NULL THEN (((lt_typepsc.valeur::text || chr(10)) || 'Nature : '::text) || geo_p_prescription_surf.l_nature::text)::character varying
                            ELSE CASE WHEN geo_p_prescription_surf.typepsc = '99' THEN lt_typepsc.valeur || ' : ' || geo_p_prescription_surf.libelle ELSE lt_typepsc.valeur END
                        END AS libelle,
                    geo_p_prescription_surf.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc_cnig2017.geo_p_prescription_surf, m_urbanisme_doc_cnig2017.lt_typepsc
                  WHERE geo_p_prescription_surf.typepsc || geo_p_prescription_surf.stypepsc = lt_typepsc.code || lt_typepsc.sous_code and st_intersects("PARCELLE"."GEOM", geo_p_prescription_surf.geom1)
                )
         SELECT p."IDU" AS idu,
                CASE
                    WHEN r_pct.libelle IS NULL AND r_lin.libelle IS NULL AND r_surf.libelle IS NULL THEN 'Aucune'::text
                    ELSE NULL::text
                END AS libelle,
                CASE
                    WHEN r_pct.urlfic IS NULL AND r_lin.urlfic IS NULL AND r_surf.urlfic IS NULL THEN NULL::text
                    ELSE NULL::text
                END AS urlfic
           FROM r_bg_edigeo."PARCELLE" p
             LEFT JOIN r_pct ON p."IDU"::text = r_pct.idu::text
             LEFT JOIN r_lin ON p."IDU"::text = r_lin.idu::text
             LEFT JOIN r_surf ON p."IDU"::text = r_surf.idu::text
          WHERE r_pct.libelle IS NULL AND r_lin.libelle IS NULL AND r_surf.libelle IS NULL
        UNION ALL
         SELECT r_pct.idu,
            r_pct.libelle,
            r_pct.urlfic
           FROM r_pct
        UNION ALL
         SELECT r_lin.idu,
            r_lin.libelle,
            r_lin.urlfic
           FROM r_lin
        UNION ALL
         SELECT r_surf.idu,
            r_surf.libelle,
            r_surf.urlfic
           FROM r_surf
        )
 SELECT row_number() OVER () AS gid,
    r_p.idu,
    r_p.libelle,
    r_p.urlfic
   FROM r_p
WITH DATA;

ALTER TABLE m_urbanisme_doc_cnig2017.an_vmr_p_prescription
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_p_prescription TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_p_prescription TO groupe_sig;
COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_p_prescription
  IS E'Vue matérialisée formatant les données les données des prescriptions pour la fiche de renseignements d''urbanisme (fiche d''information de GEO).
ATTENTION : cette vue est reformatée à chaque mise à jour de cadastre dans FME (Y:\\Ressources\\4-Partage\\3-Procedures\\FME\\prod\\URB\\00_MAJ_COMPLETE_SUP_INFO_UTILES.fmw) afin de conserver le lien vers le bon schéma de cadastre suite au rennomage de ceux-ci durant l''intégration. Si cette vue est modifiée ici pensez à répercuter la mise à jour dans le trans former SQLExecutor.';

-- Index: m_urbanisme_doc.idx_an_vmr_p_prescription_idu

-- DROP INDEX m_urbanisme_doc.idx_an_vmr_p_prescription_idu;

CREATE INDEX idx_an_vmr_p_prescription_idu
  ON m_urbanisme_doc_cnig2017.an_vmr_p_prescription
  USING btree
  (idu COLLATE pg_catalog."default");



-- Materialized View: m_urbanisme_doc.an_vmr_parcelle_plu
DROP MATERIALIZED VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu2_gdpublic;
DROP MATERIALIZED VIEW IF EXISTS m_urbanisme_doc_cnig2017.an_vmr_parcelle_plu;

CREATE MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_parcelle_plu AS 
 WITH req_par AS (
         SELECT geo_parcelle.geo_parcelle,
            geo_parcelle.annee,
            geo_parcelle.object_rid,
            geo_parcelle.idu,
            geo_parcelle.geo_section,
            geo_parcelle.geo_subdsect,
            geo_parcelle.supf,
            geo_parcelle.geo_indp,
            geo_parcelle.coar,
            geo_parcelle.tex,
            geo_parcelle.tex2,
            geo_parcelle.codm,
            geo_parcelle.creat_date,
            geo_parcelle.update_dat,
            geo_parcelle.lot,
            geo_parcelle.ogc_fid,
            geo_parcelle.geom
           FROM r_cadastre.geo_parcelle
        ), req_plu AS (
         SELECT geo_p_zone_urba.l_insee as insee,
            geo_osm_commune.commune,
            geo_p_zone_urba.libelle,
                CASE
                    WHEN geo_p_zone_urba.typesect::text = 'ZZ'::text THEN geo_p_zone_urba.libelong::text
                    ELSE
                    CASE
                        WHEN geo_p_zone_urba.typesect::text = '01'::text THEN 'Secteur ouvert à la construction'::text
                        WHEN geo_p_zone_urba.typesect::text = '02'::text THEN 'Secteur réservé aux activités'::text
                        WHEN geo_p_zone_urba.typesect::text = '03'::text THEN 'Secteur non ouvert à la construction, sauf exceptions prévues par la loi'::text
                        WHEN geo_p_zone_urba.typesect::text = '99'::text THEN 'Zone non couverte par la carte communale'::text
                        ELSE NULL::text
                    END
                END AS libelong,
            geo_p_zone_urba.urlfic,
            lt_destdomi.valeur as destdomi_lib,
            geo_p_zone_urba.l_surf_cal,
                fermreco,
                CASE
                    WHEN an_doc_urba.typedoc::text = 'PLU'::text OR an_doc_urba.typedoc::text = 'POS'::text THEN geo_p_zone_urba.typezone
                    WHEN an_doc_urba.typedoc::text = 'CC'::text THEN 'sans objet'::character varying
                    ELSE NULL::character varying
                END AS type_zone,
            geo_p_zone_urba.l_observ,
            right(geo_p_zone_urba.idurba,8) as datappro,
            st_buffer(geo_p_zone_urba.geom, (-1)::double precision) AS geom1
           FROM m_urbanisme_doc_cnig2017.geo_p_zone_urba,
            m_urbanisme_doc_cnig2017.lt_destdomi,
            m_urbanisme_doc_cnig2017.an_doc_urba,
            r_osm.geo_osm_commune
          WHERE geo_osm_commune.insee::text = geo_p_zone_urba.l_insee::text AND geo_p_zone_urba.l_insee::text = "substring"(an_doc_urba.idurba::text, 1, 5) AND an_doc_urba.etat = '03'::bpchar 
	AND geo_p_zone_urba.l_destdomi::character varying = lt_destdomi.code
        )
 SELECT row_number() OVER () AS id,
    now() AS datextract,
    '60'::text || req_par.idu AS idu,
    '60'::text || "substring"(req_par.idu, 1, 3) AS insee_par,
    req_plu.insee AS insee_plu,
    req_plu.commune,
    req_plu.libelle,
    req_plu.libelong,
    req_plu.type_zone,
    req_plu.destdomi_lib,
    req_plu.fermreco,
    sum(req_plu.l_surf_cal) AS l_surf_cal,
    req_plu.l_observ,
    to_char(req_plu.datappro::timestamp without time zone, 'DD/MM/YYYY'::text) AS datappro,
    req_plu.urlfic
   FROM req_par,
    req_plu
  WHERE st_intersects(req_par.geom, req_plu.geom1) AND ('60'::text || "substring"(req_par.idu, 1, 3)) = req_plu.insee::text
  GROUP BY '60'::text || req_par.idu, '60'::text || "substring"(req_par.idu, 1, 3), req_plu.insee, req_plu.commune, req_plu.libelle, req_plu.libelong, req_plu.type_zone, req_plu.destdomi_lib, req_plu.fermreco, req_plu.l_observ, req_plu.datappro, req_plu.urlfic
WITH DATA;

ALTER TABLE m_urbanisme_doc_cnig2017.an_vmr_parcelle_plu
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_parcelle_plu TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_parcelle_plu TO groupe_sig;
COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_parcelle_plu
  IS E'Vue matérialisée contenant les informations pré-formatés pour la constitution de la fiche d''information Renseignements d''urbanisme y compris version imprimable dans GEO.
Cette vue permet de récupérer pour chaque parcelle les informations du PLU et traiter les pbs liés aux zones entre commune et les zonages se touchant.
ATTENTION : cette vue est reformatée à chaque mise à jour de cadastre dans FME (Y:\\Ressources\\4-Partage\\3-Procedures\\FME\\prod\\URB\\00_MAJ_COMPLETE_SUP_INFO_UTILES.fmw) afin de conserver le lien vers le bon schéma de cadastre suite au rennomage de ceux-ci durant l''intégration. Si cette vue est modifiée ici pensez à répercuter la mise à jour dans le trans former SQLExecutor.';

-- Index: m_urbanisme_doc.idx_an_vmr_parcelle_plu_idu

-- DROP INDEX m_urbanisme_doc.idx_an_vmr_parcelle_plu_idu;

CREATE INDEX idx_an_vmr_parcelle_plu_idu
  ON m_urbanisme_doc_cnig2017.an_vmr_parcelle_plu
  USING btree
  (idu COLLATE pg_catalog."default");


-- Materialized View: m_urbanisme_doc.an_vmr_fichegeo_ruplu2_gdpublic

CREATE MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu2_gdpublic AS 
 WITH req_par AS (
         SELECT "substring"(parcelle.parcelle, 5, 15) AS idu,
            '60'::text || "substring"(parcelle.parcelle, 8, 15) AS parcelle,
            '60'::text || parcelle.ccocom AS insee
           FROM r_cadastre.parcelle
        ), req_plu AS (
         SELECT "substring"(an_doc_urba.idurba::text, 1, 5) AS insee,
            an_doc_urba.typedoc
           FROM m_urbanisme_doc_cnig2017.an_doc_urba
          WHERE an_doc_urba.etat = '03'::bpchar
        ), req_zonage AS (
         SELECT '60'::text || geo_parcelle.idu AS idu,
            string_agg(((('<b>'::text || an_vmr_parcelle_plu.libelle::text) || '</b>.<font size=2> Cliquez '::text) || ('<a href="'::text || an_vmr_parcelle_plu.urlfic::text)) || '" target="_blank">ici</a> pour ouvrir le règlement.</font>'::text, '<br>'::text) AS url_plu
           FROM r_cadastre.geo_parcelle
             LEFT JOIN m_urbanisme_doc_cnig2017.an_vmr_parcelle_plu ON ('60'::text || geo_parcelle.idu) = an_vmr_parcelle_plu.idu
          GROUP BY geo_parcelle.idu
          ORDER BY geo_parcelle.idu
        )
 SELECT row_number() OVER () AS gid,
    req_par.parcelle AS idu,
    req_par.insee,
    req_plu.typedoc,
        CASE
            WHEN req_plu.typedoc::text <> 'RNU'::text THEN req_zonage.url_plu
            ELSE 'Il n''existe pas de règlement de zones pour une commune soumise au RNU.'::text
        END AS plu_2
   FROM req_par
     LEFT JOIN req_zonage ON req_par.parcelle = req_zonage.idu
     LEFT JOIN req_plu ON req_par.insee = req_plu.insee
WITH DATA;

ALTER TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu2_gdpublic
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu2_gdpublic TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu2_gdpublic TO groupe_sig;
COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_cnig2017.an_vmr_fichegeo_ruplu2_gdpublic
  IS 'Vue matérialisée contenant les informations de zonages pré-formatés pour la constitution de la fiche d''information Renseignements d''urbanisme Version imprimable dans GEO Gd Public';


-- View: m_urbanisme_doc.geo_v_docurba

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
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_docurba TO postgres;
GRANT UPDATE, DELETE, REFERENCES, TRIGGER ON TABLE m_urbanisme_doc_cnig2017.geo_v_docurba TO groupe_sig;
GRANT SELECT, INSERT ON TABLE m_urbanisme_doc_cnig2017.geo_v_docurba TO groupe_sig WITH GRANT OPTION;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_docurba
  IS 'Vue géographique présentant le types de document d''urbanisme valide par commune du Pays COmpiégnois';


-- View: m_urbanisme_doc.geo_v_p_habillage_lin_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_habillage_lin_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_habillage_lin_arc AS 
 SELECT geo_p_habillage_lin.idhab,
    geo_p_habillage_lin.nattrac,
    geo_p_habillage_lin.l_insee as insee,
    right(geo_p_habillage_lin.idurba,8) as datappro,
    geo_p_habillage_lin.geom
   FROM m_urbanisme_doc_cnig2017.geo_p_habillage_lin
  WHERE geo_p_habillage_lin.l_insee::text = '60023'::text OR geo_p_habillage_lin.l_insee::text = '60070'::text OR geo_p_habillage_lin.l_insee::text = '60151'::text OR geo_p_habillage_lin.l_insee::text = '60156'::text 
  OR geo_p_habillage_lin.l_insee::text = '60159'::text OR geo_p_habillage_lin.l_insee::text = '60323'::text OR geo_p_habillage_lin.l_insee::text = '60325'::text OR geo_p_habillage_lin.l_insee::text = '60326'::text 
  OR geo_p_habillage_lin.l_insee::text = '60337'::text OR geo_p_habillage_lin.l_insee::text = '60338'::text OR geo_p_habillage_lin.l_insee::text = '60382'::text OR geo_p_habillage_lin.l_insee::text = '60402'::text 
  OR geo_p_habillage_lin.l_insee::text = '60579'::text OR geo_p_habillage_lin.l_insee::text = '60597'::text OR geo_p_habillage_lin.l_insee::text = '60665'::text OR geo_p_habillage_lin.l_insee::text = '60674'::text 
  OR geo_p_habillage_lin.l_insee::text = '60067'::text OR geo_p_habillage_lin.l_insee::text = '60068'::text OR geo_p_habillage_lin.l_insee::text = '60447'::text OR geo_p_habillage_lin.l_insee::text = '60578'::text 
  OR geo_p_habillage_lin.l_insee::text = '60600'::text OR geo_p_habillage_lin.l_insee::text = '60667'::text;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_lin_arc
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_lin_arc TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_lin_arc TO groupe_sig;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_habillage_lin_arc
  IS 'Vue géographique des habillages linéaires PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_p_habillage_txt_arc

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
    geo_p_habillage_txt.l_couleur,
    geo_p_habillage_txt.l_insee as insee,
    right(geo_p_habillage_txt.idurba,8) as datappro,
    geo_p_habillage_txt.geom
   FROM m_urbanisme_doc_cnig2017.geo_p_habillage_txt
  WHERE geo_p_habillage_txt.l_insee::text = '60023'::text OR geo_p_habillage_txt.l_insee::text = '60070'::text OR geo_p_habillage_txt.l_insee::text = '60151'::text OR geo_p_habillage_txt.l_insee::text = '60156'::text 
  OR geo_p_habillage_txt.l_insee::text = '60159'::text OR geo_p_habillage_txt.l_insee::text = '60323'::text OR geo_p_habillage_txt.l_insee::text = '60325'::text OR geo_p_habillage_txt.l_insee::text = '60326'::text 
  OR geo_p_habillage_txt.l_insee::text = '60337'::text OR geo_p_habillage_txt.l_insee::text = '60338'::text OR geo_p_habillage_txt.l_insee::text = '60382'::text OR geo_p_habillage_txt.l_insee::text = '60402'::text 
  OR geo_p_habillage_txt.l_insee::text = '60579'::text OR geo_p_habillage_txt.l_insee::text = '60597'::text OR geo_p_habillage_txt.l_insee::text = '60665'::text OR geo_p_habillage_txt.l_insee::text = '60674'::text 
  OR geo_p_habillage_txt.l_insee::text = '60067'::text OR geo_p_habillage_txt.l_insee::text = '60068'::text OR geo_p_habillage_txt.l_insee::text = '60447'::text OR geo_p_habillage_txt.l_insee::text = '60578'::text 
  OR geo_p_habillage_txt.l_insee::text = '60600'::text OR geo_p_habillage_txt.l_insee::text = '60667'::text;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_txt_arc
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_txt_arc TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_habillage_txt_arc TO groupe_sig;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_habillage_txt_arc
  IS 'Vue géographique des habillages textuels PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_p_info_pct_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_info_pct_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_info_pct_arc AS 
 SELECT geo_p_info_pct.idinf,
    lt_typeinf.valeur as libelle,
    geo_p_info_pct.txt,
    geo_p_info_pct.typeinf,
    geo_p_info_pct.stypeinf as l_typeinf2,
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
    geo_p_info_pct.l_insee as insee,
    right(geo_p_info_pct.idurba,8) as datappro,
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
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_pct_arc TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_pct_arc TO groupe_sig;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_info_pct_arc
  IS 'Vue géographique des informations ponctuelles PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- View: m_urbanisme_doc.geo_v_p_info_lin_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_info_lin_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_info_lin_arc AS 
 SELECT geo_p_info_lin.idinf,
    lt_typeinf.valeur as libelle,
    geo_p_info_lin.txt,
    geo_p_info_lin.typeinf,
    geo_p_info_lin.stypeinf as l_typeinf2,
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
    geo_p_info_lin.l_insee as insee,
    right(geo_p_info_lin.idurba,8) as datappro,
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
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_lin_arc TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_lin_arc TO groupe_sig;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_info_lin_arc
  IS 'Vue géographique des informations linéaires PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_p_info_surf_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_info_surf_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_info_surf_arc AS 
 SELECT geo_p_info_surf.idinf,
    lt_typeinf.valeur as libelle,
    geo_p_info_surf.txt,
    geo_p_info_surf.typeinf,
    geo_p_info_surf.stypeinf as l_typeinf2,
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
    geo_p_info_surf.l_insee as insee,
    right(geo_p_info_surf.idurba,8) as datappro,
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
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_surf_arc TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_info_surf_arc TO groupe_sig;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_info_surf_arc
  IS 'Vue géographique des informations surfaciques PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- View: m_urbanisme_doc.geo_v_p_prescription_lin_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_prescription_lin_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_prescription_lin_arc AS 
 SELECT geo_p_prescription_lin.idpsc,
    lt_typepsc.valeur as libelle,
    geo_p_prescription_lin.txt,
    geo_p_prescription_lin.typepsc,
    geo_p_prescription_lin.stypepsc as l_typepsc2,
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
    geo_p_prescription_lin.l_insee as insee,
    right(geo_p_prescription_lin.idurba,8) as datappro,
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
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_lin_arc TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_lin_arc TO groupe_sig;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_prescription_lin_arc
  IS 'Vue géographique des prescriptions linéaires PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_p_prescription_pct_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_prescription_pct_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_prescription_pct_arc AS 
 SELECT geo_p_prescription_pct.idpsc,
    lt_typepsc.valeur as libelle,
    geo_p_prescription_pct.txt,
    geo_p_prescription_pct.typepsc,
    geo_p_prescription_pct.stypepsc as l_typepsc2,
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
    geo_p_prescription_pct.l_insee as insee,
    right(geo_p_prescription_pct.idurba,8) as datappro,
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
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_pct_arc TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_pct_arc TO groupe_sig;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_prescription_pct_arc
  IS 'Vue géographique des prescriptions ponctuelles PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_p_prescription_surf_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_prescription_surf_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_prescription_surf_arc AS 
 SELECT geo_p_prescription_surf.idpsc,
    lt_typepsc.valeur as libelle,
    geo_p_prescription_surf.txt,
    geo_p_prescription_surf.typepsc,
    geo_p_prescription_surf.stypepsc as l_typepsc2,
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
    geo_p_prescription_surf.l_insee as insee,
    right(geo_p_prescription_surf.idurba,8) as datappro,
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
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_surf_arc TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_prescription_surf_arc TO groupe_sig;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_prescription_surf_arc
  IS 'Vue géographique des prescriptions surfaciques PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_p_zone_urba_arc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_p_zone_urba_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_p_zone_urba_arc AS 
 SELECT geo_p_zone_urba.idzone,
    geo_p_zone_urba.libelle,
    geo_p_zone_urba.libelong,
    geo_p_zone_urba.typezone,
    geo_p_zone_urba.l_destdomi as destdomi,
    geo_p_zone_urba.l_surf_cal,
    geo_p_zone_urba.l_observ,
    geo_p_zone_urba.nomfic,
    geo_p_zone_urba.urlfic,
    geo_p_zone_urba.l_insee as insee,
    right(geo_p_zone_urba.idurba,8) as datappro,
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
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_zone_urba_arc TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_p_zone_urba_arc TO groupe_sig;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_zone_urba_arc
  IS 'Vue géographique des zonages PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_urbreg_ads_commune

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_urbreg_ads_commune;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_urbreg_ads_commune AS 
 SELECT c.commune,
    a.insee,
    a.docurba,
    a.ads_arc,
    c.lib_epci,
    c.geom
   FROM r_osm.geo_v_osm_commune_apc c
     JOIN m_urbanisme_doc.an_ads_commune a ON a.insee = c.insee::bpchar
  ORDER BY a.insee;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_urbreg_ads_commune
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_urbreg_ads_commune TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_urbreg_ads_commune TO groupe_sig WITH GRANT OPTION;
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_urbreg_ads_commune
  IS 'Vue géographique sur l''état de l''ADS par l''ARC sur les communes du pays compiégnois';


-- Materialized View: m_urbanisme_doc.geo_vmr_p_zone_urba

DROP MATERIALIZED VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_vmr_p_zone_urba;

CREATE MATERIALIZED VIEW m_urbanisme_doc_cnig2017.geo_vmr_p_zone_urba AS 
 SELECT geo_p_zone_urba.idzone,
    geo_p_zone_urba.libelle,
    geo_p_zone_urba.libelong,
    geo_p_zone_urba.typezone,
    geo_p_zone_urba.l_destdomi as destdomi,
    geo_p_zone_urba.typesect,
    geo_p_zone_urba.fermreco,
    geo_p_zone_urba.l_surf_cal,
    geo_p_zone_urba.l_observ,
    geo_p_zone_urba.nomfic,
    geo_p_zone_urba.urlfic,
    geo_p_zone_urba.l_insee as insee,
    right(geo_p_zone_urba.idurba,8) as datappro,
    geo_p_zone_urba.datvalid,
    st_multi(geo_p_zone_urba.geom)::geometry(MultiPolygon,2154) AS geom
   FROM m_urbanisme_doc_cnig2017.geo_p_zone_urba
WITH DATA;

ALTER TABLE m_urbanisme_doc_cnig2017.geo_vmr_p_zone_urba
  OWNER TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_vmr_p_zone_urba TO postgres;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_vmr_p_zone_urba TO groupe_sig;
COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_cnig2017.geo_vmr_p_zone_urba
  IS 'Vue matérialisée des zones du PLU servant dans les recherches par zonage ou type dans GEO.';




-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Supression dans anciennes tables après la migration
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- DROP TABLE m_urbanisme_doc_cnig2017.an_doc_urba_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.an_doc_urba_com_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_lin_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_pct_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_surf_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_info_lin_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_info_pct_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_info_surf_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_lin_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_pct_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_a_zone_urba_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_lin_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_pct_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_surf_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_habillage_txt_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_info_lin_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_info_pct_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_info_surf_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_lin_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_pct_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_prescription_surf_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_p_zone_urba_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_lin_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_pct_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_surf_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_habillage_txt_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_info_lin_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_info_pct_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_info_surf_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_lin_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_pct_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_prescription_surf_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.geo_t_zone_urba_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.lt_destdomi_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.lt_etat_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.lt_l_secteur_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.lt_typedoc_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.lt_typeinf_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.lt_l_typeinf2_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.lt_typepsc_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.lt_l_typepsc2_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.lt_typeref_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.lt_typesect_cnig2014;
-- DROP TABLE m_urbanisme_doc_cnig2017.lt_typezone_cnig2014;

-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Supression des anciennes séquences
-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- DROP SEQUENCE m_urbanisme_doc_cnig2017.geo_a_habillage_txt_gid_seq_cnig2014;
-- DROP SEQUENCE m_urbanisme_doc_cnig2017.geo_a_info_surf_gid_seq_cnig2014;
-- DROP SEQUENCE m_urbanisme_doc_cnig2017.geo_a_prescription_surf_gid_seq_cnig2014;
-- DROP SEQUENCE m_urbanisme_doc_cnig2017.geo_a_zone_urba_gid_seq_cnig2014;

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



