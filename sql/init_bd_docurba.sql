-- ############################################################################################ SUIVI CODE SQL ###################################################################################################

-- 2018/02/23 : GB / Initialisation de la structure de la base de données pour le modèle CNIG des PLU, PLUI et CC version décembre 2017
--		GB / Ce fichier contient l'ensemble des éléments présents dans le dernier fichier d'échange avec le PNR et OLV adaptés au nouveau modèle, DDU_CNIG201410_etendu_v16.sql
--		GB / La migration des données est gérée dans le fichier DDU_CNIG2014-2017_script_integration_arc_V1.0.sql
--		GB / Toutes les données spécifiques au PNR et OLV doivent être traitée par les pertenaires concernés et intégrés dans ce fichier puis communiqués à l'ensemble des parties dans une version 2

--		GB / ATTENTION : ce fichier correspond au squellette de la base de données. il a pour objectif de suivre les évolutions structurelles du modèle. Il ne doit pas être utilisé pour une migration.
-- 2018/04/19 : GB / ATTENTION : ce code contient également la table geo_p_zone_pau intégrant les données des Parties Actuellement Urbanisées utilisées pour les communes en RNU (cette table ne fait pas partie du Standard CNIG)
--              GB / Ce code d'initialisation contient également la table an_ads_commune pour l'information des communes gérée par le droit des sols (cette table ne fait pas partie du Standard CNIG)
-- 2018/07/25 : GB / Ajout du champ optionnel l_meta et ajout des vues matérialisées ARC pour les applications websig grands publics
-- 2018/08/07 : GB / Ajout des vues matérialisées Grand Public pour l'application de consultation des documents d'urbanisme
--                 / Ajout des nouveaux profils de connexion et leur privilège suite à la modification des rôles dans la base de l'ARC
-- 2018/08/20 : GB / Intégration des vues pour traiter les données du PLUi et modification des vues applicatives filtrées sur l'ARC pour respecter la structure CNIG2017

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  SCHEMA                                                                      ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

DROP SCHEMA IF EXISTS m_urbanisme_doc;
CREATE SCHEMA m_urbanisme_doc
  AUTHORIZATION sig_create;

GRANT USAGE ON SCHEMA m_urbanisme_doc TO edit_sig;
GRANT ALL ON SCHEMA m_urbanisme_doc TO create_sig;
GRANT USAGE ON SCHEMA m_urbanisme_doc TO read_sig;
ALTER DEFAULT PRIVILEGES IN SCHEMA m_urbanisme_doc
GRANT ALL ON TABLES TO create_sig;
ALTER DEFAULT PRIVILEGES IN SCHEMA m_urbanisme_doc
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLES TO edit_sig;
ALTER DEFAULT PRIVILEGES IN SCHEMA m_urbanisme_doc
GRANT SELECT ON TABLES TO read_sig;

COMMENT ON SCHEMA m_urbanisme_doc
  IS 'Schéma contenant les données métiers relatives aux documents d''urbanisme pour le modèle CNIG2017';

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  DOMAINES DE VALEURS                                                         ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ################################################################# Domaine valeur - lt_etat #############################################

-- Table: m_urbanisme_doc.lt_etat

-- DROP TABLE m_urbanisme_doc.lt_etat;

CREATE TABLE m_urbanisme_doc.lt_etat
(
  code character(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_etat_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.lt_etat
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.lt_etat TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.lt_etat TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_etat TO edit_sig;


COMMENT ON TABLE m_urbanisme_doc.lt_etat
  IS 'Liste des valeurs de l''attribut état de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc.lt_etat.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc.lt_etat.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc.lt_etat(
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

CREATE TABLE m_urbanisme_doc.lt_typedoc
(
  code character varying(4) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_typedoc_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.lt_typedoc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.lt_typedoc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.lt_typedoc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_typedoc TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.lt_typedoc
  IS 'Liste des valeurs de l''attribut typedoc de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc.lt_typedoc.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc.lt_typedoc.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc.lt_typedoc(
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

CREATE TABLE m_urbanisme_doc.lt_typeref
(
  code character varying(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_typeref_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.lt_typeref
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.lt_typeref TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.lt_typeref TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_typeref TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.lt_typeref
  IS 'Liste des valeurs de l''attribut typeref de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc.lt_typeref.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc.lt_typeref.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc.lt_typeref(
            code, valeur)
    VALUES
    ('01','PCI'),
    ('02','BD Parcellaire'),
    ('03','RPCU'),
    ('04','Référentiel local');


-- ################################################################# Domaine valeur - lt_nomproc #############################################

-- Table: m_urbanisme_doc.lt_nomproc

-- DROP TABLE m_urbanisme_doc.lt_nomproc;

CREATE TABLE m_urbanisme_doc.lt_nomproc
(
  code character varying(3) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_nomproc_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.lt_nomproc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.lt_nomproc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.lt_nomproc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_nomproc TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.lt_nomproc
  IS 'Liste des valeurs de l''attribut Nom de la procédure de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc.lt_nomproc.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc.lt_nomproc.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc.lt_nomproc(
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

CREATE TABLE m_urbanisme_doc.lt_typezone
(
  code character varying(3) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_typezone_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.lt_typezone
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.lt_typezone TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.lt_typezone TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_typezone TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.lt_typezone
  IS 'Liste des valeurs de l''attribut typezone de la donnée zone_urba';
COMMENT ON COLUMN m_urbanisme_doc.lt_typezone.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc.lt_typezone.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc.lt_typezone(
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

CREATE TABLE m_urbanisme_doc.lt_destdomi
(
  code character (2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_destdomi_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.lt_destdomi
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.lt_destdomi TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.lt_destdomi TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_destdomi TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.lt_destdomi
  IS 'Liste des valeurs de l''attribut destdomi de la donnée zone_urba';
COMMENT ON COLUMN m_urbanisme_doc.lt_destdomi.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc.lt_destdomi.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc.lt_destdomi(
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

CREATE TABLE m_urbanisme_doc.lt_typesect
(
  code character varying(2) NOT NULL, -- Code
  valeur character varying(100) NOT NULL, -- Valeur
  CONSTRAINT lt_typesect_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.lt_typesect
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.lt_typesect TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.lt_typesect TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_typesect TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.lt_typesect
  IS 'Liste des valeurs de l''attribut typesect de la donnée zone_urba';
COMMENT ON COLUMN m_urbanisme_doc.lt_typesect.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc.lt_typesect.valeur IS 'Valeur';


INSERT INTO m_urbanisme_doc.lt_typesect(
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

CREATE TABLE m_urbanisme_doc.lt_libsect
(
  code character varying(3) NOT NULL,
  valeur character varying(100) NOT NULL,
  CONSTRAINT lt_libsect_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.lt_libsect
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.lt_libsect TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.lt_libsect TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_libsect TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.lt_libsect
  IS 'Liste des valeurs de l''attribut libelle à saisir pour la carte communale (convention de libellé pour l''affichage cartographique)';
COMMENT ON COLUMN m_urbanisme_doc.lt_libsect.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc.lt_libsect.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc.lt_libsect(
            code, valeur)
    VALUES
    ('ZC','Secteur ouvert à la construction'),
    ('ZCa','Secteur réservé aux activités'),
    ('ZnC','Secteur non ouvert à la construction, sauf exceptions prévues par la loi'),
    ('RNU','Zone non couverte par la carte communale (soumise au Règlement National de l''Urbanisme');


-- ################################################################# Domaine valeur - lt_typepsc #############################################

-- Table: m_urbanisme_doc.lt_typepsc

-- DROP TABLE m_urbanisme_doc.lt_typepsc;

CREATE TABLE m_urbanisme_doc.lt_typepsc
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
ALTER TABLE m_urbanisme_doc.lt_typepsc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.lt_typepsc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.lt_typepsc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_typepsc TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.lt_typepsc
  IS 'Liste des valeurs de l''attribut typepsc de la donnée prescription_surf, prescription_lin et prescription_pct';
COMMENT ON COLUMN m_urbanisme_doc.lt_typepsc.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc.lt_typepsc.sous_code IS 'Sous code';
COMMENT ON COLUMN m_urbanisme_doc.lt_typepsc.valeur IS 'Valeur';
COMMENT ON COLUMN m_urbanisme_doc.lt_typepsc.ref_leg IS 'Références législatives du code de l''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.lt_typepsc.ref_reg IS 'Références réglementaires du code de l''urbanisme';

INSERT INTO m_urbanisme_doc.lt_typepsc(
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

-- Table: m_urbanisme_doc.lt_typeinf

-- DROP TABLE m_urbanisme_doc.lt_typeinf;

CREATE TABLE m_urbanisme_doc.lt_typeinf
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
ALTER TABLE m_urbanisme_doc.lt_typeinf
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.lt_typeinf TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.lt_typeinf TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_typeinf TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.lt_typeinf
  IS 'Liste des valeurs de l''attribut typeinf de la donnée info_surf, info_lin et info_pct';
COMMENT ON COLUMN m_urbanisme_doc.lt_typeinf.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc.lt_typeinf.sous_code IS 'Sous code';
COMMENT ON COLUMN m_urbanisme_doc.lt_typeinf.valeur IS 'Valeur';
COMMENT ON COLUMN m_urbanisme_doc.lt_typeinf.ref_leg IS 'Références législatives du code de l''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.lt_typeinf.ref_reg IS 'Références réglementaires du code de l''urbanisme';

INSERT INTO m_urbanisme_doc.lt_typeinf(
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


-- ################################################################# Domaine valeur - lt_dispon #############################################

-- Table: m_urbanisme_doc.lt_dispon

-- DROP TABLE m_urbanisme_doc.lt_dispon;
-- 
-- CREATE TABLE m_urbanisme_doc.lt_dispon
-- (
--   code character(2) NOT NULL, -- Code
--   valeur character varying(254) NOT NULL, -- Valeur
--   CONSTRAINT lt_dispon_prkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc.lt_dispon
--   OWNER TO sig_create;
-- GRANT ALL ON TABLE m_urbanisme_doc.lt_dispon TO sig_create;
-- GRANT SELECT ON TABLE m_urbanisme_doc.lt_dispon TO read_sig;
-- GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_dispon TO edit_sig;
-- COMMENT ON TABLE m_urbanisme_doc.lt_dispon
--   IS 'Liste des valeurs de l''attribut l_dispon de la donnée doc_urba_doc';
-- COMMENT ON COLUMN m_urbanisme_doc.lt_dispon.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc.lt_dispon.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc.lt_dispon(
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
-- CREATE TABLE m_urbanisme_doc.lt_dispop
-- (
--   code character(2) NOT NULL, -- Code
--   valeur character varying(254) NOT NULL, -- Valeur
--   CONSTRAINT lt_dispop_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc.lt_dispop
--   OWNER TO sig_create;
-- GRANT ALL ON TABLE m_urbanisme_doc.lt_dispop TO sig_create;
-- GRANT SELECT ON TABLE m_urbanisme_doc.lt_dispop TO read_sig;
-- GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_dispop TO edit_sig;
-- COMMENT ON TABLE m_urbanisme_doc.lt_dispop
--   IS 'Liste des valeurs de l''attribut l_dispop de la donnée doc_urba_doc';
-- COMMENT ON COLUMN m_urbanisme_doc.lt_dispop.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc.lt_dispop.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc.lt_dispop(
--             code, valeur)
--     VALUES
--     ('00','Aucun document papier'),
--     ('10','Une partie du document (la plupart du temps le rapport de présentation, padd, règlement écrit et graphique)'),
--     ('20','Tout le document');


-- ################################################################# Domaine valeur - lt_l_themapatnat #############################################

-- Table: m_urbanisme_doc.lt_l_themapatnat

-- DROP TABLE m_urbanisme_doc.lt_l_themapatnat;
-- 
-- CREATE TABLE m_urbanisme_doc.lt_l_themapatnat
-- (
--   code character varying(10) NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_thema_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc.lt_l_themapatnat
--   OWNER TO sig_create;
-- GRANT ALL ON TABLE m_urbanisme_doc.lt_l_themapatnat TO sig_create;
-- GRANT SELECT ON TABLE m_urbanisme_doc.lt_l_themapatnat TO read_sig;
-- GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_l_themapatnat TO edit_sig;

-- COMMENT ON TABLE m_urbanisme_doc.lt_l_themapatnat
--   IS 'Liste des valeurs de l''attribut l_thema de la donnée zone_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc.lt_l_themapatnat.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc.lt_l_themapatnat.valeur IS 'Valeur';
-- 
-- 
-- INSERT INTO m_urbanisme_doc.lt_l_themapatnat(
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
-- CREATE TABLE m_urbanisme_doc.lt_l_vigipatnat
-- (
--   code character varying(10) NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_vigilance_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc.lt_l_vigipatnat
--   OWNER TO sig_create;
-- GRANT ALL ON TABLE m_urbanisme_doc.lt_l_vigipatnat TO sig_create;
-- GRANT SELECT ON TABLE m_urbanisme_doc.lt_l_vigipatnat TO read_sig;
-- GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_l_vigipatnat TO edit_sig;

-- COMMENT ON TABLE m_urbanisme_doc.lt_l_vigipatnat
--   IS 'Liste des valeurs de l''attribut l_vigilance de la donnée zone_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc.lt_l_vigipatnat.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc.lt_l_vigipatnat.valeur IS 'Valeur';
-- 
-- 
-- INSERT INTO m_urbanisme_doc.lt_l_vigipatnat(
--             code, valeur)
--     VALUES
--     ('oui','oui'),
--     ('non','non');


-- ################################################################# Domaine valeur - lt_l_pecpatnat #############################################

-- Table: m_urbanisme_doc.lt_l_pecpatnat

-- DROP TABLE m_urbanisme_doc.lt_l_pecpatnat;
-- 
-- CREATE TABLE m_urbanisme_doc.lt_l_pecpatnat
-- (
--   code character varying(50) NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_pec_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc.lt_l_pecpatnat
--   OWNER TO sig_create;
-- GRANT ALL ON TABLE m_urbanisme_doc.lt_l_pecpatnat TO sig_create;
-- GRANT SELECT ON TABLE m_urbanisme_doc.lt_l_pecpatnat TO read_sig;
-- GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_l_pecpatnat TO edit_sig;

-- COMMENT ON TABLE m_urbanisme_doc.lt_l_pecpatnat
--   IS 'Liste des valeurs de l''attribut l_prisencompte de la donnée doc_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc.lt_l_pecpatnat.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc.lt_l_pecpatnat.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc.lt_l_pecpatnat(
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
-- CREATE TABLE m_urbanisme_doc.lt_l_nspatnat
-- (
--   code bigint NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_nsynt_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc.lt_l_nspatnat
--   OWNER TO sig_create;
-- GRANT ALL ON TABLE m_urbanisme_doc.lt_l_nspatnat TO sig_create;
-- GRANT SELECT ON TABLE m_urbanisme_doc.lt_l_nspatnat TO read_sig;
-- GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.lt_l_nspatnat TO edit_sig;

-- COMMENT ON TABLE m_urbanisme_doc.lt_l_nspatnat
--   IS 'Liste des valeurs de l''attribut l_notesynth de la donnée doc_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc.lt_l_nspatnat.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc.lt_l_nspatnat.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc.lt_l_nspatnat(
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

-- Table: m_urbanisme_doc.an_doc_urba

-- DROP TABLE m_urbanisme_doc.an_doc_urba;

CREATE TABLE m_urbanisme_doc.an_doc_urba
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
  l_meta character varying(254), -- Lien http de la fiche de métadonnée
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
ALTER TABLE m_urbanisme_doc.an_doc_urba
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.an_doc_urba TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.an_doc_urba TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.an_doc_urba TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.an_doc_urba
  IS 'Ensemble des procédures des documents d''urbanisme (y compris les communes en RNU)';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.typedoc IS 'Type du document concerné';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.datappro IS 'Date d''approbation';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.datefin IS 'date de fin de validité';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.siren IS 'Code SIREN de l''intercommunalité';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.etat IS 'Etat juridique du document';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.nomproc IS 'Codage de la version du document concerné';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.l_nomprocn IS 'N° d''ordre de la procédure';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.nomreg IS 'Nom du fichier de règlement';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.urlreg IS 'URL ou URI du fichier du règlement';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.nomplan IS 'Nom du fichier du plan scanné';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.urlplan IS 'URL ou URI du fichier du plan scanné';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.urlpe IS 'Lien d''accès à l''archive zip comprenant l''ensemble des pièces écrites';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.siteweb IS 'Site web du service d''accès';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.typeref IS 'Type de référentiel utilisé';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.dateref IS 'Date du référentiel de saisie';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.l_meta IS 'Lien http de la fiche de métadonnée';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.l_moa_proc IS 'Maitre d''ouvrage de la procédure';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.l_moe_proc IS 'Maitre d''oeuvre de la procédure';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.l_moa_dmat IS 'Maitre d''ouvrage de la dématérialisation';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.l_moe_dmat IS 'Maitre d''oeuvre de la dématérialisation';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba.l_parent IS 'Identification des documents parents pour recherche des historiques entre version de documents (1 pour le premier document (élaboration, modif, mise à jour), 2 pour la révision (révision n°1, modif, mise à jour), 3 
  pour le 2nd révisoon (révision n°2, modif, mise à jour), ...)';


-- ########################################################################## table an_doc_urba_com #######################################################


-- Table: m_urbanisme_doc.an_doc_urba_com

-- DROP TABLE m_urbanisme_doc.an_doc_urba_com;

CREATE TABLE m_urbanisme_doc.an_doc_urba_com
(
  idurba character varying(30) NOT NULL, -- identifiant
  insee character varying(5) NOT NULL -- code insee de la commune 
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.an_doc_urba_com
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.an_doc_urba_com TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.an_doc_urba_com TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.an_doc_urba_com TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.an_doc_urba_com
  IS 'Donnée alphanumerique d''appartenance d''une commune à une procédure définie';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba_com.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba_com.insee IS 'Code insee de la commune';


-- ########################################################################### table geo_p_zone_urba #######################################################

-- Table: m_urbanisme_doc.geo_p_zone_urba

-- DROP TABLE m_urbanisme_doc.geo_p_zone_urba;

CREATE TABLE m_urbanisme_doc.geo_p_zone_urba
(
  idzone character varying(10) NOT NULL, -- Identifiant unique de zone
  libelle character varying(12) NOT NULL, -- Nom court de la zone
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
  l_surf_cal numeric NOT NULL, -- Surface calculée de la zone en ha
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_zone_urba_pkey PRIMARY KEY (idzone)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.geo_p_zone_urba
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_p_zone_urba TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_p_zone_urba TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_p_zone_urba TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_p_zone_urba
  IS 'Donnée géographique contenant les zonages des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.idzone IS 'Identifiant unique de zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.libelle IS 'Nom court de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.libelong IS 'Nom complet de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.typezone IS 'Type de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.l_destdomi IS 'Vocation de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.typesect IS 'Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.fermreco IS 'Secteur fermé à la reconstruction (uniquement pour la carte communale)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.l_surf_cal IS 'Surface calculée de la zone en ha';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.nomfic IS 'Nom du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.urlfic IS 'URL ou URI du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.l_nomfic IS 'Nom du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.l_urlfic IS 'URL ou URI du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_urba.idurba IS 'Identifiant du document d''urbanisme';


-- ########################################################################### geo_p_prescription_surf #######################################################

-- Table: m_urbanisme_doc.geo_p_prescription_surf

-- DROP TABLE m_urbanisme_doc.geo_p_prescription_surf;

CREATE TABLE m_urbanisme_doc.geo_p_prescription_surf
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
  geom1 geometry(MultiPolygon,2154), -- Géométrie de l'objet avec un buffer de -0.5 pour calcul de la vue an_vmr_prescription pour GEO.Champ mis à jour en automatique par un trigger à l'insertion, mise à jour du champ geom
  CONSTRAINT geo_p_prescription_surf_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.geo_p_prescription_surf
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_p_prescription_surf TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_p_prescription_surf TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_p_prescription_surf TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_p_prescription_surf
  IS 'Donnée géographique contenant les prescriptions surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.idpsc IS 'Identifiant unique de prescription surfacique';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_surf.geom1 IS 'Géométrie de l'objet avec un buffer de -0.5 pour calcul de la vue an_vmr_prescription pour GEO.Champ mis à jour en automatique par un trigger à l'insertion, mise à jour du champ geom';

-- Function: m_urbanisme_doc.m_geom1_prescription_surf()

-- DROP FUNCTION m_urbanisme_doc.m_geom1_prescription_surf();

CREATE OR REPLACE FUNCTION m_urbanisme_doc.m_geom1_prescription_surf()
  RETURNS trigger AS
$BODY$BEGIN

 UPDATE m_urbanisme_doc.geo_p_prescription_surf SET geom1 = st_multi(st_buffer(geom,-0.5));


RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc.m_geom1_prescription_surf()
  OWNER TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_geom1_prescription_surf() TO public;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_geom1_prescription_surf() TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_geom1_prescription_surf() TO create_sig;


-- Trigger: t_t1_update_geom on m_urbanisme_doc.geo_p_prescription_surf

-- DROP TRIGGER t_t1_update_geom ON m_urbanisme_doc.geo_p_prescription_surf;

CREATE TRIGGER t_t1_update_geom
  AFTER INSERT OR UPDATE OF geom
  ON m_urbanisme_doc.geo_p_prescription_surf
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc.m_geom1_prescription_surf();

-- ########################################################################### geo_p_prescription_lin #######################################################

-- Table: m_urbanisme_doc.geo_p_prescription_lin

-- DROP TABLE m_urbanisme_doc.geo_p_prescription_lin;

CREATE TABLE m_urbanisme_doc.geo_p_prescription_lin
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
  geom1 geometry(MultiPolygon,2154), -- Géométrie de l'objet avec un buffer de -0.01 pour calcul de la vue xapps_an_vmr_prescription pour GEO. Champ mis à jour en automatique par un trigger à l'insertion, mise à jour du champ geom
  CONSTRAINT geo_p_prescription_lin_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.geo_p_prescription_lin
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_p_prescription_lin TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_p_prescription_lin TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_p_prescription_lin TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_p_prescription_lin
  IS 'Donnée géographique contenant les prescriptions linéaires des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.idpsc IS 'Identifiant unique de prescription linéaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_lin.geom1 IS 'Géométrie de l'objet avec un buffer de -0.01 pour calcul de la vue xapps_an_vmr_prescription pour GEO.
Champ mis à jour en automatique par un trigger à l'insertion, mise à jour du champ geom';

-- Function: m_urbanisme_doc.m_geom1_prescription_surf()

-- DROP FUNCTION m_urbanisme_doc.m_geom1_prescription_surf();

CREATE OR REPLACE FUNCTION m_urbanisme_doc.m_geom1_prescription_lin()
  RETURNS trigger AS
$BODY$BEGIN

 UPDATE m_urbanisme_doc.geo_p_prescription_lin SET geom1 = st_multi(st_buffer(geom,0.01,'endcap=flat join=round'));

RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc.m_geom1_prescription_lin()
  OWNER TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_geom1_prescription_lin() TO public;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_geom1_prescription_lin() TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_geom1_prescription_lin() TO create_sig;


CREATE TRIGGER t_t1_update_geom
  AFTER INSERT OR UPDATE OF geom
  ON m_urbanisme_doc.geo_p_prescription_lin
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc.m_geom1_prescription_lin();
  

-- ########################################################################### geo_p_prescription_pct #######################################################

-- Table: m_urbanisme_doc.geo_p_prescription_pct

-- DROP TABLE m_urbanisme_doc.geo_p_prescription_pct;

CREATE TABLE m_urbanisme_doc.geo_p_prescription_pct
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
ALTER TABLE m_urbanisme_doc.geo_p_prescription_pct
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_p_prescription_pct TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_p_prescription_pct TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_p_prescription_pct TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_p_prescription_pct
  IS 'Donnée géographique contenant les prescriptions ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.idpsc IS 'Identifiant unique de prescription ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_prescription_pct.geom IS 'Géométrie de l''objet';


-- ################################################################################ geo_p_info_surf ##########################################################

-- Table: m_urbanisme_doc.geo_p_info_surf

-- DROP TABLE m_urbanisme_doc.geo_p_info_surf;

CREATE TABLE m_urbanisme_doc.geo_p_info_surf
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
  CONSTRAINT geo_p_info_surf_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.geo_p_info_surf
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_p_info_surf TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_p_info_surf TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_p_info_surf TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_p_info_surf
  IS 'Donnée géographique contenant les informations surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.idinf IS 'Identifiant unique de l''information surfacique';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_surf.idurba IS 'Identifiant du document d''urbanisme';

-- ################################################################################ geo_p_info_lin ##########################################################

-- Table: m_urbanisme_doc.geo_p_info_lin

-- DROP TABLE m_urbanisme_doc.geo_p_info_lin;

CREATE TABLE m_urbanisme_doc.geo_p_info_lin
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
ALTER TABLE m_urbanisme_doc.geo_p_info_lin
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_p_info_lin TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_p_info_lin TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_p_info_lin TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_p_info_lin
  IS 'Donnée géographique contenant les informations linéaires des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.idinf IS 'Identifiant unique de l''information linéaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_lin.idurba IS 'Identifiant du document d''urbanisme';


-- ################################################################################ geo_p_info_pct ##########################################################

-- Table: m_urbanisme_doc.geo_p_info_pct

-- DROP TABLE m_urbanisme_doc.geo_p_info_pct;

CREATE TABLE m_urbanisme_doc.geo_p_info_pct
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
ALTER TABLE m_urbanisme_doc.geo_p_info_pct
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_p_info_pct TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_p_info_pct TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_p_info_pct TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_p_info_pct
  IS 'Donnée géographique contenant les informations ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.idinf IS 'Identifiant unique de l''information ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_info_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_p_habillage_surf #######################################################

-- Table: m_urbanisme_doc.geo_p_habillage_surf

-- DROP TABLE m_urbanisme_doc.geo_p_habillage_surf;

CREATE TABLE m_urbanisme_doc.geo_p_habillage_surf
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
ALTER TABLE m_urbanisme_doc.geo_p_habillage_surf
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_p_habillage_surf TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_p_habillage_surf TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_p_habillage_surf TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_p_habillage_surf
  IS 'Donnée géographique contenant l''habillage surfacique des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_surf.idhab IS 'Identifiant unique de l''habillage surfacique';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_surf.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_surf.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_surf.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_surf.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_p_habillage_lin #######################################################

-- Table: m_urbanisme_doc.geo_p_habillage_lin

-- DROP TABLE m_urbanisme_doc.geo_p_habillage_lin;

CREATE TABLE m_urbanisme_doc.geo_p_habillage_lin
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
ALTER TABLE m_urbanisme_doc.geo_p_habillage_lin
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_p_habillage_lin TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_p_habillage_lin TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_p_habillage_lin TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_p_habillage_lin
  IS 'Donnée géographique contenant l''habillage linéaire des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_lin.idhab IS 'Identifiant unique de l''habillage linéaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_lin.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_lin.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_lin.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_lin.idurba IS 'Identifiant du document d''urbanisme';



-- ######################################################################## geo_p_habillage_pct #######################################################

-- Table: m_urbanisme_doc.geo_p_habillage_pct

-- DROP TABLE m_urbanisme_doc.geo_p_habillage_pct;

CREATE TABLE m_urbanisme_doc.geo_p_habillage_pct
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(Multipoint,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_habillage_pct_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.geo_p_habillage_pct
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_p_habillage_pct TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_p_habillage_pct TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_p_habillage_pct TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_p_habillage_pct
  IS 'Donnée géographique contenant l''habillage ponctuel des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_pct.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_pct.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_pct.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_pct.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_p_habillage_txt #######################################################

-- Table: m_urbanisme_doc.geo_p_habillage_txt

-- DROP TABLE m_urbanisme_doc.geo_p_habillage_txt;

CREATE TABLE m_urbanisme_doc.geo_p_habillage_txt
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
ALTER TABLE m_urbanisme_doc.geo_p_habillage_txt
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_p_habillage_txt TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_p_habillage_txt TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_p_habillage_txt TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_p_habillage_txt
  IS 'Donnée géographique contenant l''habillage textuel des documents d''urbanisme locaux (PLUi, PLU, POS) sous la forme de ponctuels';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_txt.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_txt.natecr IS 'Nature de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_txt.txt IS 'Texte de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_txt.police IS 'Police de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_txt.taille IS 'Taille de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_txt.style IS 'Style de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_txt.angle IS 'Angle de l''écriture exprimé en degré, par rapport à l''horizontale, dans le sens trigonométrique';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_txt.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_txt.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_txt.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_txt.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_habillage_txt.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';


-- ####################################################################################################################################################
-- ###                                                  	     MODE ARCHIVE                                                                   ###
-- ####################################################################################################################################################


-- ########################################################################### table geo_a_zone_urba #######################################################

-- Table: m_urbanisme_doc.geo_a_zone_urba

-- DROP TABLE m_urbanisme_doc.geo_a_zone_urba;

CREATE TABLE m_urbanisme_doc.geo_a_zone_urba
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
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.geo_a_zone_urba
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_a_zone_urba TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_a_zone_urba TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_a_zone_urba TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_a_zone_urba
  IS '(archive) Donnée géographique contenant les zonages des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.idzone IS 'Identifiant unique de zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.libelle IS 'Nom court de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.libelong IS 'Nom complet de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.typezone IS 'Type de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.l_destdomi IS 'Vocation de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.typesect IS 'Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.fermreco IS 'Secteur fermé à la reconstruction (uniquement pour la carte communale)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.l_surf_cal IS 'Surface calculée de la zone en ha';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.nomfic IS 'Nom du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.urlfic IS 'URL ou URI du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.l_nomfic IS 'Nom du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.l_urlfic IS 'URL ou URI du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_zone_urba.idurba IS 'Identifiant du document d''urbanisme';



-- ########################################################################### geo_a_prescription_surf #######################################################

-- Table: m_urbanisme_doc.geo_a_prescription_surf

-- DROP TABLE m_urbanisme_doc.geo_a_prescription_surf;

CREATE TABLE m_urbanisme_doc.geo_a_prescription_surf
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
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.geo_a_prescription_surf
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_a_prescription_surf TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_a_prescription_surf TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_a_prescription_surf TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_a_prescription_surf
  IS '(archive) Donnée géographique contenant les prescriptions surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.idpsc IS 'Identifiant unique de prescription surfacique';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_surf.geom IS 'Géométrie de l''objet';



-- ########################################################################### geo_a_prescription_lin #######################################################

-- Table: m_urbanisme_doc.geo_a_prescription_lin

-- DROP TABLE m_urbanisme_doc.geo_a_prescription_lin;

CREATE TABLE m_urbanisme_doc.geo_a_prescription_lin
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
ALTER TABLE m_urbanisme_doc.geo_a_prescription_lin
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_a_prescription_lin TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_a_prescription_lin TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_a_prescription_lin TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_a_prescription_lin
  IS '(archive) Donnée géographique contenant les prescriptions linéaires des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.idpsc IS 'Identifiant unique de prescription linéaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_lin.geom IS 'Géométrie de l''objet';


-- ########################################################################### geo_a_prescription_pct #######################################################

-- Table: m_urbanisme_doc.geo_a_prescription_pct

-- DROP TABLE m_urbanisme_doc.geo_a_prescription_pct;

CREATE TABLE m_urbanisme_doc.geo_a_prescription_pct
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
ALTER TABLE m_urbanisme_doc.geo_a_prescription_pct
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_a_prescription_pct TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_a_prescription_pct TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_a_prescription_pct TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_a_prescription_pct
  IS '(archive) Donnée géographique contenant les prescriptions ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.idpsc IS 'Identifiant unique de prescription ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_prescription_pct.geom IS 'Géométrie de l''objet';


-- ################################################################################ geo_a_info_surf ##########################################################

-- Table: m_urbanisme_doc.geo_a_info_surf

-- DROP TABLE m_urbanisme_doc.geo_a_info_surf;

CREATE TABLE m_urbanisme_doc.geo_a_info_surf
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
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.geo_a_info_surf
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_a_info_surf TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_a_info_surf TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_a_info_surf TO edit_sig;
									      
-- COMMENT GB : -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Laisser également en commentaire les lignes affectant des droits au groupe_sig si ce groupe n'existe pas dans vos structures et ajouter éventuellement les droits de vos groupes
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

COMMENT ON TABLE m_urbanisme_doc.geo_a_info_surf
  IS '(archive) Donnée géographique contenant les informations surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.idinf IS 'Identifiant unique de l''information surfacique';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_surf.idurba IS 'Identifiant du document d''urbanisme';


-- ################################################################################ geo_a_info_lin ##########################################################

-- Table: m_urbanisme_doc.geo_a_info_lin

-- DROP TABLE m_urbanisme_doc.geo_a_info_lin;

CREATE TABLE m_urbanisme_doc.geo_a_info_lin
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
ALTER TABLE m_urbanisme_doc.geo_a_info_lin
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_a_info_lin TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_a_info_lin TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_a_info_lin TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_a_info_lin
  IS '(archive) Donnée géographique contenant les informations linéaires des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.idinf IS 'Identifiant unique de l''information linéaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_lin.idurba IS 'Identifiant du document d''urbanisme';


-- ################################################################################ geo_a_info_pct ##########################################################

-- Table: m_urbanisme_doc.geo_a_info_pct

-- DROP TABLE m_urbanisme_doc.geo_a_info_pct;

CREATE TABLE m_urbanisme_doc.geo_a_info_pct
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
ALTER TABLE m_urbanisme_doc.geo_a_info_pct
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_a_info_pct TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_a_info_pct TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_a_info_pct TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_a_info_pct
  IS '(archive) Donnée géographique contenant les informations ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.idinf IS 'Identifiant unique de l''information ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_info_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_a_habillage_surf #######################################################

-- Table: m_urbanisme_doc.geo_a_habillage_surf

-- DROP TABLE m_urbanisme_doc.geo_a_habillage_surf;

CREATE TABLE m_urbanisme_doc.geo_a_habillage_surf
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
ALTER TABLE m_urbanisme_doc.geo_a_habillage_surf
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_a_habillage_surf TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_a_habillage_surf TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_a_habillage_surf TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_a_habillage_surf
  IS '(archive) Donnée géographique contenant l''habillage surfacique des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_surf.idhab IS 'Identifiant unique de l''habillage surfacique';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_surf.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_surf.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_surf.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_surf.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_a_habillage_lin #######################################################

-- Table: m_urbanisme_doc.geo_a_habillage_lin

-- DROP TABLE m_urbanisme_doc.geo_a_habillage_lin;

CREATE TABLE m_urbanisme_doc.geo_a_habillage_lin
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
ALTER TABLE m_urbanisme_doc.geo_a_habillage_lin
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_a_habillage_lin TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_a_habillage_lin TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_a_habillage_lin TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_a_habillage_lin
  IS '(archive) Donnée géographique contenant l''habillage linéaire des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_lin.idhab IS 'Identifiant unique de l''habillage linéaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_lin.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_lin.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_lin.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXE (#000000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_lin.idurba IS 'Identifiant du document d''urbanisme';



-- ######################################################################## geo_a_habillage_pct #######################################################

-- Table: m_urbanisme_doc.geo_a_habillage_pct

-- DROP TABLE m_urbanisme_doc.geo_a_habillage_pct;

CREATE TABLE m_urbanisme_doc.geo_a_habillage_pct
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme hexa (#000000)
  geom geometry(Multipoint,2154) -- Géométrie de l'objet
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.geo_a_habillage_pct
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_a_habillage_pct TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_a_habillage_pct TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_a_habillage_pct TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_a_habillage_pct
  IS '(archive) Donnée géographique contenant l''habillage ponctuel des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_pct.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_pct.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_pct.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_pct.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_a_habillage_txt #######################################################

-- Table: m_urbanisme_doc.geo_a_habillage_txt

-- DROP TABLE m_urbanisme_doc.geo_a_habillage_txt;

CREATE TABLE m_urbanisme_doc.geo_a_habillage_txt
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
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.geo_p_habillage_txt
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_p_habillage_txt TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_p_habillage_txt TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_p_habillage_txt TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_a_habillage_txt
  IS '(archive) Donnée géographique contenant l''habillage textuel des documents d''urbanisme locaux (PLUi, PLU, POS) sous la forme de ponctuels';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_txt.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_txt.natecr IS 'Nature de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_txt.txt IS 'Texte de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_txt.police IS 'Police de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_txt.taille IS 'Taille de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_txt.style IS 'Style de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_txt.angle IS 'Angle de l''écriture exprimé en degré, par rapport à l''horizontale, dans le sens trigonométrique';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_txt.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_txt.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_txt.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_txt.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_a_habillage_txt.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';



-- ####################################################################################################################################################
-- ###                                                 	      MODE TEST (pré-production)                                                            ###
-- ####################################################################################################################################################

-- ########################################################################### table geo_t_zone_urba #######################################################

-- Table: m_urbanisme_doc.geo_t_zone_urba

-- DROP TABLE m_urbanisme_doc.geo_t_zone_urba;

CREATE TABLE m_urbanisme_doc.geo_t_zone_urba
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
ALTER TABLE m_urbanisme_doc.geo_t_zone_urba
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_t_zone_urba TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_t_zone_urba TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_t_zone_urba TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_t_zone_urba
  IS '(test) Donnée géographique contenant les zonages des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.idzone IS 'Identifiant unique de zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.libelle IS 'Nom court de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.libelong IS 'Nom complet de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.typezone IS 'Type de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.l_destdomi IS 'Vocation de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.typesect IS 'Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.fermreco IS 'Secteur fermé à la reconstruction (uniquement pour la carte communale)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.l_surf_cal IS 'Surface calculée de la zone en ha';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.nomfic IS 'Nom du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.urlfic IS 'URL ou URI du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.l_nomfic IS 'Nom du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.l_urlfic IS 'URL ou URI du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_zone_urba.idurba IS 'Identifiant du document d''urbanisme';


-- ########################################################################### geo_t_prescription_surf #######################################################

-- Table: m_urbanisme_doc.geo_t_prescription_surf

-- DROP TABLE m_urbanisme_doc.geo_t_prescription_surf;

CREATE TABLE m_urbanisme_doc.geo_t_prescription_surf
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
ALTER TABLE m_urbanisme_doc.geo_t_prescription_surf
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_t_prescription_surf TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_t_prescription_surf TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_t_prescription_surf TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_t_prescription_surf
  IS '(test) Donnée géographique contenant les prescriptions surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.idpsc IS 'Identifiant unique de prescription surfacique';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_surf.geom IS 'Géométrie de l''objet';


-- ########################################################################### geo_t_prescription_lin #######################################################

-- Table: m_urbanisme_doc.geo_t_prescription_lin

-- DROP TABLE m_urbanisme_doc.geo_t_prescription_lin;

CREATE TABLE m_urbanisme_doc.geo_t_prescription_lin
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
ALTER TABLE m_urbanisme_doc.geo_t_prescription_lin
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_t_prescription_lin TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_t_prescription_lin TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_t_prescription_lin TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_t_prescription_lin
  IS '(test) Donnée géographique contenant les prescriptions linéaires des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.idpsc IS 'Identifiant unique de prescription linéaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_lin.geom IS 'Géométrie de l''objet';


-- ########################################################################### geo_t_prescription_pct #######################################################

-- Table: m_urbanisme_doc.geo_t_prescription_pct

-- DROP TABLE m_urbanisme_doc.geo_t_prescription_pct;

CREATE TABLE m_urbanisme_doc.geo_t_prescription_pct
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
ALTER TABLE m_urbanisme_doc.geo_t_prescription_pct
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_t_prescription_pct TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_t_prescription_pct TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_t_prescription_pct TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_t_prescription_pct
  IS '(test) Donnée géographique contenant les prescriptions ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.idpsc IS 'Identifiant unique de prescription ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_prescription_pct.geom IS 'Géométrie de l''objet';


-- ################################################################################ geo_t_info_surf ##########################################################

-- Table: m_urbanisme_doc.geo_t_info_surf

-- DROP TABLE m_urbanisme_doc.geo_t_info_surf;

CREATE TABLE m_urbanisme_doc.geo_t_info_surf
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
ALTER TABLE m_urbanisme_doc.geo_t_info_surf
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_t_info_surf TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_t_info_surf TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_t_info_surf TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_t_info_surf
  IS 'test) Donnée géographique contenant les informations surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.idinf IS 'Identifiant unique de l''information surfacique';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_surf.idurba IS 'Identifiant du document d''urbanisme';

-- ################################################################################ geo_t_info_lin ##########################################################

-- Table: m_urbanisme_doc.geo_t_info_lin

-- DROP TABLE m_urbanisme_doc.geo_t_info_lin;

CREATE TABLE m_urbanisme_doc.geo_t_info_lin
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
ALTER TABLE m_urbanisme_doc.geo_t_info_lin
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_t_info_lin TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_t_info_lin TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_t_info_lin TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_t_info_lin
  IS '(test) Donnée géographique contenant les informations linéaires des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.idinf IS 'Identifiant unique de l''information linéaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_lin.idurba IS 'Identifiant du document d''urbanisme';


-- ################################################################################ geo_t_info_pct ##########################################################

-- Table: m_urbanisme_doc.geo_t_info_pct

-- DROP TABLE m_urbanisme_doc.geo_t_info_pct;

CREATE TABLE m_urbanisme_doc.geo_t_info_pct
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
ALTER TABLE m_urbanisme_doc.geo_t_info_pct
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_t_info_pct TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_t_info_pct TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_t_info_pct TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_t_info_pct
  IS '(test) Donnée géographique contenant les informations ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.idinf IS 'Identifiant unique de l''information ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_info_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_t_habillage_surf #######################################################

-- Table: m_urbanisme_doc.geo_t_habillage_surf

-- DROP TABLE m_urbanisme_doc.geo_t_habillage_surf;

CREATE TABLE m_urbanisme_doc.geo_t_habillage_surf
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
ALTER TABLE m_urbanisme_doc.geo_t_habillage_surf
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_t_habillage_surf TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_t_habillage_surf TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_t_habillage_surf TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_t_habillage_surf
  IS '(test) Donnée géographique contenant l''habillage surfacique des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_surf.idhab IS 'Identifiant unique de l''habillage surfacique';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_surf.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_surf.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_surf.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_surf.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_t_habillage_lin #######################################################

-- Table: m_urbanisme_doc.geo_t_habillage_lin

-- DROP TABLE m_urbanisme_doc.geo_t_habillage_lin;

CREATE TABLE m_urbanisme_doc.geo_t_habillage_lin
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
ALTER TABLE m_urbanisme_doc.geo_t_habillage_lin
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_t_habillage_lin TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_t_habillage_lin TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_t_habillage_lin TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_t_habillage_lin
  IS '(test) Donnée géographique contenant l''habillage linéaire des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_lin.idhab IS 'Identifiant unique de l''habillage linéaire';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_lin.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_lin.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_lin.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_lin.idurba IS 'Identifiant du document d''urbanisme';



-- ######################################################################## geo_t_habillage_pct #######################################################

-- Table: m_urbanisme_doc.geo_t_habillage_pct

-- DROP TABLE m_urbanisme_doc.geo_t_habillage_pct;

CREATE TABLE m_urbanisme_doc.geo_t_habillage_pct
(
  idhab character varying(10) NOT NULL, -- Identifiant unique de l'habillage surfacique
  nattrac character varying(40) NOT NULL, -- Nature du tracé
  couleur character varying(11), -- Couleur de l'élément graphique, sous forme RVB (255-255-000)
  idurba character varying(30), -- Identifiant du document d''urbanisme
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_couleur character varying(7), -- Couleur de l'élément graphique, sous forme HEXA (#000000)
  geom geometry(Multipoint,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_habillage_pct_pkey PRIMARY KEY (idhab)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE m_urbanisme_doc.geo_t_habillage_pct
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_t_habillage_pct TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_t_habillage_pct TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_t_habillage_pct TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_t_habillage_pct
  IS '(test) Donnée géographique contenant l''habillage ponctuel des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_pct.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_pct.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_pct.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_pct.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_t_habillage_txt #######################################################

-- Table: m_urbanisme_doc.geo_t_habillage_txt

-- DROP TABLE m_urbanisme_doc.geo_t_habillage_txt;

CREATE TABLE m_urbanisme_doc.geo_t_habillage_txt
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
ALTER TABLE m_urbanisme_doc.geo_t_habillage_txt
  OWNER TO gsig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_t_habillage_txt TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_t_habillage_txt TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_t_habillage_txt TO edit_sig;

COMMENT ON TABLE m_urbanisme_doc.geo_t_habillage_txt
  IS '(test) Donnée géographique contenant l''habillage textuel des documents d''urbanisme locaux (PLUi, PLU, POS) sous la forme de ponctuels';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_txt.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_txt.natecr IS 'Nature de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_txt.txt IS 'Texte de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_txt.police IS 'Police de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_txt.taille IS 'Taille de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_txt.style IS 'Style de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_txt.angle IS 'Angle de l''écriture exprimé en degré, par rapport à l''horizontale, dans le sens trigonométrique';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_txt.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_txt.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_txt.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_txt.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc.geo_t_habillage_txt.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                       TABLES METIERS DOCUMENTS D'URBANISME (hors standard CNIG spécifique ARC)                               ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ######################################################################## an_ads_commune #######################################################

-- Table: m_urbanisme_doc.an_ads_commune

-- DROP TABLE m_urbanisme_doc.an_ads_commune;

CREATE TABLE m_urbanisme_doc.an_ads_commune
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
ALTER TABLE m_urbanisme_doc.an_ads_commune
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.an_ads_commune TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.an_ads_commune TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.an_ads_commune TO edit_sig;
									      
COMMENT ON TABLE m_urbanisme_doc.an_ads_commune
  IS 'Donnée source sur l''état de l''ADS ARC sur les communes';
COMMENT ON COLUMN m_urbanisme_doc.an_ads_commune.insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc.an_ads_commune.docurba IS 'Présence d''un document d''urbanisme (PLUi,PLU,POS,CC)';
COMMENT ON COLUMN m_urbanisme_doc.an_ads_commune.ads_arc IS 'Gestion de l''ADS par l''ARC';
COMMENT ON COLUMN m_urbanisme_doc.an_ads_commune.l_rev IS 'Information sur la révision en cours ou non du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc.an_ads_commune.l_daterev IS 'Date de prescripiton de la révision';



-- ######################################################################## geo_p_zone_pau #######################################################

-- Sequence: m_urbanisme_doc.idpau_seq

-- DROP SEQUENCE m_urbanisme_doc.idpau_seq;

CREATE SEQUENCE m_urbanisme_doc.idpau_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 99999999999999999
  START 1
  CACHE 1;
ALTER TABLE m_urbanisme_doc.idpau_seq
  OWNER TO sig_create;
GRANT ALL ON SEQUENCE m_urbanisme_doc.idpau_seq TO sig_create;
GRANT SELECT, USAGE ON SEQUENCE m_urbanisme_doc.idpau_seq TO public;



-- Table: m_urbanisme_doc.geo_p_zone_pau

-- DROP TABLE m_urbanisme_doc.geo_p_zone_pau;

CREATE TABLE m_urbanisme_doc.geo_p_zone_pau
(
  idpau integer NOT NULL DEFAULT nextval('m_urbanisme_doc.idpau_seq'::regclass), -- Identifiant géographique
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
ALTER TABLE m_urbanisme_doc.geo_p_zone_pau
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_p_zone_pau TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_p_zone_pau TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_p_zone_pau TO edit_sig;
									      
COMMENT ON TABLE m_urbanisme_doc.geo_p_zone_pau
  IS 'Table géométriquer contenant la délimitation des PAU (partie à urbaniser) dans le cadre d''une commune en RNU';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_pau.idpau IS 'Identifiant géographique';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_pau.date_sai IS 'Date de saisie des données';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_pau.date_maj IS 'Date de mise à jour';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_pau.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_pau.org_sai IS 'Organisme de saisie';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_pau.insee IS 'Code Insee de la commune';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_pau.commune IS 'Libellé de la commune';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_pau.src_geom IS 'Référentiel spatila utilisé pour la saisie';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_pau.sup_m2 IS 'Surface brute de l''objet en m²';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_pau.l_type IS 'Type de bâti intégré à la PAU';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_pau.l_statut IS 'Prise en compte de la PAU (oui : en RNU, non : documents d''urbaniusme en vigieur)';
COMMENT ON COLUMN m_urbanisme_doc.geo_p_zone_pau.geom IS 'Champ contenant la géométrie des objets';

-- Index: m_urbanisme_doc.geo_p_zone_pau_geom_idx

-- DROP INDEX m_urbanisme_doc.geo_p_zone_pau_geom_idx;

CREATE INDEX geo_p_zone_pau_geom_idx
  ON m_urbanisme_doc.geo_p_zone_pau
  USING gist
  (geom);


-- Trigger: t_t1_pau_inseecommune on m_urbanisme_doc.geo_p_zone_pau

-- DROP TRIGGER t_t1_pau_inseecommune ON m_urbanisme_doc.geo_p_zone_pau;

CREATE TRIGGER t_t1_pau_inseecommune
  BEFORE INSERT
  ON m_urbanisme_doc.geo_p_zone_pau
  FOR EACH ROW
  EXECUTE PROCEDURE public.r_commune_s();

-- Trigger: t_t2_pau_insert_date_sai on m_urbanisme_doc.geo_p_zone_pau

-- DROP TRIGGER t_t2_pau_insert_date_sai ON m_urbanisme_doc.geo_p_zone_pau;

CREATE TRIGGER t_t2_pau_insert_date_sai
  BEFORE INSERT
  ON m_urbanisme_doc.geo_p_zone_pau
  FOR EACH ROW
  EXECUTE PROCEDURE public.r_timestamp_sai();

-- Trigger: t_t3_pau_update_date_maj on m_urbanisme_doc.geo_p_zone_pau

-- DROP TRIGGER t_t3_pau_update_date_maj ON m_urbanisme_doc.geo_p_zone_pau;

CREATE TRIGGER t_t3_pau_update_date_maj
  BEFORE UPDATE
  ON m_urbanisme_doc.geo_p_zone_pau
  FOR EACH ROW
  EXECUTE PROCEDURE public.r_timestamp_maj();

-- Trigger: t_t4_pau_surface on m_urbanisme_doc.geo_p_zone_pau

-- DROP TRIGGER t_t4_pau_surface ON m_urbanisme_doc.geo_p_zone_pau;

CREATE TRIGGER t_t4_pau_surface
  BEFORE INSERT OR UPDATE
  ON m_urbanisme_doc.geo_p_zone_pau
  FOR EACH ROW
  EXECUTE PROCEDURE public.r_sup_m2_maj();


-- ####################################################################################################################################################
-- ###                                         		  TABLES SPECIFIQUES AU PNR ET OLV                                                          ###
-- ####################################################################################################################################################

-- Table: m_urbanisme_doc.an_doc_urba_doc

-- DROP TABLE m_urbanisme_doc.an_doc_urba_doc;
-- 
-- CREATE TABLE m_urbanisme_doc.an_doc_urba_doc
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
-- ALTER TABLE m_urbanisme_doc.an_doc_urba_doc
--   OWNER TO sig_create
-- GRANT ALL ON TABLE m_urbanisme_doc.an_doc_urba_doc TO sig_create;
-- GRANT SELECT ON TABLE m_urbanisme_doc.an_doc_urba_doc TO read_sig;
-- GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.an_doc_urba_doc TO edit_sig;
									      
-- COMMENT ON TABLE m_urbanisme_doc.an_doc_urba_doc
--   IS 'Donnée alphanumérique sur la disponibilité des documents numériques ou papiers à Oise-la-Vallée ou au Parc naturel régional Oise-Pays de France, le gestionnaire des données dans la base';
-- COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba_doc.idurba IS 'identifiant du document d''urbanisme';
-- COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba_doc.l_gest IS 'Type d''organisme qui gère la donnée dans la base (intégration et/ou mise à jour)';
-- COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba_doc.l_dispon IS 'Niveau de disponibilité le plus élevé des documents numériques';
-- COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba_doc.l_dispop IS 'Niveau de disponibilité le plus élevé des documents papiers';
-- COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba_doc.l_datproc IS 'date de lancement de la procédure';
-- COMMENT ON COLUMN m_urbanisme_doc.an_doc_urba_doc.l_observ IS 'observation';



-- permet d’identifier les zonages prenant en compte l’existence d’un enjeux patrimoine naturel
-- Table: m_urbanisme_doc.an_zone_patnat

-- DROP TABLE m_urbanisme_doc.an_zone_patnat;
-- 
-- CREATE TABLE m_urbanisme_doc.an_zone_patnat
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
-- ALTER TABLE m_urbanisme_doc.an_zone_patnat
--   OWNER TO sig_create;
-- GRANT ALL ON TABLE m_urbanisme_doc.an_zone_patnat TO sig_create;
-- GRANT SELECT ON TABLE m_urbanisme_doc.an_zone_patnat TO read_sig;
-- GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.an_zone_patnat TO edit_sig;
									      
-- COMMENT ON TABLE m_urbanisme_doc.an_zone_patnat
--   IS 'permet de gérer l''intégration des enjeux de patrimoine naturel dans les PLU';
-- COMMENT ON COLUMN m_urbanisme_doc.an_zone_patnat.idzone IS 'fait le lien avec le zonage concerné';
-- COMMENT ON COLUMN m_urbanisme_doc.an_zone_patnat.l_thema IS 'précise la procédure ou l outil reglementaire principal utilisé pour intégrer les enjeux de patrimoine naturel';
-- COMMENT ON COLUMN m_urbanisme_doc.an_zone_patnat.l_vigilance IS 'type booléen permet de signaler les zonages nécessitant une vigilance particulière sur la prise en compte réelle des enjeux de patrimoine naturel (oui/non)';
-- COMMENT ON COLUMN m_urbanisme_doc.an_zone_patnat.l_remarque IS 'permet de préciser toutes informations utiles ';
-- COMMENT ON COLUMN m_urbanisme_doc.an_zone_patnat.id_z_patnat IS 'identifiant unique';


-- permet de juger de la prise en compte global des enjeux patrimoine naturel par le document d’urbanisme 
-- Table: m_urbanisme_doc.an_doc_patnat

-- DROP TABLE m_urbanisme_doc.an_doc_patnat;
-- 
-- CREATE TABLE m_urbanisme_doc.an_doc_patnat
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
-- ALTER TABLE m_urbanisme_doc.an_doc_patnat
--   OWNER TO sig_create;
-- GRANT ALL ON TABLE m_urbanisme_doc.an_doc_patnat TO sig_create;
-- GRANT SELECT ON TABLE m_urbanisme_doc.an_doc_patnat TO read_sig;
-- GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.an_doc_patnat TO edit_sig;
									      
-- COMMENT ON TABLE m_urbanisme_doc.an_doc_patnat
--   IS 'permet de gérer intégration des enjeux de patrimoine naturel dans les PLU';
-- COMMENT ON COLUMN m_urbanisme_doc.an_doc_patnat.idurba IS 'fait le lien avec le document concerné';
-- COMMENT ON COLUMN m_urbanisme_doc.an_doc_patnat.l_prisencompte IS 'précise le niveau de prise en compte des enjeux de patrimoine naturel par le PLU';
-- COMMENT ON COLUMN m_urbanisme_doc.an_doc_patnat.l_notesynth IS 'note globale pour apprecier la prise en compte des enjeux (de 1 à 4)';
-- COMMENT ON COLUMN m_urbanisme_doc.an_doc_patnat.l_comment IS 'permet de préciser toutes informations utiles ';
-- COMMENT ON COLUMN m_urbanisme_doc.an_doc_patnat.id_d_patnat IS 'identifiant unique';


-- création de la table permettant de noter les différents changements réalisés sur la base (qui, quand, pourquoi)
-- 
-- CREATE TABLE m_urbanisme_doc.an_suivi_maj
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
-- ALTER TABLE m_urbanisme_doc.an_suivi_maj
--   OWNER TO sig_create;
-- GRANT ALL ON TABLE m_urbanisme_doc.an_suivi_maj TO sig_create;
-- GRANT SELECT ON TABLE m_urbanisme_doc.an_suivi_maj TO read_sig;
-- GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.an_suivi_maj TO edit_sig;
									      
-- COMMENT ON TABLE m_urbanisme_doc.an_suivi_maj
--   IS 'table permettant de noter toute modification sur la base (données et structure)';
-- COMMENT ON COLUMN m_urbanisme_doc.an_suivi_maj.l_structure IS 'nom de la structure ';
-- COMMENT ON COLUMN m_urbanisme_doc.an_suivi_maj.l_operateur IS 'nom de la personne responsable des modifications';
-- COMMENT ON COLUMN m_urbanisme_doc.an_suivi_maj.l_comment IS 'précision concernant les modifications réalisées';
-- COMMENT ON COLUMN m_urbanisme_doc.an_suivi_maj.idmaj IS 'identifiant unique';


-- ajout du champ l_datmaj dans la structure existante

-- création du champs l_datmaj chargé de conserver la date de la dernière modification effectuée
-- 
-- alter table m_urbanisme_doc.geo_t_habillage_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_p_prescription_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_p_info_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_p_prescription_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.an_doc_patnat add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.an_doc_urba_doc add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_a_habillage_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_a_habillage_txt add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_a_habillage_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_a_habillage_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.an_doc_urba add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_a_zone_urba add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.an_zone_patnat add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_p_habillage_txt add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.an_doc_urba_com add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_a_info_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_p_habillage_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_a_prescription_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_p_habillage_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_p_habillage_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_a_info_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_a_prescription_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_a_prescription_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_a_info_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_p_info_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_p_info_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_p_prescription_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_t_zone_urba add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_p_zone_urba add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_t_habillage_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_t_prescription_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_t_prescription_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_t_prescription_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_t_habillage_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_t_habillage_txt add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_t_info_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_t_info_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc.geo_t_info_surf add column l_datmaj timestamp ;



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                           FKEY (clé étrangère)                                                               ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- Table: m_urbanisme_doc.an_doc_urba

ALTER TABLE m_urbanisme_doc.an_doc_urba
ADD CONSTRAINT lt_etat_fkey FOREIGN KEY (etat)
      REFERENCES m_urbanisme_doc.lt_etat (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typedoc_fkey FOREIGN KEY (typedoc)
      REFERENCES m_urbanisme_doc.lt_typedoc (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typeref_fkey FOREIGN KEY (typeref)
      REFERENCES m_urbanisme_doc.lt_typeref (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_nomproc_fkey FOREIGN KEY (nomproc)
      REFERENCES m_urbanisme_doc.lt_nomproc (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_p_zone_urba

ALTER TABLE m_urbanisme_doc.geo_p_zone_urba
ADD CONSTRAINT lt_typezone_fkey FOREIGN KEY (typezone)
      REFERENCES m_urbanisme_doc.lt_typezone (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_destdomi_fkey FOREIGN KEY (l_destdomi)
      REFERENCES m_urbanisme_doc.lt_destdomi (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typesect_fkey FOREIGN KEY (typesect)
      REFERENCES m_urbanisme_doc.lt_typesect (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_p_prescription_surf

ALTER TABLE m_urbanisme_doc.geo_p_prescription_surf
ADD CONSTRAINT lt_typepsc_surf_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_p_prescription_lin

ALTER TABLE m_urbanisme_doc.geo_p_prescription_lin
ADD CONSTRAINT lt_typepsc_lin_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_p_prescription_pct

ALTER TABLE m_urbanisme_doc.geo_p_prescription_pct
ADD CONSTRAINT lt_typepsc_pct_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_p_info_surf

ALTER TABLE m_urbanisme_doc.geo_p_info_surf
ADD CONSTRAINT lt_typeinf_surf_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc.geo_p_info_lin

ALTER TABLE m_urbanisme_doc.geo_p_info_lin
ADD CONSTRAINT lt_typeinf_lin_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_p_info_pct

ALTER TABLE m_urbanisme_doc.geo_p_info_pct
ADD CONSTRAINT lt_typeinf_pct_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

    
-- Table: m_urbanisme_doc.geo_a_zone_urba

ALTER TABLE m_urbanisme_doc.geo_a_zone_urba
ADD CONSTRAINT lt_typezone_fkey FOREIGN KEY (typezone)
      REFERENCES m_urbanisme_doc.lt_typezone (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_destdomi_fkey FOREIGN KEY (l_destdomi)
      REFERENCES m_urbanisme_doc.lt_destdomi (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typesect_fkey FOREIGN KEY (typesect)
      REFERENCES m_urbanisme_doc.lt_typesect (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_a_prescription_surf

ALTER TABLE m_urbanisme_doc.geo_a_prescription_surf
ADD CONSTRAINT lt_typepsc_surf_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_a_prescription_lin

ALTER TABLE m_urbanisme_doc.geo_a_prescription_lin
ADD CONSTRAINT lt_typepsc_lin_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_a_prescription_pct

ALTER TABLE m_urbanisme_doc.geo_a_prescription_pct
ADD CONSTRAINT lt_typepsc_pct_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_a_info_surf

ALTER TABLE m_urbanisme_doc.geo_a_info_surf
ADD CONSTRAINT lt_typeinf_surf_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc.geo_a_info_lin

ALTER TABLE m_urbanisme_doc.geo_a_info_lin
ADD CONSTRAINT lt_typeinf_lin_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_a_info_pct

ALTER TABLE m_urbanisme_doc.geo_a_info_pct
ADD CONSTRAINT lt_typeinf_pct_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;  


-- Table: m_urbanisme_doc.geo_t_zone_urba

ALTER TABLE m_urbanisme_doc.geo_t_zone_urba
ADD CONSTRAINT lt_typezone_fkey FOREIGN KEY (typezone)
      REFERENCES m_urbanisme_doc.lt_typezone (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_destdomi_fkey FOREIGN KEY (l_destdomi)
      REFERENCES m_urbanisme_doc.lt_destdomi (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typesect_fkey FOREIGN KEY (typesect)
      REFERENCES m_urbanisme_doc.lt_typesect (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_t_prescription_surf

ALTER TABLE m_urbanisme_doc.geo_t_prescription_surf
ADD CONSTRAINT lt_typepsc_surf_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_t_prescription_lin

ALTER TABLE m_urbanisme_doc.geo_t_prescription_lin
ADD CONSTRAINT lt_typepsc_lin_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_t_prescription_pct

ALTER TABLE m_urbanisme_doc.geo_t_prescription_pct
ADD CONSTRAINT lt_typepsc_pct_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_t_info_surf

ALTER TABLE m_urbanisme_doc.geo_t_info_surf
ADD CONSTRAINT lt_typeinf_surf_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc.geo_t_info_lin

ALTER TABLE m_urbanisme_doc.geo_t_info_lin
ADD CONSTRAINT lt_typeinf_lin_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.geo_t_info_pct

ALTER TABLE m_urbanisme_doc.geo_t_info_pct
ADD CONSTRAINT lt_typeinf_pct_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;  


-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Clé étrangère des tables spécifiques métiers au PNR et OLV
-- A décommenter pour intégration (à vérifier au préalable par le PNR et OLV)
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Table: m_urbanisme_doc.an_doc_urba_doc
-- 
-- ALTER TABLE m_urbanisme_doc.an_doc_urba_doc
-- ADD CONSTRAINT dispon_fkey FOREIGN KEY (l_dispon)
--       REFERENCES m_urbanisme_doc.lt_dispon (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION,
-- ADD CONSTRAINT dispop_fkey FOREIGN KEY (l_dispop)
--       REFERENCES m_urbanisme_doc.lt_dispop (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc.an_zone_patnat
-- 
-- ALTER TABLE m_urbanisme_doc.an_zone_patnat
--   ADD CONSTRAINT lt_l_themapatnat_fkey FOREIGN KEY (l_thema)
--       REFERENCES m_urbanisme_doc.lt_l_themapatnat (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;
-- 
-- ALTER TABLE m_urbanisme_doc.an_zone_patnat
--   ADD CONSTRAINT lt_l_vigipatnat_fkey FOREIGN KEY (l_vigilance)
--       REFERENCES m_urbanisme_doc.lt_l_vigipatnat (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc.an_doc_patnat
-- 
-- ALTER TABLE m_urbanisme_doc.an_doc_patnat
--   ADD CONSTRAINT lt_l_pecpatnat_fkey FOREIGN KEY (l_prisencompte)
--       REFERENCES m_urbanisme_doc.lt_l_pecpatnat (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;

-- ALTER TABLE m_urbanisme_doc.an_doc_patnat
--   ADD CONSTRAINT lt_l_nspatnat_fkey FOREIGN KEY (l_notesynth)
--       REFERENCES m_urbanisme_doc.lt_l_nspatnat (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     TRIGGER                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ####################################################### FONCTION TRIGGER - update_geom #############################################################

-- Function: m_urbanisme_doc.an_doc_urba_null()

-- DROP FUNCTION m_urbanisme_doc.an_doc_urba_null();

CREATE OR REPLACE FUNCTION m_urbanisme_doc.an_doc_urba_null()
  RETURNS trigger AS
$BODY$BEGIN
	update m_urbanisme_doc.an_doc_urba set datefin=null where datefin='';
	update m_urbanisme_doc.an_doc_urba set nomproc=null where nomproc='';
	update m_urbanisme_doc.an_doc_urba set l_moa_proc=null where l_moa_proc='';
	update m_urbanisme_doc.an_doc_urba set l_moe_proc=null where l_moe_proc='';
	update m_urbanisme_doc.an_doc_urba set l_moa_dmat=null where l_moa_dmat='';
	update m_urbanisme_doc.an_doc_urba set l_moe_dmat=null where l_moe_dmat='';
	update m_urbanisme_doc.an_doc_urba set l_observ=null where l_observ='';
        update m_urbanisme_doc.an_doc_urba set l_meta=null where l_meta='';
	update m_urbanisme_doc.an_doc_urba set nomreg=null where nomreg='';
	update m_urbanisme_doc.an_doc_urba set urlreg=null where urlreg='';
	update m_urbanisme_doc.an_doc_urba set nomplan=null where nomplan='';
	update m_urbanisme_doc.an_doc_urba set urlplan=null where urlplan='';
	update m_urbanisme_doc.an_doc_urba set urlpe=null where urlpe='';
	update m_urbanisme_doc.an_doc_urba set siteweb=null where siteweb='';
	update m_urbanisme_doc.an_doc_urba set dateref=null where dateref='';
RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc.an_doc_urba_null()
  OWNER TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.an_doc_urba_null() TO public;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.an_doc_urba_null() TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.an_doc_urba_null() TO create_sig;

COMMENT ON FUNCTION m_urbanisme_doc.an_doc_urba_null() IS 'Fonction remplaçant les '' par null lors de la mise à jour ou de l''insertion via le module web de gestion PNR/OLV';


-- Trigger: t_t1_r_null_an_doc_urba on m_urbanisme_doc.an_doc_urba

-- DROP TRIGGER t_t1_r_null_an_doc_urba ON m_urbanisme_doc.an_doc_urba;

CREATE TRIGGER t_t1_r_null_an_doc_urba
  AFTER INSERT OR UPDATE
  ON m_urbanisme_doc.an_doc_urba
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc.an_doc_urba_null();


-- Function: m_urbanisme_doc.m_geom1_prescription_surf()

-- DROP FUNCTION m_urbanisme_doc.m_geom1_prescription_surf();

CREATE OR REPLACE FUNCTION m_urbanisme_doc.m_geom1_prescription_surf()
  RETURNS trigger AS
$BODY$BEGIN

 UPDATE m_urbanisme_doc.geo_p_prescription_surf SET geom1 = st_multi(st_buffer(geom,-0.5));


RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc.m_geom1_prescription_surf()
  OWNER TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_geom1_prescription_surf() TO public;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_geom1_prescription_surf() TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_geom1_prescription_surf() TO create_sig;


-- Trigger: update_geom on m_urbanisme_doc.geo_p_prescription_surf

-- DROP TRIGGER update_geom ON m_urbanisme_doc.geo_p_prescription_surf;

CREATE TRIGGER update_geom
  AFTER INSERT OR UPDATE OF geom
  ON m_urbanisme_doc.geo_p_prescription_surf
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc.m_geom1_prescription_surf();


-- Function: m_urbanisme_doc.m_geom1_information_surf()

-- DROP FUNCTION m_urbanisme_doc.m_geom1_information_surf();

CREATE OR REPLACE FUNCTION m_urbanisme_doc.m_geom1_information_surf()
  RETURNS trigger AS
$BODY$BEGIN

 UPDATE m_urbanisme_doc.geo_p_info_surf SET geom1 = st_multi(st_buffer(geom,-0.5)); 
 UPDATE m_urbanisme_doc.geo_p_info_surf SET geom1 = st_multi(st_buffer(geom,-1.5)) where typeinf || stypeinf='0400';

RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc.m_geom1_information_surf()
  OWNER TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_geom1_information_surf() TO public;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_geom1_information_surf() TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_geom1_information_surf() TO create_sig;


-- Trigger: update_geom on m_urbanisme_doc.geo_p_info_surf

-- DROP TRIGGER update_geom ON m_urbanisme_doc.geo_p_info_surf;

CREATE TRIGGER update_geom
  AFTER INSERT OR UPDATE OF geom
  ON m_urbanisme_doc.geo_p_info_surf
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc.m_geom1_information_surf();


-- ####################################################### FONCTION TRIGGER - m_l_surf_cal_ha ##################################################

-- Function: m_urbanisme_doc.m_l_surf_cal_ha()

-- DROP FUNCTION m_urbanisme_doc.m_l_surf_cal_ha();

CREATE OR REPLACE FUNCTION m_urbanisme_doc.m_l_surf_cal_ha()
  RETURNS trigger AS
$BODY$BEGIN
NEW.l_surf_cal=round(cast(st_area(new.geom)/10000 as numeric),2);
RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc.m_l_surf_cal_ha()
  OWNER TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_l_surf_cal_ha() TO public;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_l_surf_cal_ha() TO sig_create;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc.m_l_surf_cal_ha() TO create_sig;
								       
COMMENT ON FUNCTION m_urbanisme_doc.m_l_surf_cal_ha() IS 'Fonction dont l''objet est de mettre à jour la superficie calculée en ha du champ l_surf_cal des zones urba';

-- Trigger: l_surface on m_urbanisme_doc.geo_p_zone_urba

-- DROP TRIGGER l_surface ON m_urbanisme_doc.geo_p_zone_urba

CREATE TRIGGER l_surf_cal
  BEFORE INSERT OR UPDATE OF geom
  ON m_urbanisme_doc.geo_p_zone_urba
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc.m_l_surf_cal_ha();


-- Trigger: l_surface on m_urbanisme_doc.geo_t_zone_urba

-- DROP TRIGGER l_surface ON m_urbanisme_doc.geo_t_zone_urba;

CREATE TRIGGER l_surf_cal
  BEFORE INSERT OR UPDATE OF geom
  ON m_urbanisme_doc.geo_t_zone_urba
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc.m_l_surf_cal_ha();



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
-- ###                                                         VUES PRO (spécifiques ARC)                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- View: m_urbanisme_doc.an_v_docurba_arcba

DROP VIEW IF EXISTS m_urbanisme_doc.an_v_docurba_arcba;

CREATE OR REPLACE VIEW m_urbanisme_doc.an_v_docurba_arcba AS 
 SELECT an_doc_urba.idurba,
    "substring"(an_doc_urba.idurba::text, 1, 5) AS insee,
    geo_osm_commune.commune,
    an_doc_urba.typedoc,
    an_doc_urba.datappro,
    lt_nomproc.valeur ||
    CASE WHEN an_doc_urba.l_nomprocn is null THEN '' ELSE ' n° ' || an_doc_urba.l_nomprocn END as procedure,
    lt_etat.valeur as etat
   FROM m_urbanisme_doc.an_doc_urba,
    m_urbanisme_doc.lt_etat,
    r_osm.geo_osm_commune,
    r_osm.geo_vm_osm_epci,
    m_urbanisme_doc.lt_nomproc
  WHERE lt_etat.code = an_doc_urba.etat AND lt_nomproc.code = an_doc_urba.nomproc AND "substring"(an_doc_urba.idurba::text, 1, 5) = geo_osm_commune.insee::text AND st_intersects(st_centroid(geo_osm_commune.geom), geo_vm_osm_epci.geom) 
  AND geo_vm_osm_epci.cepci::text = '200067965'::text
  ORDER BY an_doc_urba.idurba;

ALTER TABLE m_urbanisme_doc.an_v_docurba_arcba
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.an_v_docurba_arcba TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.an_v_docurba_arcba TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.an_v_docurba_arcba TO edit_sig;
								       
COMMENT ON VIEW m_urbanisme_doc.an_v_docurba_arcba
  IS 'Vue ARC simplifiée de la table an_doc_urba à usage interne.
Ajout nom de la commune et du libellé de l''état du document';

-- View: m_urbanisme_doc.an_v_docurba_cclo

DROP VIEW IF EXISTS m_urbanisme_doc.an_v_docurba_cclo;

CREATE OR REPLACE VIEW m_urbanisme_doc.an_v_docurba_cclo AS 
 SELECT an_doc_urba.idurba,
    "substring"(an_doc_urba.idurba::text, 1, 5) AS insee,
    geo_osm_commune.commune,
    an_doc_urba.typedoc,
    an_doc_urba.datappro,
    lt_nomproc.valeur ||
    CASE WHEN an_doc_urba.l_nomprocn is null THEN '' ELSE ' n° ' || an_doc_urba.l_nomprocn END as procedure,
    lt_etat.valeur as etat
   FROM m_urbanisme_doc.an_doc_urba,
    m_urbanisme_doc.lt_etat,
    r_osm.geo_osm_commune,
    r_osm.geo_vm_osm_epci,
    m_urbanisme_doc.lt_nomproc
  WHERE lt_etat.code = an_doc_urba.etat AND lt_nomproc.code = an_doc_urba.nomproc AND "substring"(an_doc_urba.idurba::text, 1, 5) = geo_osm_commune.insee::text AND st_intersects(st_centroid(geo_osm_commune.geom), geo_vm_osm_epci.geom) AND geo_vm_osm_epci.cepci::text = '246000749'::text
  ORDER BY an_doc_urba.idurba;

ALTER TABLE m_urbanisme_doc.an_v_docurba_cclo
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.an_v_docurba_cclo TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.an_v_docurba_cclo TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.an_v_docurba_cclo TO edit_sig;
								       
COMMENT ON VIEW m_urbanisme_doc.an_v_docurba_cclo
  IS 'Vue CCLO simplifiée de la table an_doc_urba à usage interne.
Ajout nom de la commune et du libellé de l''état du document';


-- View: m_urbanisme_doc.an_v_docurba_ccpe

DROP VIEW IF EXISTS m_urbanisme_doc.an_v_docurba_ccpe;

CREATE OR REPLACE VIEW m_urbanisme_doc.an_v_docurba_ccpe AS 
 SELECT an_doc_urba.idurba,
    "substring"(an_doc_urba.idurba::text, 1, 5) AS insee,
    geo_osm_commune.commune,
    an_doc_urba.typedoc,
    an_doc_urba.datappro,
    lt_nomproc.valeur ||
    CASE WHEN an_doc_urba.l_nomprocn is null THEN '' ELSE ' n° ' || an_doc_urba.l_nomprocn END as procedure,
    lt_etat.valeur as etat
   FROM m_urbanisme_doc.an_doc_urba,
    m_urbanisme_doc.lt_etat,
    r_osm.geo_osm_commune,
    r_osm.geo_vm_osm_epci,
    m_urbanisme_doc.lt_nomproc
  WHERE lt_etat.code = an_doc_urba.etat AND lt_nomproc.code = an_doc_urba.nomproc AND "substring"(an_doc_urba.idurba::text, 1, 5) = geo_osm_commune.insee::text AND st_intersects(st_centroid(geo_osm_commune.geom), geo_vm_osm_epci.geom) AND geo_vm_osm_epci.cepci::text = '246000897'::text
  ORDER BY an_doc_urba.idurba;

ALTER TABLE m_urbanisme_doc.an_v_docurba_ccpe
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.an_v_docurba_ccpe TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.an_v_docurba_ccpe TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.an_v_docurba_ccpe TO edit_sig;
								       
COMMENT ON VIEW m_urbanisme_doc.an_v_docurba_ccpe
  IS 'Vue CCPE simplifiée de la table an_doc_urba à usage interne.
Ajout nom de la commune et du libellé de l''état du document';


-- View: m_urbanisme_doc.an_v_docurba_valide

DROP VIEW IF EXISTS m_urbanisme_doc.an_v_docurba_valide;

CREATE OR REPLACE VIEW m_urbanisme_doc.an_v_docurba_valide AS 
 SELECT "substring"(an_doc_urba.idurba::text, 1, 5) AS insee,
    an_doc_urba.typedoc,
    to_date(an_doc_urba.datappro::text, 'YYYYMMDD'::text) AS datappro,
    lt_nomproc.valeur ||
    CASE WHEN an_doc_urba.l_nomprocn is null THEN '' ELSE ' n° ' || an_doc_urba.l_nomprocn END as procedure
   FROM m_urbanisme_doc.an_doc_urba, m_urbanisme_doc.lt_nomproc 
  WHERE an_doc_urba.nomproc=lt_nomproc.code AND an_doc_urba.etat = '03'::bpchar
  ORDER BY "substring"(an_doc_urba.idurba::text, 1, 5);

ALTER TABLE m_urbanisme_doc.an_v_docurba_valide
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.an_v_docurba_valide TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.an_v_docurba_valide TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.an_v_docurba_valide TO edit_sig;
								       
COMMENT ON VIEW m_urbanisme_doc.an_v_docurba_valide
  IS 'Liste des documents d''urbanisme valide sur les communes du Pays Compiégnois';


-- Materialized View: x_apps.xapps_an_vmr_p_information

DROP MATERIALIZED VIEW x_apps.xapps_an_vmr_p_information;

CREATE MATERIALIZED VIEW x_apps.xapps_an_vmr_p_information AS 
 WITH r_p AS (
         WITH r_pct AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    ((((geo_p_info_pct.libelle::text ||
                        CASE
                            WHEN length(geo_p_info_pct.l_nom::text) <> 0 THEN ' Nom : '::text || geo_p_info_pct.l_nom::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_pct.l_dateins) <> 0 THEN (chr(10) || ' Instauré(e) le : '::text) || to_char(to_date(geo_p_info_pct.l_dateins::text, 'YYYYMMDD'::text)::timestamp without time zone, 'DD/MM/YYYY'::text)::character varying
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_pct.l_gen::text) <> 0 THEN (chr(10) || ' Générateur du recul : '::text) || geo_p_info_pct.l_gen::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_pct.l_valrecul::text) <> 0 THEN (chr(10) || ' Valeur du recul : '::text) || geo_p_info_pct.l_valrecul::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_pct.l_typrecul::text) <> 0 THEN (chr(10) || ' Type du recul : '::text) || geo_p_info_pct.l_typrecul::text
                            ELSE ''::text
                        END AS libelle,
                    geo_p_info_pct.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc.geo_p_info_pct
                  WHERE st_intersects("PARCELLE"."GEOM", geo_p_info_pct.geom)
                ), r_lin AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    ((((geo_p_info_lin.libelle::text ||
                        CASE
                            WHEN length(geo_p_info_lin.l_nom::text) <> 0 THEN ' Nom : '::text || geo_p_info_lin.l_nom::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_lin.l_dateins) <> 0 THEN (chr(10) || ' Instauré(e) le : '::text) || to_char(to_date(geo_p_info_lin.l_dateins::text, 'YYYYMMDD'::text)::timestamp without time zone, 'DD/MM/YYYY'::text)::character varying
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_lin.l_gen::text) <> 0 THEN (chr(10) || ' Générateur du recul : '::text) || geo_p_info_lin.l_gen::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_lin.l_valrecul::text) <> 0 THEN (chr(10) || ' Valeur du recul : '::text) || geo_p_info_lin.l_valrecul::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_lin.l_typrecul::text) <> 0 THEN (chr(10) || ' Type du recul : '::text) || geo_p_info_lin.l_typrecul::text
                            ELSE ''::text
                        END AS libelle,
                    geo_p_info_lin.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc.geo_p_info_lin
                  WHERE st_intersects("PARCELLE"."GEOM", geo_p_info_lin.geom)
                ), r_surf AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    ((((geo_p_info_surf.libelle::text ||
                        CASE
                            WHEN length(geo_p_info_surf.l_nom::text) <> 0 THEN ' Nom : '::text || geo_p_info_surf.l_nom::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_surf.l_dateins) <> 0 THEN (chr(10) || ' Instauré(e) le : '::text) || to_char(to_date(geo_p_info_surf.l_dateins::text, 'YYYYMMDD'::text)::timestamp without time zone, 'DD/MM/YYYY'::text)::character varying
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_surf.l_gen::text) <> 0 THEN (chr(10) || ' Générateur du recul : '::text) || geo_p_info_surf.l_gen::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_surf.l_valrecul::text) <> 0 THEN (chr(10) || ' Valeur du recul : '::text) || geo_p_info_surf.l_valrecul::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_surf.l_typrecul::text) <> 0 THEN (chr(10) || ' Type du recul : '::text) || geo_p_info_surf.l_typrecul::text
                            ELSE ''::text
                        END AS libelle,
                    geo_p_info_surf.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc.geo_p_info_surf
                  WHERE geo_p_info_surf.typeinf::text <> '04'::text AND geo_p_info_surf.typeinf::text <> '05'::text AND st_intersects("PARCELLE"."GEOM", geo_p_info_surf.geom1)
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
                    x_apps.xapps_geo_vmr_proc z,
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

ALTER TABLE x_apps.xapps_an_vmr_p_information
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.xapps_an_vmr_p_information TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.xapps_an_vmr_p_information TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.xapps_an_vmr_p_information TO edit_sig;

COMMENT ON MATERIALIZED VIEW x_apps.xapps_an_vmr_p_information
  IS E'Vue matérialisée formatant les données les données informations jugées utiles pour la fiche de renseignements d''urbanisme (fiche d''information de GEO).
ATTENTION : cette vue est reformatée à chaque mise à jour de cadastre dans FME (Y:\\Ressources\\4-Partage\\3-Procedures\\FME\\prod\\URB\\00_MAJ_COMPLETE_SUP_INFO_UTILES.fmw) afin de conserver le lien vers le bon schéma de cadastre suite au rennomage de ceux-ci durant l''intégration. Si cette vue est modifiée ici pensez à répercuter la mise à jour dans le trans former SQLExecutor.';

-- Index: x_apps.idx_an_vmr_p_information_idu

-- DROP INDEX x_apps.idx_an_vmr_p_information_idu;

CREATE INDEX idx_an_vmr_p_information_idu
  ON x_apps.xapps_an_vmr_p_information
  USING btree
  (idu COLLATE pg_catalog."default");



-- Materialized View: x_apps.xapps_an_vmr_p_information_dpu

DROP MATERIALIZED VIEW x_apps.xapps_an_vmr_p_information_dpu;

CREATE MATERIALIZED VIEW x_apps.xapps_an_vmr_p_information_dpu AS 
 WITH r_p AS (
         WITH r_surf AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    geo_p_info_surf.l_nom,
                    geo_p_info_surf.l_bnfcr,
                    geo_p_info_surf.l_dateins,
                    geo_p_info_surf.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc.geo_p_info_surf
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
            WHEN length(r_p.l_nom::text) = 0 OR r_p.l_nom::text = ''::text OR r_p.l_nom::text IS NULL THEN 'La parcelle n''est pas concernée'::character varying
            ELSE 'Zone urbaine, zone d''urbanisation future et/ou périmètre de protection rapprochée du prélèvement d''eau'::character varying
        END AS application,
    r_p.l_bnfcr AS beneficiaire,
    to_char(to_date(r_p.l_dateins::text, 'YYYYMMDD'::text)::timestamp without time zone, 'DD-MM-YYYY'::text) AS date_ins,
    r_p.urlfic
   FROM r_p
WITH DATA;

ALTER TABLE x_apps.xapps_an_vmr_p_information_dpu
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.xapps_an_vmr_p_information_dpu TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.xapps_an_vmr_p_information_dpu TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.xapps_an_vmr_p_information_dpu TO edit_sig;

COMMENT ON MATERIALIZED VIEW x_apps.xapps_an_vmr_p_information_dpu
  IS E'Vue matérialisée formatant les données les données des DPU pour la fiche de renseignements d''''urbanisme (fiche d''''information de GEO).
ATTENTION : cette vue est reformatée à chaque mise à jour de cadastre dans FME (Y:\\\\\\\\Ressources\\\\\\\\4-Partage\\\\\\\\3-Procedures\\\\\\\\FME\\\\prod\\\\\\\\URB\\\\\\\\00_MAJ_COMPLETE_SUP_INFO_UTILES.fmw) 
afin de conserver le lien vers le bon schéma de cadastre suite au rennomage de ceux-ci durant l''''intégration. Si cette vue est modifiée ici pensez à répercuter la mise à jour dans le trans former SQLExecutor.';


-- Materialized View: x_apps.xapps_an_vmr_p_prescription

DROP MATERIALIZED VIEW x_apps.xapps_an_vmr_p_prescription;

CREATE MATERIALIZED VIEW x_apps.xapps_an_vmr_p_prescription AS 
 WITH r_p AS (
         WITH r_pct AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    ((((((geo_p_prescription_pct.libelle::text ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_numero::text) <> 0 THEN ' n°'::text || geo_p_prescription_pct.l_numero::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_nom::text) <> 0 THEN (chr(10) || 'Nom : '::text) || geo_p_prescription_pct.l_nom::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_nature::text) <> 0 THEN (chr(10) || 'Nature : '::text) || geo_p_prescription_pct.l_nature::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_surf_txt::text) <> 0 THEN (chr(10) || 'Surface : '::text) || geo_p_prescription_pct.l_surf_txt::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_gen::text) <> 0 THEN (chr(10) || 'Générateur du recul : '::text) || geo_p_prescription_pct.l_gen::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_valrecul::text) <> 0 THEN (chr(10) || 'Valeur du recul : '::text) || geo_p_prescription_pct.l_valrecul::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_typrecul::text) <> 0 THEN (chr(10) || 'Type du recul : '::text) || geo_p_prescription_pct.l_typrecul::text
                            ELSE ''::text
                        END AS libelle,
                    geo_p_prescription_pct.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc.geo_p_prescription_pct
                  WHERE st_intersects("PARCELLE"."GEOM", geo_p_prescription_pct.geom)
                ), r_lin AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    ((((((geo_p_prescription_lin.libelle::text ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_numero::text) <> 0 THEN ' n°'::text || geo_p_prescription_lin.l_numero::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_nom::text) <> 0 THEN (chr(10) || 'Nom : '::text) || geo_p_prescription_lin.l_nom::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_nature::text) <> 0 THEN (chr(10) || 'Nature : '::text) || geo_p_prescription_lin.l_nature::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_surf_txt::text) <> 0 THEN (chr(10) || 'Surface : '::text) || geo_p_prescription_lin.l_surf_txt::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_gen::text) <> 0 THEN (chr(10) || 'Générateur du recul : '::text) || geo_p_prescription_lin.l_gen::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_valrecul::text) <> 0 THEN (chr(10) || 'Valeur du recul : '::text) || geo_p_prescription_lin.l_valrecul::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_typrecul::text) <> 0 THEN (chr(10) || 'Type du recul : '::text) || geo_p_prescription_lin.l_typrecul::text
                            ELSE ''::text
                        END AS libelle,
                    geo_p_prescription_lin.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc.geo_p_prescription_lin
                  WHERE st_intersects("PARCELLE"."GEOM", geo_p_prescription_lin.geom1) AND geo_p_prescription_lin.insee::text = "left"("PARCELLE"."IDU"::text, 5)
                ), r_surf AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    ((((((geo_p_prescription_surf.libelle::text ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_numero::text) <> 0 THEN ' n°'::text || geo_p_prescription_surf.l_numero::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_nom::text) <> 0 THEN (chr(10) || 'Nom : '::text) || geo_p_prescription_surf.l_nom::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_nature::text) <> 0 THEN (chr(10) || 'Nature : '::text) || geo_p_prescription_surf.l_nature::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_surf_txt::text) <> 0 THEN (chr(10) || 'Surface : '::text) || geo_p_prescription_surf.l_surf_txt::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_gen::text) <> 0 THEN (chr(10) || 'Générateur du recul : '::text) || geo_p_prescription_surf.l_gen::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_valrecul::text) <> 0 THEN (chr(10) || 'Valeur du recul : '::text) || geo_p_prescription_surf.l_valrecul::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_typrecul::text) <> 0 THEN (chr(10) || 'Type du recul : '::text) || geo_p_prescription_surf.l_typrecul::text
                            ELSE ''::text
                        END AS libelle,
                    geo_p_prescription_surf.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc.geo_p_prescription_surf
                  WHERE st_intersects("PARCELLE"."GEOM", geo_p_prescription_surf.geom1) AND geo_p_prescription_surf.insee::text = "left"("PARCELLE"."IDU"::text, 5)
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

ALTER TABLE x_apps.xapps_an_vmr_p_prescription
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.xapps_an_vmr_p_prescription TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.xapps_an_vmr_p_prescription TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.xapps_an_vmr_p_prescription TO edit_sig;

COMMENT ON MATERIALIZED VIEW x_apps.xapps_an_vmr_p_prescription
  IS E'Vue matérialisée formatant les données les données des prescriptions pour la fiche de renseignements d''urbanisme (fiche d''information de GEO).
ATTENTION : cette vue est reformatée à chaque mise à jour de cadastre dans FME (Y:\\Ressources\\4-Partage\\3-Procedures\\FME\\prod\\URB\\00_MAJ_COMPLETE_SUP_INFO_UTILES.fmw) afin de conserver le lien vers le bon schéma de cadastre suite au rennomage de ceux-ci durant l''intégration. Si cette vue est modifiée ici pensez à répercuter la mise à jour dans le trans former SQLExecutor.';

-- Index: x_apps.idx_an_vmr_p_prescription_idu

-- DROP INDEX x_apps.idx_an_vmr_p_prescription_idu;

CREATE INDEX idx_an_vmr_p_prescription_idu
  ON x_apps.xapps_an_vmr_p_prescription
  USING btree
  (idu COLLATE pg_catalog."default");





-- Materialized View: x_apps.xapps_an_vmr_parcelle_plu
DROP MATERIALIZED VIEW IF EXISTS x_apps.xapps_an_vmr_parcelle_plu;


CREATE MATERIALIZED VIEW x_apps.xapps_an_vmr_parcelle_plu AS 
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
         SELECT geo_p_zone_urba.insee,
            geo_osm_commune.commune,
            geo_p_zone_urba.libelle,
                CASE
                    WHEN geo_p_zone_urba.typesect::text = 'ZZ'::text THEN geo_p_zone_urba.libelong::text
                    ELSE
                    CASE
                        WHEN geo_p_zone_urba.typesect::text = '01'::text THEN 'Ouvert à la construction'::text
                        WHEN geo_p_zone_urba.typesect::text = '02'::text THEN 'Réservé aux activités'::text
                        WHEN geo_p_zone_urba.typesect::text = '03'::text THEN 'Construction non autorisée sauf exceptions prévues par la loi'::text
                        WHEN geo_p_zone_urba.typesect::text = '99'::text THEN 'Zone non couverte'::text
                        ELSE NULL::text
                    END
                END AS libelong,
            geo_p_zone_urba.urlfic,
            lt_destdomi.destdomi_lib,
            geo_p_zone_urba.l_surf_cal,
                CASE
                    WHEN geo_p_zone_urba.fermreco = true THEN 'Oui'::text
                    WHEN geo_p_zone_urba.fermreco = false THEN 'Non'::text
                    ELSE NULL::text
                END AS fermreco,
                CASE
                    WHEN an_doc_urba.typedoc::text = 'PLU'::text OR an_doc_urba.typedoc::text = 'POS'::text THEN geo_p_zone_urba.typezone
                    WHEN an_doc_urba.typedoc::text = 'CC'::text THEN 'sans objet'::character varying
                    ELSE NULL::character varying
                END AS type_zone,
            geo_p_zone_urba.l_observ,
            geo_p_zone_urba.datappro,
            st_buffer(geo_p_zone_urba.geom, (-1.5)::double precision) AS geom1
           FROM m_urbanisme_doc.geo_p_zone_urba,
            m_urbanisme_doc.lt_destdomi,
            m_urbanisme_doc.an_doc_urba,
            r_osm.geo_osm_commune
          WHERE geo_osm_commune.insee::text = geo_p_zone_urba.insee::text AND geo_p_zone_urba.insee::text = "substring"(an_doc_urba.idurba::text, 1, 5) AND an_doc_urba.etat = '03'::bpchar AND geo_p_zone_urba.destdomi::bpchar = lt_destdomi.destdomi
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

ALTER TABLE x_apps.xapps_an_vmr_parcelle_plu
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.xapps_an_vmr_parcelle_plu TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.xapps_an_vmr_parcelle_plu TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.xapps_an_vmr_parcelle_plu TO edit_sig;
										  
COMMENT ON MATERIALIZED VIEW x_apps.xapps_an_vmr_parcelle_plu
  IS E'Vue matérialisée contenant les informations pré-formatés pour la constitution de la fiche d''information Renseignements d''urbanisme y compris version imprimable dans GEO.
Cette vue permet de récupérer pour chaque parcelle les informations du PLU et traiter les pbs liés aux zones entre commune et les zonages se touchant.
ATTENTION : cette vue est reformatée à chaque mise à jour de cadastre dans FME (Y:\\Ressources\\4-Partage\\3-Procedures\\FME\\prod\\URB\\00_MAJ_COMPLETE_SUP_INFO_UTILES.fmw) afin de conserver le lien vers le bon schéma de cadastre suite au rennomage de ceux-ci durant l''intégration. Si cette vue est modifiée ici pensez à répercuter la mise à jour dans le trans former SQLExecutor.';

-- Index: x_apps.idx_an_vmr_parcelle_plu_idu

-- DROP INDEX x_apps.idx_an_vmr_parcelle_plu_idu;

CREATE INDEX idx_an_vmr_parcelle_plu_idu
  ON x_apps.xapps_an_vmr_parcelle_plu
  USING btree
  (idu COLLATE pg_catalog."default");


-- View: m_urbanisme_doc.geo_v_docurba

DROP VIEW IF EXISTS m_urbanisme_doc.geo_v_docurba;

CREATE OR REPLACE VIEW m_urbanisme_doc.geo_v_docurba AS 
 SELECT "substring"(u.idurba::text, 1, 5) AS insee,
    a.libgeo AS commune,
    u.typedoc,
    c.geom
   FROM m_urbanisme_doc.an_doc_urba u,
    r_osm.geo_osm_commune c,
    r_administratif.an_geo a
  WHERE a.insee::text = c.insee::text AND "substring"(u.idurba::text, 1, 5) = c.insee::text AND (a.epci::text = '200067965'::text OR a.epci::text = '246000897'::text OR a.epci::text = '246000749'::text) AND u.etat = '03'::bpchar
  ORDER BY a.libgeo;

ALTER TABLE m_urbanisme_doc.geo_v_docurba
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_v_docurba TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_v_docurba TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_v_docurba TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc.geo_v_docurba
  IS 'Vue géographique présentant le types de document d''urbanisme valide par commune du Pays COmpiégnois';

										  
-- View: m_urbanisme_doc.geo_v_p_habillage_surf_arc

DROP VIEW IF EXISTS m_urbanisme_doc.geo_v_p_habillage_surf_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc.geo_v_p_habillage_surf_arc AS 
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

ALTER TABLE m_urbanisme_doc.geo_v_p_habillage_surf_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_v_p_habillage_surf_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_v_p_habillage_surf_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_v_p_habillage_surf_arc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_p_habillage_surf_arc
  IS 'Vue géographique des habillages surfaciques PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

										       
-- View: m_urbanisme_doc.geo_v_p_habillage_pct_arc

DROP VIEW IF EXISTS m_urbanisme_doc.geo_v_p_habillage_pct_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc.geo_v_p_habillage_pct_arc AS 
 SELECT geo_p_habillage_pct.idhab,
    geo_p_habillage_pct.nattrac,
    geo_p_habillage_pct.couleur,
    geo_p_habillage_pct.idurba,
    geo_p_habillage_pct.l_insee,
    right(geo_p_habillage_pct.idurba,8) as l_datappro,
    geo_p_habillage_pct.geom
   FROM m_urbanisme_doc.geo_p_habillage_pct
  WHERE geo_p_habillage_pct.l_insee::text = '60023'::text OR geo_p_habillage_pct.l_insee::text = '60070'::text OR geo_p_habillage_pct.l_insee::text = '60151'::text OR geo_p_habillage_pct.l_insee::text = '60156'::text 
  OR geo_p_habillage_pct.l_insee::text = '60159'::text OR geo_p_habillage_pct.l_insee::text = '60323'::text OR geo_p_habillage_pct.l_insee::text = '60325'::text OR geo_p_habillage_pct.l_insee::text = '60326'::text 
  OR geo_p_habillage_pct.l_insee::text = '60337'::text OR geo_p_habillage_pct.l_insee::text = '60338'::text OR geo_p_habillage_pct.l_insee::text = '60382'::text OR geo_p_habillage_pct.l_insee::text = '60402'::text 
  OR geo_p_habillage_pct.l_insee::text = '60579'::text OR geo_p_habillage_pct.l_insee::text = '60597'::text OR geo_p_habillage_pct.l_insee::text = '60665'::text OR geo_p_habillage_pct.l_insee::text = '60674'::text 
  OR geo_p_habillage_pct.l_insee::text = '60067'::text OR geo_p_habillage_pct.l_insee::text = '60068'::text OR geo_p_habillage_pct.l_insee::text = '60447'::text OR geo_p_habillage_pct.l_insee::text = '60578'::text 
  OR geo_p_habillage_pct.l_insee::text = '60600'::text OR geo_p_habillage_pct.l_insee::text = '60667'::text;

ALTER TABLE m_urbanisme_doc.geo_v_p_habillage_pct_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_v_p_habillage_pct_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_v_p_habillage_pct_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_v_p_habillage_pct_arc TO edit_sig;
										       
COMMENT ON VIEW m_urbanisme_doc.geo_v_p_habillage_surf_arc
  IS 'Vue géographique des habillages ponctuels PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_p_habillage_lin_arc

DROP VIEW IF EXISTS m_urbanisme_doc.geo_v_p_habillage_lin_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc.geo_v_p_habillage_lin_arc AS 
 SELECT geo_p_habillage_lin.idhab,
    geo_p_habillage_lin.nattrac,
    geo_p_habillage_lin.idurba,
    geo_p_habillage_lin.l_insee,
    right(geo_p_habillage_lin.idurba,8) as l_datappro,
    geo_p_habillage_lin.geom
   FROM m_urbanisme_doc.geo_p_habillage_lin
  WHERE geo_p_habillage_lin.l_insee::text = '60023'::text OR geo_p_habillage_lin.l_insee::text = '60070'::text OR geo_p_habillage_lin.l_insee::text = '60151'::text OR geo_p_habillage_lin.l_insee::text = '60156'::text 
  OR geo_p_habillage_lin.l_insee::text = '60159'::text OR geo_p_habillage_lin.l_insee::text = '60323'::text OR geo_p_habillage_lin.l_insee::text = '60325'::text OR geo_p_habillage_lin.l_insee::text = '60326'::text 
  OR geo_p_habillage_lin.l_insee::text = '60337'::text OR geo_p_habillage_lin.l_insee::text = '60338'::text OR geo_p_habillage_lin.l_insee::text = '60382'::text OR geo_p_habillage_lin.l_insee::text = '60402'::text 
  OR geo_p_habillage_lin.l_insee::text = '60579'::text OR geo_p_habillage_lin.l_insee::text = '60597'::text OR geo_p_habillage_lin.l_insee::text = '60665'::text OR geo_p_habillage_lin.l_insee::text = '60674'::text 
  OR geo_p_habillage_lin.l_insee::text = '60067'::text OR geo_p_habillage_lin.l_insee::text = '60068'::text OR geo_p_habillage_lin.l_insee::text = '60447'::text OR geo_p_habillage_lin.l_insee::text = '60578'::text 
  OR geo_p_habillage_lin.l_insee::text = '60600'::text OR geo_p_habillage_lin.l_insee::text = '60667'::text;

ALTER TABLE m_urbanisme_doc.geo_v_p_habillage_lin_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_v_p_habillage_lin_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_v_p_habillage_lin_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_v_p_habillage_lin_arc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc.geo_v_p_habillage_lin_arc
  IS 'Vue géographique des habillages linéaires PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_p_habillage_txt_arc

DROP VIEW IF EXISTS m_urbanisme_doc.geo_v_p_habillage_txt_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc.geo_v_p_habillage_txt_arc AS 
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
   FROM m_urbanisme_doc.geo_p_habillage_txt
  WHERE geo_p_habillage_txt.l_insee::text = '60023'::text OR geo_p_habillage_txt.l_insee::text = '60070'::text OR geo_p_habillage_txt.l_insee::text = '60151'::text OR geo_p_habillage_txt.l_insee::text = '60156'::text 
  OR geo_p_habillage_txt.l_insee::text = '60159'::text OR geo_p_habillage_txt.l_insee::text = '60323'::text OR geo_p_habillage_txt.l_insee::text = '60325'::text OR geo_p_habillage_txt.l_insee::text = '60326'::text 
  OR geo_p_habillage_txt.l_insee::text = '60337'::text OR geo_p_habillage_txt.l_insee::text = '60338'::text OR geo_p_habillage_txt.l_insee::text = '60382'::text OR geo_p_habillage_txt.l_insee::text = '60402'::text 
  OR geo_p_habillage_txt.l_insee::text = '60579'::text OR geo_p_habillage_txt.l_insee::text = '60597'::text OR geo_p_habillage_txt.l_insee::text = '60665'::text OR geo_p_habillage_txt.l_insee::text = '60674'::text 
  OR geo_p_habillage_txt.l_insee::text = '60067'::text OR geo_p_habillage_txt.l_insee::text = '60068'::text OR geo_p_habillage_txt.l_insee::text = '60447'::text OR geo_p_habillage_txt.l_insee::text = '60578'::text 
  OR geo_p_habillage_txt.l_insee::text = '60600'::text OR geo_p_habillage_txt.l_insee::text = '60667'::text;

ALTER TABLE m_urbanisme_doc.geo_v_p_habillage_txt_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_v_p_habillage_txt_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_v_p_habillage_txt_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_v_p_habillage_txt_arc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc.geo_v_p_habillage_txt_arc
  IS 'Vue géographique des habillages textuels PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_p_info_pct_arc

DROP VIEW IF EXISTS m_urbanisme_doc.geo_v_p_info_pct_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc.geo_v_p_info_pct_arc AS 
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
   FROM m_urbanisme_doc.geo_p_info_pct, m_urbanisme_doc.lt_typeinf
  WHERE geo_p_info_pct.typeinf || geo_p_info_pct.stypeinf = lt_typeinf.code || lt_typeinf.sous_code and (geo_p_info_pct.l_insee::text = '60023'::text OR geo_p_info_pct.l_insee::text = '60070'::text OR geo_p_info_pct.l_insee::text = '60151'::text 
  OR geo_p_info_pct.l_insee::text = '60156'::text 
  OR geo_p_info_pct.l_insee::text = '60159'::text OR geo_p_info_pct.l_insee::text = '60323'::text OR geo_p_info_pct.l_insee::text = '60325'::text OR geo_p_info_pct.l_insee::text = '60326'::text 
  OR geo_p_info_pct.l_insee::text = '60337'::text OR geo_p_info_pct.l_insee::text = '60338'::text OR geo_p_info_pct.l_insee::text = '60382'::text OR geo_p_info_pct.l_insee::text = '60402'::text 
  OR geo_p_info_pct.l_insee::text = '60579'::text OR geo_p_info_pct.l_insee::text = '60597'::text OR geo_p_info_pct.l_insee::text = '60665'::text OR geo_p_info_pct.l_insee::text = '60674'::text 
  OR geo_p_info_pct.l_insee::text = '60067'::text OR geo_p_info_pct.l_insee::text = '60068'::text OR geo_p_info_pct.l_insee::text = '60447'::text OR geo_p_info_pct.l_insee::text = '60578'::text 
  OR geo_p_info_pct.l_insee::text = '60600'::text OR geo_p_info_pct.l_insee::text = '60667'::text);

ALTER TABLE m_urbanisme_doc.geo_v_p_info_pct_arc
OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_v_p_info_pct_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_v_p_info_pct_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_v_p_info_pct_arc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc.geo_v_p_info_pct_arc
  IS 'Vue géographique des informations ponctuelles PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- View: m_urbanisme_doc.geo_v_p_info_lin_arc

DROP VIEW IF EXISTS m_urbanisme_doc.geo_v_p_info_lin_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc.geo_v_p_info_lin_arc AS 
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
   FROM m_urbanisme_doc.geo_p_info_lin, m_urbanisme_doc.lt_typeinf
  WHERE geo_p_info_lin.typeinf || geo_p_info_lin.stypeinf = lt_typeinf.code || lt_typeinf.sous_code and (geo_p_info_lin.l_insee::text = '60023'::text OR geo_p_info_lin.l_insee::text = '60070'::text OR geo_p_info_lin.l_insee::text = '60151'::text OR geo_p_info_lin.l_insee::text = '60156'::text 
  OR geo_p_info_lin.l_insee::text = '60159'::text OR geo_p_info_lin.l_insee::text = '60323'::text OR geo_p_info_lin.l_insee::text = '60325'::text OR geo_p_info_lin.l_insee::text = '60326'::text 
  OR geo_p_info_lin.l_insee::text = '60337'::text OR geo_p_info_lin.l_insee::text = '60338'::text OR geo_p_info_lin.l_insee::text = '60382'::text OR geo_p_info_lin.l_insee::text = '60402'::text 
  OR geo_p_info_lin.l_insee::text = '60579'::text OR geo_p_info_lin.l_insee::text = '60597'::text OR geo_p_info_lin.l_insee::text = '60665'::text OR geo_p_info_lin.l_insee::text = '60674'::text 
  OR geo_p_info_lin.l_insee::text = '60067'::text OR geo_p_info_lin.l_insee::text = '60068'::text OR geo_p_info_lin.l_insee::text = '60447'::text OR geo_p_info_lin.l_insee::text = '60578'::text 
  OR geo_p_info_lin.l_insee::text = '60600'::text OR geo_p_info_lin.l_insee::text = '60667'::text);

ALTER TABLE m_urbanisme_doc.geo_v_p_info_lin_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_v_p_info_lin_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_v_p_info_lin_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_v_p_info_lin_arc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc.geo_v_p_info_lin_arc
  IS 'Vue géographique des informations linéaires PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_p_info_surf_arc

DROP VIEW IF EXISTS m_urbanisme_doc.geo_v_p_info_surf_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc.geo_v_p_info_surf_arc AS 
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
   FROM m_urbanisme_doc.geo_p_info_surf, m_urbanisme_doc.lt_typeinf
  WHERE geo_p_info_surf.typeinf || geo_p_info_surf.stypeinf = lt_typeinf.code || lt_typeinf.sous_code and (geo_p_info_surf.l_insee::text = '60023'::text OR geo_p_info_surf.l_insee::text = '60070'::text OR geo_p_info_surf.l_insee::text = '60151'::text OR geo_p_info_surf.l_insee::text = '60156'::text 
  OR geo_p_info_surf.l_insee::text = '60159'::text OR geo_p_info_surf.l_insee::text = '60323'::text OR geo_p_info_surf.l_insee::text = '60325'::text OR geo_p_info_surf.l_insee::text = '60326'::text 
  OR geo_p_info_surf.l_insee::text = '60337'::text OR geo_p_info_surf.l_insee::text = '60338'::text OR geo_p_info_surf.l_insee::text = '60382'::text OR geo_p_info_surf.l_insee::text = '60402'::text 
  OR geo_p_info_surf.l_insee::text = '60579'::text OR geo_p_info_surf.l_insee::text = '60597'::text OR geo_p_info_surf.l_insee::text = '60665'::text OR geo_p_info_surf.l_insee::text = '60674'::text 
  OR geo_p_info_surf.l_insee::text = '60067'::text OR geo_p_info_surf.l_insee::text = '60068'::text OR geo_p_info_surf.l_insee::text = '60447'::text OR geo_p_info_surf.l_insee::text = '60578'::text 
  OR geo_p_info_surf.l_insee::text = '60600'::text OR geo_p_info_surf.l_insee::text = '60667'::text);

ALTER TABLE m_urbanisme_doc.geo_v_p_info_surf_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_v_p_info_surf_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_v_p_info_surf_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_v_p_info_surf_arc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc.geo_v_p_info_surf_arc
  IS 'Vue géographique des informations surfaciques PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- View: m_urbanisme_doc.geo_v_p_prescription_lin_arc

DROP VIEW IF EXISTS m_urbanisme_doc.geo_v_p_prescription_lin_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc.geo_v_p_prescription_lin_arc AS 
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
   FROM m_urbanisme_doc.geo_p_prescription_lin, m_urbanisme_doc.lt_typepsc
  WHERE  geo_p_prescription_lin.typepsc || geo_p_prescription_lin.stypepsc = lt_typepsc.code || lt_typepsc.sous_code and (geo_p_prescription_lin.l_insee::text = '60023'::text OR geo_p_prescription_lin.l_insee::text = '60070'::text OR geo_p_prescription_lin.l_insee::text = '60151'::text OR geo_p_prescription_lin.l_insee::text = '60156'::text 
   OR geo_p_prescription_lin.l_insee::text = '60159'::text OR geo_p_prescription_lin.l_insee::text = '60323'::text OR geo_p_prescription_lin.l_insee::text = '60325'::text OR geo_p_prescription_lin.l_insee::text = '60326'::text 
   OR geo_p_prescription_lin.l_insee::text = '60337'::text OR geo_p_prescription_lin.l_insee::text = '60338'::text OR geo_p_prescription_lin.l_insee::text = '60382'::text OR geo_p_prescription_lin.l_insee::text = '60402'::text 
   OR geo_p_prescription_lin.l_insee::text = '60579'::text OR geo_p_prescription_lin.l_insee::text = '60597'::text OR geo_p_prescription_lin.l_insee::text = '60665'::text OR geo_p_prescription_lin.l_insee::text = '60674'::text 
   OR geo_p_prescription_lin.l_insee::text = '60067'::text OR geo_p_prescription_lin.l_insee::text = '60068'::text OR geo_p_prescription_lin.l_insee::text = '60447'::text OR geo_p_prescription_lin.l_insee::text = '60578'::text 
   OR geo_p_prescription_lin.l_insee::text = '60600'::text OR geo_p_prescription_lin.l_insee::text = '60667'::text);

ALTER TABLE m_urbanisme_doc.geo_v_p_prescription_lin_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_v_p_prescription_lin_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_v_p_prescription_lin_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_v_p_prescription_lin_arc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc.geo_v_p_prescription_lin_arc
  IS 'Vue géographique des prescriptions linéaires PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_p_prescription_pct_arc

DROP VIEW IF EXISTS m_urbanisme_doc.geo_v_p_prescription_pct_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc.geo_v_p_prescription_pct_arc AS 
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
   FROM m_urbanisme_doc.geo_p_prescription_pct, m_urbanisme_doc.lt_typepsc
  WHERE geo_p_prescription_pct.typepsc || geo_p_prescription_pct.stypepsc = lt_typepsc.code || lt_typepsc.sous_code and (geo_p_prescription_pct.l_insee::text = '60023'::text OR geo_p_prescription_pct.l_insee::text = '60070'::text OR geo_p_prescription_pct.l_insee::text = '60151'::text OR geo_p_prescription_pct.l_insee::text = '60156'::text 
OR geo_p_prescription_pct.l_insee::text = '60159'::text OR geo_p_prescription_pct.l_insee::text = '60323'::text OR geo_p_prescription_pct.l_insee::text = '60325'::text OR geo_p_prescription_pct.l_insee::text = '60326'::text 
OR geo_p_prescription_pct.l_insee::text = '60337'::text OR geo_p_prescription_pct.l_insee::text = '60338'::text OR geo_p_prescription_pct.l_insee::text = '60382'::text OR geo_p_prescription_pct.l_insee::text = '60402'::text 
OR geo_p_prescription_pct.l_insee::text = '60579'::text OR geo_p_prescription_pct.l_insee::text = '60597'::text OR geo_p_prescription_pct.l_insee::text = '60665'::text OR geo_p_prescription_pct.l_insee::text = '60674'::text 
OR geo_p_prescription_pct.l_insee::text = '60067'::text OR geo_p_prescription_pct.l_insee::text = '60068'::text OR geo_p_prescription_pct.l_insee::text = '60447'::text OR geo_p_prescription_pct.l_insee::text = '60578'::text 
OR geo_p_prescription_pct.l_insee::text = '60600'::text OR geo_p_prescription_pct.l_insee::text = '60667'::text);

ALTER TABLE m_urbanisme_doc.geo_v_p_prescription_pct_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_v_p_prescription_pct_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_v_p_prescription_pct_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_v_p_prescription_pct_arc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc.geo_v_p_prescription_pct_arc
  IS 'Vue géographique des prescriptions ponctuelles PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_p_prescription_surf_arc

DROP VIEW IF EXISTS m_urbanisme_doc.geo_v_p_prescription_surf_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc.geo_v_p_prescription_surf_arc AS 
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
   FROM m_urbanisme_doc.geo_p_prescription_surf, m_urbanisme_doc.lt_typepsc
  WHERE geo_p_prescription_surf.typepsc || geo_p_prescription_surf.stypepsc = lt_typepsc.code || lt_typepsc.sous_code and (geo_p_prescription_surf.l_insee::text = '60023'::text OR geo_p_prescription_surf.l_insee::text = '60070'::text OR geo_p_prescription_surf.l_insee::text = '60151'::text OR geo_p_prescription_surf.l_insee::text = '60156'::text 
OR geo_p_prescription_surf.l_insee::text = '60159'::text OR geo_p_prescription_surf.l_insee::text = '60323'::text OR geo_p_prescription_surf.l_insee::text = '60325'::text OR geo_p_prescription_surf.l_insee::text = '60326'::text 
OR geo_p_prescription_surf.l_insee::text = '60337'::text OR geo_p_prescription_surf.l_insee::text = '60338'::text OR geo_p_prescription_surf.l_insee::text = '60382'::text OR geo_p_prescription_surf.l_insee::text = '60402'::text 
OR geo_p_prescription_surf.l_insee::text = '60579'::text OR geo_p_prescription_surf.l_insee::text = '60597'::text OR geo_p_prescription_surf.l_insee::text = '60665'::text OR geo_p_prescription_surf.l_insee::text = '60674'::text 
OR geo_p_prescription_surf.l_insee::text = '60067'::text OR geo_p_prescription_surf.l_insee::text = '60068'::text OR geo_p_prescription_surf.l_insee::text = '60447'::text OR geo_p_prescription_surf.l_insee::text = '60578'::text 
OR geo_p_prescription_surf.l_insee::text = '60600'::text OR geo_p_prescription_surf.l_insee::text = '60667'::text);

ALTER TABLE m_urbanisme_doc.geo_v_p_prescription_surf_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_v_p_prescription_surf_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_v_p_prescription_surf_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_v_p_prescription_surf_arc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc.geo_v_p_prescription_surf_arc
  IS 'Vue géographique des prescriptions surfaciques PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_p_zone_urba_arc

DROP VIEW IF EXISTS m_urbanisme_doc.geo_v_p_zone_urba_arc;

CREATE OR REPLACE VIEW m_urbanisme_doc.geo_v_p_zone_urba_arc AS 
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
   FROM m_urbanisme_doc.geo_p_zone_urba
  WHERE geo_p_zone_urba.l_insee::text = '60023'::text OR geo_p_zone_urba.l_insee::text = '60070'::text OR geo_p_zone_urba.l_insee::text = '60151'::text OR geo_p_zone_urba.l_insee::text = '60156'::text 
OR geo_p_zone_urba.l_insee::text = '60159'::text OR geo_p_zone_urba.l_insee::text = '60323'::text OR geo_p_zone_urba.l_insee::text = '60325'::text OR geo_p_zone_urba.l_insee::text = '60326'::text 
OR geo_p_zone_urba.l_insee::text = '60337'::text OR geo_p_zone_urba.l_insee::text = '60338'::text OR geo_p_zone_urba.l_insee::text = '60382'::text OR geo_p_zone_urba.l_insee::text = '60402'::text 
OR geo_p_zone_urba.l_insee::text = '60579'::text OR geo_p_zone_urba.l_insee::text = '60597'::text OR geo_p_zone_urba.l_insee::text = '60665'::text OR geo_p_zone_urba.l_insee::text = '60674'::text 
OR geo_p_zone_urba.l_insee::text = '60067'::text OR geo_p_zone_urba.l_insee::text = '60068'::text OR geo_p_zone_urba.l_insee::text = '60447'::text OR geo_p_zone_urba.l_insee::text = '60578'::text 
OR geo_p_zone_urba.l_insee::text = '60600'::text OR geo_p_zone_urba.l_insee::text = '60667'::text;

ALTER TABLE m_urbanisme_doc.geo_v_p_zone_urba_arc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_v_p_zone_urba_arc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_v_p_zone_urba_arc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_v_p_zone_urba_arc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc.geo_v_p_zone_urba_arc
  IS 'Vue géographique des zonages PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';


-- View: m_urbanisme_doc.geo_v_urbreg_ads_commune

DROP VIEW IF EXISTS m_urbanisme_doc.geo_v_urbreg_ads_commune;

CREATE OR REPLACE VIEW m_urbanisme_doc.geo_v_urbreg_ads_commune AS 
 SELECT c.commune,
    a.insee,
    a.docurba,
    a.ads_arc,
    c.lib_epci,
    c.geom
   FROM r_osm.geo_v_osm_commune_apc c
     JOIN m_urbanisme_doc.an_ads_commune a ON a.insee = c.insee::bpchar
  ORDER BY a.insee;

ALTER TABLE m_urbanisme_doc.geo_v_urbreg_ads_commune
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.geo_v_urbreg_ads_commune TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.geo_v_urbreg_ads_commune TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.geo_v_urbreg_ads_commune TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc.geo_v_urbreg_ads_commune
  IS 'Vue géographique sur l''état de l''ADS par l''ARC sur les communes du pays compiégnois';


-- Materialized View: x_apps.xapps_geo_vmr_p_zone_urba

DROP MATERIALIZED VIEW x_apps.xapps_geo_vmr_p_zone_urba;

CREATE MATERIALIZED VIEW x_apps.xapps_geo_vmr_p_zone_urba AS 
 SELECT geo_p_zone_urba.idzone,
    geo_p_zone_urba.libelle,
    geo_p_zone_urba.libelong,
    geo_p_zone_urba.typezone,
    geo_p_zone_urba.destdomi,
    geo_p_zone_urba.typesect,
    geo_p_zone_urba.fermreco,
    geo_p_zone_urba.l_surf_cal,
    geo_p_zone_urba.l_observ,
    geo_p_zone_urba.nomfic,
    geo_p_zone_urba.urlfic,
    geo_p_zone_urba.insee,
    geo_p_zone_urba.datappro,
    geo_p_zone_urba.datvalid,
    st_multi(geo_p_zone_urba.geom)::geometry(MultiPolygon,2154) AS geom
   FROM m_urbanisme_doc.geo_p_zone_urba
WITH DATA;

ALTER TABLE x_apps.xapps_geo_vmr_p_zone_urba
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc.xapps_geo_vmr_p_zone_urba TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc.xapps_geo_vmr_p_zone_urba TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc.xapps_geo_vmr_p_zone_urba TO edit_sig;
										  
COMMENT ON MATERIALIZED VIEW x_apps.xapps_geo_vmr_p_zone_urba
  IS 'Vue matérialisée des zones du PLU servant dans les recherches par zonage ou type dans GEO.';

-- Index: x_apps.idx_geo_vmr_p_zone_urba_destdomi

-- DROP INDEX x_apps.idx_geo_vmr_p_zone_urba_destdomi;

CREATE INDEX idx_geo_vmr_p_zone_urba_destdomi
  ON x_apps.xapps_geo_vmr_p_zone_urba
  USING btree
  (destdomi COLLATE pg_catalog."default");

-- Index: x_apps.idx_geo_vmr_p_zone_urba_insee

-- DROP INDEX x_apps.idx_geo_vmr_p_zone_urba_insee;

CREATE INDEX idx_geo_vmr_p_zone_urba_insee
  ON x_apps.xapps_geo_vmr_p_zone_urba
  USING btree
  (insee COLLATE pg_catalog."default");

-- Index: x_apps.idx_geo_vmr_p_zone_urba_typesect

-- DROP INDEX x_apps.idx_geo_vmr_p_zone_urba_typesect;

CREATE INDEX idx_geo_vmr_p_zone_urba_typesect
  ON x_apps.xapps_geo_vmr_p_zone_urba
  USING btree
  (typesect COLLATE pg_catalog."default");

-- Index: x_apps.idx_geo_vmr_p_zone_urba_typezone

-- DROP INDEX x_apps.idx_geo_vmr_p_zone_urba_typezone;

CREATE INDEX idx_geo_vmr_p_zone_urba_typezone
  ON x_apps.xapps_geo_vmr_p_zone_urba
  USING btree
  (typezone COLLATE pg_catalog."default");

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                   VUES ETUDE PLUi (spécifiques ARC)                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- View: m_urbanisme_doc_cnig2017.geo_v_t_habillage_lin_pluiarc

DROP VIEW IF EXISTS m_urbanisme_doc_cnig2017.geo_v_t_habillage_lin_pluiarc;

CREATE OR REPLACE VIEW m_urbanisme_doc_cnig2017.geo_v_t_habillage_lin_pluiarc AS 
 SELECT geo_p_habillage_lin.idhab,
    geo_p_habillage_lin.nattrac,
	geo_p_habillage_lin.idurba,
    geo_p_habillage_lin.l_insee,
    right(geo_p_habillage_lin.idurba,8) as l_datappro,
    geo_p_habillage_lin.geom
   FROM m_urbanisme_doc_cnig2017.geo_p_habillage_lin
  WHERE idurba = '200067965_PLUI_99999999';

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
  WHERE idurba = '200067965_PLUI_99999999';

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
  WHERE geo_p_info_pct.typeinf || geo_p_info_pct.stypeinf = lt_typeinf.code || lt_typeinf.sous_code AND idurba = '200067965_PLUI_99999999';

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
  WHERE geo_p_info_lin.typeinf || geo_p_info_lin.stypeinf = lt_typeinf.code || lt_typeinf.sous_code and idurba = '200067965_PLUI_99999999';

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
  WHERE geo_p_info_surf.typeinf || geo_p_info_surf.stypeinf = lt_typeinf.code || lt_typeinf.sous_code and idurba = '200067965_PLUI_99999999';

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
  WHERE  geo_p_prescription_lin.typepsc || geo_p_prescription_lin.stypepsc = lt_typepsc.code || lt_typepsc.sous_code and idurba = '200067965_PLUI_99999999';

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
  WHERE geo_p_prescription_pct.typepsc || geo_p_prescription_pct.stypepsc = lt_typepsc.code || lt_typepsc.sous_code and idurba = '200067965_PLUI_99999999';

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
  WHERE geo_p_prescription_surf.typepsc || geo_p_prescription_surf.stypepsc = lt_typepsc.code || lt_typepsc.sous_code and idurba = '200067965_PLUI_99999999';

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
  WHERE idurba = '200067965_PLUI_99999999';

ALTER TABLE m_urbanisme_doc_cnig2017.geo_v_t_zone_urba_pluiarc
  OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_zone_urba_pluiarc TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_zone_urba_pluiarc TO read_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_cnig2017.geo_v_t_zone_urba_pluiarc TO edit_sig;
										  
COMMENT ON VIEW m_urbanisme_doc_cnig2017.geo_v_t_zone_urba_pluiarc
  IS 'Vue géographique des zonages PLUi en mode test sur l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                   VUES GD PUBLIC (spécifiques ARC)                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- View: x_apps_public.xappspublic_an_vmr_fichegeo_ruplu0_gdpublic

-- DROP MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu0_gdpublic;

CREATE MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu0_gdpublic
TABLESPACE pg_default
AS
 SELECT row_number() OVER () AS gid,
    "left"(p.idurba::text, 5) AS insee,
    an_geo.libgeo AS commune,
    p.typedoc,
    (((((('http://geo.compiegnois.fr/documents/metiers/urba/docurba/'::text || "left"(p.idurba::text, 5)) || '_'::text) || p.typedoc::text) || '_'::text) || p.datappro::text) || '/Pieces_ecrites/3_Reglement/'::text) || p.nomreg::text AS url_reg,
    ((((('http://geo.compiegnois.fr/documents/metiers/urba/docurba/'::text || "left"(p.idurba::text, 5)) || '_'::text) || p.typedoc::text) || '_'::text) || p.datappro::text) || '.zip'::text AS url_zip,
        CASE
            WHEN p.typedoc::text = 'RNU'::text THEN '<font size=2>La commune est soumise aux dispositions du <b>Réglèment National d''Urbanisme (RNU)</b>.'::text
            ELSE (((('<font size=2>La commune est soumise aux dispositions '::text ||
            CASE
                WHEN p.typedoc::text = 'PLUI'::text THEN 'du <b>Plan Local d''Urbanisme Intercommunal</b>'::text
                WHEN p.typedoc::text = 'PLU'::text THEN ' du <b>Plan Local d''Urbanisme</b>'::text
                WHEN p.typedoc::text = 'POS'::text THEN 'du <b>Plan d''Occupation des Sol</b>'::text
                WHEN p.typedoc::text = 'CC'::text THEN 'de la <b>Carte Communale</b></font>'::text
                ELSE NULL::text
            END) || ' en vigueur sur la commune <b>approuvé le '::text) || to_char(p.datappro::date::timestamp with time zone, 'DD/MM/YYYY'::text)) || '</b> dans le cadre '::text) ||
            CASE
                WHEN p.l_version::text ~~ 'élaboration%'::text THEN ('d''une <b>'::text || p.l_version::text) || '</b></font>'::text
                WHEN p.l_version::text ~~ 'mise à jour%'::text THEN ('de la <b>'::text || p.l_version::text) || '</b></font>'::text
                WHEN p.l_version::text ~~ 'mise en compatibilité%'::text THEN ('de la <b>'::text || p.l_version::text) || '</b></font>'::text
                WHEN p.l_version::text ~~ 'modification n°%'::text THEN ('de la <b>'::text || p.l_version::text) || '</b></font>'::text
                WHEN p.l_version::text ~~ 'modification simplifiée%'::text THEN ('de la <b>'::text || p.l_version::text) || '</b></font>'::text
                WHEN p.l_version::text = 'modification simplifiée'::text THEN ('d''une <b>'::text || p.l_version::text) || '</b></font>'::text
                WHEN p.l_version::text ~~ 'modification simplifiée n°%'::text THEN ('de la <b>'::text || p.l_version::text) || '</b></font>'::text
                WHEN p.l_version::text = 'révision'::text THEN ('d''une <b>'::text || p.l_version::text) || '</b>'::text
                WHEN p.l_version::text ~~ 'révision simplifiée n°%'::text THEN ('de la <b>'::text || p.l_version::text) || '</b></font>'::text
                ELSE NULL::text
            END
        END AS typedoc_l,
    ((("left"(p.idurba::text, 5) || '_'::text) || p.typedoc::text) || '_'::text) || p.datappro::text AS idurba,
    p.l_meta AS url_meta,
    ('<font size=2>'::text || string_agg(DISTINCT (((((
        CASE
            WHEN sup.serv1 IS NOT NULL THEN sup.serv1::text || '<br>'::text
            ELSE ''::text
        END ||
        CASE
            WHEN sup.serv2 IS NOT NULL THEN sup.serv2::text || '<br>'::text
            ELSE ''::text
        END) ||
        CASE
            WHEN sup.serv3 IS NOT NULL THEN sup.serv3::text || '<br>'::text
            ELSE ''::text
        END) ||
        CASE
            WHEN sup.serv4 IS NOT NULL THEN sup.serv4::text || '<br>'::text
            ELSE ''::text
        END) ||
        CASE
            WHEN sup.serv5 IS NOT NULL THEN sup.serv5::text || '<br>'::text
            ELSE ''::text
        END) ||
        CASE
            WHEN sup.serv6 IS NOT NULL THEN sup.serv6::text || '<br>'::text
            ELSE ''::text
        END) ||
        CASE
            WHEN sup.serv7 IS NOT NULL THEN sup.serv7::text || '<br>'::text
            ELSE ''::text
        END, ''::text)) || '</font>'::text AS cate_sup_autre,
    c.geom
   FROM m_urbanisme_doc.an_doc_urba p,
    r_cadastre.geo_commune c,
    r_administratif.an_geo,
    m_urbanisme_reg.an_sup_geo_commune sup
  WHERE "left"(p.idurba::text, 5) = ('60'::text || c.idu) AND p.etat = '03'::bpchar AND an_geo.insee::text = ('60'::text || c.idu) AND sup.insee::text = an_geo.insee::text
  GROUP BY p.idurba, an_geo.libgeo, c.geom
WITH DATA;

ALTER TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu0_gdpublic
    OWNER TO sig_create;

COMMENT ON MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu0_gdpublic
    IS 'Vue matérialisée contenant les informations de niveau 0 à la commune pour l''application PLU Interactif (téléchargement direct des documents à la commune)';

GRANT DELETE, UPDATE, SELECT, INSERT ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu0_gdpublic TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu0_gdpublic TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu0_gdpublic TO read_sig;

-- View: x_apps_public.xappspublic_an_vmr_fichegeo_ruplu1_gdpublic

-- DROP MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu1_gdpublic;

CREATE MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu1_gdpublic
TABLESPACE pg_default
AS
 WITH req_par AS (
         SELECT "substring"(parcelle.parcelle, 5, 15) AS idu,
            '60'::text || "substring"(parcelle.parcelle, 8, 15) AS parcelle,
            '60'::text || parcelle.ccocom AS insee
           FROM r_cadastre.parcelle
        ), req_plu AS (
         SELECT "substring"(an_doc_urba.idurba::text, 1, 5) AS insee,
            an_doc_urba.datappro,
            an_doc_urba.typedoc,
                CASE
                    WHEN an_doc_urba.typedoc::text = 'RNU'::text THEN '<font size=2>Ce terrain est soumis aux dispositions du <b>Réglèment National d''Urbanisme (RNU)</b>.'::text
                    ELSE (((('<font size=2>Ce terrain est soumis aux dispositions '::text ||
                    CASE
                        WHEN an_doc_urba.typedoc::text = 'PLUI'::text THEN 'du <b>Plan Local d''Urbanisme Intercommunal</b>'::text
                        WHEN an_doc_urba.typedoc::text = 'PLU'::text THEN ' du <b>Plan Local d''Urbanisme</b>'::text
                        WHEN an_doc_urba.typedoc::text = 'POS'::text THEN 'du <b>Plan d''Occupation des Sol</b>'::text
                        WHEN an_doc_urba.typedoc::text = 'CC'::text THEN 'de la <b>Carte Communale</b></font>'::text
                        ELSE NULL::text
                    END) || ' en vigueur sur la commune <b>approuvé le '::text) || to_char(an_doc_urba.datappro::date::timestamp with time zone, 'DD/MM/YYYY'::text)) || '</b> dans le cadre '::text) ||
                    CASE
                        WHEN an_doc_urba.l_version::text ~~ 'élaboration%'::text THEN ('d''une <b>'::text || an_doc_urba.l_version::text) || '</b>'::text
                        WHEN an_doc_urba.l_version::text ~~ 'mise à jour%'::text THEN ('de la <b>'::text || an_doc_urba.l_version::text) || '</b>'::text
                        WHEN an_doc_urba.l_version::text ~~ 'mise en compatibilité%'::text THEN ('de la <b>'::text || an_doc_urba.l_version::text) || '</b>'::text
                        WHEN an_doc_urba.l_version::text ~~ 'modification n°%'::text THEN ('de la <b>'::text || an_doc_urba.l_version::text) || '</b>'::text
                        WHEN an_doc_urba.l_version::text ~~ 'modification simplifiée%'::text THEN ('de la <b>'::text || an_doc_urba.l_version::text) || '</b>'::text
                        WHEN an_doc_urba.l_version::text = 'modification simplifiée'::text THEN ('d''une <b>'::text || an_doc_urba.l_version::text) || '</b>'::text
                        WHEN an_doc_urba.l_version::text ~~ 'modification simplifiée n°%'::text THEN ('de la <b>'::text || an_doc_urba.l_version::text) || '</b>'::text
                        WHEN an_doc_urba.l_version::text = 'révision'::text THEN ('d''une <b>'::text || an_doc_urba.l_version::text) || '</b>'::text
                        WHEN an_doc_urba.l_version::text ~~ 'révision simplifiée n°%'::text THEN ('de la <b>'::text || an_doc_urba.l_version::text) || '</b>'::text
                        ELSE NULL::text
                    END
                END AS typedoc_l,
            an_doc_urba.l_meta AS url_meta
           FROM m_urbanisme_doc.an_doc_urba,
            r_administratif.an_geo a
          WHERE a.insee::text = "substring"(an_doc_urba.idurba::text, 1, 5) AND an_doc_urba.etat = '03'::bpchar
        ), req_zonage AS (
         SELECT '60'::text || geo_parcelle.idu AS idu,
            '<font size=2>Règlement applicable : Dispositions générales, Lexique, Zonage(s) </font>'::text || string_agg(((('<a href="'::text || xapps_an_vmr_parcelle_plu.urlfic::text) || '" target="_blank"><font size=2 color="#000000"><b><u>'::text) || xapps_an_vmr_parcelle_plu.libelle::text) || '</u></b></font></a>'::text, ', '::text) AS url_plu
           FROM r_cadastre.geo_parcelle
             LEFT JOIN x_apps.xapps_an_vmr_parcelle_plu ON ('60'::text || geo_parcelle.idu) = xapps_an_vmr_parcelle_plu.idu
          GROUP BY geo_parcelle.idu
          ORDER BY geo_parcelle.idu
        ), req_zac AS (
         SELECT "PARCELLE"."IDU" AS idu,
            'oui'::text AS zac,
            ((('<font size=2> Règlement applicable :</font><a href="'::text || geo_p_info_surf.urlfic::text) || '" target="_blank"><font size=2 color="#000000"><b><u> '::text) || geo_p_info_surf.l_nom::text) || '</u></b></font></a>'::text AS url_zac,
            geo_p_info_surf.l_nom AS l_nom_zac
           FROM r_bg_edigeo."PARCELLE",
            m_urbanisme_doc.geo_p_info_surf
          WHERE (geo_p_info_surf.insee::text = '60402'::text OR geo_p_info_surf.insee::text = '60023'::text OR geo_p_info_surf.insee::text = '60665'::text AND geo_p_info_surf.idinf::text <> '60665IS007'::text) AND geo_p_info_surf.typeinf::text = '02'::text AND st_intersects("PARCELLE"."GEOM", geo_p_info_surf.geom1)
        )
 SELECT row_number() OVER () AS gid,
    req_par.parcelle AS idu,
    req_par.insee,
    req_plu.typedoc,
    req_plu.typedoc_l,
    req_plu.url_meta,
    req_zonage.url_plu,
    req_zac.zac,
    req_zac.url_zac,
    req_zac.l_nom_zac,
    ((((('http://geo.compiegnois.fr/documents/metiers/urba/docurba/'::text || req_par.insee) || '_'::text) || req_plu.typedoc::text) || '_'::text) || req_plu.datappro::text) || '.zip'::text AS url_zip
   FROM req_par
     LEFT JOIN req_plu ON req_par.insee = req_plu.insee
     LEFT JOIN req_zonage ON req_par.parcelle = req_zonage.idu
     LEFT JOIN req_zac ON req_par.parcelle = req_zac.idu::text
WITH DATA;

ALTER TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu1_gdpublic
    OWNER TO sig_create;

COMMENT ON MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu1_gdpublic
    IS 'Vue matérialisée contenant les informations de niveau 1 pour l''application PLU Interactif (type de document et zonage)';

GRANT DELETE, UPDATE, SELECT, INSERT ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu1_gdpublic TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu1_gdpublic TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu1_gdpublic TO read_sig;

-- View: x_apps_public.xappspublic_an_vmr_fichegeo_ruplu2_gdpublic

-- DROP MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu2_gdpublic;

CREATE MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu2_gdpublic
TABLESPACE pg_default
AS
 WITH r_p AS (
         WITH r_pct AS (
                 SELECT DISTINCT "PARCELLE"."IDU" AS idu,
                    (('<font size=2>'::text || (((((((geo_p_prescription_pct.libelle::text ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_numero::text) <> 0 OR length(geo_p_prescription_pct.l_nom::text) <> 0 OR length(geo_p_prescription_pct.l_nature::text) <> 0 OR length(geo_p_prescription_pct.l_surf_txt::text) <> 0 OR length(geo_p_prescription_pct.l_gen::text) <> 0 OR length(geo_p_prescription_pct.l_valrecul::text) <> 0 OR length(geo_p_prescription_pct.l_typrecul::text) <> 0 OR length(geo_p_prescription_pct.urlfic::text) <> 0 THEN '&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_psc'');">+</button><div id="id_psc" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2>'::text
                            ELSE '</font>'::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_numero::text) IS NOT NULL THEN ' N°'::text || geo_p_prescription_pct.l_numero::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_nom::text) IS NOT NULL THEN ('<br>'::text || 'Nom : '::text) || geo_p_prescription_pct.l_nom::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_nature::text) IS NOT NULL THEN ('<br>'::text || 'Nature : '::text) || geo_p_prescription_pct.l_nature::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_surf_txt::text) IS NOT NULL THEN ('<br>'::text || 'Surface : '::text) || geo_p_prescription_pct.l_surf_txt::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_gen::text) IS NOT NULL THEN ('<br>'::text || 'Générateur du recul : '::text) || geo_p_prescription_pct.l_gen::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_valrecul::text) IS NOT NULL THEN ('<br>'::text || 'Valeur du recul : '::text) || geo_p_prescription_pct.l_valrecul::text
                            ELSE ''::text
                        END)) ||
                        CASE
                            WHEN length(geo_p_prescription_pct.l_typrecul::text) IS NOT NULL THEN ('<br>'::text || 'Type du recul : '::text) || geo_p_prescription_pct.l_typrecul::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_pct.urlfic::text) <> 0 THEN ('<br><a href="'::text || geo_p_prescription_pct.urlfic::text) || '" target="_blank"><font size=2 color="#000000"><b>+ d''infos</b></font></a></font></div>'::text
                            ELSE ''::text
                        END AS libelle
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc.geo_p_prescription_pct
                  WHERE st_intersects("PARCELLE"."GEOM", geo_p_prescription_pct.geom)
                ), r_lin AS (
                 SELECT DISTINCT "PARCELLE"."IDU" AS idu,
                    (((((((((('<font size=2>'::text || geo_p_prescription_lin.libelle::text) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_numero::text) <> 0 OR length(geo_p_prescription_lin.l_nom::text) <> 0 OR length(geo_p_prescription_lin.l_nature::text) <> 0 OR length(geo_p_prescription_lin.l_surf_txt::text) <> 0 OR length(geo_p_prescription_lin.l_gen::text) <> 0 OR length(geo_p_prescription_lin.l_valrecul::text) <> 0 OR length(geo_p_prescription_lin.l_typrecul::text) <> 0 OR length(geo_p_prescription_lin.urlfic::text) <> 0 THEN '&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_psc'');">+</button><div id="id_psc" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2>'::text
                            ELSE '</font>'::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_numero::text) IS NOT NULL THEN ' N°'::text || geo_p_prescription_lin.l_numero::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_nom::text) IS NOT NULL THEN ('<br>'::text || 'Nom : '::text) || geo_p_prescription_lin.l_nom::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_nature::text) IS NOT NULL THEN ('<br>'::text || 'Nature : '::text) || geo_p_prescription_lin.l_nature::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_surf_txt::text) IS NOT NULL THEN ('<br>'::text || 'Surface : '::text) || geo_p_prescription_lin.l_surf_txt::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_gen::text) IS NOT NULL THEN ('<br>'::text || 'Générateur du recul : '::text) || geo_p_prescription_lin.l_gen::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_valrecul::text) IS NOT NULL THEN ('<br>'::text || 'Valeur du recul : '::text) || geo_p_prescription_lin.l_valrecul::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.l_typrecul::text) IS NOT NULL THEN ('<br>'::text || 'Type du recul : '::text) || geo_p_prescription_lin.l_typrecul::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_lin.urlfic::text) <> 0 THEN ('<br><a href="'::text || geo_p_prescription_lin.urlfic::text) || '" target="_blank"><font size=2 color="#000000"><b>+ d''infos</b></font></a></font></div>'::text
                            ELSE ''::text
                        END) || '</font>'::text AS libelle
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc.geo_p_prescription_lin
                  WHERE st_intersects("PARCELLE"."GEOM", geo_p_prescription_lin.geom1) AND geo_p_prescription_lin.insee::text = "left"("PARCELLE"."IDU"::text, 5)
                ), r_surf AS (
                 SELECT DISTINCT "PARCELLE"."IDU" AS idu,
                    (('<font size=2>'::text || (((((((geo_p_prescription_surf.libelle::text ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_numero::text) <> 0 OR length(geo_p_prescription_surf.l_nom::text) <> 0 OR length(geo_p_prescription_surf.l_nature::text) <> 0 OR length(geo_p_prescription_surf.l_surf_txt::text) <> 0 OR length(geo_p_prescription_surf.l_gen::text) <> 0 OR length(geo_p_prescription_surf.l_valrecul::text) <> 0 OR length(geo_p_prescription_surf.l_typrecul::text) <> 0 OR length(geo_p_prescription_surf.urlfic::text) <> 0 THEN '&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_psc'');">+</button><div id="id_psc" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2>'::text
                            ELSE '</font>'::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_numero::text) IS NOT NULL THEN ' N°'::text || geo_p_prescription_surf.l_numero::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_nom::text) IS NOT NULL THEN ('<br>'::text || 'Nom : '::text) || geo_p_prescription_surf.l_nom::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_nature::text) IS NOT NULL THEN ('<br>'::text || 'Nature : '::text) || geo_p_prescription_surf.l_nature::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_surf_txt::text) IS NOT NULL THEN ('<br>'::text || 'Surface : '::text) || geo_p_prescription_surf.l_surf_txt::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_gen::text) IS NOT NULL THEN ('<br>'::text || 'Générateur du recul : '::text) || geo_p_prescription_surf.l_gen::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_valrecul::text) IS NOT NULL THEN ('<br>'::text || 'Valeur du recul : '::text) || geo_p_prescription_surf.l_valrecul::text
                            ELSE ''::text
                        END)) ||
                        CASE
                            WHEN length(geo_p_prescription_surf.l_typrecul::text) IS NOT NULL THEN ('<br>'::text || 'Type du recul : '::text) || geo_p_prescription_surf.l_typrecul::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_prescription_surf.urlfic::text) <> 0 THEN ('<br><a href="'::text || geo_p_prescription_surf.urlfic::text) || '" target="_blank"><font size=2 color="#000000"><b>+ d''infos</b></font></a></font></div>'::text
                            ELSE ''::text
                        END AS libelle
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc.geo_p_prescription_surf
                  WHERE st_intersects("PARCELLE"."GEOM", geo_p_prescription_surf.geom1) AND geo_p_prescription_surf.insee::text = "left"("PARCELLE"."IDU"::text, 5)
                )
         SELECT p."IDU" AS idu,
                CASE
                    WHEN r_pct.libelle IS NULL AND r_lin.libelle IS NULL AND r_surf.libelle IS NULL THEN '<font size=2>Aucune prescription à porter à connaissance sur ce terrain.</font>'::text
                    ELSE NULL::text
                END AS libelle
           FROM r_bg_edigeo."PARCELLE" p
             LEFT JOIN r_pct ON p."IDU"::text = r_pct.idu::text
             LEFT JOIN r_lin ON p."IDU"::text = r_lin.idu::text
             LEFT JOIN r_surf ON p."IDU"::text = r_surf.idu::text
          WHERE r_pct.libelle IS NULL AND r_lin.libelle IS NULL AND r_surf.libelle IS NULL
        UNION ALL
         SELECT r_pct.idu,
            r_pct.libelle
           FROM r_pct
        UNION ALL
         SELECT r_lin.idu,
            r_lin.libelle
           FROM r_lin
        UNION ALL
         SELECT r_surf.idu,
            r_surf.libelle
           FROM r_surf
        )
 SELECT row_number() OVER () AS gid,
    r_p.idu,
    r_p.libelle
   FROM r_p
WITH DATA;

ALTER TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu2_gdpublic
    OWNER TO sig_create;

COMMENT ON MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu2_gdpublic
    IS 'Vue matérialisée contenant les informations de niveau 2 pour l''application PLU Interactif (prescriptions)';

GRANT DELETE, UPDATE, SELECT, INSERT ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu2_gdpublic TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu2_gdpublic TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu2_gdpublic TO read_sig;

-- View: x_apps_public.xappspublic_an_vmr_fichegeo_ruplu3_gdpublic

-- DROP MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu3_gdpublic;

CREATE MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu3_gdpublic
TABLESPACE pg_default
AS
 WITH r_p AS (
         WITH r_surf AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    geo_p_info_surf.l_nom,
                    geo_p_info_surf.l_bnfcr,
                    geo_p_info_surf.l_dateins,
                    geo_p_info_surf.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc.geo_p_info_surf
                  WHERE geo_p_info_surf.typeinf::text = '04'::text AND st_intersects("PARCELLE"."GEOM", geo_p_info_surf.geom1) AND "left"("PARCELLE"."IDU"::text, 5) = "left"(geo_p_info_surf.idinf::text, 5)
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
    '<font size=2>'::text ||
        CASE
            WHEN length(r_p.l_nom::text) = 0 OR r_p.l_nom::text = ''::text OR r_p.l_nom::text IS NULL THEN 'Aucun droit de préemption urbain n''est applicable sur ce terrain.</font>'::character varying::text
            ELSE (((((('<font size=2>Ce terrain est concerné par le droit de préemption urbain au bénéfice de l'''::text || r_p.l_bnfcr::text) || ' applicable suite à la délibération du '::text) || to_char(to_date(r_p.l_dateins::text, 'YYYYMMDD'::text)::timestamp without time zone, 'DD/MM/YYYY'::text)::character varying::text) ||
            CASE
                WHEN length(r_p.urlfic::text) <> 0 THEN '&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_dup'');">+</button><div id="id_dup" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2>'::text
                ELSE '</font>'::text
            END) || '<br><a href="'::text) || r_p.urlfic::text) || '" target="_blank"><font size=2 color="#000000"><b>+ d''infos</b></font></a></font></div>'::text
        END AS application,
    r_p.l_bnfcr AS beneficiaire,
    r_p.urlfic
   FROM r_p
WITH DATA;

ALTER TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu3_gdpublic
    OWNER TO sig_create;

COMMENT ON MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu3_gdpublic
    IS 'Vue matérialisée contenant les informations de niveau 3 pour l''application PLU Interactif (droit de préemption)';

GRANT DELETE, UPDATE, SELECT, INSERT ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu3_gdpublic TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu3_gdpublic TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu3_gdpublic TO read_sig;

-- View: x_apps_public.xappspublic_an_vmr_fichegeo_ruplu4_gdpublic

-- DROP MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu4_gdpublic;

CREATE MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu4_gdpublic
TABLESPACE pg_default
AS
 SELECT DISTINCT row_number() OVER () AS gid,
    s.idu,
        CASE
            WHEN s.code IS NOT NULL THEN
            CASE
                WHEN s.code::text = 'A4'::text THEN ('<font size=2><b>Cours d''eau concerné(s)</b> :</font><br><font size=2>'::text || string_agg('- '::text || replace(s.ligne_aff::text, 'A4 - Servitude de passage permettant l''exécution des travaux ainsi que l''exploitation et l''entretien des ouvrages sur les cours d''eau non domaniaux'::text, ''::text), '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'AC1'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_ac1'');">+</button><div id="id_ac1" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Liste des monuments historiques concernées et classement</b> :</font><br><font size=2>'::text) || string_agg('- '::text || replace(replace(s.ligne_aff::text, 'AC1 - Servitude de protection des monuments historiques classés ou inscrits'::text, ''::text), 'Type : '::text, ', '::text), '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'AC2'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_ac2'');">+</button><div id="id_ac2" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Liste des sites et type de protection</b> :</font><br><font size=2>'::text) || string_agg('- '::text || replace(replace(s.ligne_aff::text, 'AC2 - Sites inscrits et classés'::text, ''::text), 'Type : '::text, ', '::text), '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'AC4'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_ac4'');">+</button><div id="id_ac4" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Type de protection sur le terrain</b> :</font><br><font size=2>'::text) || string_agg(DISTINCT ((((z.message::text || '<br>'::text) || z.typeprotec::text) || ' : '::text) || z.protec::text) ||
                CASE
                    WHEN length(z.nomplan::text) IS NOT NULL THEN ('<br><a href="'::text || z.nomreg::text) || '" target="_blank"><font size=2 color="#000000"><b>+ d''infos</b></font></a>'::text
                    ELSE ''::text
                END, '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'AS1'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_as1'');">+</button><div id="id_as1" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Liste des captages et type de protection</b> :</font><br><font size=2>'::text) || string_agg('- '::text || replace(replace(s.ligne_aff::text, 'AS1 - Servitude résultant de l''instauration de périmètres de protection des eaux potables et minérales'::text, ''::text), 'Type : '::text, ', '::text), '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'EL3'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_el3'');">+</button><div id="id_el3" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Rivière concernée et distance</b> :</font><br><font size=2>'::text) || string_agg('- '::text || replace(s.ligne_aff::text, 'EL3 - Servitude de halage et de marchepied'::text, ''::text), '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'EL7'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_el7'');">+</button><div id="id_el7 style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Liste des routes concernées et type de proection</b> :</font><br><font size=2>'::text) || string_agg('- '::text || replace(replace(s.ligne_aff::text, 'EL7 - Servitudes attachées à l''alignement des voies nationales, départementales et communales'::text, ''::text), 'Type : '::text, ', '::text), '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'I3'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_i3'');">+</button><div id="id_i3" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Caractéristiques</b> :</font><br><font size=2>'::text) || string_agg('- '::text || replace(replace(s.ligne_aff::text, 'I3 - Périmètres de servitude autour d''une canalisation de gaz'::text, ''::text), 'Servitude relative au transport de gaz naturel : '::text, ''::text), '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'I4'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_i4'');">+</button><div id="id_i4" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Caractéristiques</b> :</font><br><font size=2>'::text) || string_agg('- '::text || replace(s.ligne_aff::text, 'I4 - Servitude au voisinage d''une ligne électrique aérienne ou souterraine'::text, ''::text), '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'INT1'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_int1'');">+</button><div id="id_int1" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Liste des cimetières</b> :</font><br><font size=2>'::text) || string_agg('- '::text || replace(s.ligne_aff::text, 'INT1 - Servitudes relatives aux cimétières'::text, ''::text), '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'PM1'::text THEN ((((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_pm1'');">+</button><div id="id_pm1" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Liste des plans et type de zones</b> :</font><br><font size=2>'::text) || string_agg(('- '::text || replace(s.ligne_aff::text, 'PM1 - Plans de Prévention des risques Naturels prévisibles et plans de prévention des risques miniers - documents valant PPRN'::text, ''::text)) || ' '::text, '<br>'::text)) || 'Zone(s) : '::text) || string_agg(p.l_zone::text, ', '::text)) || '</font>'::text
                WHEN s.code::text = 'PM3'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_pm3'');">+</button><div id="id_pm3" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Liste des sites</b> :</font><br><font size=2>'::text) || string_agg('- '::text || replace(s.ligne_aff::text, 'PM3 - Plans de prévention des risques technologiques'::text, ''::text), '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'PT1'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_pt1'');">+</button><div id="id_pt1" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Liste des antennes concernées et type de protection</b> :</font><br><font size=2>'::text) || string_agg('- '::text || replace(replace(s.ligne_aff::text, 'PT1 - Servitude de protection des centres de réception radioélectrique contre les perturbations électromagnétiques'::text, ''::text), 'Type : '::text, ', '::text), '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'PT2'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_pt2'');">+</button><div id="id_pt2" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Liste des antennes concernées et type de protection</b> :</font><br><font size=2>'::text) || string_agg('- '::text || replace(replace(s.ligne_aff::text, 'PT2 - Servitude de protection des centres radioélectriques d''émission et de récéption contre les obstacles'::text, ''::text), 'Type : '::text, ', '::text), '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'PT2LH'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_pt2lh'');">+</button><div id="id_pt2lh" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Liste des antennes concernées et type de protection</b> :</font><br><font size=2>'::text) || string_agg('- '::text || replace(replace(s.ligne_aff::text, 'PT2LH - Servitudes de protection contre les obstacles pour une liaison hertzienne'::text, ''::text), 'Type : '::text, ', '::text), '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'T1'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_t1'');">+</button><div id="id_t1" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Ligne ferrée concernée </b> :</font><br><font size=2>'::text) || string_agg('- '::text || replace(s.ligne_aff::text, 'T1 - Servitude de visibilité sur les voies publiques. Zones de servitudes relatives aux chemins de fer'::text, ''::text), '<br>'::text)) || '</font>'::text
                WHEN s.code::text = 'T4-T5'::text THEN ((((('<font size=2>'::text || s.code::text) || ' - '::text) || s.libelle::text) || '</font>&nbsp;&nbsp;<button class="gbbutton" onclick="toggle_div(this,''id_t4t5'');">+</button><div id="id_t4t5" style="display:none;"><div style="text-align:justify;"><small><span style="font-family:arial,helvetica,sans-serif;"><font size=2><b>Aérodrome concerné </b> :</font><br><font size=2>'::text) || string_agg('- '::text || replace(s.ligne_aff::text, 'T4-T5 - Servitudes aéronautique de balisage et de dégagement'::text, ''::text), '<br>'::text)) || '</font>'::text
                ELSE ''::text
            END
            ELSE ''::text
        END AS cate_sup
   FROM m_urbanisme_reg.an_sup_geo s
     LEFT JOIN m_urbanisme_reg.an_sup_ac4_geo_protect z ON s.idu::text = z.idu::text
     LEFT JOIN m_urbanisme_reg.an_sup_geo_pm1 p ON s.idu::text = p.idu::text
     LEFT JOIN m_urbanisme_reg.an_sup_geo_commune sup ON "left"(s.idu::text, 5) = sup.insee::text
  GROUP BY s.idu, s.code, s.libelle
  ORDER BY s.idu
WITH DATA;

ALTER TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu4_gdpublic
    OWNER TO sig_create;

COMMENT ON MATERIALIZED VIEW x_apps_public.xappspublic_an_vmr_fichegeo_ruplu4_gdpublic
    IS 'Vue matérialisée contenant les informations de niveau 4 pour l''application PLU Interactif (SUP)';

GRANT DELETE, UPDATE, SELECT, INSERT ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu4_gdpublic TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu4_gdpublic TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_vmr_fichegeo_ruplu4_gdpublic TO read_sig;

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                INDEX (sur les tables)                                                        ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

CREATE INDEX geo_p_habillage_lin_geom_idx
  ON m_urbanisme_doc.geo_p_habillage_lin
  USING gist
  (geom);

CREATE INDEX geo_p_habillage_pct_geom_idx
  ON m_urbanisme_doc.geo_p_habillage_pct
  USING gist
  (geom);

CREATE INDEX geo_p_habillage_surf_geom_idx
  ON m_urbanisme_doc.geo_p_habillage_surf
  USING gist
  (geom);

CREATE INDEX geo_p_habillage_txt_geom_idx
  ON m_urbanisme_doc.geo_p_habillage_txt
  USING gist
  (geom);

CREATE INDEX geo_p_info_lin_geom_idx
  ON m_urbanisme_doc.geo_p_info_lin
  USING gist
  (geom);

CREATE INDEX geo_p_info_pct_geom_idx
  ON m_urbanisme_doc.geo_p_info_pct
  USING gist
  (geom);


CREATE INDEX geo_p_info_surf_geom_idx
  ON m_urbanisme_doc.geo_p_info_surf
  USING gist
  (geom);

CREATE INDEX geo_p_zone_urba_geom_idx
  ON m_urbanisme_doc.geo_p_zone_urba
  USING gist
  (geom);
