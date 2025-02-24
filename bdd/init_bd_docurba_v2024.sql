-- ############################################################################################ SUIVI CODE SQL ###################################################################################################

-- 2024/10/08 : GB / Initialisation de la structure de la base de données pour le modèle CNIG des PLU, PLUI et CC avec les versions 2022 et 2024 du CNIG

-- ATTENTION : cette structure de base de données intègres les éléments d'autres standarts pour gérer dans une même structure de base, les PLU, et Carte Communale
-- L'ARC a également intégré ces particularités de gestion et d'exploitation comme celles d'autres partenaires.

-- Chaque structure doit donc adapter ce script en fonction de ces particularités.

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  SCHEMA                                                                      ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

DROP SCHEMA IF EXISTS m_urbanisme_doc_v2024 cascade;
CREATE SCHEMA m_urbanisme_doc_v2024
  AUTHORIZATION create_sig;

COMMENT ON SCHEMA m_urbanisme_doc_v2024 IS 'Schéma contenant les données métiers relatives aux documents d''urbanisme du nouveau modèle CNIG2022 et 2024';


-- Permissions

GRANT ALL ON SCHEMA m_urbanisme_doc_v2024 TO create_sig;
GRANT ALL ON SCHEMA m_urbanisme_doc_v2024 TO sig_create;
GRANT ALL ON SCHEMA m_urbanisme_doc_v2024 TO sig_edit;
GRANT ALL ON SCHEMA m_urbanisme_doc_v2024 TO sig_read;
GRANT ALL ON SCHEMA m_urbanisme_doc_v2024 TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA m_urbanisme_doc_v2024 GRANT DELETE, UPDATE, SELECT, TRUNCATE, TRIGGER, INSERT, REFERENCES ON TABLES TO create_sig;
ALTER DEFAULT PRIVILEGES IN SCHEMA m_urbanisme_doc_v2024 GRANT DELETE, UPDATE, SELECT, TRUNCATE, TRIGGER, INSERT, REFERENCES ON TABLES TO sig_create;
ALTER DEFAULT PRIVILEGES IN SCHEMA m_urbanisme_doc_v2024 GRANT DELETE, UPDATE, SELECT, INSERT ON TABLES TO sig_edit;
ALTER DEFAULT PRIVILEGES IN SCHEMA m_urbanisme_doc_v2024 GRANT SELECT ON TABLES TO sig_read;

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  SEQUENCE NON LIEE (spécifique ARC)                                          ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- m_urbanisme_doc_v2024.geo_a_habillage_txt_gid_seq definition

-- DROP SEQUENCE m_urbanisme_doc_v2024.geo_a_habillage_txt_gid_seq;

CREATE SEQUENCE m_urbanisme_doc_v2024.geo_a_habillage_txt_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 8573
	NO CYCLE;

-- Permissions
/*
ALTER SEQUENCE m_urbanisme_doc_v2024.geo_a_habillage_txt_gid_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_v2024.geo_a_habillage_txt_gid_seq TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_v2024.geo_a_habillage_txt_gid_seq TO public;
*/

--ALTER SEQUENCE m_urbanisme_doc_v2024.geo_a_habillage_txt_gid_seq RESTART WITH 39601;


-- m_urbanisme_doc_v2024.geo_a_info_surf_gid_seq definition

-- DROP SEQUENCE m_urbanisme_doc_v2024.geo_a_info_surf_gid_seq;

CREATE SEQUENCE m_urbanisme_doc_v2024.geo_a_info_surf_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 782
	NO CYCLE;

-- Permissions
/*
ALTER SEQUENCE m_urbanisme_doc_v2024.geo_a_info_surf_gid_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_v2024.geo_a_info_surf_gid_seq TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_v2024.geo_a_info_surf_gid_seq TO public;
*/

--ALTER SEQUENCE m_urbanisme_doc_v2024.geo_a_info_surf_gid_seq RESTART WITH 5806;


-- m_urbanisme_doc_v2024.geo_a_prescription_surf_gid_seq definition

-- DROP SEQUENCE m_urbanisme_doc_v2024.geo_a_prescription_surf_gid_seq;

CREATE SEQUENCE m_urbanisme_doc_v2024.geo_a_prescription_surf_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 7586
	NO CYCLE;

-- Permissions
/*
ALTER SEQUENCE m_urbanisme_doc_v2024.geo_a_prescription_surf_gid_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_v2024.geo_a_prescription_surf_gid_seq TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_v2024.geo_a_prescription_surf_gid_seq TO public;

ALTER SEQUENCE m_urbanisme_doc_v2024.geo_a_prescription_surf_gid_seq RESTART WITH 29914;
*/

-- m_urbanisme_doc_v2024.geo_a_zone_urba_gid_seq definition

-- DROP SEQUENCE m_urbanisme_doc_v2024.geo_a_zone_urba_gid_seq;

CREATE SEQUENCE m_urbanisme_doc_v2024.geo_a_zone_urba_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 4811
	NO CYCLE;

-- Permissions
/*
ALTER SEQUENCE m_urbanisme_doc_v2024.geo_a_zone_urba_gid_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_v2024.geo_a_zone_urba_gid_seq TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_v2024.geo_a_zone_urba_gid_seq TO public;

ALTER SEQUENCE m_urbanisme_doc_v2024.geo_a_zone_urba_gid_seq RESTART WITH 18602;
*/

-- m_urbanisme_doc_v2024.geo_v_t_zone_urba_pluiarc_seq definition

-- DROP SEQUENCE m_urbanisme_doc_v2024.geo_v_t_zone_urba_pluiarc_seq;

CREATE SEQUENCE m_urbanisme_doc_v2024.geo_v_t_zone_urba_pluiarc_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;

-- Permissions
/*
ALTER SEQUENCE m_urbanisme_doc_v2024.geo_v_t_zone_urba_pluiarc_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_v2024.geo_v_t_zone_urba_pluiarc_seq TO create_sig;

ALTER SEQUENCE m_urbanisme_doc_v2024.geo_v_t_zone_urba_pluiarc_seq RESTART WITH 2703;
*/


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  DOMAINES DE VALEURS                                                         ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- ################################################################# Domaine valeur - lt_etat #############################################

-- Table: m_urbanisme_doc_v2024.lt_etat

-- DROP TABLE m_urbanisme_doc_v2024.lt_etat;

CREATE TABLE m_urbanisme_doc_v2024.lt_etat
(
  code character(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_etat_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);
/*
ALTER TABLE m_urbanisme_doc_v2024.lt_etat
  OWNER TO create_sig;

ALTER TABLE m_urbanisme_doc_v2024.lt_etat OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_etat TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_etat TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_etat TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.lt_etat TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.lt_etat
  IS 'Liste des valeurs de l''attribut état de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_etat.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_etat.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_v2024.lt_etat(
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

-- Table: m_urbanisme_doc_v2024.lt_typedoc

-- DROP TABLE m_urbanisme_doc_v2024.lt_typedoc;

CREATE TABLE m_urbanisme_doc_v2024.lt_typedoc
(
  code character varying(4) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_typedoc_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.lt_typedoc
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.lt_typedoc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_typedoc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_typedoc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_typedoc TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.lt_typedoc TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.lt_typedoc
  IS 'Liste des valeurs de l''attribut état de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typedoc.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typedoc.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_v2024.lt_typedoc(
            code, valeur)
    VALUES
    ('RNU','Règlement national de l''urbanisme'),
    ('PLU','Plan local d''urbanisme'),
    ('PLUI','Plan local d''urbanisme intercommunal'),
    ('POS','Plan d''occupation des sols'),
    ('CC','Carte communale'),
    ('PSMV','Plan de sauvegarde et de mise en valeur'),
    ('SCOT','SCOT'); 

-- ################################################################# Domaine valeur - lt_typeref #############################################

-- Table: m_urbanisme_doc_v2024.lt_typeref

-- DROP TABLE m_urbanisme_doc_v2024.lt_typeref;

CREATE TABLE m_urbanisme_doc_v2024.lt_typeref
(
  code character varying(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_typeref_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.lt_typeref
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.lt_typeref OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_typeref TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_typeref TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_typeref TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.lt_typeref TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.lt_typeref
  IS 'Liste des valeurs de l''attribut typeref de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typeref.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typeref.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_v2024.lt_typeref(
            code, valeur)
    VALUES
    ('01','PCI'),
    ('02','BD Parcellaire'),
    ('03','RPCU'),
    ('04','Référentiel local'),
    ('05','Orthophoto & Cadastre');


-- ################################################################# Domaine valeur - lt_nomproc #############################################

-- Table: m_urbanisme_doc_v2024.lt_nomproc

-- DROP TABLE m_urbanisme_doc_v2024.lt_nomproc;

CREATE TABLE m_urbanisme_doc_v2024.lt_nomproc
(
  code character varying(3) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_nomproc_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.lt_nomproc
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.lt_nomproc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_nomproc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_nomproc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_nomproc TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.lt_nomproc TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.lt_nomproc
  IS 'Liste des valeurs de l''attribut Nom de la procédure de la donnée doc_urba';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_nomproc.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_nomproc.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_v2024.lt_nomproc(
            code, valeur)
    VALUES
    ('RNU','Commune soumise au RNU'),
    ('E','Elaboration'),
    ('MEC','Mise en compatibilité'),
    ('MAJ','Mise à jour'),
    ('M','Modification de droit commun'),
    ('MS','Modification simplifiée'),
    ('R','Révision'),
    ('RA','Révision allégée'),
    ('RS','Révision simplifiée'),
    ('A','Abrogation');


-- ################################################################# Domaine valeur - lt_typezone #############################################

-- Table: m_urbanisme_doc_v2024.lt_typezone

-- DROP TABLE m_urbanisme_doc_v2024.lt_typezone;

CREATE TABLE m_urbanisme_doc_v2024.lt_typezone
(
  code character varying(3) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_typezone_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.lt_typezone
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.lt_typezone OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_typezone TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_typezone TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_typezone TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.lt_typezone TO sig_edit;

*/

COMMENT ON TABLE m_urbanisme_doc_v2024.lt_typezone
  IS 'Liste des valeurs de l''attribut typezone de la donnée zone_urba';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typezone.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typezone.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_v2024.lt_typezone(
            code, valeur)
    VALUES
    ('U','Urbaine'),
    ('AUc','A urbaniser'),
    ('AUs','A urbaniser bloquée'),
    ('A','Agricole'),
    ('N','Naturel et forestière'),
    ('ZZ','Non concerné')
    ;

-- ################################################################# Domaine valeur - lt_formdomi #############################################
   
-- Table: m_urbanisme_doc_v2024.lt_formdomi

-- DROP TABLE m_urbanisme_doc_v2024.lt_formdomi;

CREATE TABLE m_urbanisme_doc_v2024.lt_formdomi
(
  code character varying (4) NOT NULL,
  valeur character varying(80) NOT NULL,
  def character varying(1000),
  CONSTRAINT lt_formdomi_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.lt_formdomi
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.lt_formdomi OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_formdomi TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_formdomi TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_formdomi TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.lt_formdomi TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.lt_formdomi
  IS 'Liste des valeurs des formes d''aménagement dominante souhaitée pour la zone d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_formdomi.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_formdomi.valeur IS 'Valeur';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_formdomi.def IS 'Définition';

INSERT INTO m_urbanisme_doc_v2024.lt_formdomi(
            code, valeur, def)
    VALUES
  	('0000','sans objet ou non encore définie dans le règlement',''),
	('0100','habitat','Tout type d''habitat'),
	('0101','habitat centre-ville','Petites parcelles étroites – bâti implanté en mitoyen et à l''alignement Rues sinueuses et non structurées.'),
	('0102','habitat centre-villageois','Tissu compact issu d''une implantation historique - petites parcelles étroites – bâti implanté en mitoyen et/ou à l’alignement. Rues sinueuses et non structurées. Présence d''espaces ou équipements publics fédérateurs, nombre de constructions plus important que les hameaux.'),
	('0103','habitat faubourg','Tissu compact et dense en extension du centre ancien. Petites parcelles étroites et souvent allongées (autour de 400 m²) en forme parallélogramme – bâti implanté en mitoyen et/ou à l''alignement.'),
	('0104','habitat hameau','Tissu compact issu d’une implantation historique. Parcelles de taille variable – bâti globalement implanté au contact de l’espace public. Rues sinueuses et étroites.'),
	('0105','habitat collectif','(R+3 et plus). Bâti discontinu, déconnecté des espaces urbains voisins. Taille des parcelles variables avec une prédominance de grandes parcelles de plus de 1 000 m² – voies de desserte larges – bâti en retrait par rapport aux limites parcellaires.'),
	('0106','habitat petits collectifs','(R+2 max)Bâti discontinu, déconnecté des espaces urbains voisinsTaille des parcelles variables avec une prédominance de grandes parcelles de plus de 1 000 m² – voies de desserte larges – bâti en retrait par rapport aux limites parcellaires.'),
	('0107','habitat pavillonnaire dense','Tissus résidentiel discontinu, dense, organisé et présentant une certaine homogénéité. Petites parcelles en forme homogène – bâti implanté en retrait des limites parcellaires.'),
	('0108','habitat pavillonnaire peu dense','Tissus discontinu, non organisé et hétérogène. Bâti implanté de manière aléatoire – plutôt grandes parcelles - bâti implanté en retrait des limites parcellaires.'),
	('0109','habitat maitrisé','Bâti isolé au milieu d’un espace naturel, agricole ou forestier Parcelles de forme variable avec prédominance pour les grandes de plus de 1 000 m² - bâti implanté en retrait des limites parcellaires.'),
	('0200','activité','Tout type d’activité'),
	('0201','activité industrielle / logistique / commerciale','Zone regroupant des entreprises, usines, entrepôts, surfaces commerciales… visibles et en dehors des zones urbanisées.'),
	('0202','activité commerces','Espace regroupant des commerces de proximité. Parcelles de taille et forme variables.'),
	('0203','activité bureaux','Ensembles d’immeubles de bureaux privatisés abritant des entreprises et activités tertiaires Parcelles de taille et de formes variables – surface de parkings importante mais espaces verts présents.'),
	('0300','mixte habitat / activité','Secteur où une mixité fonctionnelle est soit recherchée, soit à encadrer.'),
	('0400','loisirs et tourisme','Tout type de loisir et de tourisme'),
	('0401','loisir parc et jardin','Parcs et jardins en milieu urbain'),
	('0402','loisir parc d''attraction','Parcs d''attraction'),
	('0403','loisir balnéaire et nautique','Plages, port de plaisance'),
	('0404','loisir de montagne','Pistes et domaines orientés vers les loisirs de montagnes (tracés skiables en hiver, espaces de randonnées, activités sportives …)'),
	('0405','loisir sportif','Ensemble d''équipements sportifs (stades, gymnases, circuit automobile …)'),
	('0406','tourisme hôtelier','Ensembles d''immeubles d''hébergement hôtelier'),
	('0407','tourisme camping','Espaces réservés aux activités de camping'),
	('0500','Equipement public','Tout type d’équipement'),
	('0501','Equipement de proximité','Crèches, écoles, collèges, lycées, gendarmerie, commissariat, sécurité incendie'),
	('0502','Equipement généraux','Hopitaux, Universités'),
	('0503','Equipement de défense nationale','Domaine militaire'),
	('0600','Enfrastructure de transport','Tout type d’infrastructure de transport'),
	('0601','Infrastructure autoroutière','Emprise autoroutière et équipements associés'),
	('0602','Infrastructure ferroviaire','Emprise ferroviaire et équipements associés'),
	('0603','Infrastructure aéroportuaire','Emprise aéroportuaire et équipements associés'),
	('0604','Infrastructure portuaire','Port d''ampleur nationale (frêt, marchandises…)'),
	('0700','Activité agricole','Toutes activités agricoles'),
	('0701','Terres agricoles non bâties','Terres agricoles dépourvues de toute construction'),
	('0702','Terres agricoles avec bâtis légers','Terres agricoles pouvant contenir des constructions démontables (serres, tunnels, constructions sans fondation…)'),
	('0703','Terres agricoles avec bâtis en dur','Terres agricoles avec éventuellement des bâtiments agricoles en dur'), 
	('0704','Terres agricoles avec bâtis agricoles','Terres agricoles avec éventuellement des bâtiments agricoles, le logement des exploitants et des locaux dans le prolongement de l’activité agricole (point de vente à la ferme, atelier de transformation des produits de la ferme...)'),
	('0705','Terres agricoles avec bâtis divers','Terres agricoles avec éventuellement des bâtiments agricoles, le logement des exploitants, des locaux dans le prolongement de l’activité agricole (point de vente à la ferme, atelier de transformation des produits de la ferme…), des locaux associés à une diversification (touristique, culturelle, éducative…)'),
	('0800','Espace naturel','Tous espaces naturels'),
	('0801','Espace naturel remarquable','Espace naturel remarquable'),
	('0802','Espace naturel montagne ou littoral','Espace naturel caractéristique du patrimoine naturel et relevant de l’application des dispositions montagne / littoral'),
	('0900','Valorisation des sols et sous-sols','Toutes valorisations des sols et sous-sols'),
	('0901','Secteur de carrière','Secteur d''activité d''extraction minérale'),
	('0902','Secteur d''accueil des déchets','Secteur de traitement ou d''enfouissement des déchets'),
	('0903','Secteur de parc photovoltaïque','Secteur susceptible d’accueillir des parcs photovoltaïques'),
	('9900','Autre','Autre');    
    

-- ################################################################# Domaine valeur - lt_dest_type #############################################
   
-- Table: m_urbanisme_doc_v2024.lt_dest_type

-- DROP TABLE m_urbanisme_doc_v2024.lt_dest_type;

CREATE TABLE m_urbanisme_doc_v2024.lt_dest_type
(
  code character varying(2) NOT NULL,
  valeur character varying(254) NOT NULL,
  CONSTRAINT lt_dest_type_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.lt_dest_type
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.lt_dest_type OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_dest_type TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_dest_type TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_dest_type TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.lt_dest_type TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.lt_dest_type
  IS 'Liste des valeurs des destinations et sous-destination d''une zone d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_dest_type.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_dest_type.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_v2024.lt_dest_type(
            code, valeur)
    VALUES
  	('10','Exploitation agricole et foretière'),
  	('11','Exploitation agricole'),
  	('12','Exploitation forestière'),
  	('20','Habitation'),
  	('21','Logement'),
  	('22','Hébergement'),  	
  	('30','Commerce et activité de service'),
  	('31','Artisanat et commerce de détail'),
  	('32','Restauration'),
  	('33','Commerce de gros'),
  	('34','Activités de services où s''effectue l''accueil d''une clientèle'),
  	('35','Cinéma'),
  	('36','Hôtels'),
  	('37','Autres hébergements touristiques'),
  	('40','Equipements d''intérêts colllectif et services publics'),
  	('41','Locaux et bureaux accueillant du public des administrations publiques et assimilés'),
  	('42','Locaux techniques et industriels des administrations publiques et assimilés'),
  	('43','Etablissements d''enseignements, de santé, et d''action sociale'),
  	('44','Salles d''art et de spectacles'),
  	('45','Equipements sportifs'),
  	('46','Autres équipements recevant du public'),
  	('47','Lieux de culte'),  	
  	('50','Autres activités des secteurs primaire, secondaire ou tertiaire'),
  	('51','Industrie'),
  	('52','Entrepôts'),
  	('53','Bureau'),
  	('54','Centre de congrès et d''exposition'),
  	('55','Cuisine dédiée à la vente en ligne'),	
  	('99','Autres activités, usages et affectations du sols. Il est recommandé de consulter le règlement littéral.');


 	
-- ################################################################# Domaine valeur - lt_typesect #############################################


-- Table: m_urbanisme_doc_v2024.lt_typesect

-- DROP TABLE m_urbanisme_doc_v2024.lt_typesect;

CREATE TABLE m_urbanisme_doc_v2024.lt_typesect
(
  code character varying(2) NOT NULL, -- Code
  valeur character varying(100) NOT NULL, -- Valeur
  CONSTRAINT lt_typesect_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.lt_typesect
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.lt_typesect OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_typesect TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_typesect TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_typesect TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.lt_typesect TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.lt_typesect
  IS 'Liste des valeurs de l''attribut typesect de la donnée zone_urba';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typesect.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typesect.valeur IS 'Valeur';


INSERT INTO m_urbanisme_doc_v2024.lt_typesect(
            code, valeur)
    VALUES
    ('ZZ','Non concerné'),
    ('01','Secteur ouvert à la construction'),
    ('02','Secteur réservé aux activités'),
    ('03','Secteur non ouvert à la construction, sauf exceptions prévues par la loi'),
    ('99','Zone non couverte par la carte communale');

-- ################################################################# Domaine valeur - lt_libsect #############################################

-- Table: m_urbanisme_doc_v2024.lt_libsect

-- DROP TABLE m_urbanisme_doc_v2024.lt_libsect;

CREATE TABLE m_urbanisme_doc_v2024.lt_libsect
(
  code character varying(3) NOT NULL,
  valeur character varying(100) NOT NULL,
  CONSTRAINT lt_libsect_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.lt_libsect
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.lt_libsect OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_libsect TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_libsect TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_libsect TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.lt_libsect TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.lt_libsect
  IS 'Liste des valeurs de l''attribut libelle à saisir pour la carte communale (convention de libellé pour l''affichage cartographique)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_libsect.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_libsect.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_v2024.lt_libsect(
            code, valeur)
    VALUES
    ('ZC','Secteur ouvert à la construction'),
    ('ZCa','Secteur réservé aux activités'),
    ('ZnC','Secteur non ouvert à la construction, sauf exceptions prévues par la loi'),
    ('RNU','Zone non couverte par la carte communale (soumise au Règlement National de l''Urbanisme');


-- ################################################################# Domaine valeur - lt_typepsc #############################################

-- Table: m_urbanisme_doc_v2024.lt_typepsc

-- DROP TABLE m_urbanisme_doc_v2024.lt_typepsc;

CREATE TABLE m_urbanisme_doc_v2024.lt_typepsc
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

/*
ALTER TABLE m_urbanisme_doc_v2024.lt_typepsc
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.lt_typepsc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_typepsc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_typepsc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_typepsc TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.lt_typepsc TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.lt_typepsc
  IS 'Liste des valeurs de l''attribut typepsc de la donnée prescription_surf, prescription_lin et prescription_pct';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typepsc.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typepsc.sous_code IS 'Sous code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typepsc.valeur IS 'Valeur';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typepsc.ref_leg IS 'Références législatives du code de l''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typepsc.ref_reg IS 'Références réglementaires du code de l''urbanisme';

INSERT INTO m_urbanisme_doc_v2024.lt_typepsc(
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
	('03','03','Interdiction de reconstruction à l''identique','L111-15',null),    
    ('04','00','Périmètre issu des PDU sur obligation de stationnement','L151-47 dernier alinéa',null),
    ('05','00','Emplacement réservé','L151-41 1° à 3°','R151-48 2°,R151-50 1°,R151-34 4°,R151-43 3°'),
    ('05','01','Emplacement réservé aux voies publiques','L151-41 1°','R151-48 2°'),
    ('05','02','Emplacement réservé aux ouvrages publics','L151-41 1°','R151-50 1°'),
    ('05','03','Emplacement réservé aux installations d''intérêt général','L151-41 2°','R151-34 4°'),
    ('05','04','Emplacement réservé aux espaces verts/continuités écologiques','L151-41 3°','R151-43 3°'),
    ('05','05','Emplacement réservé logement social/mixité sociale','L151-41 4°','R151-38 1°'),
    ('05','06','Servitude de localisation des voies, ouvrages publics, installations d''intérêt général et espaces verts en zone U ou AU','L151-41 dernier alinéa',null),
    ('05','07','Secteur de projet en attente d''un projet d''aménagement global','L151-41 5°','R151-32'),
    ('05','08','Emplacements réservés à la relocalisation d''équipements, de constructions et d''installations exposés au recul du trait de côté','L151-41 6°','en attente'),
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
	('16','04','Constructions et installations nécessaires à l''activité agricole en zone A ou N',null,'R151-23 1° et R151-25 1°'),    
	('16','05','Diversification de l''activité agricole : transformation conditionnement et ventes de produits agricoles (activités liées au tourisme exclues','L151-11 II',null),    
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
	('18','09','OAP relatives aux espaces publics en zone d''aménagement concerté','L151-7-1 1°',null),
	('18','10','OAP relatives aux ouvrages publics, installations d''intérêts général et espaces verts en zone d''aménagements concerté','L151-7-1 2°',null),	
	('18','11','OAP valant création de zone d''aménagement concerté','L151-7-2','R151-8-1'),	
	('18','12','OAP Secteurs de renaturation','L151-7 I 4°',null),
	('18','13','OAP relatives à la protection des franges urbaines et rurales','L.151-7 I 7°',null),
	('18','14','OAP recul du trait de côte','L.151-7 III',null),
	('18','15','OAP trames vertes et bleues','L.151-6-2','R151-7'),
	('18','16','OAP zone d’accélération de la production d’énergies renouvelables','L.151-7 I 8°',null),
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
	('29','02','Secteur de ZAC avec densité minimale de construction','L151-27 2e al',null),    
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
    ('43','03','Réglementation des plantations',null,'R151-43 2°'),
    ('44','00','Stationnement',null,null),
    ('44','01','Stationnement minimal','L151-30 à L151-37',null),
    ('44','02','Stationnement maximal','L151-30 à L151-37','R151-45 3°'),
    ('44','03','Caractéristiques et type de stationnement',null,'R151-45 1°'),
    ('44','04','Minoration des règles de stationnement',null,'R151-45 2°'),
	('44','05','Réalisation d''aires de livraisons imposée','L151-33-1',null),    
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
    ('52','00','Infrastructures et équipements logistiques à préserver ou à développer en zones U et AU','L151-16-2',NULL),
	('53','00','Dérogation à l’article L.111-6 pour l’implantation des constructions le long des grands axes routiers','L.111-8',NULL),
	('97','00','Périmètre d’application d’une pièce écrite territorialisée (rapport de présentation, PADD, règlement, règlement graphique, POA)',null,null),
	('97','01','Périmètre couvert par un Plan de secteurs','L151-3',NULL),
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

-- Table: m_urbanisme_doc_v2024.lt_typeinf

-- DROP TABLE m_urbanisme_doc_v2024.lt_typeinf;

CREATE TABLE m_urbanisme_doc_v2024.lt_typeinf
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

/*
ALTER TABLE m_urbanisme_doc_v2024.lt_typeinf
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.lt_typeinf OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_typeinf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_typeinf TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_typeinf TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.lt_typeinf TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.lt_typeinf
  IS 'Liste des valeurs de l''attribut typeinf de la donnée info_surf, info_lin et info_pct';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typeinf.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typeinf.sous_code IS 'Sous code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typeinf.valeur IS 'Valeur';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typeinf.ref_leg IS 'Références législatives du code de l''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typeinf.ref_reg IS 'Références réglementaires du code de l''urbanisme';

INSERT INTO m_urbanisme_doc_v2024.lt_typeinf(
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
	('40','01','Périmètre d’un bien inscrit au patrimoine mondial','L612-1 et R612-1 à R612-2 code du patrimoine','R151-53'),
	('40','02','Zone tampon d’un bien inscrit au patrimoine mondial','L612-1 et R612-1 à R612-2 code du patrimoine','R151-53'),
	('41','00','Bande de recul le long des axes à grande circulation','L111-6 code de l’urbanisme','Pas de référence pour l’annexion'),
	('42','00','Secteurs délimités par délibération de l''autorité compétente en matière d''urbanisme, dans lesquels certaines opérations sont soumises à autorisation d''urbanisme.',NULL,NULL),
	('42','01','secteur dans lequel les travaux de démolition sont soumis à permis de démolir','R421-27','R151-52'),
	('42','02','Secteur dans lequel l''édification d''une clôture doit être précédée d''une déclaration préalable','R421-12 d',NULL),
	('42','03','Secteur dans lequel les travaux de ravalement sont soumis à déclaration préalable','R421-17-1 e',NULL),
	('97','00','Périmètre d’application d’une pièce écrite territorialisée relative aux annexes (liste des annexes, liste et plan des SUP)',NULL,NULL),
	('98','00','Périmètre d’annulation partielle du document d’urbanisme (lorsqu’elle impacte le règlement graphique)',NULL,NULL),
	('99','00','Autre périmètre, secteur, plan, document, site, projet, espace',null,null),
	('99','01','Autre relevant de la loi littoral',null,null),
	('99','02','Autre relevant de la loi montagne',null,null);

-- ####################################################################################################################################################
-- ###                                                  DOMAINES DE VALEURS SPECIFIQUE ARC                                                          ###
-- ####################################################################################################################################################
/*
-- ################################################################# Domaine valeur - lt_typerep_cnig #############################################

-- m_urbanisme_doc_v2024.lt_typerep_cnig definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.lt_typerep_cnig;

CREATE TABLE m_urbanisme_doc_v2024.lt_typerep_cnig (
	code varchar(2) NOT NULL, -- Code
	valeur varchar(80) NOT NULL, -- Valeur
	definition varchar(60) NULL,
	CONSTRAINT lt_typerep_cnig_pkey PRIMARY KEY (code)
);
COMMENT ON TABLE m_urbanisme_doc_v2024.lt_typerep_cnig IS 'Liste des valeurs de l''attribut rep_cnig de la donnée an_doc_urba_titre_pieces_ecrites';

-- Column comments

COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typerep_cnig.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_typerep_cnig.valeur IS 'Valeur';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.lt_typerep_cnig OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_typerep_cnig TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_typerep_cnig TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_typerep_cnig TO sig_read;
GRANT SELECT, DELETE, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.lt_typerep_cnig TO sig_edit;

INSERT INTO m_urbanisme_doc_v2024.lt_typerep_cnig(
            code, valeur,definition)
    VALUES
  	('0','0_Procedure','Procédure'),
  	('1','1_Rapport_de_presentation','Rapport de présentation'),
  	('2','2_PADD','PADD'),
  	('3','3_Reglement','Règlement'),
  	('4','4_Annexes','Annexes'),
  	('5','5_OAP','Orientations d''aménagement'),
  	('6','6_POA','Programme d''orientations et d''actions'),
  	('7','7_Plans_de_secteur','Plans de secteur');

-- ################################################################# Domaine valeur - lt_titre_cnig #############################################

-- m_urbanisme_doc_v2024.lt_titre_cnig definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.lt_titre_cnig;

CREATE TABLE m_urbanisme_doc_v2024.lt_titre_cnig (
	code varchar(2) NOT NULL, -- Code
	valeur varchar(80) NOT NULL, -- Valeur
	CONSTRAINT lt_titre_cnig_pkey PRIMARY KEY (code)
);
COMMENT ON TABLE m_urbanisme_doc_v2024.lt_titre_cnig IS 'Liste des valeurs de l''attribut titre de la donnée an_doc_urba_titre_pieces_ecrites';

-- Column comments

COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_titre_cnig.code IS 'Code';
COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_titre_cnig.valeur IS 'Valeur';

INSERT INTO m_urbanisme_doc_v2024.lt_titre_cnig(
            code, valeur)
    VALUES
  	('01','Délibération de l''autorité compétente'),
  	('10','Rapport de présentation'),
  	('20','PADD'),
  	('30','Règlement écrit'),
  	('31','Règlement graphique'),
  	('32','Liste des emplacements réservés'),
  	('39','Autres prescriptions'),
  	('40','Liste des SUP'),
  	('41','Plan des SUP'),
  	('42','Liste des annexes'),
  	('43','Notice sanitaire'),
  	('44','Réseaux'),
  	('49','Autres annexes'),
  	('50','Orientations d''aménagement');

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.lt_titre_cnig OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_titre_cnig TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_titre_cnig TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_titre_cnig TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.lt_titre_cnig TO sig_edit;


-- ################################################################# Domaine valeur - lt_conf1 #############################################

-- m_urbanisme_doc_v2024.lt_conf1 definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.lt_conf1;

CREATE TABLE m_urbanisme_doc_v2024.lt_conf1 (
	id int4 NOT NULL,
	attr1 varchar(254) NULL,
	attr2 varchar(254) NULL,
	attr3 varchar(254) NULL,
	CONSTRAINT lt_conf1_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE m_urbanisme_doc_v2024.lt_conf1 IS 'Liste des valeurs du fichier de configuration n°1 pour l''automatisation des planches graphiques du PLUiH';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.lt_conf1 OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_conf1 TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_conf1 TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_conf1 TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.lt_conf1 TO sig_edit;

-- ################################################################# Domaine valeur - lt_conf2 #############################################


-- m_urbanisme_doc_v2024.lt_conf2 definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.lt_conf2;

CREATE TABLE m_urbanisme_doc_v2024.lt_conf2 (
	id int4 NOT NULL,
	datapro varchar(8) NULL,
	CONSTRAINT lt_conf2_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE m_urbanisme_doc_v2024.lt_conf2 IS 'Liste des valeurs du fichier de configuration n°2 pour l''automatisation des planches graphiques du PLUiH';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.lt_conf2 OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_conf2 TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_conf2 TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_conf2 TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.lt_conf2 TO sig_edit;

-- ################################################################# Domaine valeur - lt_conf3 #############################################

-- m_urbanisme_doc_v2024.lt_conf3 definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.lt_conf3;

CREATE TABLE m_urbanisme_doc_v2024.lt_conf3 (
	id int4 NOT NULL,
	insee varchar(8) NULL,
	idurba varchar(25) NULL,
	CONSTRAINT lt_conf3_pkey PRIMARY KEY (id)
);
COMMENT ON TABLE m_urbanisme_doc_v2024.lt_conf3 IS 'Liste des valeurs du fichier de configuration n°3 pour l''automatisation des planches graphiques du PLUiH';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.lt_conf3 OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_conf3 TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_conf3 TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.lt_conf3 TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.lt_conf3 TO sig_edit;
*/

-- ####################################################################################################################################################
-- ###                                                  DOMAINES DE VALEURS SPECIFIQUE PNR-OLV                                                      ###
-- ####################################################################################################################################################


-- ################################################################# Domaine valeur - lt_dispon #############################################

-- Table: m_urbanisme_doc_v2024.lt_dispon

-- DROP TABLE m_urbanisme_doc_v2024.lt_dispon;
-- 
-- CREATE TABLE m_urbanisme_doc_v2024.lt_dispon
-- (
--   code character(2) NOT NULL, -- Code
--   valeur character varying(254) NOT NULL, -- Valeur
--   CONSTRAINT lt_dispon_prkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_v2024.lt_dispon
--   OWNER TO postgres;
-- GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_dispon TO postgres WITH GRANT OPTION;
-- COMMENT ON TABLE m_urbanisme_doc_v2024.lt_dispon
--   IS 'Liste des valeurs de l''attribut l_dispon de la donnée doc_urba_doc';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_dispon.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_dispon.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc_v2024.lt_dispon(
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

-- Table: m_urbanisme_doc_v2024.lt_dispop

-- DROP TABLE m_urbanisme_doc_v2024.lt_dispop;
-- 
-- CREATE TABLE m_urbanisme_doc_v2024.lt_dispop
-- (
--   code character(2) NOT NULL, -- Code
--   valeur character varying(254) NOT NULL, -- Valeur
--   CONSTRAINT lt_dispop_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_v2024.lt_dispop
--   OWNER TO postgres;
-- GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_dispop TO postgres WITH GRANT OPTION;
-- COMMENT ON TABLE m_urbanisme_doc_v2024.lt_dispop
--   IS 'Liste des valeurs de l''attribut l_dispop de la donnée doc_urba_doc';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_dispop.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_dispop.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc_v2024.lt_dispop(
--             code, valeur)
--     VALUES
--     ('00','Aucun document papier'),
--     ('10','Une partie du document (la plupart du temps le rapport de présentation, padd, règlement écrit et graphique)'),
--     ('20','Tout le document');


-- ################################################################# Domaine valeur - lt_l_themapatnat #############################################

-- Table: m_urbanisme_doc_v2024.lt_l_themapatnat

-- DROP TABLE m_urbanisme_doc_v2024.lt_l_themapatnat;
-- 
-- CREATE TABLE m_urbanisme_doc_v2024.lt_l_themapatnat
-- (
--   code character varying(10) NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_thema_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_v2024.lt_l_themapatnat
--   OWNER TO postgres;
-- GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_l_themapatnat TO postgres WITH GRANT OPTION;
-- COMMENT ON TABLE m_urbanisme_doc_v2024.lt_l_themapatnat
--   IS 'Liste des valeurs de l''attribut l_thema de la donnée zone_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_l_themapatnat.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_l_themapatnat.valeur IS 'Valeur';
-- 
-- 
-- INSERT INTO m_urbanisme_doc_v2024.lt_l_themapatnat(
--             code, valeur)
--     VALUES
--     ('aucun','aucun'),
--     ('CE','Corridor ecologique'),
--     ('N2000','Natura 2000'),
--     ('Paysage','Paysage'),
--     ('ZH','Zones humides');


-- ################################################################# Domaine valeur - lt_l_vigipatnat #############################################

-- Table: m_urbanisme_doc_v2024.lt_l_vigipatnat

-- DROP TABLE m_urbanisme_doc_v2024.lt_l_vigipatnat;
-- 
-- CREATE TABLE m_urbanisme_doc_v2024.lt_l_vigipatnat
-- (
--   code character varying(10) NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_vigilance_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_v2024.lt_l_vigipatnat
--   OWNER TO postgres;
-- GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_l_vigipatnat TO postgres WITH GRANT OPTION;
-- COMMENT ON TABLE m_urbanisme_doc_v2024.lt_l_vigipatnat
--   IS 'Liste des valeurs de l''attribut l_vigilance de la donnée zone_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_l_vigipatnat.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_l_vigipatnat.valeur IS 'Valeur';
-- 
-- 
-- INSERT INTO m_urbanisme_doc_v2024.lt_l_vigipatnat(
--             code, valeur)
--     VALUES
--     ('oui','oui'),
--     ('non','non');


-- ################################################################# Domaine valeur - lt_l_pecpatnat #############################################

-- Table: m_urbanisme_doc_v2024.lt_l_pecpatnat

-- DROP TABLE m_urbanisme_doc_v2024.lt_l_pecpatnat;
-- 
-- CREATE TABLE m_urbanisme_doc_v2024.lt_l_pecpatnat
-- (
--   code character varying(50) NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_pec_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_v2024.lt_l_pecpatnat
--   OWNER TO postgres;
-- GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_l_pecpatnat TO postgres WITH GRANT OPTION;
-- COMMENT ON TABLE m_urbanisme_doc_v2024.lt_l_pecpatnat
--   IS 'Liste des valeurs de l''attribut l_prisencompte de la donnée doc_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_l_pecpatnat.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_l_pecpatnat.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc_v2024.lt_l_pecpatnat(
--             code, valeur)
--     VALUES
--     ('diagnostic','dans diagnostic'),
--     ('non concerne','non concerné'),
--     ('PADD','dans PADD'),
--     ('pas de prise en compte','pas de prise en compte'),
--     ('Reglement','dans la réglement');



-- ################################################################# Domaine valeur - lt_l_nspatnat #############################################


-- Table: m_urbanisme_doc_v2024.lt_l_nspatnat

-- DROP TABLE m_urbanisme_doc_v2024.lt_l_nspatnat;
-- 
-- CREATE TABLE m_urbanisme_doc_v2024.lt_l_nspatnat
-- (
--   code bigint NOT NULL, -- Code
--   valeur character varying(100) NOT NULL, -- Valeur
--   CONSTRAINT lt_nsynt_pkey PRIMARY KEY (code)
-- )
-- WITH (
--   OIDS=FALSE
-- );
-- ALTER TABLE m_urbanisme_doc_v2024.lt_l_nspatnat
--   OWNER TO postgres;
-- GRANT ALL ON TABLE m_urbanisme_doc_v2024.lt_l_nspatnat TO postgres WITH GRANT OPTION;
-- COMMENT ON TABLE m_urbanisme_doc_v2024.lt_l_nspatnat
--   IS 'Liste des valeurs de l''attribut l_notesynth de la donnée doc_patnat';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_l_nspatnat.code IS 'Code';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.lt_l_nspatnat.valeur IS 'Valeur';
-- 
-- INSERT INTO m_urbanisme_doc_v2024.lt_l_nspatnat(
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

-- m_urbanisme_doc_v2024.an_doc_urba definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.an_doc_urba;

CREATE TABLE m_urbanisme_doc_v2024.an_doc_urba (
	idurba varchar(30) NOT NULL, -- Identifiant du document d'urbanisme
	typedoc varchar(4) NOT NULL, -- Type du document concerné
	etat varchar(2) NOT NULL, -- Etat juridique du document
	nomproc varchar(10) NULL, -- Codage de la version du document concerné
	l_nomprocn int4 NULL, -- N° d'ordre de la procédure
	datappro varchar(8) NULL, -- Date d'approbation
	datefin varchar(8) NULL, -- date de fin de validité
	siren varchar(9) NULL, -- Code SIREN de l'intercommunalité
	nomreg varchar(80) NULL, -- Nom du fichier de règlement
	urlreg varchar(254) NULL, -- URL ou URI du fichier du règlement
	nomplan varchar(80) NULL, -- Nom du fichier du plan scanné
	urlplan varchar(254) NULL, -- URL ou URI du fichier du plan scanné
	urlpe varchar(254) NULL, -- Lien d'accès à l'archive zip comprenant l'ensemble des pièces écrites
	siteweb varchar(254) NULL, -- Site web du service d'accès
	typeref varchar(2) NULL, -- Type de référentiel utilisé
	dateref varchar(8) NULL, -- Date du référentiel de saisie
	l_meta varchar(254) NULL, -- Lien http vers la fiche de métadonnées
	l_moa_proc varchar(80) NULL, -- Maitre d'ouvrage de la procédure
	l_moe_proc varchar(80) NULL, -- Maitre d'oeuvre de la procédure
	l_moa_dmat varchar(80) NULL, -- Maitre d'ouvrage de la dématérialisation
	l_moe_dmat varchar(80) NULL, -- Maitre d'oeuvre de la dématérialisation
	l_observ varchar(254) NULL, -- Observations
	l_parent int4 NULL, -- Identification des documents parents pour recherche des historiques entre version de documents (1 pour le premier document (élaboration, modif, mise à jour), 2 pour la révision (révision n°1, modif, mise à jour), 3 ¶  pour le 2nd révisoon (révision n°2, modif, mise à jour), ...)
	l_urldgen varchar(255) NULL, -- Lien vers les dispositions générales du règlement (uniquement rempli si utilisé dans les applications WEB le dissociant du règlement affiché par zone)
	l_urlann varchar(255) NULL, -- Lien vers les annexes du règlement (uniquement rempli si utilisé dans les applications WEB le dissociant du règlement affiché par zone)
	l_urllex varchar(255) NULL, -- Lien vers le lexique du règlement (uniquement rempli si utilisé dans les applications WEB le dissociant du règlement affiché par zone)
	nom varchar(254) NULL, -- Dénomination du SCoT
	rapport varchar(30) NULL, -- Nom du fichier contenant le rapport de présentation
	padd varchar(30) NULL, -- Nom du fichier contenant le projet d'aménagement et de développement durables
	doo varchar(30) NULL, -- Nom du fichier contenant le document d'orientation et d'objectifs
	urlrapport varchar(254) NULL, -- Lien d'accès au fichier du rapport de présentation sous forme numérique
	urlpadd varchar(254) NULL, -- Lien d'accès au fichier du PADD
	urldoo varchar(254) NULL, -- Lien d'accès au fichier du document d'orientation et d'objectifs
	CONSTRAINT an_doc_urba_pkey PRIMARY KEY (idurba)
);
COMMENT ON TABLE m_urbanisme_doc_v2024.an_doc_urba IS 'Donnée alphanumerique de référence des documents d''urbanisme en projet ou ayant été approuvés';

-- Column comments

COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.typedoc IS 'Type du document concerné';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.etat IS 'Etat juridique du document';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.nomproc IS 'Codage de la version du document concerné';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.l_nomprocn IS 'N° d''ordre de la procédure';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.datappro IS 'Date d''approbation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.datefin IS 'date de fin de validité';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.siren IS 'Code SIREN de l''intercommunalité';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.nomreg IS 'Nom du fichier de règlement';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.urlreg IS 'URL ou URI du fichier du règlement';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.nomplan IS 'Nom du fichier du plan scanné';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.urlplan IS 'URL ou URI du fichier du plan scanné';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.urlpe IS 'Lien d''accès à l''archive zip comprenant l''ensemble des pièces écrites';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.siteweb IS 'Site web du service d''accès';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.typeref IS 'Type de référentiel utilisé';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.dateref IS 'Date du référentiel de saisie';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.l_meta IS 'Lien http vers la fiche de métadonnées';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.l_moa_proc IS 'Maitre d''ouvrage de la procédure';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.l_moe_proc IS 'Maitre d''oeuvre de la procédure';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.l_moa_dmat IS 'Maitre d''ouvrage de la dématérialisation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.l_moe_dmat IS 'Maitre d''oeuvre de la dématérialisation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.l_parent IS 'Identification des documents parents pour recherche des historiques entre version de documents (1 pour le premier document (élaboration, modif, mise à jour), 2 pour la révision (révision n°1, modif, mise à jour), 3 
  pour le 2nd révisoon (révision n°2, modif, mise à jour), ...)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.l_urldgen IS 'Lien vers les dispositions générales du règlement (uniquement rempli si utilisé dans les applications WEB le dissociant du règlement affiché par zone)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.l_urlann IS 'Lien vers les annexes du règlement (uniquement rempli si utilisé dans les applications WEB le dissociant du règlement affiché par zone)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.l_urllex IS 'Lien vers le lexique du règlement (uniquement rempli si utilisé dans les applications WEB le dissociant du règlement affiché par zone)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.nom IS 'Dénomination du SCoT';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.rapport IS 'Nom du fichier contenant le rapport de présentation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.padd IS 'Nom du fichier contenant le projet d''aménagement et de développement durables';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.doo IS 'Nom du fichier contenant le document d''orientation et d''objectifs';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.urlrapport IS 'Lien d''accès au fichier du rapport de présentation sous forme numérique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.urlpadd IS 'Lien d''accès au fichier du PADD';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba.urldoo IS 'Lien d''accès au fichier du document d''orientation et d''objectifs';

-- Permissions
/*
ALTER TABLE m_urbanisme_doc_v2024.an_doc_urba OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_doc_urba TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_doc_urba TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_doc_urba TO sig_create;
GRANT INSERT, DELETE, SELECT, UPDATE ON TABLE m_urbanisme_doc_v2024.an_doc_urba TO sig_edit;
*/

-- ########################################################################## table an_doc_urba_com #######################################################


-- m_urbanisme_doc_v2024.an_doc_urba_com definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.an_doc_urba_com;

CREATE TABLE m_urbanisme_doc_v2024.an_doc_urba_com (
	idurba varchar(30) NOT NULL, -- Identifiant du document d'urbanisme
	insee varchar(5) NOT NULL, -- Code insee de la commune
	epci varchar(9) NULL, -- Code SIREN de l'EPCI auquel appartient la commune (uniquement pour un SCoT)
	CONSTRAINT an_doc_urba_com_pkey PRIMARY KEY (idurba, insee)
);
COMMENT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_com IS 'Donnée alphanumerique d''appartenance d''une commune à une procédure définie (approuvée ou non).';

-- Column comments

COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_com.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_com.insee IS 'Code insee de la commune';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_com.epci IS 'Code SIREN de l''EPCI auquel appartient la commune (uniquement pour un SCoT)';

-- Permissions
/*
ALTER TABLE m_urbanisme_doc_v2024.an_doc_urba_com OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_doc_urba_com TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_com TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_doc_urba_com TO sig_create;
GRANT INSERT, DELETE, SELECT, UPDATE ON TABLE m_urbanisme_doc_v2024.an_doc_urba_com TO sig_edit;
*/

-- ########################################################################### table geo_p_zone_urba #######################################################

-- Table: m_urbanisme_doc_v2024.geo_p_zone_urba

-- DROP TABLE m_urbanisme_doc_v2024.geo_p_zone_urba;

CREATE TABLE m_urbanisme_doc_v2024.geo_p_zone_urba
(
  idzone character varying(40) NOT NULL, -- Identifiant unique de zone
  libelle character varying(12) NOT NULL, -- Nom court de la zone
  libelong character varying(254), -- Nom complet de la zone
  typezone character varying(3) NOT NULL, -- Type de la zone
  formdomi character varying(4), -- Forme d'aménagements
  destoui character varying(120), -- Destinations et sous-destination autorisées
  destcdt character varying(120), -- Destinations et sous-destination conditionnées
  destnon character varying(120), -- Destinations et sous-destination non autorisées      
  nomfic character varying(80), -- Nom du fichier du règlement complet
  urlfic character varying(254), -- URL ou URI du fichier du règlement complet
  l_nomfic character varying(80), -- Nom du fichier du règlement de la zone
  l_urlfic character varying(254), -- URL ou URI du fichier du règlement de la zone
  idurba character varying(30) NOT NULL, -- identifiant
  datvalid character varying(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.
  typesect character varying(2) DEFAULT 'ZZ'::character varying, -- Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)
  fermreco character varying(3) NOT NULL DEFAULT 'non', -- Secteur fermé à la reconstruction (uniquement pour la carte communale)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_surf_cal numeric NOT NULL, -- Surface calculée de la zone en ha
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  geom1 geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_zone_urba_pkey PRIMARY KEY (idzone)
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_p_zone_urba
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_p_zone_urba OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_zone_urba TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_p_zone_urba TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_zone_urba TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_p_zone_urba TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_p_zone_urba
  IS 'Donnée géographique contenant les zonages des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.idzone IS 'Identifiant unique de zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.libelle IS 'Nom court de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.libelong IS 'Nom complet de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.typezone IS 'Type de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.formdomi IS 'Forme d''aménagement dominante souhaitée pour la zone afin de répondre aux besoins de réhabilitation, restructuration ou d''aménagement. Par exemple, une zone de type U peut voir sa
forme urbaine dominante différer suivant qu''elle accueille préférentiellement tel type d''habitat ou d''équipement. Cet attribut est à renseigner en procédant à une analyse du chapitre s’appliquant à la zone, ou des dispositions générales du règlement. Toutes les zones de même libellé (Ex : Uc) ont a priori la même forme urbaine dominante correspondant aux indications portées dans le règlement.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.typesect IS 'Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.fermreco IS 'Secteur fermé à la reconstruction (uniquement pour la carte communale)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.destoui IS 'Destinations et sous-destination autorisées';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.destcdt IS 'Destinations et sous-destination conditionnées';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.destnon IS 'Destinations et sous-destination non autorisées';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.l_surf_cal IS 'Surface calculée de la zone en ha';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.nomfic IS 'Nom du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.urlfic IS 'URL ou URI du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.l_nomfic IS 'Nom du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.l_urlfic IS 'URL ou URI du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.geom1 IS 'Géométrie de l''objet avec un tampon de -0.5 pour traiter les intersections avec le cadastre';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_urba.idurba IS 'Identifiant du document d''urbanisme';


-- ########################################################################### geo_p_prescription_surf #######################################################

-- Table: m_urbanisme_doc_v2024.geo_p_prescription_surf

-- DROP TABLE m_urbanisme_doc_v2024.geo_p_prescription_surf;

CREATE TABLE m_urbanisme_doc_v2024.geo_p_prescription_surf
(
  idpsc character varying(40) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nature character varying(254), -- Libellé caractérisant un ensemble de prescription de même typepsc
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.  
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(254), -- Nom
  l_nature character varying(254), -- Nature / vocation
  l_bnfcr character varying(80), -- Bénéficiaire
  l_numero character varying(20), -- Numéro
  l_surf_txt character varying(30), -- Superficie littérale
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  geom1 geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_prescription_surf_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_p_prescription_surf
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_p_prescription_surf OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_surf TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_surf TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_surf TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_surf
  IS 'Donnée géographique contenant les prescriptions surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.idpsc IS 'Identifiant unique de prescription surfacique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.nature IS 'Libellé caractérisant un ensemble de prescriptions de même TYPEPSCSTYPEPSC (ex : NATURE = Cones_de_vue)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_surf.geom1 IS 'Géométrie de l''objet avec un tampon de -0.5 pour traiter les intersections avec le cadastre';


-- ########################################################################### geo_p_prescription_lin #######################################################

-- Table: m_urbanisme_doc_v2024.geo_p_prescription_lin

-- DROP TABLE m_urbanisme_doc_v2024.geo_p_prescription_lin;

CREATE TABLE m_urbanisme_doc_v2024.geo_p_prescription_lin
(
  idpsc character varying(40) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nature character varying(254), -- Libellé caractérisant un ensemble de prescription de même typepsc  
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant. 
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(254), -- Nom
  l_nature character varying(254), -- Nature / vocation
  l_bnfcr character varying(80), -- Bénéficiaire
  l_numero character varying(10), -- Numéro
  l_surf_txt character varying(30), -- Superficie littérale
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(Multilinestring,2154), -- Géométrie de l'objet
  geom1 geometry(multipolygon,2154), -- Géométrie de l'objet  
  CONSTRAINT geo_p_prescription_lin_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_p_prescription_lin
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_p_prescription_lin OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_lin TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_lin TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_lin TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_lin
  IS 'Donnée géographique contenant les prescriptions linéaires des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.idpsc IS 'Identifiant unique de prescription linéaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.nature IS 'Libellé caractérisant un ensemble de prescriptions de même TYPEPSCSTYPEPSC (ex : NATURE = Cones_de_vue)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_lin.geom1 IS 'Géométrie de l''objet avec un tampon de -0.5 pour traiter les intersections avec le cadastre';

-- ########################################################################### geo_p_prescription_pct #######################################################

-- Table: m_urbanisme_doc_v2024.geo_p_prescription_pct

-- DROP TABLE m_urbanisme_doc_v2024.geo_p_prescription_pct;

CREATE TABLE m_urbanisme_doc_v2024.geo_p_prescription_pct
(
  idpsc character varying(40) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nature character varying(254), -- Libellé caractérisant un ensemble de prescription de même typepsc    
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.  
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(254), -- Nom
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

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_p_prescription_pct
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_p_prescription_pct OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_pct TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_pct TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_pct TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_p_prescription_pct
  IS 'Donnée géographique contenant les prescriptions ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.idpsc IS 'Identifiant unique de prescription ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.nature IS 'Libellé caractérisant un ensemble de prescriptions de même TYPEPSCSTYPEPSC (ex : NATURE = Cones_de_vue)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_prescription_pct.geom IS 'Géométrie de l''objet';


-- ################################################################################ geo_p_info_surf ##########################################################

-- Table: m_urbanisme_doc_v2024.geo_p_info_surf

-- DROP TABLE m_urbanisme_doc_v2024.geo_p_info_surf;

CREATE TABLE m_urbanisme_doc_v2024.geo_p_info_surf
(
  idinf character varying(40) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.    
  l_insee character varying(5), -- Code INSEE
  l_nom character varying(254), -- Nom
  l_dateins character(8), -- Date d'instauration
  l_bnfcr character varying(80), -- Bénéficiaire
  l_datdlg character(8), -- Date de délégation
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  geom1 geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_info_surf_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_p_info_surf
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_p_info_surf OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_info_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_p_info_surf TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_info_surf TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_p_info_surf TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_p_info_surf
  IS 'Donnée géographique contenant les informations surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.idinf IS 'Identifiant unique de l''information surfacique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_surf.geom1 IS 'Géométrie de l''objet avec un tampon de -0.5 pour traiter les intersections avec le cadastre';

-- ################################################################################ geo_p_info_lin ##########################################################

-- Table: m_urbanisme_doc_v2024.geo_p_info_lin

-- DROP TABLE m_urbanisme_doc_v2024.geo_p_info_lin;

CREATE TABLE m_urbanisme_doc_v2024.geo_p_info_lin
(
  idinf character varying(40) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.     
  l_insee character varying(5), -- Code INSEE
  l_nom character varying(254), -- Nom
  l_dateins character(8), -- Date d'instauration
  l_bnfcr character varying(80), -- Bénéficiaire
  l_datdlg character(8), -- Date de délégation
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiLineString,2154), -- Géométrie de l'objet
  geom1 geometry(Multipolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_p_info_lin_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_p_info_lin
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_p_info_lin OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_info_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_p_info_lin TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_info_lin TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_p_info_lin TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_p_info_lin
  IS 'Donnée géographique contenant les informations linéaires des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.idinf IS 'Identifiant unique de l''information linéaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_lin.geom1 IS 'Géométrie de l''objet avec un tampon de -0.5 pour traiter les intersections avec le cadastre';

-- ################################################################################ geo_p_info_pct ##########################################################

-- Table: m_urbanisme_doc_v2024.geo_p_info_pct

-- DROP TABLE m_urbanisme_doc_v2024.geo_p_info_pct;

CREATE TABLE m_urbanisme_doc_v2024.geo_p_info_pct
(
  idinf character varying(40) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.   
  l_insee character varying(5), -- Code INSEE
  l_nom character varying(254), -- Nom
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
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_p_info_pct
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_p_info_pct OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_info_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_p_info_pct TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_info_pct TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_p_info_pct TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_p_info_pct
  IS 'Donnée géographique contenant les informations ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.idinf IS 'Identifiant unique de l''information ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_info_pct.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';


-- ######################################################################## geo_p_habillage_surf #######################################################

-- Table: m_urbanisme_doc_v2024.geo_p_habillage_surf

-- DROP TABLE m_urbanisme_doc_v2024.geo_p_habillage_surf;

CREATE TABLE m_urbanisme_doc_v2024.geo_p_habillage_surf
(
  idhab character varying(40) NOT NULL, -- Identifiant unique de l'habillage surfacique
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

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_p_habillage_surf
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_p_habillage_surf OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_surf TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_surf TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_surf TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_surf
  IS 'Donnée géographique contenant l''habillage surfacique des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_surf.idhab IS 'Identifiant unique de l''habillage surfacique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_surf.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_surf.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_surf.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_surf.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_p_habillage_lin #######################################################

-- Table: m_urbanisme_doc_v2024.geo_p_habillage_lin

-- DROP TABLE m_urbanisme_doc_v2024.geo_p_habillage_lin;

CREATE TABLE m_urbanisme_doc_v2024.geo_p_habillage_lin
(
  idhab character varying(40) NOT NULL, -- Identifiant unique de l'habillage surfacique
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

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_p_habillage_lin
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_p_habillage_lin OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_lin TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_lin TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_lin TO sig_edit;
*/


COMMENT ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_lin
  IS 'Donnée géographique contenant l''habillage linéaire des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_lin.idhab IS 'Identifiant unique de l''habillage linéaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_lin.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_lin.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_lin.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_lin.idurba IS 'Identifiant du document d''urbanisme';



-- ######################################################################## geo_p_habillage_pct #######################################################

-- Table: m_urbanisme_doc_v2024.geo_p_habillage_pct

-- DROP TABLE m_urbanisme_doc_v2024.geo_p_habillage_pct;

CREATE TABLE m_urbanisme_doc_v2024.geo_p_habillage_pct
(
  idhab character varying(40) NOT NULL, -- Identifiant unique de l'habillage surfacique
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

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_p_habillage_pct
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_p_habillage_pct OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_pct TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_pct TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_pct TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_pct
  IS 'Donnée géographique contenant l''habillage ponctuel des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_pct.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_pct.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_pct.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_pct.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_p_habillage_txt #######################################################

-- Table: m_urbanisme_doc_v2024.geo_p_habillage_txt

-- DROP TABLE m_urbanisme_doc_v2024.geo_p_habillage_txt;

CREATE TABLE m_urbanisme_doc_v2024.geo_p_habillage_txt
(
  idhab character varying(40) NOT NULL, -- Identifiant unique de l'habillage ponctuel
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
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_p_habillage_txt
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_p_habillage_txt OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_txt TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_txt TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_txt TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_txt TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_p_habillage_txt
  IS 'Donnée géographique contenant l''habillage textuel des documents d''urbanisme locaux (PLUi, PLU, POS) sous la forme de ponctuels';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_txt.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_txt.natecr IS 'Nature de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_txt.txt IS 'Texte de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_txt.police IS 'Police de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_txt.taille IS 'Taille de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_txt.style IS 'Style de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_txt.angle IS 'Angle de l''écriture exprimé en degré, par rapport à l''horizontale, dans le sens trigonométrique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_txt.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_txt.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_txt.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_txt.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_habillage_txt.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';


-- ####################################################################################################################################################
-- ###                                                  	     MODE ARCHIVE                                                                   ###
-- ####################################################################################################################################################


-- ########################################################################### table geo_a_zone_urba #######################################################

-- Table: m_urbanisme_doc_v2024.geo_a_zone_urba

-- DROP TABLE m_urbanisme_doc_v2024.geo_a_zone_urba;

CREATE TABLE m_urbanisme_doc_v2024.geo_a_zone_urba
(
  idzone character varying(40) NOT NULL, -- Identifiant unique de zone
  libelle character varying(12), -- Nom court de la zone
  libelong character varying(254), -- Nom complet de la zone
  typezone character varying(3) NOT NULL, -- Type de la ZONE
  formdomi character varying(4), -- Forme d'aménagements
  destoui character varying(120), -- Destinations et sous-destination autorisées
  destcdt character varying(120), -- Destinations et sous-destination conditionnées
  destnon character varying(120), -- Destinations et sous-destination non autorisées  
  nomfic character varying(80), -- Nom du fichier du règlement complet
  urlfic character varying(254), -- URL ou URI du fichier du règlement complet
  l_nomfic character varying(80), -- Nom du fichier du règlement de la zone
  l_urlfic character varying(254), -- URL ou URI du fichier du règlement de la zone
  idurba character varying(30) NOT NULL, -- identifiant
  datvalid character varying(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.  
  typesect character varying(2) DEFAULT 'ZZ'::character varying, -- Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)
  fermreco character varying(3) NOT NULL DEFAULT 'non', -- Secteur fermé à la reconstruction (uniquement pour la carte communale)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_surf_cal numeric, -- Surface calculée de la zone en ha
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  gid int8 NOT NULL DEFAULT nextval('m_urbanisme_doc_v2024.geo_a_zone_urba_gid_seq'::regclass)  -- Identifiant unique spécifique à l'ARC
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_a_zone_urba
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_a_zone_urba OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_zone_urba TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_a_zone_urba TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_zone_urba TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_a_zone_urba TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_a_zone_urba
  IS '(archive) Donnée géographique contenant les zonages des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.idzone IS 'Identifiant unique de zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.libelle IS 'Nom court de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.libelong IS 'Nom complet de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.typezone IS 'Type de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.typesect IS 'Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.formdomi IS 'Forme d''aménagement dominante souhaitée pour la zone afin de répondre aux besoins de réhabilitation, restructuration ou d''aménagement. Par exemple, une zone de type U peut voir sa
forme urbaine dominante différer suivant qu''elle accueille préférentiellement tel type d''habitat ou d''équipement. Cet attribut est à renseigner en procédant à une analyse du chapitre s’appliquant à la zone, ou des dispositions générales du règlement. Toutes les zones de même libellé (Ex : Uc) ont a priori la même forme urbaine dominante correspondant aux indications portées dans le règlement.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.destoui IS 'Destinations et sous-destination autorisées';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.destcdt IS 'Destinations et sous-destination conditionnées';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.destnon IS 'Destinations et sous-destination non autorisées';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.fermreco IS 'Secteur fermé à la reconstruction (uniquement pour la carte communale)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.l_surf_cal IS 'Surface calculée de la zone en ha';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.nomfic IS 'Nom du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.urlfic IS 'URL ou URI du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.l_nomfic IS 'Nom du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.l_urlfic IS 'URL ou URI du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_zone_urba.idurba IS 'Identifiant du document d''urbanisme';



-- ########################################################################### geo_a_prescription_surf #######################################################

-- Table: m_urbanisme_doc_v2024.geo_a_prescription_surf

-- DROP TABLE m_urbanisme_doc_v2024.geo_a_prescription_surf;

CREATE TABLE m_urbanisme_doc_v2024.geo_a_prescription_surf
(
  idpsc character varying(40) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nature character varying(254), -- Libellé caractérisant un ensemble de prescription de même typepsc  
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.  
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(254), -- Nom
  l_nature character varying(254), -- Nature / vocation
  l_bnfcr character varying(80), -- Bénéficiaire
  l_numero character varying(20), -- Numéro
  l_surf_txt character varying(30), -- Superficie littérale
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  geom1 geometry(MultiPolygon,2154), -- Géométrie de l'objet
  gid int8 NOT NULL DEFAULT nextval('m_urbanisme_doc_v2024.geo_a_prescription_surf_gid_seq'::regclass) -- Identifiant unique spécifique à l'ARC
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_a_prescription_surf
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_a_prescription_surf OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_surf TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_surf TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_surf TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_surf
  IS '(archive) Donnée géographique contenant les prescriptions surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.idpsc IS 'Identifiant unique de prescription surfacique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.nature IS 'Libellé caractérisant un ensemble de prescriptions de même TYPEPSCSTYPEPSC (ex : NATURE = Cones_de_vue)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.geom1 IS 'Géométrie de l''objet -0.5m pour croisement avec parcelle';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_surf.gid IS 'Identifiant unique spécifique à l''ARC';



-- ########################################################################### geo_a_prescription_lin #######################################################

-- Table: m_urbanisme_doc_v2024.geo_a_prescription_lin

-- DROP TABLE m_urbanisme_doc_v2024.geo_a_prescription_lin;

CREATE TABLE m_urbanisme_doc_v2024.geo_a_prescription_lin
(
  idpsc character varying(40) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nature character varying(254), -- Libellé caractérisant un ensemble de prescription de même typepsc  
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.  
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(254), -- Nom
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

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_a_prescription_lin
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_a_prescription_lin OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_lin TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_lin TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_lin TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_lin
  IS '(archive) Donnée géographique contenant les prescriptions linéaires des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.idpsc IS 'Identifiant unique de prescription linéaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.nature IS 'Libellé caractérisant un ensemble de prescriptions de même TYPEPSCSTYPEPSC (ex : NATURE = Cones_de_vue)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_lin.geom IS 'Géométrie de l''objet';


-- ########################################################################### geo_a_prescription_pct #######################################################

-- Table: m_urbanisme_doc_v2024.geo_a_prescription_pct

-- DROP TABLE m_urbanisme_doc_v2024.geo_a_prescription_pct;

CREATE TABLE m_urbanisme_doc_v2024.geo_a_prescription_pct
(
  idpsc character varying(40) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nature character varying(254), -- Libellé caractérisant un ensemble de prescription de même typepsc
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.  
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(254), -- Nom
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

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_a_prescription_pct
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_a_prescription_pct OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_pct TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_pct TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_pct TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_a_prescription_pct
  IS '(archive) Donnée géographique contenant les prescriptions ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.idpsc IS 'Identifiant unique de prescription ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.nature IS 'Libellé caractérisant un ensemble de prescriptions de même TYPEPSCSTYPEPSC (ex : NATURE = Cones_de_vue)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_prescription_pct.geom IS 'Géométrie de l''objet';


-- ################################################################################ geo_a_info_surf ##########################################################

-- Table: m_urbanisme_doc_v2024.geo_a_info_surf

-- DROP TABLE m_urbanisme_doc_v2024.geo_a_info_surf;

CREATE TABLE m_urbanisme_doc_v2024.geo_a_info_surf
(
  idinf character varying(40) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.
  l_insee character varying(5), -- Code INSEE
  l_nom character varying(254), -- Nom
  l_dateins character(8), -- Date d'instauration
  l_bnfcr character varying(80), -- Bénéficiaire
  l_datdlg character(8), -- Date de délégation
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  geom1 geometry(MultiPolygon,2154), -- Géométrie de l'objet
  gid int8 NOT NULL DEFAULT nextval('m_urbanisme_doc_v2024.geo_a_info_surf_gid_seq'::regclass) -- Identifiant unique spécifique à l'ARC
)
WITH (
  OIDS=FALSE
);

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_a_info_surf
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_a_info_surf OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_info_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_a_info_surf TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_info_surf TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_a_info_surf TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_a_info_surf
  IS '(archive) Donnée géographique contenant les informations surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.idinf IS 'Identifiant unique de l''information surfacique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.geom1 IS 'Géométrie de l''objet -0.5m pour croisement avec parcelle';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_surf.gid IS 'Identifiant unique spécifique à l''ARC';

-- ################################################################################ geo_a_info_lin ##########################################################

-- Table: m_urbanisme_doc_v2024.geo_a_info_lin

-- DROP TABLE m_urbanisme_doc_v2024.geo_a_info_lin;

CREATE TABLE m_urbanisme_doc_v2024.geo_a_info_lin
(
  idinf character varying(40) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.
  l_insee character varying(5), -- Code INSEE
  l_nom character varying(254), -- Nom
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

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_a_info_lin
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_a_info_lin OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_info_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_a_info_lin TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_info_lin TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_a_info_lin TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_a_info_lin
  IS '(archive) Donnée géographique contenant les informations linéaires des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.idinf IS 'Identifiant unique de l''information linéaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_lin.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';


-- ################################################################################ geo_a_info_pct ##########################################################

-- Table: m_urbanisme_doc_v2024.geo_a_info_pct

-- DROP TABLE m_urbanisme_doc_v2024.geo_a_info_pct;

CREATE TABLE m_urbanisme_doc_v2024.geo_a_info_pct
(
  idinf character varying(40) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30) NOT NULL, -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.
  l_insee character varying(5), -- Code INSEE
  l_nom character varying(254), -- Nom
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

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_a_info_pct
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_a_info_pct OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_info_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_a_info_pct TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_info_pct TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_a_info_pct TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_a_info_pct
  IS '(archive) Donnée géographique contenant les informations ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.idinf IS 'Identifiant unique de l''information ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_info_pct.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';


-- ######################################################################## geo_a_habillage_surf #######################################################

-- Table: m_urbanisme_doc_v2024.geo_a_habillage_surf

-- DROP TABLE m_urbanisme_doc_v2024.geo_a_habillage_surf;

CREATE TABLE m_urbanisme_doc_v2024.geo_a_habillage_surf
(
  idhab character varying(40) NOT NULL, -- Identifiant unique de l'habillage surfacique
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

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_a_habillage_surf
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_a_habillage_surf OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_surf TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_surf TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_surf TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_surf
  IS '(archive) Donnée géographique contenant l''habillage surfacique des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_surf.idhab IS 'Identifiant unique de l''habillage surfacique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_surf.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_surf.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_surf.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_surf.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_a_habillage_lin #######################################################

-- Table: m_urbanisme_doc_v2024.geo_a_habillage_lin

-- DROP TABLE m_urbanisme_doc_v2024.geo_a_habillage_lin;

CREATE TABLE m_urbanisme_doc_v2024.geo_a_habillage_lin
(
  idhab character varying(40) NOT NULL, -- Identifiant unique de l'habillage surfacique
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

/*
ALTER TABLE m_urbanisme_doc_v2024.geo_a_habillage_lin
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_a_habillage_lin OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_lin TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_lin TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_lin TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_lin
  IS '(archive) Donnée géographique contenant l''habillage linéaire des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_lin.idhab IS 'Identifiant unique de l''habillage linéaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_lin.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_lin.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_lin.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXE (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_lin.idurba IS 'Identifiant du document d''urbanisme';



-- ######################################################################## geo_a_habillage_pct #######################################################

-- Table: m_urbanisme_doc_v2024.geo_a_habillage_pct

-- DROP TABLE m_urbanisme_doc_v2024.geo_a_habillage_pct;

CREATE TABLE m_urbanisme_doc_v2024.geo_a_habillage_pct
(
  idhab character varying(40) NOT NULL, -- Identifiant unique de l'habillage surfacique
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
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_a_habillage_pct
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_a_habillage_pct OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_pct TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_pct TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_pct TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_pct
  IS '(archive) Donnée géographique contenant l''habillage ponctuel des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_pct.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_pct.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_pct.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_pct.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_a_habillage_txt #######################################################

-- Table: m_urbanisme_doc_v2024.geo_a_habillage_txt

-- DROP TABLE m_urbanisme_doc_v2024.geo_a_habillage_txt;

CREATE TABLE m_urbanisme_doc_v2024.geo_a_habillage_txt
(
  idhab character varying(40) NOT NULL, -- Identifiant unique de l'habillage ponctuel
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
  gid int8 NOT NULL DEFAULT nextval('m_urbanisme_doc_v2024.geo_a_habillage_txt_gid_seq'::regclass) -- Identifiant unique pour l'ARC
)
WITH (
  OIDS=FALSE
);
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_a_habillage_txt
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_a_habillage_txt OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_txt TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_txt TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_txt TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_txt TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_a_habillage_txt
  IS '(archive) Donnée géographique contenant l''habillage textuel des documents d''urbanisme locaux (PLUi, PLU, POS) sous la forme de ponctuels';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_txt.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_txt.natecr IS 'Nature de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_txt.txt IS 'Texte de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_txt.police IS 'Police de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_txt.taille IS 'Taille de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_txt.style IS 'Style de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_txt.angle IS 'Angle de l''écriture exprimé en degré, par rapport à l''horizontale, dans le sens trigonométrique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_txt.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_txt.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_txt.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_txt.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_txt.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_habillage_txt.gid IS 'Identifiant unique pour l''ARC';


-- ####################################################################################################################################################
-- ###                                                 	      MODE TEST (pré-production)                                                            ###
-- ####################################################################################################################################################

-- ########################################################################### table geo_t_zone_urba #######################################################

-- Table: m_urbanisme_doc_v2024.geo_t_zone_urba

-- DROP TABLE m_urbanisme_doc_v2024.geo_t_zone_urba;

CREATE TABLE m_urbanisme_doc_v2024.geo_t_zone_urba
(
  idzone character varying(40) NOT NULL, -- Identifiant unique de zone
  libelle character varying(12), -- Nom court de la zone
  libelong character varying(254), -- Nom complet de la zone
  typezone character varying(3) NOT NULL, -- Type de la ZONE
  formdomi character varying(4), -- Forme d'aménagements
  destoui character varying(120), -- Destinations et sous-destination autorisées
  destcdt character varying(120), -- Destinations et sous-destination conditionnées
  destnon character varying(120), -- Destinations et sous-destination non autorisées      
  nomfic character varying(80), -- Nom du fichier du règlement complet
  urlfic character varying(254), -- URL ou URI du fichier du règlement complet
  l_nomfic character varying(80), -- Nom du fichier du règlement de la zone
  l_urlfic character varying(254), -- URL ou URI du fichier du règlement de la zone
  idurba character varying(30), -- identifiant
  datvalid character varying(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.  
  typesect character varying(2) DEFAULT 'ZZ'::character varying, -- Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)
  fermreco character varying(3) NOT NULL DEFAULT 'non', -- Secteur fermé à la reconstruction (uniquement pour la carte communale)
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_surf_cal numeric NOT NULL, -- Surface calculée de la zone en ha
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_zone_urba_pkey PRIMARY KEY (idzone)
)
WITH (
  OIDS=FALSE
);
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_t_zone_urba
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_t_zone_urba OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_zone_urba TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_t_zone_urba TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_zone_urba TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_t_zone_urba TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_t_zone_urba
  IS '(test) Donnée géographique contenant les zonages des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.idzone IS 'Identifiant unique de zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.libelle IS 'Nom court de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.libelong IS 'Nom complet de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.typezone IS 'Type de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.formdomi IS 'Forme d''aménagement dominante souhaitée pour la zone afin de répondre aux besoins de réhabilitation, restructuration ou d''aménagement. Par exemple, une zone de type U peut voir sa
forme urbaine dominante différer suivant qu''elle accueille préférentiellement tel type d''habitat ou d''équipement. Cet attribut est à renseigner en procédant à une analyse du chapitre s’appliquant à la zone, ou des dispositions générales du règlement. Toutes les zones de même libellé (Ex : Uc) ont a priori la même forme urbaine dominante correspondant aux indications portées dans le règlement.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.destoui IS 'Destinations et sous-destinations autorisées, conditionnées, interdites dans une zone en application des articles R151-27 et R151-28 du code de l’urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.destcdt IS 'Destinations et sous-destination conditionnées';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.destnon IS 'Destinations et sous-destination non autorisées';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.typesect IS 'Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.fermreco IS 'Secteur fermé à la reconstruction (uniquement pour la carte communale)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.l_surf_cal IS 'Surface calculée de la zone en ha';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.nomfic IS 'Nom du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.urlfic IS 'URL ou URI du fichier du règlement complet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.l_nomfic IS 'Nom du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.l_urlfic IS 'URL ou URI du fichier du règlement de la zone';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_zone_urba.idurba IS 'Identifiant du document d''urbanisme';


-- ########################################################################### geo_t_prescription_surf #######################################################

-- Table: m_urbanisme_doc_v2024.geo_t_prescription_surf

-- DROP TABLE m_urbanisme_doc_v2024.geo_t_prescription_surf;

CREATE TABLE m_urbanisme_doc_v2024.geo_t_prescription_surf
(
  idpsc character varying(40) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nature character varying(254), -- Libellé caractérisant un ensemble de prescription de même typepsc  
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30), -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(254), -- Nom
  l_nature character varying(254), -- Nature / vocation
  l_bnfcr character varying(80), -- Bénéficiaire
  l_numero character varying(20), -- Numéro
  l_surf_txt character varying(30), -- Superficie littérale
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  geom1 geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_prescription_surf_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_t_prescription_surf
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_t_prescription_surf OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_surf TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_surf TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_surf TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_surf
  IS '(test) Donnée géographique contenant les prescriptions surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.idpsc IS 'Identifiant unique de prescription surfacique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.nature IS 'Libellé caractérisant un ensemble de prescriptions de même TYPEPSCSTYPEPSC (ex : NATURE = Cones_de_vue)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_surf.geom1 IS 'Géométrie de l''objet avec un tampon de -0.5 pour traiter les intersections avec le cadastre (temporaire)';

-- ########################################################################### geo_t_prescription_lin #######################################################

-- Table: m_urbanisme_doc_v2024.geo_t_prescription_lin

-- DROP TABLE m_urbanisme_doc_v2024.geo_t_prescription_lin;

CREATE TABLE m_urbanisme_doc_v2024.geo_t_prescription_lin
(
  idpsc character varying(40) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nature character varying(254), -- Libellé caractérisant un ensemble de prescription de même typepsc
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30), -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.  
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(254), -- Nom
  l_nature character varying(254), -- Nature / vocation
  l_bnfcr character varying(80), -- Bénéficiaire
  l_numero character varying(10), -- Numéro
  l_surf_txt character varying(30), -- Superficie littérale
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(Multilinestring,2154), -- Géométrie de l'objet
  geom1 geometry(Multipolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_prescription_lin_pkey PRIMARY KEY (idpsc)
)
WITH (
  OIDS=FALSE
);
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_t_prescription_lin
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_t_prescription_lin OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_lin TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_lin TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_lin TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_lin
  IS '(test) Donnée géographique contenant les prescriptions linéaires des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.idpsc IS 'Identifiant unique de prescription linéaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.nature IS 'Libellé caractérisant un ensemble de prescriptions de même TYPEPSCSTYPEPSC (ex : NATURE = Cones_de_vue)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_lin.geom1 IS 'Géométrie de l''objet avec un tampon de -0.5 pour traiter les intersections avec le cadastre (temporaire)';


-- ########################################################################### geo_t_prescription_pct #######################################################

-- Table: m_urbanisme_doc_v2024.geo_t_prescription_pct

-- DROP TABLE m_urbanisme_doc_v2024.geo_t_prescription_pct;

CREATE TABLE m_urbanisme_doc_v2024.geo_t_prescription_pct
(
  idpsc character varying(40) NOT NULL, -- Identifiant unique de prescription surfacique
  libelle character varying(254) NOT NULL, -- Nom de la prescription
  txt character varying(10), -- Texte étiquette
  typepsc character varying(2) NOT NULL, -- Type de la prescription
  stypepsc character varying(2) NOT NULL, -- Sous-Type de la prescription
  nature character varying(254), -- Libellé caractérisant un ensemble de prescription de même typepsc
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30), -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.
  l_insee character varying(5) NOT NULL, -- Code INSEE
  l_nom character varying(254), -- Nom
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
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_t_prescription_pct
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_t_prescription_pct OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_pct TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_pct TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_pct TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_t_prescription_pct
  IS '(test) Donnée géographique contenant les prescriptions ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS, CC)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.idpsc IS 'Identifiant unique de prescription ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.libelle IS 'Nom de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.typepsc IS 'Type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.stypepsc IS 'Sous type de la prescription';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.nature IS 'Libellé caractérisant un ensemble de prescriptions de même TYPEPSCSTYPEPSC (ex : NATURE = Cones_de_vue)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.l_nature IS 'Nature / vocation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.l_numero IS 'Numéro';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.l_surf_txt IS 'Superficie littérale';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_prescription_pct.geom IS 'Géométrie de l''objet';


-- ################################################################################ geo_t_info_surf ##########################################################

-- Table: m_urbanisme_doc_v2024.geo_t_info_surf

-- DROP TABLE m_urbanisme_doc_v2024.geo_t_info_surf;

CREATE TABLE m_urbanisme_doc_v2024.geo_t_info_surf
(
  idinf character varying(40) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nature character varying(254), -- Libellé caractérisant un ensemble de prescription de même typepsc
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30), -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.  
  l_insee character varying(5), -- Code INSEE
  l_nom character varying(254), -- Nom
  l_dateins character(8), -- Date d'instauration
  l_bnfcr character varying(80), -- Bénéficiaire
  l_datdlg character(8), -- Date de délégation
  l_gen character varying(80), -- Générateur du recul
  l_valrecul character varying(80), -- Valeur de recul
  l_typrecul character varying(80), -- Type de recul
  l_observ character varying(254), -- Observations
  geom geometry(MultiPolygon,2154), -- Géométrie de l'objet
  geom1 geometry(MultiPolygon,2154), -- Géométrie de l'objet
  CONSTRAINT geo_t_info_surf_pkey PRIMARY KEY (idinf)
)
WITH (
  OIDS=FALSE
);
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_t_info_surf
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_t_info_surf OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_info_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_t_info_surf TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_info_surf TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_t_info_surf TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_t_info_surf
  IS 'test) Donnée géographique contenant les informations surfaciques des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.idinf IS 'Identifiant unique de l''information surfacique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.nature IS 'Libellé caractérisant un ensemble de prescriptions de même TYPEPSCSTYPEPSC (ex : NATURE = Cones_de_vue)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.geom1 IS 'Géométrie de l''objet avec un tampon de -0.5 pour traiter les intersections avec le cadastre (temporaire)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_surf.idurba IS 'Identifiant du document d''urbanisme';

-- ################################################################################ geo_t_info_lin ##########################################################

-- Table: m_urbanisme_doc_v2024.geo_t_info_lin

-- DROP TABLE m_urbanisme_doc_v2024.geo_t_info_lin;

CREATE TABLE m_urbanisme_doc_v2024.geo_t_info_lin
(
  idinf character varying(40) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nature character varying(254), -- Libellé caractérisant un ensemble de prescription de même typepsc
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30), -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.
  l_insee character varying(5), -- Code INSEE
  l_nom character varying(254), -- Nom
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
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_t_info_lin
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_t_info_lin OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_info_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_t_info_lin TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_info_lin TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_t_info_lin TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_t_info_lin
  IS '(test) Donnée géographique contenant les informations linéaires des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.idinf IS 'Identifiant unique de l''information linéaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.nature IS 'Libellé caractérisant un ensemble de prescriptions de même TYPEPSCSTYPEPSC (ex : NATURE = Cones_de_vue)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_lin.idurba IS 'Identifiant du document d''urbanisme';


-- ################################################################################ geo_t_info_pct ##########################################################

-- Table: m_urbanisme_doc_v2024.geo_t_info_pct

-- DROP TABLE m_urbanisme_doc_v2024.geo_t_info_pct;

CREATE TABLE m_urbanisme_doc_v2024.geo_t_info_pct
(
  idinf character varying(40) NOT NULL, -- Identifiant unique de l'information surfacique
  libelle character varying(254) NOT NULL, -- Nom de l'information
  txt character varying(10), -- Texte étiquette
  typeinf character varying(2) NOT NULL, -- Type d'information
  stypeinf character varying(2) NOT NULL, -- Sous type d'information
  nature character varying(254), -- Libellé caractérisant un ensemble de prescription de même typepsc
  nomfic character varying(80), -- Nom du fichier
  urlfic character varying(254), -- URL ou URI du fichier
  idurba character varying(30), -- Identifiant du document d''urbanisme
  datvalid character(8), -- Date de validation (aaaammjj)
  symbole character varying(20), -- Symbolisation alternative, le cas échéant.
  l_insee character varying(5), -- Code INSEE
  l_nom character varying(254), -- Nom
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
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_t_info_pct
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_t_info_pct OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_info_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_t_info_pct TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_info_pct TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_t_info_pct TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_t_info_pct
  IS '(test) Donnée géographique contenant les informations ponctuelles des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.idinf IS 'Identifiant unique de l''information ponctuelle';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.libelle IS 'Nom de l''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.txt IS 'Texte étiquette';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.typeinf IS 'Type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.stypeinf IS 'Sous type d''information';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.nature IS 'Libellé caractérisant un ensemble de prescriptions de même TYPEPSCSTYPEPSC (ex : NATURE = Cones_de_vue)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.l_nom IS 'Nom';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.l_dateins IS 'Date d''instauration';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.l_bnfcr IS 'Bénéficiaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.l_datdlg IS 'Date de délégation';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.l_gen IS 'Générateur du recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.l_valrecul IS 'Valeur de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.l_typrecul IS 'Type de recul';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.l_observ IS 'Observations';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.nomfic IS 'Nom du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.urlfic IS 'URL ou URI du fichier';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.datvalid IS 'Date de validation (aaaammjj)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.symbole IS 'Symbolisation alternative, le cas échéant. Elle fait référence au registre des symboles.';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_info_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_t_habillage_surf #######################################################

-- Table: m_urbanisme_doc_v2024.geo_t_habillage_surf

-- DROP TABLE m_urbanisme_doc_v2024.geo_t_habillage_surf;

CREATE TABLE m_urbanisme_doc_v2024.geo_t_habillage_surf
(
  idhab character varying(40) NOT NULL, -- Identifiant unique de l'habillage surfacique
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
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_t_habillage_surf
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_t_habillage_surf OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_surf TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_surf TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_surf TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_surf TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_surf
  IS '(test) Donnée géographique contenant l''habillage surfacique des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_surf.idhab IS 'Identifiant unique de l''habillage surfacique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_surf.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_surf.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_surf.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_surf.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_surf.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_surf.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_t_habillage_lin #######################################################

-- Table: m_urbanisme_doc_v2024.geo_t_habillage_lin

-- DROP TABLE m_urbanisme_doc_v2024.geo_t_habillage_lin;

CREATE TABLE m_urbanisme_doc_v2024.geo_t_habillage_lin
(
  idhab character varying(40) NOT NULL, -- Identifiant unique de l'habillage surfacique
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
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_t_habillage_lin
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_t_habillage_lin OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_lin TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_lin TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_lin TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_lin TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_lin
  IS '(test) Donnée géographique contenant l''habillage linéaire des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_lin.idhab IS 'Identifiant unique de l''habillage linéaire';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_lin.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_lin.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_lin.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_lin.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_lin.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_lin.idurba IS 'Identifiant du document d''urbanisme';



-- ######################################################################## geo_t_habillage_pct #######################################################

-- Table: m_urbanisme_doc_v2024.geo_t_habillage_pct

-- DROP TABLE m_urbanisme_doc_v2024.geo_t_habillage_pct;

CREATE TABLE m_urbanisme_doc_v2024.geo_t_habillage_pct
(
  idhab character varying(40) NOT NULL, -- Identifiant unique de l'habillage surfacique
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
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_t_habillage_pct
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_t_habillage_pct OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_pct TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_pct TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_pct TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_pct TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_pct
  IS '(test) Donnée géographique contenant l''habillage ponctuel des documents d''urbanisme locaux (PLUi, PLU, POS)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_pct.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_pct.nattrac IS 'Nature du tracé';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_pct.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_pct.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_pct.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_pct.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_pct.idurba IS 'Identifiant du document d''urbanisme';


-- ######################################################################## geo_t_habillage_txt #######################################################

-- Table: m_urbanisme_doc_v2024.geo_t_habillage_txt

-- DROP TABLE m_urbanisme_doc_v2024.geo_t_habillage_txt;

CREATE TABLE m_urbanisme_doc_v2024.geo_t_habillage_txt
(
  idhab character varying(40) NOT NULL, -- Identifiant unique de l'habillage ponctuel
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
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_t_habillage_txt
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.geo_t_habillage_txt OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_txt TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_txt TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_txt TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_txt TO sig_edit;
*/

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_t_habillage_txt
  IS '(test) Donnée géographique contenant l''habillage textuel des documents d''urbanisme locaux (PLUi, PLU, POS) sous la forme de ponctuels';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_txt.idhab IS 'Identifiant unique de l''habillage ponctuel';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_txt.natecr IS 'Nature de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_txt.txt IS 'Texte de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_txt.police IS 'Police de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_txt.taille IS 'Taille de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_txt.style IS 'Style de l''écriture';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_txt.angle IS 'Angle de l''écriture exprimé en degré, par rapport à l''horizontale, dans le sens trigonométrique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_txt.l_insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_txt.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_txt.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_txt.couleur IS 'Couleur de l''élément graphique, sous forme RVB (255-255-000)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_habillage_txt.l_couleur IS 'Couleur de l''élément graphique, sous forme HEXA (#000000)';


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                       TABLES METIERS DOCUMENTS D'URBANISME (hors standard CNIG spécifique ARC)                               ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################
/*
-- ######################################################################## an_ads_commune #######################################################

-- Table: m_urbanisme_doc_v2024.an_ads_commune

-- DROP TABLE m_urbanisme_doc_v2024.an_ads_commune;

CREATE TABLE m_urbanisme_doc_v2024.an_ads_commune
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
ALTER TABLE m_urbanisme_doc_v2024.an_ads_commune
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.an_ads_commune OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_ads_commune TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_ads_commune TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_ads_commune TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.an_ads_commune TO sig_edit;

COMMENT ON TABLE m_urbanisme_doc_v2024.an_ads_commune
  IS 'Donnée source sur l''état de l''ADS ARC sur les communes';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_ads_commune.insee IS 'Code INSEE';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_ads_commune.docurba IS 'Présence d''un document d''urbanisme (PLUi,PLU,POS,CC)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_ads_commune.ads_arc IS 'Gestion de l''ADS par l''ARC';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_ads_commune.l_rev IS 'Information sur la révision en cours ou non du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_ads_commune.l_daterev IS 'Date de prescripiton de la révision';


-- ######################################################################## geo_p_planche_pluiarc #######################################################

-- m_urbanisme_doc_v2024.geo_p_planche_pluiarc definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.geo_p_planche_pluiarc;

CREATE TABLE m_urbanisme_doc_v2024.geo_p_planche_pluiarc (
	id_maille int4 NOT NULL,
	orient int2 NULL,
	format varchar(8) NULL,
	ft_planche varchar(2) NULL,
	lieudit varchar(254) NULL,
	insee varchar(5) NULL,
	echelle varchar(8) NULL,
	id_planche varchar(8) NULL,
	geom geometry(multipolygon, 2154) NULL,
	id int2 NULL,
	CONSTRAINT geo_p_planche_pluiarc_pkey PRIMARY KEY (id_maille)
);
CREATE INDEX geo_p_planche_pluiarc_geom_idx ON m_urbanisme_doc_v2024.geo_p_planche_pluiarc USING gist (geom);
COMMENT ON TABLE m_urbanisme_doc_v2024.geo_p_planche_pluiarc IS 'Découpage en planche numérotée par commune pour le règlement graphique du PLUiH de l''ARC arrêté le 7 février 2019';

COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_planche_pluiarc.id_maille IS 'Identifiant de la maille';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_planche_pluiarc.orient IS 'Orientation en degré';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_planche_pluiarc.format IS 'Orientation portrait/paysage';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_planche_pluiarc.ft_planche IS 'Format de la page (A, ...)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_planche_pluiarc.lieudit IS 'Commune ou lieu';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_planche_pluiarc.insee IS 'Code insee de la commune';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_planche_pluiarc.echelle IS 'Echelle du plan';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_planche_pluiarc.id_planche IS 'N° de la planche';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_planche_pluiarc.geom IS 'Géométrie de l''objet';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_planche_pluiarc.id IS 'identifiant non unique';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_p_planche_pluiarc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_planche_pluiarc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_p_planche_pluiarc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_planche_pluiarc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_p_planche_pluiarc TO sig_edit;

-- ######################################################################## geo_p_zone_pau #######################################################

-- Sequence: m_urbanisme_doc_v2024.idpau_seq

-- DROP SEQUENCE m_urbanisme_doc_v2024.idpau_seq;

CREATE SEQUENCE m_urbanisme_doc_v2024.idpau_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 99999999999999999
  START 1
  CACHE 1;
ALTER TABLE m_urbanisme_doc_v2024.idpau_seq
  OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_v2024.idpau_seq TO postgres;
GRANT USAGE ON SEQUENCE m_urbanisme_doc_v2024.idpau_seq TO create_sig;

ALTER SEQUENCE m_urbanisme_doc_v2024.idpau_seq RESTART WITH 168;

-- Table: m_urbanisme_doc_v2024.geo_p_zone_pau

-- DROP TABLE m_urbanisme_doc_v2024.geo_p_zone_pau;

CREATE TABLE m_urbanisme_doc_v2024.geo_p_zone_pau
(
  idpau integer NOT NULL DEFAULT nextval('m_urbanisme_doc_v2024.idpau_seq'::regclass), -- Identifiant géographique
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
ALTER TABLE m_urbanisme_doc_v2024.an_ads_commune
  OWNER TO create_sig;
ALTER TABLE m_urbanisme_doc_v2024.an_ads_commune OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_ads_commune TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_ads_commune TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_ads_commune TO sig_create;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_urbanisme_doc_v2024.an_ads_commune TO sig_edit;

COMMENT ON TABLE m_urbanisme_doc_v2024.geo_p_zone_pau
  IS 'Table géométriquer contenant la délimitation des PAU (partie à urbaniser) dans le cadre d''une commune en RNU';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_pau.idpau IS 'Identifiant géographique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_pau.date_sai IS 'Date de saisie des données';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_pau.date_maj IS 'Date de mise à jour';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_pau.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_pau.org_sai IS 'Organisme de saisie';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_pau.insee IS 'Code Insee de la commune';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_pau.commune IS 'Libellé de la commune';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_pau.src_geom IS 'Référentiel spatila utilisé pour la saisie';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_pau.sup_m2 IS 'Surface brute de l''objet en m²';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_pau.l_type IS 'Type de bâti intégré à la PAU';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_pau.l_statut IS 'Prise en compte de la PAU (oui : en RNU, non : documents d''urbaniusme en vigieur)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_zone_pau.geom IS 'Champ contenant la géométrie des objets';

-- Index: m_urbanisme_doc_v2024.geo_p_zone_pau_geom_idx

-- DROP INDEX m_urbanisme_doc_v2024.geo_p_zone_pau_geom_idx;

CREATE INDEX geo_p_zone_pau_geom_idx
  ON m_urbanisme_doc_v2024.geo_p_zone_pau
  USING gist
  (geom);


-- Trigger: t_t1_pau_inseecommune on m_urbanisme_doc_v2024.geo_p_zone_pau

-- DROP TRIGGER t_t1_pau_inseecommune ON m_urbanisme_doc.geo_p_zone_pau;

CREATE TRIGGER t_t1_pau_inseecommune
  BEFORE INSERT
  ON m_urbanisme_doc_v2024.geo_p_zone_pau
  FOR EACH ROW
  EXECUTE PROCEDURE public.ft_r_commune_s();

-- Trigger: t_t2_pau_insert_date_sai on m_urbanisme_doc_v2024.geo_p_zone_pau

-- DROP TRIGGER t_t2_pau_insert_date_sai ON m_urbanisme_doc_v2024.geo_p_zone_pau;

CREATE TRIGGER t_t2_pau_insert_date_sai
  BEFORE INSERT
  ON m_urbanisme_doc_v2024.geo_p_zone_pau
  FOR EACH ROW
  EXECUTE PROCEDURE public.ft_r_timestamp_sai();

-- Trigger: t_t3_pau_update_date_maj on m_urbanisme_doc_v2024.geo_p_zone_pau

-- DROP TRIGGER t_t3_pau_update_date_maj ON m_urbanisme_doc_v2024.geo_p_zone_pau;

CREATE TRIGGER t_t3_pau_update_date_maj
  BEFORE UPDATE
  ON m_urbanisme_doc_v2024.geo_p_zone_pau
  FOR EACH ROW
  EXECUTE PROCEDURE public.ft_r_timestamp_maj();

-- Trigger: t_t4_pau_surface on m_urbanisme_doc_v2024.geo_p_zone_pau

-- DROP TRIGGER t_t4_pau_surface ON m_urbanisme_doc_v2024.geo_p_zone_pau;

CREATE TRIGGER t_t4_pau_surface
  BEFORE INSERT OR UPDATE
  ON m_urbanisme_doc_v2024.geo_p_zone_pau
  FOR EACH ROW
  EXECUTE PROCEDURE public.ft_r_sup_m2_maj();

 -- ######################################################################## geo_pluih_limite_communale_l #######################################################
 
 -- m_urbanisme_doc_v2024.geo_pluih_limite_communale_l definition

-- Drop table

-- DROP TABLE m_urbam_urbanisme_doc_v2024nisme_doc.geo_pluih_limite_communale_l;

CREATE TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_l (
	gid int4 NOT NULL,
	"source" varchar(100) NULL,
	geom geometry(linestring, 2154) NULL,
	CONSTRAINT geo_pluih_limite_communale_l_pkey PRIMARY KEY (gid)
);
CREATE INDEX geo_pluih_limite_communale_l_geom_idx ON m_urbanisme_doc_v2024.geo_pluih_limite_communale_l USING gist (geom);
COMMENT ON TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_l IS 'Limite communale (objet linéaire) réalisée dans le cadre du PLUih spécifiquement pour gérer les chevauchements entre commune et cadastre.
Issu de l''aggrégation des zonages corrigés pour créer les polygones puis transformation pour créer des lignes (cf traitement ici (à refaire))';

COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_pluih_limite_communale_l.gid IS 'Identifiant unique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_pluih_limite_communale_l."source" IS 'Source de la limite communale';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_pluih_limite_communale_l.geom IS 'Géométrie de l''objet';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_l OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_l TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_l TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_l TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_l TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_l TO sig_edit;

-- ######################################################################## geo_pluih_limite_communale_p #######################################################

-- m_urbanisme_doc_v2024.geo_pluih_limite_communale_p definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_p;

CREATE TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_p (
	gid int4 NOT NULL,
	insee varchar(5) NULL,
	commune varchar(80) NULL,
	geom geometry(multipolygon, 2154) NULL,
	CONSTRAINT geo_pluih_limite_communale_pkey PRIMARY KEY (gid)
);
CREATE INDEX geo_pluih_limite_communale_p_geom_idx ON m_urbanisme_doc_v2024.geo_pluih_limite_communale_p USING gist (geom);
COMMENT ON TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_p IS 'Limite communale (objet polygone) réalisée dans le cadre du PLUih spécifiquement pour gérer les chevauchements entre commune et cadastre.
Issu de l''aggrégation des zonages corrigés.';

COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_pluih_limite_communale_p.gid IS 'Identifiant unique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_pluih_limite_communale_p.insee IS 'Code insee de la commune';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_pluih_limite_communale_p.commune IS 'Libellé de la commune';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_pluih_limite_communale_p.geom IS 'Géométrie de l''objet';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_p OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_p TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_p TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_p TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_p TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_pluih_limite_communale_p TO sig_edit;



-- ######################################################################## an_doc_urba_com_plan #######################################################

-- m_urbanisme_doc_v2024.an_doc_urba_com_plan_seq definition

-- DROP SEQUENCE m_urbanisme_doc_v2024.an_doc_urba_com_plan_seq;

CREATE SEQUENCE m_urbanisme_doc_v2024.an_doc_urba_com_plan_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE m_urbanisme_doc_v2024.an_doc_urba_com_plan_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_v2024.an_doc_urba_com_plan_seq TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_v2024.an_doc_urba_com_plan_seq TO public;

ALTER SEQUENCE m_urbanisme_doc_v2024.an_doc_urba_com_plan_seq RESTART WITH 116;

-- m_urbanisme_doc_v2024.an_doc_urba_com_plan definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.an_doc_urba_com_plan;

CREATE TABLE m_urbanisme_doc_v2024.an_doc_urba_com_plan (
	gid int4 DEFAULT nextval('m_urbanisme_doc_v2024.an_doc_urba_com_plan_seq'::regclass) NOT NULL,
	idurba varchar(30) NOT NULL, -- Identifiant du document d'urbanisme
	insee varchar(5) NOT NULL, -- Code insee de la commune
	numplan varchar(50) NULL, -- Numéro du plan
	echelleplan varchar(50) NULL, -- Echelle du plan
	urlfic varchar(254) NULL, -- Lien URL vers le plan
	CONSTRAINT an_doc_urba_com_plan_pkey PRIMARY KEY (gid)
);
COMMENT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_com_plan IS 'Donnée alphanumerique d''appartenance des plans du règlement graphique à une procédure définie (approuvée) pour une commune hors du PLUiH de l''ARC';

-- Column comments

COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_com_plan.idurba IS 'Identifiant du document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_com_plan.insee IS 'Code insee de la commune';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_com_plan.numplan IS 'Numéro du plan';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_com_plan.echelleplan IS 'Echelle du plan';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_com_plan.urlfic IS 'Lien URL vers le plan';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.an_doc_urba_com_plan OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_doc_urba_com_plan TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_doc_urba_com_plan TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_com_plan TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_com_plan TO sig_edit;

-- ######################################################################## an_doc_urba_psc_commune #######################################################

-- m_urbanisme_doc_v2024.an_doc_urba_psc_commune definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.an_doc_urba_psc_commune;

CREATE TABLE m_urbanisme_doc_v2024.an_doc_urba_psc_commune (
	idu varchar(200) NULL, -- Identifiant de la parcelle
	ligne_aff varchar(2500) NULL, -- Liste des prescriptions
	gid int4 NOT NULL, -- Identifiant interne unique
	l_psc varchar(50) NULL, -- Liste des codes de prescriptions ou 'Aucune'
	CONSTRAINT an_doc_urba_psc_commune_pkey PRIMARY KEY (gid)
);
CREATE INDEX idx_an_doc_urba_psc_commune_id ON m_urbanisme_doc_v2024.an_doc_urba_psc_commune USING btree (idu);
COMMENT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_psc_commune IS 'Table alphanumérique listant pour chaque parcelle, la liste des prescriptions linéaires et surfaciques dessiner dans l''espace public sur le règlement graphique et pouvant avoir un impact fonctionnel sur les parcelles. Cette liste est à la commune pour chaque parcelle sur le même principe que les SUP non localisées. Traitement FME R:\Ressources\4-Partage\3-Procedures\FME\prod\URB\PLU\bloc\07_PLU_generer_table_idu_psc_GEO.fmw (intégration du fichier Excel présent ici R:\Ressources\3-Donnees\1-Metiers\URB-SUP\psc_par_commune_non_fonctionnel.xlsx).
Traitement intégré à la chaine de production finale du document d''urbanisme';

-- Column comments

COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_psc_commune.idu IS 'Identifiant de la parcelle';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_psc_commune.ligne_aff IS 'Liste des prescriptions';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_psc_commune.gid IS 'Identifiant interne unique';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_psc_commune.l_psc IS 'Liste des codes de prescriptions ou ''Aucune''';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.an_doc_urba_psc_commune OWNER TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_doc_urba_psc_commune TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_psc_commune TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_doc_urba_psc_commune TO create_sig;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_psc_commune TO sig_edit;


-- ######################################################################## an_doc_urba_titre_pieces_ecrites #######################################################

-- m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites_seq definition

-- DROP SEQUENCE m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites_seq;

CREATE SEQUENCE m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites_seq OWNER TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites_seq TO create_sig;
GRANT ALL ON SEQUENCE m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites_seq TO public;

ALTER SEQUENCE m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites_seq RESTART WITH 32;

-- m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites;

CREATE TABLE m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites (
	gid int4 DEFAULT nextval('m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites_seq'::regclass) NOT NULL, -- Identifiant unique interne
	idurba varchar(30) NOT NULL, -- Identifiant de la procédure d'urbanisme
	code_geo varchar(9) NOT NULL, -- Code Insee ou siren de l'autorité compétente ou s'applique le document d'urbanisme
	rep_cnig varchar(1) NOT NULL, -- Code du répertoire CNIG de stockage des fichiers (clé étrangère sur lt_typerep_cnig)
	nomfic varchar(80) NOT NULL, -- Libellé du fichier avec l'extension .pdf
	titre varchar(2) NOT NULL, -- Code du libellé générique de la pièce écrite (clé étrangère sur lt_titre_cnig)
	complt varchar(80) NULL, -- Compléments d'information permettant d'identifier plus précisément la pièce écrites (si plusieurs pièces de type identique). Cette information sera affichée à l'utilisateur dans le fonctionnel GEO de la fiche de RU ou dans la recherche métier
	CONSTRAINT an_doc_urba_titre_pieces_ecrites_pkey PRIMARY KEY (gid),
	CONSTRAINT an_doc_urba_titre_pieces_ecrites_titre_fkey FOREIGN KEY (titre) REFERENCES m_urbanisme_doc_v2024.lt_titre_cnig(code),
	CONSTRAINT an_doc_urba_titre_pieces_ecrites_typ_fkey FOREIGN KEY (rep_cnig) REFERENCES m_urbanisme_doc_v2024.lt_typerep_cnig(code)
);
CREATE INDEX idx_an_doc_urba_titre_pieces_e ON m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites USING btree (idurba);
COMMENT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites IS 'Liste des pièces écrites des procédures d''urbanisme pour export CNIG et fonctionnel GEO d''accès aux documents (test en cours)';

-- Column comments

COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites.gid IS 'Identifiant unique interne';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites.idurba IS 'Identifiant de la procédure d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites.code_geo IS 'Code Insee ou siren de l''autorité compétente ou s''applique le document d''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites.rep_cnig IS 'Code du répertoire CNIG de stockage des fichiers (clé étrangère sur lt_typerep_cnig)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites.nomfic IS 'Libellé du fichier avec l''extension .pdf';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites.titre IS 'Code du libellé générique de la pièce écrite (clé étrangère sur lt_titre_cnig)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites.complt IS 'Compléments d''information permettant d''identifier plus précisément la pièce écrites (si plusieurs pièces de type identique). Cette information sera affichée à l''utilisateur dans le fonctionnel GEO de la fiche de RU ou dans la recherche métier';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_titre_pieces_ecrites TO sig_edit;


-- ######################################################################## an_doc_urba_tpe #######################################################


-- m_urbanisme_doc_v2024.an_doc_urba_tpe definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.an_doc_urba_tpe;

CREATE TABLE m_urbanisme_doc_v2024.an_doc_urba_tpe (
	idtpe varchar(40) NOT NULL, -- Identifiant unique de la pièce écrite
	idurba varchar(30) NOT NULL, -- Identifiant du document d''urbanisme
	fichier varchar(80) NULL, -- nom du fichier technique de la pièce écrite (avec l'extension)
	titre varchar(80) NULL, -- nom usuel ou titre du fichier technique de la pièce écrite
	CONSTRAINT an_doc_urba_tpe_pkey PRIMARY KEY (idtpe)
);
COMMENT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_tpe IS 'Table alphanumérique gérant la correspondance entre le nom des fichiers techniques et le nom usuel des pièces écrites (test en cours)';

-- Column comments

COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_tpe.idtpe IS 'Identifiant unique de la pièce écrite';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_tpe.idurba IS 'Identifiant du document d''''urbanisme';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_tpe.fichier IS 'nom du fichier technique de la pièce écrite (avec l''extension)';
COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_tpe.titre IS 'nom usuel ou titre du fichier technique de la pièce écrite';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.an_doc_urba_tpe OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_doc_urba_tpe TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_doc_urba_tpe TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_tpe TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_tpe TO sig_edit;

-- ######################################################################## old_geo_p_maillage_pluiarc #######################################################

-- m_urbanisme_doc_v2024.old_geo_p_maillage_pluiarc definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.old_geo_p_maillage_pluiarc;

CREATE TABLE m_urbanisme_doc_v2024.old_geo_p_maillage_pluiarc (
	id_maille int4 NOT NULL,
	angle int2 NULL,
	format varchar(10) NULL,
	echelle varchar(7) NULL,
	insee varchar(30) NULL,
	commune varchar(80) NULL,
	nomplan varchar(254) NULL,
	urlplan varchar(254) NULL,
	description varchar(254) NULL,
	geom geometry(polygon, 2154) NULL,
	CONSTRAINT geo_p_maillage_pluiarc_pkey PRIMARY KEY (id_maille)
);
CREATE INDEX m_urbanisme_doc_v2024 ON m_urbanisme_doc_v2024.old_geo_p_maillage_pluiarc USING gist (geom);
COMMENT ON TABLE m_urbanisme_doc_v2024.old_geo_p_maillage_pluiarc IS 'Table géographique contenant le maillage des plans de zonage du PLUI de l''ARC';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.old_geo_p_maillage_pluiarc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.old_geo_p_maillage_pluiarc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.old_geo_p_maillage_pluiarc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.old_geo_p_maillage_pluiarc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.old_geo_p_maillage_pluiarc TO sig_edit;


*/

-- ####################################################################################################################################################
-- ###                                                TABLES METIERS DOCUMENTS D'URBANISME (SCOT)                                                   ###
-- ####################################################################################################################################################


-- ######################################################################## geo_p_perimetre_scot #######################################################

-- m_urbanisme_doc_v2024.geo_p_perimetre_scot definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.geo_p_perimetre_scot;

CREATE TABLE m_urbanisme_doc_v2024.geo_p_perimetre_scot (
	idurba varchar(30) NOT NULL, -- Identifiant unique du SCOT
	geom geometry(multipolygon, 2154) NULL, -- Géométrie de l'objet
	CONSTRAINT geo_p_perimetre_scot_pkey PRIMARY KEY (idurba)
);
CREATE INDEX geo_p_perimetre_scot_geom_idx ON m_urbanisme_doc_v2024.geo_p_perimetre_scot USING gist (geom);
COMMENT ON TABLE m_urbanisme_doc_v2024.geo_p_perimetre_scot IS 'Donnée géographique contenant les périmètres de SCOT';

-- Column comments

COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_perimetre_scot.idurba IS 'Identifiant unique du SCOT';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_p_perimetre_scot.geom IS 'Géométrie de l''objet';

-- Permissions
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_p_perimetre_scot OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_perimetre_scot TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_p_perimetre_scot TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_p_perimetre_scot TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_p_perimetre_scot TO sig_edit;
*/
-- ######################################################################## geo_a_perimetre_scot #######################################################

-- m_urbanisme_doc_v2024.geo_a_perimetre_scot definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.geo_a_perimetre_scot;

CREATE TABLE m_urbanisme_doc_v2024.geo_a_perimetre_scot (
	idurba varchar(30) NOT NULL, -- Identifiant unique du SCOT
	geom geometry(multipolygon, 2154) NULL, -- Géométrie de l'objet
	CONSTRAINT geo_a_perimetre_scot_pkey PRIMARY KEY (idurba)
);
COMMENT ON TABLE m_urbanisme_doc_v2024.geo_a_perimetre_scot IS '(archive) Donnée géographique contenant les périmètres de SCOT';

-- Column comments

COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_perimetre_scot.idurba IS 'Identifiant unique du SCOT';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_a_perimetre_scot.geom IS 'Géométrie de l''objet';

-- Permissions
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_a_perimetre_scot OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_perimetre_scot TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_a_perimetre_scot TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_a_perimetre_scot TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_a_perimetre_scot TO sig_edit;
*/
-- ######################################################################## geo_t_perimetre_scot #######################################################

-- m_urbanisme_doc_v2024.geo_t_perimetre_scot definition

-- Drop table

-- DROP TABLE m_urbanisme_doc_v2024.geo_t_perimetre_scot;

CREATE TABLE m_urbanisme_doc_v2024.geo_t_perimetre_scot (
	idurba varchar(30) NOT NULL, -- Identifiant unique du SCOT
	geom geometry(multipolygon, 2154) NULL, -- Géométrie de l'objet
	CONSTRAINT geo_t_perimetre_scot_pkey PRIMARY KEY (idurba)
);
COMMENT ON TABLE m_urbanisme_doc_v2024.geo_t_perimetre_scot IS '(test) Donnée géographique contenant les périmètres de SCOT';

-- Column comments

COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_perimetre_scot.idurba IS 'Identifiant unique du SCOT';
COMMENT ON COLUMN m_urbanisme_doc_v2024.geo_t_perimetre_scot.geom IS 'Géométrie de l''objet';

-- Permissions
/*
ALTER TABLE m_urbanisme_doc_v2024.geo_t_perimetre_scot OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_perimetre_scot TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_t_perimetre_scot TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_t_perimetre_scot TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_t_perimetre_scot TO sig_edit;
*/



-- ####################################################################################################################################################
-- ###                                         		  TABLES SPECIFIQUES AU PNR ET OLV                                                          ###
-- ####################################################################################################################################################

-- Table: m_urbanisme_doc_v2024.an_doc_urba_doc

-- DROP TABLE m_urbanisme_doc_v2024.an_doc_urba_doc;
-- 
-- CREATE TABLE m_urbanisme_doc_v2024.an_doc_urba_doc
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
-- ALTER TABLE m_urbanisme_doc_v2024.an_doc_urba_doc
--   OWNER TO postgres;
-- COMMENT ON TABLE m_urbanisme_doc_v2024.an_doc_urba_doc
--   IS 'Donnée alphanumérique sur la disponibilité des documents numériques ou papiers à Oise-la-Vallée ou au Parc naturel régional Oise-Pays de France, le gestionnaire des données dans la base';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_doc.idurba IS 'identifiant du document d''urbanisme';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_doc.l_gest IS 'Type d''organisme qui gère la donnée dans la base (intégration et/ou mise à jour)';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_doc.l_dispon IS 'Niveau de disponibilité le plus élevé des documents numériques';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_doc.l_dispop IS 'Niveau de disponibilité le plus élevé des documents papiers';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_doc.l_datproc IS 'date de lancement de la procédure';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_urba_doc.l_observ IS 'observation';



-- permet d’identifier les zonages prenant en compte l’existence d’un enjeux patrimoine naturel
-- Table: m_urbanisme_doc_v2024.an_zone_patnat

-- DROP TABLE m_urbanisme_doc_v2024.an_zone_patnat;
-- 
-- CREATE TABLE m_urbanisme_doc_v2024.an_zone_patnat
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
-- ALTER TABLE m_urbanisme_doc_v2024.an_zone_patnat
--   OWNER TO olv;
-- COMMENT ON TABLE m_urbanisme_doc_v2024.an_zone_patnat
--   IS 'permet de gérer l''intégration des enjeux de patrimoine naturel dans les PLU';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_zone_patnat.idzone IS 'fait le lien avec le zonage concerné';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_zone_patnat.l_thema IS 'précise la procédure ou l outil reglementaire principal utilisé pour intégrer les enjeux de patrimoine naturel';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_zone_patnat.l_vigilance IS 'type booléen permet de signaler les zonages nécessitant une vigilance particulière sur la prise en compte réelle des enjeux de patrimoine naturel (oui/non)';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_zone_patnat.l_remarque IS 'permet de préciser toutes informations utiles ';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_zone_patnat.id_z_patnat IS 'identifiant unique';


-- permet de juger de la prise en compte global des enjeux patrimoine naturel par le document d’urbanisme 
-- Table: m_urbanisme_doc_v2024.an_doc_patnat

-- DROP TABLE m_urbanisme_doc_v2024.an_doc_patnat;
-- 
-- CREATE TABLE m_urbanisme_doc_v2024.an_doc_patnat
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
-- ALTER TABLE m_urbanisme_doc_v2024.an_doc_patnat
--   OWNER TO olv;
-- COMMENT ON TABLE m_urbanisme_doc_v2024.an_doc_patnat
--   IS 'permet de gérer intégration des enjeux de patrimoine naturel dans les PLU';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_patnat.idurba IS 'fait le lien avec le document concerné';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_patnat.l_prisencompte IS 'précise le niveau de prise en compte des enjeux de patrimoine naturel par le PLU';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_patnat.l_notesynth IS 'note globale pour apprecier la prise en compte des enjeux (de 1 à 4)';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_patnat.l_comment IS 'permet de préciser toutes informations utiles ';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_doc_patnat.id_d_patnat IS 'identifiant unique';


-- création de la table permettant de noter les différents changements réalisés sur la base (qui, quand, pourquoi)
-- 
-- CREATE TABLE m_urbanisme_doc_v2024.an_suivi_maj
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
-- ALTER TABLE m_urbanisme_doc_v2024.an_suivi_maj
--   OWNER TO olv;
-- GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_suivi_maj TO olv;
-- GRANT SELECT, UPDATE, INSERT, DELETE, REFERENCES, TRIGGER ON TABLE m_urbanisme_doc_v2024.an_suivi_maj TO sig WITH GRANT OPTION;
-- GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_suivi_maj TO public;
-- COMMENT ON TABLE m_urbanisme_doc_v2024.an_suivi_maj
--   IS 'table permettant de noter toute modification sur la base (données et structure)';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_suivi_maj.l_structure IS 'nom de la structure ';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_suivi_maj.l_operateur IS 'nom de la personne responsable des modifications';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_suivi_maj.l_comment IS 'précision concernant les modifications réalisées';
-- COMMENT ON COLUMN m_urbanisme_doc_v2024.an_suivi_maj.idmaj IS 'identifiant unique';


-- ajout du champ l_datmaj dans la structure existante

-- création du champs l_datmaj chargé de conserver la date de la dernière modification effectuée
-- 
-- alter table m_urbanisme_doc_v2024.geo_t_habillage_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_p_prescription_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_p_info_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_p_prescription_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.an_doc_patnat add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.an_doc_urba_doc add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_a_habillage_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_a_habillage_txt add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_a_habillage_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_a_habillage_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.an_doc_urba add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_a_zone_urba add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.an_zone_patnat add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_p_habillage_txt add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.an_doc_urba_com add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_a_info_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_p_habillage_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_a_prescription_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_p_habillage_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_p_habillage_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_a_info_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_a_prescription_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_a_prescription_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_a_info_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_p_info_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_p_info_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_p_prescription_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_t_zone_urba add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_p_zone_urba add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_t_habillage_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_t_prescription_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_t_prescription_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_t_prescription_surf add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_t_habillage_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_t_habillage_txt add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_t_info_lin add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_t_info_pct add column l_datmaj timestamp ;
-- alter table m_urbanisme_doc_v2024.geo_t_info_surf add column l_datmaj timestamp ;



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                           FKEY (clé étrangère)                                                               ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- Table: m_urbanisme_doc_v2024.an_doc_urba

ALTER TABLE m_urbanisme_doc_v2024.an_doc_urba
ADD CONSTRAINT lt_etat_fkey FOREIGN KEY (etat)
      REFERENCES m_urbanisme_doc_v2024.lt_etat (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typedoc_fkey FOREIGN KEY (typedoc)
      REFERENCES m_urbanisme_doc_v2024.lt_typedoc (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typeref_fkey FOREIGN KEY (typeref)
      REFERENCES m_urbanisme_doc_v2024.lt_typeref (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_nomproc_fkey FOREIGN KEY (nomproc)
      REFERENCES m_urbanisme_doc_v2024.lt_nomproc (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;



-- Table: m_urbanisme_doc_v2024.geo_p_zone_urba

ALTER TABLE m_urbanisme_doc_v2024.geo_p_zone_urba
ADD CONSTRAINT lt_typezone_fkey FOREIGN KEY (typezone)
      REFERENCES m_urbanisme_doc_v2024.lt_typezone (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_formdomi_fkey FOREIGN KEY (formdomi)
      REFERENCES m_urbanisme_doc_v2024.lt_formdomi (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typesect_fkey FOREIGN KEY (typesect)
      REFERENCES m_urbanisme_doc_v2024.lt_typesect (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_p_prescription_surf

ALTER TABLE m_urbanisme_doc_v2024.geo_p_prescription_surf
ADD CONSTRAINT lt_typepsc_surf_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_v2024.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_p_prescription_lin

ALTER TABLE m_urbanisme_doc_v2024.geo_p_prescription_lin
ADD CONSTRAINT lt_typepsc_lin_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_v2024.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_p_prescription_pct

ALTER TABLE m_urbanisme_doc_v2024.geo_p_prescription_pct
ADD CONSTRAINT lt_typepsc_pct_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_v2024.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_p_info_surf

ALTER TABLE m_urbanisme_doc_v2024.geo_p_info_surf
ADD CONSTRAINT lt_typeinf_surf_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_v2024.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc_v2024.geo_p_info_lin

ALTER TABLE m_urbanisme_doc_v2024.geo_p_info_lin
ADD CONSTRAINT lt_typeinf_lin_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_v2024.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_p_info_pct

ALTER TABLE m_urbanisme_doc_v2024.geo_p_info_pct
ADD CONSTRAINT lt_typeinf_pct_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_v2024.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

    
-- Table: m_urbanisme_doc_v2024.geo_a_zone_urba

ALTER TABLE m_urbanisme_doc_v2024.geo_a_zone_urba
ADD CONSTRAINT lt_typezone_fkey FOREIGN KEY (typezone)
      REFERENCES m_urbanisme_doc_v2024.lt_typezone (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_formdomi_fkey FOREIGN KEY (formdomi)
      REFERENCES m_urbanisme_doc_v2024.lt_formdomi (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typesect_fkey FOREIGN KEY (typesect)
      REFERENCES m_urbanisme_doc_v2024.lt_typesect (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_a_prescription_surf

ALTER TABLE m_urbanisme_doc_v2024.geo_a_prescription_surf
ADD CONSTRAINT lt_typepsc_surf_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_v2024.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_a_prescription_lin

ALTER TABLE m_urbanisme_doc_v2024.geo_a_prescription_lin
ADD CONSTRAINT lt_typepsc_lin_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_v2024.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_a_prescription_pct

ALTER TABLE m_urbanisme_doc_v2024.geo_a_prescription_pct
ADD CONSTRAINT lt_typepsc_pct_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_v2024.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_a_info_surf

ALTER TABLE m_urbanisme_doc_v2024.geo_a_info_surf
ADD CONSTRAINT lt_typeinf_surf_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_v2024.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc_v2024.geo_a_info_lin

ALTER TABLE m_urbanisme_doc_v2024.geo_a_info_lin
ADD CONSTRAINT lt_typeinf_lin_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_v2024.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_a_info_pct

ALTER TABLE m_urbanisme_doc_v2024.geo_a_info_pct
ADD CONSTRAINT lt_typeinf_pct_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_v2024.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;  


-- Table: m_urbanisme_doc_v2024.geo_t_zone_urba

ALTER TABLE m_urbanisme_doc_v2024.geo_t_zone_urba
ADD CONSTRAINT lt_typezone_fkey FOREIGN KEY (typezone)
      REFERENCES m_urbanisme_doc_v2024.lt_typezone (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_formdomi_fkey FOREIGN KEY (formdomi)
      REFERENCES m_urbanisme_doc_v2024.lt_formdomi (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
ADD CONSTRAINT lt_typesect_fkey FOREIGN KEY (typesect)
      REFERENCES m_urbanisme_doc_v2024.lt_typesect (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_t_prescription_surf

ALTER TABLE m_urbanisme_doc_v2024.geo_t_prescription_surf
ADD CONSTRAINT lt_typepsc_surf_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_v2024.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_t_prescription_lin

ALTER TABLE m_urbanisme_doc_v2024.geo_t_prescription_lin
ADD CONSTRAINT lt_typepsc_lin_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_v2024.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_t_prescription_pct

ALTER TABLE m_urbanisme_doc_v2024.geo_t_prescription_pct
ADD CONSTRAINT lt_typepsc_pct_fkey FOREIGN KEY (typepsc,stypepsc)
      REFERENCES m_urbanisme_doc_v2024.lt_typepsc (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_t_info_surf

ALTER TABLE m_urbanisme_doc_v2024.geo_t_info_surf
ADD CONSTRAINT lt_typeinf_surf_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_v2024.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc_v2024.geo_t_info_lin

ALTER TABLE m_urbanisme_doc_v2024.geo_t_info_lin
ADD CONSTRAINT lt_typeinf_lin_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_v2024.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.geo_t_info_pct

ALTER TABLE m_urbanisme_doc_v2024.geo_t_info_pct
ADD CONSTRAINT lt_typeinf_pct_fkey FOREIGN KEY (typeinf,stypeinf)
      REFERENCES m_urbanisme_doc_v2024.lt_typeinf (code, sous_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;  


-- COMMENT GB : ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Clé étrangère des tables spécifiques métiers au PNR et OLV
-- A décommenter pour intégration (à vérifier au préalable par le PNR et OLV)
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Table: m_urbanisme_doc_v2024.an_doc_urba_doc
-- 
-- ALTER TABLE m_urbanisme_doc_v2024.an_doc_urba_doc
-- ADD CONSTRAINT dispon_fkey FOREIGN KEY (l_dispon)
--       REFERENCES m_urbanisme_doc_v2024.lt_dispon (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION,
-- ADD CONSTRAINT dispop_fkey FOREIGN KEY (l_dispop)
--       REFERENCES m_urbanisme_doc_v2024.lt_dispop (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Table: m_urbanisme_doc_v2024.an_zone_patnat
-- 
-- ALTER TABLE m_urbanisme_doc_v2024.an_zone_patnat
--   ADD CONSTRAINT lt_l_themapatnat_fkey FOREIGN KEY (l_thema)
--       REFERENCES m_urbanisme_doc_v2024.lt_l_themapatnat (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;
-- 
-- ALTER TABLE m_urbanisme_doc_v2024.an_zone_patnat
--   ADD CONSTRAINT lt_l_vigipatnat_fkey FOREIGN KEY (l_vigilance)
--       REFERENCES m_urbanisme_doc_v2024.lt_l_vigipatnat (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Table: m_urbanisme_doc_v2024.an_doc_patnat
-- 
-- ALTER TABLE m_urbanisme_doc_v2024.an_doc_patnat
--   ADD CONSTRAINT lt_l_pecpatnat_fkey FOREIGN KEY (l_prisencompte)
--       REFERENCES m_urbanisme_doc_v2024.lt_l_pecpatnat (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;

-- ALTER TABLE m_urbanisme_doc_v2024.an_doc_patnat
--   ADD CONSTRAINT lt_l_nspatnat_fkey FOREIGN KEY (l_notesynth)
--       REFERENCES m_urbanisme_doc_v2024.lt_l_nspatnat (code) MATCH SIMPLE
--       ON UPDATE NO ACTION ON DELETE NO ACTION;



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     TRIGGER    (spécifiques ARC)                                             ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

/*
-- ####################################################### FONCTION TRIGGER - update_geom #############################################################

-- Function: m_urbanisme_doc_v2024.an_doc_urba_null()

-- DROP FUNCTION m_urbanisme_doc_v2024.an_doc_urba_null();

CREATE OR REPLACE FUNCTION m_urbanisme_doc_v2024.an_doc_urba_null()
  RETURNS trigger AS
$BODY$BEGIN
	update m_urbanisme_doc_v2024.an_doc_urba set datefin=null where datefin='';
	update m_urbanisme_doc_v2024.an_doc_urba set nomproc=null where nomproc='';
	update m_urbanisme_doc_v2024.an_doc_urba set l_moa_proc=null where l_moa_proc='';
	update m_urbanisme_doc_v2024.an_doc_urba set l_moe_proc=null where l_moe_proc='';
	update m_urbanisme_doc_v2024.an_doc_urba set l_moa_dmat=null where l_moa_dmat='';
	update m_urbanisme_doc_v2024.an_doc_urba set l_moe_dmat=null where l_moe_dmat='';
	update m_urbanisme_doc_v2024.an_doc_urba set l_observ=null where l_observ='';
	update m_urbanisme_doc_v2024.an_doc_urba set nomreg=null where nomreg='';
	update m_urbanisme_doc_v2024.an_doc_urba set urlreg=null where urlreg='';
	update m_urbanisme_doc_v2024.an_doc_urba set nomplan=null where nomplan='';
	update m_urbanisme_doc_v2024.an_doc_urba set urlplan=null where urlplan='';
	update m_urbanisme_doc_v2024.an_doc_urba set urlpe=null where urlpe='';
	update m_urbanisme_doc_v2024.an_doc_urba set siteweb=null where siteweb='';
	update m_urbanisme_doc_v2024.an_doc_urba set dateref=null where dateref='';
RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc_v2024.an_doc_urba_null()
  OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_v2024.an_doc_urba_null() TO postgres;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_v2024.an_doc_urba_null() TO public;
COMMENT ON FUNCTION m_urbanisme_doc_v2024.an_doc_urba_null() IS 'Fonction remplaçant les '' par null lors de la mise à jour ou de l''insertion via le module web de gestion PNR/OLV';


-- DROP FUNCTION m_urbanisme_doc_v2024.ft_m_an_vmr_docurba_h();

CREATE OR REPLACE FUNCTION m_urbanisme_doc_v2024.ft_m_an_vmr_docurba_h()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$BEGIN

REFRESH MATERIALIZED VIEW x_apps.xapps_an_vmr_docurba_h;

RETURN NEW;
END;$function$
;

COMMENT ON FUNCTION m_urbanisme_doc_v2024.ft_m_an_vmr_docurba_h() IS 'Fonction rafraichissant la vue permettant de créer une table provisoire des anciens documents d''urbanisme accessible dans la fiche de renseignements d''urbanisme dans GEO';

-- Permissions

ALTER FUNCTION m_urbanisme_doc_v2024.ft_m_an_vmr_docurba_h() OWNER TO create_sig;
GRANT ALL ON FUNCTION m_urbanisme_doc_v2024.ft_m_an_vmr_docurba_h() TO create_sig;
GRANT ALL ON FUNCTION m_urbanisme_doc_v2024.ft_m_an_vmr_docurba_h() TO public;

-- Trigger: t_t1_r_null_an_doc_urba on m_urbanisme_doc_v2024.an_doc_urba

-- DROP TRIGGER t_t1_r_null_an_doc_urba ON m_urbanisme_doc_v2024.an_doc_urba;

CREATE TRIGGER t_t1_r_null_an_doc_urba
  AFTER INSERT OR UPDATE
  ON m_urbanisme_doc_v2024.an_doc_urba
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc_v2024.an_doc_urba_null();

 
create trigger t_t2_m_an_vmr_docurba_h 
after insert or delete or update
    on m_urbanisme_doc_v2024.an_doc_urba 
    for each row execute procedure m_urbanisme_doc_v2024.ft_m_an_vmr_docurba_h();

    
-- ####################################################### FONCTION TRIGGER - m_l_surf_cal_ha ##################################################

-- Function: m_urbanisme_doc_v2024.m_l_surf_cal_ha()

-- DROP FUNCTION m_urbanisme_doc_v2024.m_l_surf_cal_ha();

CREATE OR REPLACE FUNCTION m_urbanisme_doc_v2024.m_l_surf_cal_ha()
  RETURNS trigger AS
$BODY$BEGIN
NEW.l_surf_cal=round(cast(st_area(new.geom)/10000 as numeric),2);
RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION m_urbanisme_doc_v2024.m_l_surf_cal_ha()
  OWNER TO create_sig;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_v2024.m_l_surf_cal_ha() TO public;
GRANT EXECUTE ON FUNCTION m_urbanisme_doc_v2024.m_l_surf_cal_ha() TO postgres;
COMMENT ON FUNCTION m_urbanisme_doc_v2024.m_l_surf_cal_ha() IS 'Fonction dont l''objet est de mettre à jour la superficie calculée en ha du champ l_surf_cal des zones urba';

-- Trigger: l_surface on m_urbanisme_doc_v2024.geo_t_zone_urba

-- DROP TRIGGER l_surface ON m_urbanisme_doc_v2024.geo_t_zone_urba;

CREATE TRIGGER t_t1_l_surf_cal
  BEFORE INSERT OR UPDATE OF geom
  ON m_urbanisme_doc_v2024.geo_t_zone_urba
  FOR EACH ROW
  EXECUTE PROCEDURE m_urbanisme_doc_v2024.m_l_surf_cal_ha();

 
create trigger t_t1_m_an_vmr_docurba_h after
INSERT OR DELETE OR update
    on
    m_urbanisme_doc_v2024.an_doc_urba_com for each row execute procedure m_urbanisme_doc_v2024.ft_m_an_vmr_docurba_h();

   -- ####################################################### FONCTION TRIGGER - ft_m_nature_cnig2024 ##################################################

   
   -- DROP FUNCTION m_urbanisme_doc.ft_m_nature_cnig2024();

CREATE OR REPLACE FUNCTION m_urbanisme_doc.ft_m_nature_cnig2024()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$BEGIN

new.nature := lower((replace(new.l_nature,' ','_')));

RETURN NEW;
END;$function$
;

COMMENT ON FUNCTION m_urbanisme_doc.ft_m_nature_cnig2024() IS 'Fonction générant le contenu de l''attribut "nature" du standard CNIG 2024 à partir de l''attriburt métier "l_nature"';

-- Permissions

ALTER FUNCTION m_urbanisme_doc.ft_m_nature_cnig2024() OWNER TO create_sig;
GRANT ALL ON FUNCTION m_urbanisme_doc.ft_m_nature_cnig2024() TO public;
GRANT ALL ON FUNCTION m_urbanisme_doc.ft_m_nature_cnig2024() TO create_sig;

create trigger t_t2_nature_cnig2024 before
INSERT OR UPDATE of l_nature on
    m_urbanisme_doc.geo_t_prescription_surf for each row execute procedure m_urbanisme_doc.ft_m_nature_cnig2024()
*/

   
-- ####################################################################################################################################################
-- ###                                                             TRIGGER SPECIFIQUE PNR-OLV                                                       ###
-- ####################################################################################################################################################

-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Ils n'ont pas été intégrés ici, à adapter par le PNR et OLV
-- ----------------------------------------------------------------------------------------------------------------------------------------------------


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                           VUES (spécifiques PNR-OLV)                                                         ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Elles n'ont pas été intégrés ici, à adapter par le PNR et OLV
-- ----------------------------------------------------------------------------------------------------------------------------------------------------



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                          ROLES (spécifiques PNR-OLV)                                                         ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- COMMENT GB : ---------------------------------------------------------------------------------------------------------------------------------------
-- Ils n'ont pas été intégrés ici, à adapter par le PNR et OLV ou à modifier dans le code source directement
-- ----------------------------------------------------------------------------------------------------------------------------------------------------



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                           VUES (spécifiques ARC)                                                             ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################
/*

-- ####################################################### VUE - an_v_docurba_annee ##################################################

-- m_urbanisme_doc_v2024.an_v_docurba_annee source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.an_v_docurba_annee
AS WITH req_tot AS (
        ( WITH req_plu AS (
                 SELECT g.insee AS territoire_insee,
                    ''::character varying(9) AS territoire_siren,
                    g.libgeo AS territoire,
                    g.epci AS epci_siren,
                    i.lib_epci AS epci_lib,
                    u.typedoc,
                    p.valeur AS nomproc,
                    e.valeur AS etat,
                    to_char(to_date(u.datappro::text, 'YYYYMMDD'::text)::timestamp with time zone, 'YYYY'::text) AS anneappro,
                    to_char(to_date(u.datappro::text, 'YYYYMMDD'::text)::timestamp with time zone, 'DD-MM-YYYY'::text) AS datappro
                   FROM m_urbanisme_doc_v2024.an_doc_urba u,
                    m_urbanisme_doc_v2024.lt_etat e,
                    m_urbanisme_doc_v2024.lt_nomproc p,
                    r_administratif.an_geo g,
                    r_osm.geo_vm_osm_epci i
                  WHERE u.etat::bpchar = e.code AND u.nomproc::text = p.code::text AND g.insee::text = "left"(u.idurba::text, 5) AND (u.typedoc::text = 'PLU'::text OR u.typedoc::text = 'POS'::text OR u.typedoc::text = 'CC'::text) AND g.epci::text = i.cepci::text
                  ORDER BY g.libgeo, (to_date(u.datappro::text, 'YYYYMMDD'::text)) DESC
                )
         SELECT req_plu.territoire_insee,
            req_plu.territoire_siren,
            req_plu.territoire,
            req_plu.epci_siren,
            req_plu.epci_lib,
            req_plu.typedoc,
            req_plu.nomproc,
            req_plu.etat,
            req_plu.anneappro,
            req_plu.datappro
           FROM req_plu)
        UNION ALL
        ( WITH req_plui AS (
                 SELECT ''::character varying(5) AS territoire_insee,
                    g.cepci AS territoire_siren,
                    g.lib_epci AS territoire,
                    g.cepci AS epci_siren,
                    g.lib_epci AS epci_lib,
                    u.typedoc,
                    p.valeur AS nomproc,
                    e.valeur AS etat,
                    to_char(to_date(u.datappro::text, 'YYYYMMDD'::text)::timestamp with time zone, 'YYYY'::text) AS anneappro,
                    to_char(to_date(u.datappro::text, 'YYYYMMDD'::text)::timestamp with time zone, 'DD-MM-YYYY'::text) AS datappro
                   FROM m_urbanisme_doc_v2024.an_doc_urba u,
                    m_urbanisme_doc_v2024.lt_etat e,
                    m_urbanisme_doc_v2024.lt_nomproc p,
                    r_osm.geo_vm_osm_epci g
                  WHERE u.etat::bpchar = e.code AND u.nomproc::text = p.code::text AND g.cepci::text = "left"(u.idurba::text, 9) AND u.typedoc::text = 'PLUI'::text
                  ORDER BY g.lib_epci, (to_date(u.datappro::text, 'YYYYMMDD'::text)) DESC
                )
         SELECT req_plui.territoire_insee,
            req_plui.territoire_siren,
            req_plui.territoire,
            req_plui.epci_siren,
            req_plui.epci_lib,
            req_plui.typedoc,
            req_plui.nomproc,
            req_plui.etat,
            req_plui.anneappro,
            req_plui.datappro
           FROM req_plui)
        UNION ALL
        ( WITH req_scot AS (
                 SELECT ''::character varying(5) AS territoire_insee,
                    g.cepci AS territoire_siren,
                    g.lib_epci AS territoire,
                    g.cepci AS epci_siren,
                    g.lib_epci AS epci_lib,
                    u.typedoc,
                    p.valeur AS nomproc,
                    e.valeur AS etat,
                    to_char(to_date(u.datappro::text, 'YYYYMMDD'::text)::timestamp with time zone, 'YYYY'::text) AS anneappro,
                    to_char(to_date(u.datappro::text, 'YYYYMMDD'::text)::timestamp with time zone, 'DD-MM-YYYY'::text) AS datappro
                   FROM m_urbanisme_doc_v2024.an_doc_urba u,
                    m_urbanisme_doc_v2024.lt_etat e,
                    m_urbanisme_doc_v2024.lt_nomproc p,
                    r_osm.geo_vm_osm_epci g
                  WHERE u.etat::bpchar = e.code AND u.nomproc::text = p.code::text AND g.cepci::text = "left"(u.idurba::text, 9) AND u.typedoc::text = 'SCOT'::text
                  ORDER BY g.lib_epci, (to_date(u.datappro::text, 'YYYYMMDD'::text)) DESC
                )
         SELECT req_scot.territoire_insee,
            req_scot.territoire_siren,
            req_scot.territoire,
            req_scot.epci_siren,
            req_scot.epci_lib,
            req_scot.typedoc,
            req_scot.nomproc,
            req_scot.etat,
            req_scot.anneappro,
            req_scot.datappro
           FROM req_scot)
        UNION ALL
        ( WITH req_scot_arc AS (
                 SELECT ''::character varying(5) AS territoire_insee,
                    '246001010'::character varying(9) AS territoire_siren,
                    'Agglomération de la Région de Compiègne'::text AS territoire,
                    '200067965'::character varying(9) AS epci_siren,
                    'Agglomération de la Région de Compiègne et de la Basse Automne'::text AS epci_lib,
                    u.typedoc,
                    p.valeur AS nomproc,
                    e.valeur AS etat,
                    to_char(to_date(u.datappro::text, 'YYYYMMDD'::text)::timestamp with time zone, 'YYYY'::text) AS anneappro,
                    to_char(to_date(u.datappro::text, 'YYYYMMDD'::text)::timestamp with time zone, 'DD-MM-YYYY'::text) AS datappro
                   FROM m_urbanisme_doc_v2024.an_doc_urba u,
                    m_urbanisme_doc_v2024.lt_etat e,
                    m_urbanisme_doc_v2024.lt_nomproc p
                  WHERE u.etat::bpchar = e.code AND u.nomproc::text = p.code::text AND u.idurba::text = '246001010_SCOT_20121215'::text AND u.typedoc::text = 'SCOT'::text
                  ORDER BY 'Agglomération de la Région de Compiègne'::text, (to_date(u.datappro::text, 'YYYYMMDD'::text)) DESC
                )
         SELECT req_scot_arc.territoire_insee,
            req_scot_arc.territoire_siren,
            req_scot_arc.territoire,
            req_scot_arc.epci_siren,
            req_scot_arc.epci_lib,
            req_scot_arc.typedoc,
            req_scot_arc.nomproc,
            req_scot_arc.etat,
            req_scot_arc.anneappro,
            req_scot_arc.datappro
           FROM req_scot_arc)
        )
 SELECT row_number() OVER () AS id,
    req_tot.territoire_insee,
    req_tot.territoire_siren,
    req_tot.territoire,
    req_tot.epci_siren,
    req_tot.epci_lib,
    req_tot.typedoc,
    req_tot.nomproc,
    req_tot.etat,
    req_tot.anneappro,
    req_tot.datappro
   FROM req_tot
  ORDER BY req_tot.anneappro DESC, req_tot.territoire;

COMMENT ON VIEW m_urbanisme_doc_v2024.an_v_docurba_annee IS 'Vue alphanumérique des documents d''urbanisme par territoire et par année';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.an_v_docurba_annee OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_v_docurba_annee TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_v_docurba_annee TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_v_docurba_annee TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_v_docurba_annee TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.an_v_docurba_annee TO sig_edit;


-- ####################################################### VUE - an_v_docurba_arcba ##################################################

-- m_urbanisme_doc_v2024.an_v_docurba_arcba source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.an_v_docurba_arcba
AS SELECT an_doc_urba.idurba,
        CASE
            WHEN length(an_doc_urba.idurba::text) = 23 THEN "substring"(an_doc_urba.idurba::text, 1, 9)
            ELSE "substring"(an_doc_urba.idurba::text, 1, 5)
        END AS siren,
        CASE
            WHEN length(an_doc_urba.idurba::text) = 18 THEN "substring"(an_doc_urba.idurba::text, 1, 5)
            ELSE ''::text
        END AS insee,
    geo_osm_commune.commune,
    an_doc_urba.typedoc,
    an_doc_urba.datappro,
    lt_nomproc.valeur::text ||
        CASE
            WHEN an_doc_urba.l_nomprocn IS NULL THEN ''::text
            ELSE ' n° '::text || an_doc_urba.l_nomprocn
        END AS procedure,
    lt_etat.valeur AS etat
   FROM m_urbanisme_doc_v2024.an_doc_urba,
    m_urbanisme_doc_v2024.an_doc_urba_com,
    m_urbanisme_doc_v2024.lt_etat,
    r_osm.geo_osm_commune,
    r_osm.geo_vm_osm_epci,
    m_urbanisme_doc_v2024.lt_nomproc
  WHERE an_doc_urba_com.idurba::text = an_doc_urba.idurba::text AND lt_etat.code = an_doc_urba.etat::bpchar AND lt_nomproc.code::text = an_doc_urba.nomproc::text AND "substring"(an_doc_urba_com.insee::text, 1, 5) = geo_osm_commune.insee::text AND st_intersects(st_centroid(geo_osm_commune.geom), geo_vm_osm_epci.geom) AND geo_vm_osm_epci.cepci::text = '200067965'::text
  ORDER BY an_doc_urba.idurba;

COMMENT ON VIEW m_urbanisme_doc_v2024.an_v_docurba_arcba IS 'Vue ARC simplifiée de la table an_doc_urba à usage interne.
Ajout nom de la commune et du libellé de l''état du document';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.an_v_docurba_arcba OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_v_docurba_arcba TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_v_docurba_arcba TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_v_docurba_arcba TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_v_docurba_arcba TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.an_v_docurba_arcba TO sig_edit;

-- ####################################################### VUE - an_v_docurba_cclo ##################################################

-- m_urbanisme_doc_v2024.an_v_docurba_cclo source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.an_v_docurba_cclo
AS SELECT an_doc_urba.idurba,
    "substring"(an_doc_urba.idurba::text, 1, 5) AS insee,
    geo_osm_commune.commune,
    an_doc_urba.typedoc,
    an_doc_urba.datappro,
    lt_nomproc.valeur::text ||
        CASE
            WHEN an_doc_urba.l_nomprocn IS NULL THEN ''::text
            ELSE ' n° '::text || an_doc_urba.l_nomprocn
        END AS procedure,
    lt_etat.valeur AS etat
   FROM m_urbanisme_doc_v2024.an_doc_urba,
    m_urbanisme_doc_v2024.lt_etat,
    r_osm.geo_osm_commune,
    r_osm.geo_vm_osm_epci,
    m_urbanisme_doc_v2024.lt_nomproc
  WHERE lt_etat.code = an_doc_urba.etat::bpchar AND lt_nomproc.code::text = an_doc_urba.nomproc::text AND "substring"(an_doc_urba.idurba::text, 1, 5) = geo_osm_commune.insee::text AND st_intersects(st_centroid(geo_osm_commune.geom), geo_vm_osm_epci.geom) AND geo_vm_osm_epci.cepci::text = '246000749'::text
  ORDER BY an_doc_urba.idurba;

COMMENT ON VIEW m_urbanisme_doc_v2024.an_v_docurba_cclo IS 'Vue CCLO simplifiée de la table an_doc_urba à usage interne.
Ajout nom de la commune et du libellé de l''état du document';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.an_v_docurba_cclo OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_v_docurba_cclo TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_v_docurba_cclo TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_v_docurba_cclo TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.an_v_docurba_cclo TO sig_edit;

-- ####################################################### VUE - an_v_docurba_ccpe ##################################################
-- m_urbanisme_doc_v2024.an_v_docurba_ccpe source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.an_v_docurba_ccpe
AS SELECT an_doc_urba.idurba,
    "substring"(an_doc_urba.idurba::text, 1, 5) AS insee,
    geo_osm_commune.commune,
    an_doc_urba.typedoc,
    an_doc_urba.datappro,
    lt_nomproc.valeur::text ||
        CASE
            WHEN an_doc_urba.l_nomprocn IS NULL THEN ''::text
            ELSE ' n° '::text || an_doc_urba.l_nomprocn
        END AS procedure,
    lt_etat.valeur AS etat
   FROM m_urbanisme_doc_v2024.an_doc_urba,
    m_urbanisme_doc_v2024.lt_etat,
    r_osm.geo_osm_commune,
    r_osm.geo_vm_osm_epci,
    m_urbanisme_doc_v2024.lt_nomproc
  WHERE lt_etat.code = an_doc_urba.etat::bpchar AND lt_nomproc.code::text = an_doc_urba.nomproc::text AND "substring"(an_doc_urba.idurba::text, 1, 5) = geo_osm_commune.insee::text AND st_intersects(st_centroid(geo_osm_commune.geom), geo_vm_osm_epci.geom) AND geo_vm_osm_epci.cepci::text = '246000897'::text
  ORDER BY an_doc_urba.idurba;

COMMENT ON VIEW m_urbanisme_doc_v2024.an_v_docurba_ccpe IS 'Vue CCPE simplifiée de la table an_doc_urba à usage interne.
Ajout nom de la commune et du libellé de l''état du document';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.an_v_docurba_ccpe OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_v_docurba_ccpe TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_v_docurba_ccpe TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_v_docurba_ccpe TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.an_v_docurba_ccpe TO sig_edit;


-- ####################################################### VUE - an_v_docurba_valide ##################################################

-- m_urbanisme_doc_v2024.an_v_docurba_valide source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.an_v_docurba_valide
AS SELECT an_doc_urba_com.insee::text AS insee,
    an_doc_urba.typedoc,
    to_date(an_doc_urba.datappro::text, 'YYYYMMDD'::text) AS datappro,
    lt_nomproc.valeur::text ||
        CASE
            WHEN an_doc_urba.l_nomprocn IS NULL THEN ''::text
            ELSE ' n° '::text || an_doc_urba.l_nomprocn
        END AS l_version,
    an_doc_urba.l_urldgen,
    an_doc_urba.l_urlann,
    an_doc_urba.l_urllex,
    an_doc_urba.idurba
   FROM m_urbanisme_doc_v2024.an_doc_urba,
    m_urbanisme_doc_v2024.an_doc_urba_com,
    m_urbanisme_doc_v2024.lt_nomproc
  WHERE an_doc_urba.idurba::text = an_doc_urba_com.idurba::text AND an_doc_urba.nomproc::text = lt_nomproc.code::text AND an_doc_urba.etat::bpchar = '03'::bpchar AND an_doc_urba.typedoc::text <> 'SCOT'::text AND an_doc_urba.typedoc::text <> 'RNU'::text
UNION ALL
 SELECT "left"(an_doc_urba.idurba::text, 5) AS insee,
    an_doc_urba.typedoc,
    to_date(an_doc_urba.datappro::text, 'YYYYMMDD'::text) AS datappro,
    lt_nomproc.valeur::text ||
        CASE
            WHEN an_doc_urba.l_nomprocn IS NULL THEN ''::text
            ELSE ' n° '::text || an_doc_urba.l_nomprocn
        END AS l_version,
    an_doc_urba.l_urldgen,
    an_doc_urba.l_urlann,
    an_doc_urba.l_urllex,
    NULL::character varying AS idurba
   FROM m_urbanisme_doc_v2024.an_doc_urba,
    m_urbanisme_doc_v2024.lt_nomproc
  WHERE an_doc_urba.nomproc::text = lt_nomproc.code::text AND an_doc_urba.etat::bpchar = '03'::bpchar AND an_doc_urba.typedoc::bpchar = 'RNU'::bpchar;

COMMENT ON VIEW m_urbanisme_doc_v2024.an_v_docurba_valide IS 'Liste des documents d''urbanisme valide sur les communes du Grand Compiégnois avec le formatage d''accès aux dispositions générales, annexes et lexique du PLUih de l''ARC';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.an_v_docurba_valide OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_v_docurba_valide TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_v_docurba_valide TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.an_v_docurba_valide TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.an_v_docurba_valide TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.an_v_docurba_valide TO sig_edit;

-- ####################################################### VUE - geo_v_docurba ##################################################


-- m_urbanisme_doc_v2024.geo_v_docurba source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_docurba
AS SELECT uc.insee::text AS insee,
    a.libgeo AS commune,
    u.typedoc,
    c.geom
   FROM m_urbanisme_doc_v2024.an_doc_urba u,
    m_urbanisme_doc_v2024.an_doc_urba_com uc,
    r_osm.geo_osm_commune c,
    r_administratif.an_geo a
  WHERE u.idurba::text = uc.idurba::text AND a.insee::text = c.insee::text AND uc.insee::text = c.insee::text AND 
 (a.epci::text = '200067965'::text OR a.epci::text = '246000897'::text OR a.epci::text = '246000749'::text OR a.epci::text = '246000772'::text) AND u.etat::bpchar = '03'::bpchar AND u.typedoc::text <> 'SCOT'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_docurba IS 'Vue géographique présentant le types de document d''urbanisme valide par commune du Grand COmpiégnois';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_docurba OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_docurba TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_docurba TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_docurba TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_docurba TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_docurba TO sig_edit;


-- ####################################################### VUE - geo_v_p_habillage_lin_arc ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_habillage_lin_arc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_habillage_lin_arc
AS SELECT geo_p_habillage_lin.idhab,
    geo_p_habillage_lin.nattrac,
    geo_p_habillage_lin.idurba,
    geo_p_habillage_lin.l_insee,
    "right"(geo_p_habillage_lin.idurba::text, 8) AS l_datappro,
    geo_p_habillage_lin.geom
   FROM m_urbanisme_doc_v2024.geo_p_habillage_lin
  WHERE geo_p_habillage_lin.idurba::text ~~ '200067965%'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_habillage_lin_arc IS 'Vue géographique des habillages linéaires PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_lin_arc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_lin_arc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_lin_arc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_lin_arc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_lin_arc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_lin_arc TO sig_edit;

-- ####################################################### VUE - geo_v_p_habillage_lin_cclo ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_habillage_lin_cclo source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_habillage_lin_cclo
AS SELECT geo_p_habillage_lin.idhab,
    geo_p_habillage_lin.nattrac,
    geo_p_habillage_lin.idurba,
    geo_p_habillage_lin.l_insee,
    "right"(geo_p_habillage_lin.idurba::text, 8) AS l_datappro,
    geo_p_habillage_lin.geom
   FROM m_urbanisme_doc_v2024.geo_p_habillage_lin
  WHERE geo_p_habillage_lin.l_insee::text = ANY (ARRAY['60025'::character varying, '60032'::character varying, '60064'::character varying, '60072'::character varying, '60145'::character varying, '60167'::character varying, '60171'::character varying, '60184'::character varying, '60188'::character varying, '60305'::character varying, '60324'::character varying, '60438'::character varying, '60445'::character varying, '60491'::character varying, '60534'::character varying, '60569'::character varying, '60572'::character varying, '60593'::character varying, '60641'::character varying, '60647'::character varying]::text[]);

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_habillage_lin_cclo IS 'Vue géographique des habillages linéaires PLU filtrée sur les communes de la CCLO pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLUi CCLO';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_lin_cclo OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_lin_cclo TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_lin_cclo TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_lin_cclo TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_lin_cclo TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_lin_cclo TO sig_edit;


-- ####################################################### VUE - geo_v_p_habillage_pct_arc ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_habillage_pct_arc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_habillage_pct_arc
AS SELECT geo_p_habillage_pct.idhab,
    geo_p_habillage_pct.nattrac,
    geo_p_habillage_pct.couleur,
    geo_p_habillage_pct.idurba,
    geo_p_habillage_pct.l_insee,
    "right"(geo_p_habillage_pct.idurba::text, 8) AS l_datappro,
    geo_p_habillage_pct.geom
   FROM m_urbanisme_doc_v2024.geo_p_habillage_pct
  WHERE geo_p_habillage_pct.idurba::text ~~ '200067965%'::text;

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_pct_arc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_pct_arc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_pct_arc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_pct_arc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_pct_arc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_pct_arc TO sig_edit;

-- ####################################################### VUE - geo_v_p_habillage_pct_cclo ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_habillage_pct_cclo source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_habillage_pct_cclo
AS SELECT geo_p_habillage_pct.idhab,
    geo_p_habillage_pct.nattrac,
    geo_p_habillage_pct.couleur,
    geo_p_habillage_pct.idurba,
    geo_p_habillage_pct.l_insee,
    "right"(geo_p_habillage_pct.idurba::text, 8) AS l_datappro,
    geo_p_habillage_pct.geom
   FROM m_urbanisme_doc_v2024.geo_p_habillage_pct
  WHERE geo_p_habillage_pct.l_insee::text = ANY (ARRAY['60025'::character varying, '60032'::character varying, '60064'::character varying, '60072'::character varying, '60145'::character varying, '60167'::character varying, '60171'::character varying, '60184'::character varying, '60188'::character varying, '60305'::character varying, '60324'::character varying, '60438'::character varying, '60445'::character varying, '60491'::character varying, '60534'::character varying, '60569'::character varying, '60572'::character varying, '60593'::character varying, '60641'::character varying, '60647'::character varying]::text[]);

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_pct_cclo OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_pct_cclo TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_pct_cclo TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_pct_cclo TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_pct_cclo TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_pct_cclo TO sig_edit;

-- ####################################################### VUE - geo_v_p_habillage_surf_arc ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_habillage_surf_arc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_habillage_surf_arc
AS SELECT geo_p_habillage_surf.idhab,
    geo_p_habillage_surf.nattrac,
    geo_p_habillage_surf.couleur,
    geo_p_habillage_surf.idurba,
    geo_p_habillage_surf.l_insee,
    "right"(geo_p_habillage_surf.idurba::text, 8) AS l_datappro,
    geo_p_habillage_surf.geom
   FROM m_urbanisme_doc_v2024.geo_p_habillage_surf
  WHERE geo_p_habillage_surf.idurba::text ~~ '200067965%'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_habillage_surf_arc IS 'Vue géographique des habillages ponctuels PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_surf_arc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_surf_arc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_surf_arc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_surf_arc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_surf_arc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_surf_arc TO sig_edit;


-- ####################################################### VUE - geo_v_p_habillage_surf_cclo ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_habillage_surf_cclo source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_habillage_surf_cclo
AS SELECT geo_p_habillage_surf.idhab,
    geo_p_habillage_surf.nattrac,
    geo_p_habillage_surf.couleur,
    geo_p_habillage_surf.idurba,
    geo_p_habillage_surf.l_insee,
    "right"(geo_p_habillage_surf.idurba::text, 8) AS l_datappro,
    geo_p_habillage_surf.geom
   FROM m_urbanisme_doc_v2024.geo_p_habillage_surf
  WHERE geo_p_habillage_surf.l_insee::text = ANY (ARRAY['60025'::character varying, '60032'::character varying, '60064'::character varying, '60072'::character varying, '60145'::character varying, '60167'::character varying, '60171'::character varying, '60184'::character varying, '60188'::character varying, '60305'::character varying, '60324'::character varying, '60438'::character varying, '60445'::character varying, '60491'::character varying, '60534'::character varying, '60569'::character varying, '60572'::character varying, '60593'::character varying, '60641'::character varying, '60647'::character varying]::text[]);

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_habillage_surf_cclo IS 'Vue géographique des habillages ponctuels PLU filtrée sur les communes de la CCLO pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''appli PLUi CCLO';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_surf_cclo OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_surf_cclo TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_surf_cclo TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_surf_cclo TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_surf_cclo TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_surf_cclo TO sig_edit;


-- ####################################################### VUE - geo_v_p_habillage_txt_arc ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_habillage_txt_arc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_habillage_txt_arc
AS SELECT geo_p_habillage_txt.idhab,
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
    "right"(geo_p_habillage_txt.idurba::text, 8) AS l_datappro,
    geo_p_habillage_txt.geom
   FROM m_urbanisme_doc_v2024.geo_p_habillage_txt
  WHERE geo_p_habillage_txt.idurba::text ~~ '200067965%'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_habillage_txt_arc IS 'Vue géographique des habillages textuels PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_txt_arc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_txt_arc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_txt_arc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_txt_arc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_txt_arc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_txt_arc TO sig_edit;


-- ####################################################### VUE - geo_v_p_habillage_txt_cclo ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_habillage_txt_cclo source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_habillage_txt_cclo
AS SELECT geo_p_habillage_txt.idhab,
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
    "right"(geo_p_habillage_txt.idurba::text, 8) AS l_datappro,
    geo_p_habillage_txt.geom
   FROM m_urbanisme_doc_v2024.geo_p_habillage_txt
  WHERE geo_p_habillage_txt.l_insee::text = ANY (ARRAY['60025'::character varying, '60032'::character varying, '60064'::character varying, '60072'::character varying, '60145'::character varying, '60167'::character varying, '60171'::character varying, '60184'::character varying, '60188'::character varying, '60305'::character varying, '60324'::character varying, '60438'::character varying, '60445'::character varying, '60491'::character varying, '60534'::character varying, '60569'::character varying, '60572'::character varying, '60593'::character varying, '60641'::character varying, '60647'::character varying]::text[]);

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_habillage_txt_cclo IS 'Vue géographique des habillages textuels PLU filtrée sur les communes de la CCLO pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLUi CCLO';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_txt_cclo OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_txt_cclo TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_txt_cclo TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_txt_cclo TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_txt_cclo TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_habillage_txt_cclo TO sig_edit;

-- ####################################################### VUE - geo_v_p_info_lin_arc ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_info_lin_arc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_info_lin_arc
AS SELECT geo_p_info_lin.idinf,
    lt_typeinf.valeur AS libelle,
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
    "right"(geo_p_info_lin.idurba::text, 8) AS l_datappro,
    geo_p_info_lin.datvalid,
    geo_p_info_lin.geom
   FROM m_urbanisme_doc_v2024.geo_p_info_lin,
    m_urbanisme_doc_v2024.lt_typeinf
  WHERE (geo_p_info_lin.typeinf::text || geo_p_info_lin.stypeinf::text) = (lt_typeinf.code::text || lt_typeinf.sous_code::text) AND geo_p_info_lin.idurba::text ~~ '200067965%'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_info_lin_arc IS 'Vue géographique des informations linéaires PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_info_lin_arc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_lin_arc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_lin_arc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_lin_arc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_lin_arc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_lin_arc TO sig_edit;

-- ####################################################### VUE - geo_v_p_info_lin_cclo ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_info_lin_cclo source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_info_lin_cclo
AS SELECT geo_p_info_lin.idinf,
    lt_typeinf.valeur AS libelle,
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
    "right"(geo_p_info_lin.idurba::text, 8) AS l_datappro,
    geo_p_info_lin.datvalid,
    geo_p_info_lin.geom
   FROM m_urbanisme_doc_v2024.geo_p_info_lin,
    m_urbanisme_doc_v2024.lt_typeinf
  WHERE (geo_p_info_lin.typeinf::text || geo_p_info_lin.stypeinf::text) = (lt_typeinf.code::text || lt_typeinf.sous_code::text) AND (geo_p_info_lin.l_insee::text = ANY (ARRAY['60025'::character varying, '60032'::character varying, '60064'::character varying, '60072'::character varying, '60145'::character varying, '60167'::character varying, '60171'::character varying, '60184'::character varying, '60188'::character varying, '60305'::character varying, '60324'::character varying, '60438'::character varying, '60445'::character varying, '60491'::character varying, '60534'::character varying, '60569'::character varying, '60572'::character varying, '60593'::character varying, '60641'::character varying, '60647'::character varying]::text[]));

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_info_lin_cclo IS 'Vue géographique des informations linéaires PLU filtrée sur les communes de la CCLO pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLUi CCLO';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_info_lin_cclo OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_lin_cclo TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_lin_cclo TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_lin_cclo TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_lin_cclo TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_lin_cclo TO sig_edit;

-- ####################################################### VUE - geo_v_p_info_pct_arc ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_info_pct_arc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_info_pct_arc
AS SELECT geo_p_info_pct.idinf,
    lt_typeinf.valeur AS libelle,
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
    "right"(geo_p_info_pct.idurba::text, 8) AS l_datappro,
    geo_p_info_pct.datvalid,
    geo_p_info_pct.geom
   FROM m_urbanisme_doc_v2024.geo_p_info_pct,
    m_urbanisme_doc_v2024.lt_typeinf
  WHERE (geo_p_info_pct.typeinf::text || geo_p_info_pct.stypeinf::text) = (lt_typeinf.code::text || lt_typeinf.sous_code::text) AND geo_p_info_pct.idurba::text ~~ '200067965%'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_info_pct_arc IS 'Vue géographique des informations ponctuelles PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_info_pct_arc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_pct_arc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_pct_arc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_pct_arc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_pct_arc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_pct_arc TO sig_edit;


-- ####################################################### VUE - geo_v_p_info_pct_cclo ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_info_pct_cclo source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_info_pct_cclo
AS SELECT geo_p_info_pct.idinf,
    lt_typeinf.valeur AS libelle,
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
    "right"(geo_p_info_pct.idurba::text, 8) AS l_datappro,
    geo_p_info_pct.datvalid,
    geo_p_info_pct.geom
   FROM m_urbanisme_doc_v2024.geo_p_info_pct,
    m_urbanisme_doc_v2024.lt_typeinf
  WHERE (geo_p_info_pct.typeinf::text || geo_p_info_pct.stypeinf::text) = (lt_typeinf.code::text || lt_typeinf.sous_code::text) AND (geo_p_info_pct.l_insee::text = ANY (ARRAY['60025'::character varying, '60032'::character varying, '60064'::character varying, '60072'::character varying, '60145'::character varying, '60167'::character varying, '60171'::character varying, '60184'::character varying, '60188'::character varying, '60305'::character varying, '60324'::character varying, '60438'::character varying, '60445'::character varying, '60491'::character varying, '60534'::character varying, '60569'::character varying, '60572'::character varying, '60593'::character varying, '60641'::character varying, '60647'::character varying]::text[]));

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_info_pct_cclo IS 'Vue géographique des informations ponctuelles PLU filtrée sur les communes de la CCLO pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLUi CCLO';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_info_pct_cclo OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_pct_cclo TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_pct_cclo TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_pct_cclo TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_pct_cclo TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_pct_cclo TO sig_edit;


-- ####################################################### VUE - geo_v_p_info_surf_arc ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_info_surf_arc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_info_surf_arc
AS SELECT geo_p_info_surf.idinf,
    lt_typeinf.valeur AS libelle,
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
    "right"(geo_p_info_surf.idurba::text, 8) AS l_datappro,
    geo_p_info_surf.datvalid,
    geo_p_info_surf.geom,
    geo_p_info_surf.geom1
   FROM m_urbanisme_doc_v2024.geo_p_info_surf,
    m_urbanisme_doc_v2024.lt_typeinf
  WHERE (geo_p_info_surf.typeinf::text || geo_p_info_surf.stypeinf::text) = (lt_typeinf.code::text || lt_typeinf.sous_code::text) AND geo_p_info_surf.idurba::text ~~ '200067965%'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_info_surf_arc IS 'Vue géographique des informations surfaciques PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_info_surf_arc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_surf_arc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_surf_arc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_surf_arc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_surf_arc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_surf_arc TO sig_edit;


-- ####################################################### VUE - geo_v_p_info_surf_cclo ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_info_surf_cclo source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_info_surf_cclo
AS SELECT geo_p_info_surf.idinf,
    lt_typeinf.valeur AS libelle,
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
    "right"(geo_p_info_surf.idurba::text, 8) AS l_datappro,
    geo_p_info_surf.datvalid,
    geo_p_info_surf.geom,
    geo_p_info_surf.geom1
   FROM m_urbanisme_doc_v2024.geo_p_info_surf,
    m_urbanisme_doc_v2024.lt_typeinf
  WHERE (geo_p_info_surf.typeinf::text || geo_p_info_surf.stypeinf::text) = (lt_typeinf.code::text || lt_typeinf.sous_code::text) AND (geo_p_info_surf.l_insee::text = ANY (ARRAY['60025'::character varying, '60032'::character varying, '60064'::character varying, '60072'::character varying, '60145'::character varying, '60167'::character varying, '60171'::character varying, '60184'::character varying, '60188'::character varying, '60305'::character varying, '60324'::character varying, '60438'::character varying, '60445'::character varying, '60491'::character varying, '60534'::character varying, '60569'::character varying, '60572'::character varying, '60593'::character varying, '60641'::character varying, '60647'::character varying]::text[]));

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_info_surf_cclo IS 'Vue géographique des informations surfaciques PLU filtrée sur les communes de la CCLO pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLUi CCLO';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_info_surf_cclo OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_surf_cclo TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_surf_cclo TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_surf_cclo TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_surf_cclo TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_info_surf_cclo TO sig_edit;



-- ####################################################### VUE - geo_v_p_prescription_lin_arc ##################################################
-- m_urbanisme_doc_v2024.geo_v_p_prescription_lin_arc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_prescription_lin_arc
AS SELECT geo_p_prescription_lin.idpsc,
    lt_typepsc.valeur AS libelle,
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
    "right"(geo_p_prescription_lin.idurba::text, 8) AS l_datappro,
    geo_p_prescription_lin.datvalid,
    geo_p_prescription_lin.geom,
    geo_p_prescription_lin.geom1
   FROM m_urbanisme_doc_v2024.geo_p_prescription_lin,
    m_urbanisme_doc_v2024.lt_typepsc
  WHERE (geo_p_prescription_lin.typepsc::text || geo_p_prescription_lin.stypepsc::text) = (lt_typepsc.code::text || lt_typepsc.sous_code::text) AND geo_p_prescription_lin.idurba::text ~~ '200067965%'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_prescription_lin_arc IS 'Vue géographique des prescriptions linéaires PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_lin_arc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_lin_arc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_lin_arc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_lin_arc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_lin_arc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_lin_arc TO sig_edit;

-- ####################################################### VUE - geo_v_p_prescription_lin_cclo ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_prescription_lin_cclo source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_prescription_lin_cclo
AS SELECT geo_p_prescription_lin.idpsc,
    lt_typepsc.valeur AS libelle,
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
    "right"(geo_p_prescription_lin.idurba::text, 8) AS l_datappro,
    geo_p_prescription_lin.datvalid,
    geo_p_prescription_lin.geom,
    geo_p_prescription_lin.geom1
   FROM m_urbanisme_doc_v2024.geo_p_prescription_lin,
    m_urbanisme_doc_v2024.lt_typepsc
  WHERE (geo_p_prescription_lin.typepsc::text || geo_p_prescription_lin.stypepsc::text) = (lt_typepsc.code::text || lt_typepsc.sous_code::text) AND (geo_p_prescription_lin.l_insee::text = ANY (ARRAY['60025'::character varying, '60032'::character varying, '60064'::character varying, '60072'::character varying, '60145'::character varying, '60167'::character varying, '60171'::character varying, '60184'::character varying, '60188'::character varying, '60305'::character varying, '60324'::character varying, '60438'::character varying, '60445'::character varying, '60491'::character varying, '60534'::character varying, '60569'::character varying, '60572'::character varying, '60593'::character varying, '60641'::character varying, '60647'::character varying]::text[]));

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_prescription_lin_cclo IS 'Vue géographique des prescriptions linéaires PLU filtrée sur les communes de la CCLO pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLUi CCLO';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_lin_cclo OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_lin_cclo TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_lin_cclo TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_lin_cclo TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_lin_cclo TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_lin_cclo TO sig_edit;

-- ####################################################### VUE - geo_v_p_prescription_pct_arc ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_prescription_pct_arc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_prescription_pct_arc
AS SELECT geo_p_prescription_pct.idpsc,
    lt_typepsc.valeur AS libelle,
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
    "right"(geo_p_prescription_pct.idurba::text, 8) AS l_datappro,
    geo_p_prescription_pct.datvalid,
    geo_p_prescription_pct.geom
   FROM m_urbanisme_doc_v2024.geo_p_prescription_pct,
    m_urbanisme_doc_v2024.lt_typepsc
  WHERE (geo_p_prescription_pct.typepsc::text || geo_p_prescription_pct.stypepsc::text) = (lt_typepsc.code::text || lt_typepsc.sous_code::text) AND geo_p_prescription_pct.idurba::text ~~ '200067965%'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_prescription_pct_arc IS 'Vue géographique des prescriptions ponctuelles PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_pct_arc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_pct_arc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_pct_arc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_pct_arc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_pct_arc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_pct_arc TO sig_edit;


-- ####################################################### VUE - geo_v_p_prescription_pct_cclo ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_prescription_pct_cclo source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_prescription_pct_cclo
AS SELECT geo_p_prescription_pct.idpsc,
    lt_typepsc.valeur AS libelle,
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
    "right"(geo_p_prescription_pct.idurba::text, 8) AS l_datappro,
    geo_p_prescription_pct.datvalid,
    geo_p_prescription_pct.geom
   FROM m_urbanisme_doc_v2024.geo_p_prescription_pct,
    m_urbanisme_doc_v2024.lt_typepsc
  WHERE (geo_p_prescription_pct.typepsc::text || geo_p_prescription_pct.stypepsc::text) = (lt_typepsc.code::text || lt_typepsc.sous_code::text) AND (geo_p_prescription_pct.l_insee::text = ANY (ARRAY['60025'::character varying, '60032'::character varying, '60064'::character varying, '60072'::character varying, '60145'::character varying, '60167'::character varying, '60171'::character varying, '60184'::character varying, '60188'::character varying, '60305'::character varying, '60324'::character varying, '60438'::character varying, '60445'::character varying, '60491'::character varying, '60534'::character varying, '60569'::character varying, '60572'::character varying, '60593'::character varying, '60641'::character varying, '60647'::character varying]::text[]));

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_prescription_pct_cclo IS 'Vue géographique des prescriptions ponctuelles PLU filtrée sur les communes de la CCLO pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLUi CCLO';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_pct_cclo OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_pct_cclo TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_pct_cclo TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_pct_cclo TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_pct_cclo TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_pct_cclo TO sig_edit;


-- ####################################################### VUE - geo_v_p_prescription_surf_arc ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_prescription_surf_arc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_prescription_surf_arc
AS SELECT geo_p_prescription_surf.idpsc,
    lt_typepsc.valeur AS libelle,
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
    "right"(geo_p_prescription_surf.idurba::text, 8) AS l_datappro,
    geo_p_prescription_surf.datvalid,
    geo_p_prescription_surf.geom,
    geo_p_prescription_surf.geom1
   FROM m_urbanisme_doc_v2024.geo_p_prescription_surf,
    m_urbanisme_doc_v2024.lt_typepsc
  WHERE (geo_p_prescription_surf.typepsc::text || geo_p_prescription_surf.stypepsc::text) = (lt_typepsc.code::text || lt_typepsc.sous_code::text) AND geo_p_prescription_surf.idurba::text ~~ '200067965%'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_prescription_surf_arc IS 'Vue géographique des prescriptions surfaciques PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_surf_arc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_surf_arc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_surf_arc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_surf_arc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_surf_arc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_surf_arc TO sig_edit;

-- ####################################################### VUE - geo_v_p_prescription_surf_cclo ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_prescription_surf_cclo source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_prescription_surf_cclo
AS SELECT geo_p_prescription_surf.idpsc,
    lt_typepsc.valeur AS libelle,
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
    "right"(geo_p_prescription_surf.idurba::text, 8) AS l_datappro,
    geo_p_prescription_surf.datvalid,
    geo_p_prescription_surf.geom,
    geo_p_prescription_surf.geom1
   FROM m_urbanisme_doc_v2024.geo_p_prescription_surf,
    m_urbanisme_doc_v2024.lt_typepsc
  WHERE (geo_p_prescription_surf.typepsc::text || geo_p_prescription_surf.stypepsc::text) = (lt_typepsc.code::text || lt_typepsc.sous_code::text) AND (geo_p_prescription_surf.l_insee::text = ANY (ARRAY['60025'::character varying, '60032'::character varying, '60064'::character varying, '60072'::character varying, '60145'::character varying, '60167'::character varying, '60171'::character varying, '60184'::character varying, '60188'::character varying, '60305'::character varying, '60324'::character varying, '60438'::character varying, '60445'::character varying, '60491'::character varying, '60534'::character varying, '60569'::character varying, '60572'::character varying, '60593'::character varying, '60641'::character varying, '60647'::character varying]::text[]));

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_prescription_surf_cclo IS 'Vue géographique des prescriptions surfaciques PLU filtrée sur les communes de la CCLO pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLUi CCLO';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_surf_cclo OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_surf_cclo TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_surf_cclo TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_surf_cclo TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_surf_cclo TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_prescription_surf_cclo TO sig_edit;

-- ####################################################### VUE - geo_v_p_zone_urba_arc ##################################################


-- m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc
AS SELECT geo_p_zone_urba.idzone,
    geo_p_zone_urba.libelle,
    geo_p_zone_urba.libelong,
    geo_p_zone_urba.typezone,
    geo_p_zone_urba.idurba,
    geo_p_zone_urba.formdomi,
    geo_p_zone_urba.destoui,
    geo_p_zone_urba.destcdt,
    geo_p_zone_urba.destnon,
    geo_p_zone_urba.l_surf_cal,
    geo_p_zone_urba.l_observ,
    geo_p_zone_urba.nomfic,
    geo_p_zone_urba.l_nomfic,
    geo_p_zone_urba.urlfic,
    geo_p_zone_urba.l_urlfic,
    geo_p_zone_urba.l_insee,
    "right"(geo_p_zone_urba.idurba::text, 8) AS l_datappro,
    geo_p_zone_urba.datvalid,
    geo_p_zone_urba.typesect,
    geo_p_zone_urba.fermreco,
    geo_p_zone_urba.geom,
    geo_p_zone_urba.geom1
   FROM m_urbanisme_doc_v2024.geo_p_zone_urba
  WHERE geo_p_zone_urba.idurba::text ~~ '200067965%'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc IS 'Vue géographique des zonages PLU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLU Interactif';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc TO sig_edit;

-- ####################################################### VUE - geo_v_p_zone_urba_arc_au ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc_au source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc_au
AS SELECT geo_p_zone_urba.idzone,
    geo_p_zone_urba.libelle,
    geo_p_zone_urba.libelong,
    geo_p_zone_urba.typezone,
    geo_p_zone_urba.idurba,
    geo_p_zone_urba.formdomi,
    geo_p_zone_urba.destoui,
    geo_p_zone_urba.destcdt,
    geo_p_zone_urba.destnon,
    geo_p_zone_urba.l_surf_cal,
    geo_p_zone_urba.l_observ,
    geo_p_zone_urba.nomfic,
    geo_p_zone_urba.l_nomfic,
    geo_p_zone_urba.urlfic,
    geo_p_zone_urba.l_urlfic,
    geo_p_zone_urba.l_insee,
    "right"(geo_p_zone_urba.idurba::text, 8) AS l_datappro,
    geo_p_zone_urba.datvalid,
    geo_p_zone_urba.typesect,
    geo_p_zone_urba.fermreco,
    geo_p_zone_urba.geom,
    geo_p_zone_urba.geom1
   FROM m_urbanisme_doc_v2024.geo_p_zone_urba
  WHERE geo_p_zone_urba.idurba::text ~~ '200067965%'::text AND geo_p_zone_urba.typezone::text ~~ 'AU%'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc_au IS 'Vue géographique des zonages AU filtrée sur les communes de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLUi Travail';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc_au OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc_au TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc_au TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc_au TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc_au TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc_au TO sig_edit;

-- ####################################################### VUE - geo_v_p_zone_urba_cclo ##################################################

-- m_urbanisme_doc_v2024.geo_v_p_zone_urba_cclo source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_p_zone_urba_cclo
AS SELECT geo_p_zone_urba.idzone,
    geo_p_zone_urba.libelle,
    geo_p_zone_urba.libelong,
    geo_p_zone_urba.typezone,
    geo_p_zone_urba.idurba,
    geo_p_zone_urba.formdomi,
    geo_p_zone_urba.destoui,
    geo_p_zone_urba.destcdt,
    geo_p_zone_urba.destnon,
    geo_p_zone_urba.l_surf_cal,
    geo_p_zone_urba.l_observ,
    geo_p_zone_urba.nomfic,
    geo_p_zone_urba.l_nomfic,
    geo_p_zone_urba.urlfic,
    geo_p_zone_urba.l_urlfic,
    geo_p_zone_urba.l_insee,
    "right"(geo_p_zone_urba.idurba::text, 8) AS l_datappro,
    geo_p_zone_urba.datvalid,
    geo_p_zone_urba.typesect,
    geo_p_zone_urba.fermreco,
    geo_p_zone_urba.geom,
    geo_p_zone_urba.geom1
   FROM m_urbanisme_doc_v2024.geo_p_zone_urba
  WHERE geo_p_zone_urba.l_insee::text = ANY (ARRAY['60025'::character varying, '60032'::character varying, '60064'::character varying, '60072'::character varying, '60145'::character varying, '60167'::character varying, '60171'::character varying, '60184'::character varying, '60188'::character varying, '60305'::character varying, '60324'::character varying, '60438'::character varying, '60445'::character varying, '60491'::character varying, '60534'::character varying, '60569'::character varying, '60572'::character varying, '60593'::character varying, '60641'::character varying, '60647'::character varying]::text[]);

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_p_zone_urba_cclo IS 'Vue géographique des zonages PLU filtrée sur les communes de la CCLO pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l''application PLUi CCLO';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_cclo OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_cclo TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_cclo TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_cclo TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_cclo TO sig_read;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_p_zone_urba_cclo TO sig_edit;

-- ####################################################### VUE - geo_v_t_habillage_lin_cc2v ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_habillage_lin_cc2v source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_lin_cc2v
AS SELECT geo_t_habillage_lin.idhab,
    geo_t_habillage_lin.nattrac,
    geo_t_habillage_lin.idurba,
    geo_t_habillage_lin.l_insee,
    "right"(geo_t_habillage_lin.idurba::text, 8) AS l_datappro,
    geo_t_habillage_lin.geom
   FROM m_urbanisme_doc_v2024.geo_t_habillage_lin
  WHERE geo_t_habillage_lin.l_insee::text = ANY (ARRAY['60043'::text, '60119'::text, '60147'::text, '60150'::text, '60368'::text, '60373'::text, '60378'::text, '60392'::text, '60423'::text, '60492'::text, '60501'::text, '60537'::text, '60582'::text, '60636'::text, '60642'::text, '60654'::text]);

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_lin_cc2v IS 'Vue géographique des habillages linéaires en mode test des PLU de la CC2V';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_lin_cc2v OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_lin_cc2v TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_lin_cc2v TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_lin_cc2v TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_lin_cc2v TO sig_read;

-- ####################################################### VUE - geo_v_t_habillage_lin_pluiarc ##################################################
-- m_urbanisme_doc_v2024.geo_v_t_habillage_lin_pluiarc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_lin_pluiarc
AS SELECT geo_t_habillage_lin.idhab,
    geo_t_habillage_lin.nattrac,
    geo_t_habillage_lin.idurba,
    geo_t_habillage_lin.l_insee,
    "right"(geo_t_habillage_lin.idurba::text, 8) AS l_datappro,
    geo_t_habillage_lin.geom
   FROM m_urbanisme_doc_v2024.geo_t_habillage_lin
  WHERE geo_t_habillage_lin.idurba::text = '200067965_PLUI_20220701'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_lin_pluiarc IS 'Vue géographique des habillages linéaires en mode test du PLUi de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_lin_pluiarc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_lin_pluiarc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_lin_pluiarc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_lin_pluiarc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_lin_pluiarc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_lin_pluiarc TO sig_edit;

-- ####################################################### VUE - geo_v_t_habillage_pct_cc2v ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_habillage_pct_cc2v source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_pct_cc2v
AS SELECT geo_t_habillage_pct.idhab,
    geo_t_habillage_pct.nattrac,
    geo_t_habillage_pct.couleur,
    geo_t_habillage_pct.idurba,
    geo_t_habillage_pct.l_insee,
    "right"(geo_t_habillage_pct.idurba::text, 8) AS l_datappro,
    geo_t_habillage_pct.geom
   FROM m_urbanisme_doc_v2024.geo_t_habillage_pct
  WHERE geo_t_habillage_pct.l_insee::text = ANY (ARRAY['60043'::text, '60119'::text, '60147'::text, '60150'::text, '60368'::text, '60373'::text, '60378'::text, '60392'::text, '60423'::text, '60492'::text, '60501'::text, '60537'::text, '60582'::text, '60636'::text, '60642'::text, '60654'::text]);

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_pct_cc2v IS 'Vue géographique des habillages ponctuels en mode test des PLU de la CC2V';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_pct_cc2v OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_pct_cc2v TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_pct_cc2v TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_pct_cc2v TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_pct_cc2v TO sig_read;

-- ####################################################### VUE - geo_v_t_habillage_pct_pluiarc ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_habillage_pct_pluiarc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_pct_pluiarc
AS SELECT geo_t_habillage_pct.idhab,
    geo_t_habillage_pct.nattrac,
    geo_t_habillage_pct.couleur,
    geo_t_habillage_pct.idurba,
    geo_t_habillage_pct.l_insee,
    "right"(geo_t_habillage_pct.idurba::text, 8) AS l_datappro,
    geo_t_habillage_pct.geom
   FROM m_urbanisme_doc_v2024.geo_t_habillage_pct
  WHERE geo_t_habillage_pct.idurba::text = '200067965_PLUI_20220701'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_pct_pluiarc IS 'Vue géographique des habillages ponctuels en mode test du PLUi de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_pct_pluiarc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_pct_pluiarc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_pct_pluiarc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_pct_pluiarc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_pct_pluiarc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_pct_pluiarc TO sig_edit;


-- ####################################################### VUE - geo_v_t_habillage_surf_cc2v ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_habillage_surf_cc2v source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_surf_cc2v
AS SELECT geo_t_habillage_surf.idhab,
    geo_t_habillage_surf.nattrac,
    geo_t_habillage_surf.couleur,
    geo_t_habillage_surf.idurba,
    geo_t_habillage_surf.l_insee,
    "right"(geo_t_habillage_surf.idurba::text, 8) AS l_datappro,
    geo_t_habillage_surf.geom
   FROM m_urbanisme_doc_v2024.geo_t_habillage_surf
  WHERE geo_t_habillage_surf.l_insee::text = ANY (ARRAY['60043'::text, '60119'::text, '60147'::text, '60150'::text, '60368'::text, '60373'::text, '60378'::text, '60392'::text, '60423'::text, '60492'::text, '60501'::text, '60537'::text, '60582'::text, '60636'::text, '60642'::text, '60654'::text]);

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_surf_cc2v IS 'Vue géographique des habillages surfaciques en mode test des PLU de la CC2V';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_surf_cc2v OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_surf_cc2v TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_surf_cc2v TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_surf_cc2v TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_surf_cc2v TO sig_read;


-- ####################################################### VUE - geo_v_t_habillage_surf_pluiarc ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_habillage_surf_pluiarc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_surf_pluiarc
AS SELECT geo_t_habillage_surf.idhab,
    geo_t_habillage_surf.nattrac,
    geo_t_habillage_surf.couleur,
    geo_t_habillage_surf.idurba,
    geo_t_habillage_surf.l_insee,
    "right"(geo_t_habillage_surf.idurba::text, 8) AS l_datappro,
    geo_t_habillage_surf.geom
   FROM m_urbanisme_doc_v2024.geo_t_habillage_surf
  WHERE geo_t_habillage_surf.idurba::text = '200067965_PLUI_20220701'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_surf_pluiarc IS 'Vue géographique des habillages surfaciques en mode test du PLUi de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_surf_pluiarc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_surf_pluiarc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_surf_pluiarc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_surf_pluiarc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_surf_pluiarc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_surf_pluiarc TO sig_edit;

-- ####################################################### VUE - geo_v_t_habillage_txt_cc2v ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_habillage_txt_cc2v source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_txt_cc2v
AS SELECT geo_t_habillage_txt.idhab,
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
    "right"(geo_t_habillage_txt.idurba::text, 8) AS l_datappro,
    geo_t_habillage_txt.geom
   FROM m_urbanisme_doc_v2024.geo_t_habillage_txt
  WHERE geo_t_habillage_txt.l_insee::text = ANY (ARRAY['60043'::text, '60119'::text, '60147'::text, '60150'::text, '60368'::text, '60373'::text, '60378'::text, '60392'::text, '60423'::text, '60492'::text, '60501'::text, '60537'::text, '60582'::text, '60636'::text, '60642'::text, '60654'::text]);

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_txt_cc2v IS 'Vue géographique des habillages textuels en mode test des PLU de la CC2V';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_txt_cc2v OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_txt_cc2v TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_txt_cc2v TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_txt_cc2v TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_txt_cc2v TO sig_read;

-- ####################################################### VUE - geo_v_t_habillage_txt_pluiarc ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_habillage_txt_pluiarc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_txt_pluiarc
AS SELECT geo_t_habillage_txt.idhab,
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
    "right"(geo_t_habillage_txt.idurba::text, 8) AS l_datappro,
    geo_t_habillage_txt.geom
   FROM m_urbanisme_doc_v2024.geo_t_habillage_txt
  WHERE geo_t_habillage_txt.idurba::text = '200067965_PLUI_20220701'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_habillage_txt_pluiarc IS 'Vue géographique des habillages textuels en mode test du PLUi pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_txt_pluiarc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_txt_pluiarc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_txt_pluiarc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_txt_pluiarc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_txt_pluiarc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_habillage_txt_pluiarc TO sig_edit;


-- ####################################################### VUE - geo_v_t_info_lin_cc2v ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_info_lin_cc2v source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_info_lin_cc2v
AS SELECT geo_t_info_lin.idinf,
    lt_typeinf.valeur AS libelle,
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
    "right"(geo_t_info_lin.idurba::text, 8) AS l_datappro,
    geo_t_info_lin.datvalid,
    geo_t_info_lin.geom
   FROM m_urbanisme_doc_v2024.geo_t_info_lin,
    m_urbanisme_doc_v2024.lt_typeinf
  WHERE (geo_t_info_lin.typeinf::text || geo_t_info_lin.stypeinf::text) = (lt_typeinf.code::text || lt_typeinf.sous_code::text) AND (geo_t_info_lin.l_insee::text = ANY (ARRAY['60043'::text, '60119'::text, '60147'::text, '60150'::text, '60368'::text, '60373'::text, '60378'::text, '60392'::text, '60423'::text, '60492'::text, '60501'::text, '60537'::text, '60582'::text, '60636'::text, '60642'::text, '60654'::text]));

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_info_lin_cc2v IS 'Vue géographique des informations linéaires mode test des PLU de la CC2V';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_info_lin_cc2v OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_lin_cc2v TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_lin_cc2v TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_lin_cc2v TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_lin_cc2v TO sig_read;


-- ####################################################### VUE - geo_v_t_info_lin_pluiarc ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_info_lin_pluiarc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_info_lin_pluiarc
AS SELECT geo_t_info_lin.idinf,
    lt_typeinf.valeur AS libelle,
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
    "right"(geo_t_info_lin.idurba::text, 8) AS l_datappro,
    geo_t_info_lin.datvalid,
    geo_t_info_lin.geom
   FROM m_urbanisme_doc_v2024.geo_t_info_lin,
    m_urbanisme_doc_v2024.lt_typeinf
  WHERE (geo_t_info_lin.typeinf::text || geo_t_info_lin.stypeinf::text) = (lt_typeinf.code::text || lt_typeinf.sous_code::text) AND geo_t_info_lin.idurba::text = '200067965_PLUI_20220701'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_info_lin_pluiarc IS 'Vue géographique des informations linéaires mode test du PLUi de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_info_lin_pluiarc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_lin_pluiarc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_lin_pluiarc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_lin_pluiarc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_lin_pluiarc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_lin_pluiarc TO sig_edit;


-- ####################################################### VUE - geo_v_t_info_pct_cc2v ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_info_pct_cc2v source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_info_pct_cc2v
AS SELECT geo_t_info_pct.idinf,
    lt_typeinf.valeur AS libelle,
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
    "right"(geo_t_info_pct.idurba::text, 8) AS l_datappro,
    geo_t_info_pct.datvalid,
    geo_t_info_pct.geom
   FROM m_urbanisme_doc_v2024.geo_t_info_pct,
    m_urbanisme_doc_v2024.lt_typeinf
  WHERE (geo_t_info_pct.typeinf::text || geo_t_info_pct.stypeinf::text) = (lt_typeinf.code::text || lt_typeinf.sous_code::text) AND (geo_t_info_pct.l_insee::text = ANY (ARRAY['60043'::text, '60119'::text, '60147'::text, '60150'::text, '60368'::text, '60373'::text, '60378'::text, '60392'::text, '60423'::text, '60492'::text, '60501'::text, '60537'::text, '60582'::text, '60636'::text, '60642'::text, '60654'::text]));

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_info_pct_cc2v IS 'Vue géographique des informations ponctuelles en mode test des PLU de la CC2V';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_info_pct_cc2v OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_pct_cc2v TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_pct_cc2v TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_pct_cc2v TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_pct_cc2v TO sig_read;

-- ####################################################### VUE - geo_v_t_info_pct_pluiarc ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_info_pct_pluiarc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_info_pct_pluiarc
AS SELECT geo_t_info_pct.idinf,
    lt_typeinf.valeur AS libelle,
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
    "right"(geo_t_info_pct.idurba::text, 8) AS l_datappro,
    geo_t_info_pct.datvalid,
    geo_t_info_pct.geom
   FROM m_urbanisme_doc_v2024.geo_t_info_pct,
    m_urbanisme_doc_v2024.lt_typeinf
  WHERE (geo_t_info_pct.typeinf::text || geo_t_info_pct.stypeinf::text) = (lt_typeinf.code::text || lt_typeinf.sous_code::text) AND geo_t_info_pct.idurba::text = '200067965_PLUI_20220701'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_info_pct_pluiarc IS 'Vue géographique des informations ponctuelles en mode test du PLUi de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_info_pct_pluiarc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_pct_pluiarc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_pct_pluiarc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_pct_pluiarc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_pct_pluiarc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_pct_pluiarc TO sig_edit;

-- ####################################################### VUE - geo_v_t_info_surf_cc2v ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_info_surf_cc2v source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_info_surf_cc2v
AS SELECT geo_t_info_surf.idinf,
    lt_typeinf.valeur AS libelle,
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
    "right"(geo_t_info_surf.idurba::text, 8) AS l_datappro,
    geo_t_info_surf.datvalid,
    geo_t_info_surf.geom,
    geo_t_info_surf.geom1
   FROM m_urbanisme_doc_v2024.geo_t_info_surf,
    m_urbanisme_doc_v2024.lt_typeinf
  WHERE (geo_t_info_surf.typeinf::text || geo_t_info_surf.stypeinf::text) = (lt_typeinf.code::text || lt_typeinf.sous_code::text) AND (geo_t_info_surf.l_insee::text = ANY (ARRAY['60043'::text, '60119'::text, '60147'::text, '60150'::text, '60368'::text, '60373'::text, '60378'::text, '60392'::text, '60423'::text, '60492'::text, '60501'::text, '60537'::text, '60582'::text, '60636'::text, '60642'::text, '60654'::text]));

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_info_surf_cc2v IS 'Vue géographique des informations surfaciques en mode test des PLU de la CC2V';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_info_surf_cc2v OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_surf_cc2v TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_surf_cc2v TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_surf_cc2v TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_surf_cc2v TO sig_read;

-- ####################################################### VUE - geo_v_t_info_surf_pluiarc ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_info_surf_pluiarc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_info_surf_pluiarc
AS SELECT geo_t_info_surf.idinf,
    lt_typeinf.valeur AS libelle,
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
    "right"(geo_t_info_surf.idurba::text, 8) AS l_datappro,
    geo_t_info_surf.datvalid,
    geo_t_info_surf.geom,
    geo_t_info_surf.geom1
   FROM m_urbanisme_doc_v2024.geo_t_info_surf,
    m_urbanisme_doc_v2024.lt_typeinf
  WHERE (geo_t_info_surf.typeinf::text || geo_t_info_surf.stypeinf::text) = (lt_typeinf.code::text || lt_typeinf.sous_code::text) AND geo_t_info_surf.idurba::text = '200067965_PLUI_20220701'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_info_surf_pluiarc IS 'Vue géographique des informations surfaciques en mode test du PLUi de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_info_surf_pluiarc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_surf_pluiarc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_surf_pluiarc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_surf_pluiarc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_surf_pluiarc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_info_surf_pluiarc TO sig_edit;


-- ####################################################### VUE - geo_v_t_prescription_lin_cc2v ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_prescription_lin_cc2v source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_prescription_lin_cc2v
AS SELECT geo_t_prescription_lin.idpsc,
    lt_typepsc.valeur AS libelle,
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
    "right"(geo_t_prescription_lin.idurba::text, 8) AS l_datappro,
    geo_t_prescription_lin.datvalid,
    geo_t_prescription_lin.geom,
    geo_t_prescription_lin.geom1
   FROM m_urbanisme_doc_v2024.geo_t_prescription_lin,
    m_urbanisme_doc_v2024.lt_typepsc
  WHERE (geo_t_prescription_lin.typepsc::text || geo_t_prescription_lin.stypepsc::text) = (lt_typepsc.code::text || lt_typepsc.sous_code::text) AND (geo_t_prescription_lin.l_insee::text = ANY (ARRAY['60043'::text, '60119'::text, '60147'::text, '60150'::text, '60368'::text, '60373'::text, '60378'::text, '60392'::text, '60423'::text, '60492'::text, '60501'::text, '60537'::text, '60582'::text, '60636'::text, '60642'::text, '60654'::text]));

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_prescription_lin_cc2v IS 'Vue géographique des prescriptions linéaires en mode test des PLU de la CC2V';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_lin_cc2v OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_lin_cc2v TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_lin_cc2v TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_lin_cc2v TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_lin_cc2v TO sig_read;

-- ####################################################### VUE - geo_v_t_prescription_lin_pluiarc ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_prescription_lin_pluiarc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_prescription_lin_pluiarc
AS SELECT geo_t_prescription_lin.idpsc,
    lt_typepsc.valeur AS libelle,
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
    "right"(geo_t_prescription_lin.idurba::text, 8) AS l_datappro,
    geo_t_prescription_lin.datvalid,
    geo_t_prescription_lin.geom,
    geo_t_prescription_lin.geom1
   FROM m_urbanisme_doc_v2024.geo_t_prescription_lin,
    m_urbanisme_doc_v2024.lt_typepsc
  WHERE (geo_t_prescription_lin.typepsc::text || geo_t_prescription_lin.stypepsc::text) = (lt_typepsc.code::text || lt_typepsc.sous_code::text) AND geo_t_prescription_lin.idurba::text = '200067965_PLUI_20220701'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_prescription_lin_pluiarc IS 'Vue géographique des prescriptions linéaires en mode test du PLUi l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_lin_pluiarc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_lin_pluiarc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_lin_pluiarc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_lin_pluiarc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_lin_pluiarc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_lin_pluiarc TO sig_edit;


-- ####################################################### VUE - geo_v_t_prescription_pct_cc2v ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_prescription_pct_cc2v source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_prescription_pct_cc2v
AS SELECT geo_t_prescription_pct.idpsc,
    lt_typepsc.valeur AS libelle,
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
    "right"(geo_t_prescription_pct.idurba::text, 8) AS l_datappro,
    geo_t_prescription_pct.datvalid,
    geo_t_prescription_pct.geom
   FROM m_urbanisme_doc_v2024.geo_t_prescription_pct,
    m_urbanisme_doc_v2024.lt_typepsc
  WHERE (geo_t_prescription_pct.typepsc::text || geo_t_prescription_pct.stypepsc::text) = (lt_typepsc.code::text || lt_typepsc.sous_code::text) AND (geo_t_prescription_pct.l_insee::text = ANY (ARRAY['60043'::text, '60119'::text, '60147'::text, '60150'::text, '60368'::text, '60373'::text, '60378'::text, '60392'::text, '60423'::text, '60492'::text, '60501'::text, '60537'::text, '60582'::text, '60636'::text, '60642'::text, '60654'::text]));

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_prescription_pct_cc2v IS 'Vue géographique des prescriptions ponctuelles en mode test des PLU de la CC2V';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_pct_cc2v OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_pct_cc2v TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_pct_cc2v TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_pct_cc2v TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_pct_cc2v TO sig_read;


-- ####################################################### VUE - geo_v_t_prescription_pct_pluiarc ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_prescription_pct_pluiarc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_prescription_pct_pluiarc
AS SELECT geo_t_prescription_pct.idpsc,
    lt_typepsc.valeur AS libelle,
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
    "right"(geo_t_prescription_pct.idurba::text, 8) AS l_datappro,
    geo_t_prescription_pct.datvalid,
    geo_t_prescription_pct.geom
   FROM m_urbanisme_doc_v2024.geo_t_prescription_pct,
    m_urbanisme_doc_v2024.lt_typepsc
  WHERE (geo_t_prescription_pct.typepsc::text || geo_t_prescription_pct.stypepsc::text) = (lt_typepsc.code::text || lt_typepsc.sous_code::text) AND geo_t_prescription_pct.idurba::text = '200067965_PLUI_20220701'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_prescription_pct_pluiarc IS 'Vue géographique des prescriptions ponctuelles en mode test du PLUide l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_pct_pluiarc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_pct_pluiarc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_pct_pluiarc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_pct_pluiarc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_pct_pluiarc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_pct_pluiarc TO sig_edit;

-- ####################################################### VUE - geo_v_t_prescription_surf_cc2v ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_prescription_surf_cc2v source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_prescription_surf_cc2v
AS SELECT geo_t_prescription_surf.idpsc,
    lt_typepsc.valeur AS libelle,
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
    "right"(geo_t_prescription_surf.idurba::text, 8) AS l_datappro,
    geo_t_prescription_surf.datvalid,
    geo_t_prescription_surf.geom,
    geo_t_prescription_surf.geom1
   FROM m_urbanisme_doc_v2024.geo_t_prescription_surf,
    m_urbanisme_doc_v2024.lt_typepsc
  WHERE (geo_t_prescription_surf.typepsc::text || geo_t_prescription_surf.stypepsc::text) = (lt_typepsc.code::text || lt_typepsc.sous_code::text) AND (geo_t_prescription_surf.l_insee::text = ANY (ARRAY['60043'::text, '60119'::text, '60147'::text, '60150'::text, '60368'::text, '60373'::text, '60378'::text, '60392'::text, '60423'::text, '60492'::text, '60501'::text, '60537'::text, '60582'::text, '60636'::text, '60642'::text, '60654'::text]));

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_prescription_surf_cc2v IS 'Vue géographique des prescriptions surfaciques en mode test des PLU de la CC2V';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_surf_cc2v OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_surf_cc2v TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_surf_cc2v TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_surf_cc2v TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_surf_cc2v TO sig_read;

-- ####################################################### VUE - geo_v_t_prescription_surf_pluiarc ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_prescription_surf_pluiarc source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_prescription_surf_pluiarc
AS SELECT geo_t_prescription_surf.idpsc,
    lt_typepsc.valeur AS libelle,
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
    "right"(geo_t_prescription_surf.idurba::text, 8) AS l_datappro,
    geo_t_prescription_surf.datvalid,
    geo_t_prescription_surf.geom,
    geo_t_prescription_surf.geom1
   FROM m_urbanisme_doc_v2024.geo_t_prescription_surf,
    m_urbanisme_doc_v2024.lt_typepsc
  WHERE (geo_t_prescription_surf.typepsc::text || geo_t_prescription_surf.stypepsc::text) = (lt_typepsc.code::text || lt_typepsc.sous_code::text) AND geo_t_prescription_surf.idurba::text = '200067965_PLUI_20220701'::text;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_prescription_surf_pluiarc IS 'Vue géographique des prescriptions surfaciques en mode test du PLUi de l''ARC pour la création du flux GeoServer DocUrba_ARC utilisée dans l''application PLUi';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_surf_pluiarc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_surf_pluiarc TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_surf_pluiarc TO slazarescu;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_surf_pluiarc TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_surf_pluiarc TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_prescription_surf_pluiarc TO sig_edit;

-- ####################################################### VUE - geo_v_t_prescription_pct_pluiarc ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v
AS SELECT geo_t_zone_urba.idzone,
    geo_t_zone_urba.libelle,
    geo_t_zone_urba.libelong,
    geo_t_zone_urba.typezone,
    geo_t_zone_urba.idurba,
    geo_t_zone_urba.formdomi,
    geo_t_zone_urba.destoui,
    geo_t_zone_urba.destcdt,
    geo_t_zone_urba.destnon,
    geo_t_zone_urba.l_surf_cal,
    geo_t_zone_urba.l_observ,
    geo_t_zone_urba.nomfic,
    geo_t_zone_urba.l_urlfic,
    geo_t_zone_urba.urlfic,
    geo_t_zone_urba.l_insee,
    "right"(geo_t_zone_urba.idurba::text, 8) AS l_datappro,
    geo_t_zone_urba.datvalid,
    geo_t_zone_urba.geom,
    geo_t_zone_urba.typesect,
    geo_t_zone_urba.fermreco
   FROM m_urbanisme_doc_v2024.geo_t_zone_urba
  WHERE geo_t_zone_urba.l_insee::text = ANY (ARRAY['60043'::character varying, '60119'::character varying, '60147'::character varying, '60150'::character varying, '60368'::character varying, '60373'::character varying, '60378'::character varying, '60392'::character varying, '60423'::character varying, '60492'::character varying, '60501'::character varying, '60537'::character varying, '60582'::character varying, '60636'::character varying, '60642'::character varying, '60654'::character varying]::text[]);

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v IS 'Vue géographique des zonages PLU en mode test la CC2V';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v TO sig_read;


-- ####################################################### VUE - geo_v_t_zone_urba_cc2v ##################################################

-- m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v
AS SELECT geo_t_zone_urba.idzone,
    geo_t_zone_urba.libelle,
    geo_t_zone_urba.libelong,
    geo_t_zone_urba.typezone,
    geo_t_zone_urba.idurba,
    geo_t_zone_urba.formdomi,
    geo_t_zone_urba.destoui,
    geo_t_zone_urba.destcdt,
    geo_t_zone_urba.destnon,
    geo_t_zone_urba.l_surf_cal,
    geo_t_zone_urba.l_observ,
    geo_t_zone_urba.nomfic,
    geo_t_zone_urba.l_urlfic,
    geo_t_zone_urba.urlfic,
    geo_t_zone_urba.l_insee,
    "right"(geo_t_zone_urba.idurba::text, 8) AS l_datappro,
    geo_t_zone_urba.datvalid,
    geo_t_zone_urba.geom,
    geo_t_zone_urba.typesect,
    geo_t_zone_urba.fermreco
   FROM m_urbanisme_doc_v2024.geo_t_zone_urba
  WHERE geo_t_zone_urba.l_insee::text = ANY (ARRAY['60043'::character varying, '60119'::character varying, '60147'::character varying, '60150'::character varying, '60368'::character varying, '60373'::character varying, '60378'::character varying, '60392'::character varying, '60423'::character varying, '60492'::character varying, '60501'::character varying, '60537'::character varying, '60582'::character varying, '60636'::character varying, '60642'::character varying, '60654'::character varying]::text[]);

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v IS 'Vue géographique des zonages PLU en mode test la CC2V';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_t_zone_urba_cc2v TO sig_read;

-- ####################################################### VUE - geo_v_urbreg_ads_commune ##################################################


-- m_urbanisme_doc_v2024.geo_v_urbreg_ads_commune source

CREATE OR REPLACE VIEW m_urbanisme_doc_v2024.geo_v_urbreg_ads_commune
AS SELECT c.commune,
    a.insee,
    a.docurba,
    a.ads_arc,
    c.lib_epci,
    c.geom
   FROM r_osm.geo_vm_osm_commune_apc c
     JOIN m_urbanisme_doc_v2024.an_ads_commune a ON a.insee = c.insee::bpchar
  ORDER BY a.insee;

COMMENT ON VIEW m_urbanisme_doc_v2024.geo_v_urbreg_ads_commune IS 'Vue géographique sur l''état de l''ADS par l''ARC sur les communes du pays compiégnois';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.geo_v_urbreg_ads_commune OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_urbreg_ads_commune TO create_sig;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.geo_v_urbreg_ads_commune TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.geo_v_urbreg_ads_commune TO sig_create;
GRANT DELETE, SELECT, UPDATE, INSERT ON TABLE m_urbanisme_doc_v2024.geo_v_urbreg_ads_commune TO sig_edit;

*/

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                           VUES MATERIALISEES (spécifiques ARC)                                               ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################
/*
-- ####################################################### VUE - xapps_an_vmr_docurba_h ##################################################
     
-- m_urbanisme_doc_v2024.xapps_an_vmr_docurba_h source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_docurba_h
TABLESPACE pg_default
AS WITH req_t AS (
         WITH req_plu AS (
                 SELECT "left"(an_doc_urba.idurba::text, 5) AS insee,
                    an_doc_urba.idurba,
                    an_doc_urba.typedoc,
                    an_doc_urba.etat,
                    an_doc_urba.nomproc,
                    an_doc_urba.l_nomprocn,
                    an_doc_urba.datappro,
                    an_doc_urba.datefin,
                    an_doc_urba.siren,
                    an_doc_urba.nomreg,
                    an_doc_urba.urlreg,
                    an_doc_urba.nomplan,
                    an_doc_urba.urlplan,
                    an_doc_urba.urlpe,
                    an_doc_urba.siteweb,
                    an_doc_urba.typeref,
                    an_doc_urba.dateref,
                    an_doc_urba.l_meta,
                    an_doc_urba.l_moa_proc,
                    an_doc_urba.l_moe_proc,
                    an_doc_urba.l_moa_dmat,
                    an_doc_urba.l_moe_dmat,
                    an_doc_urba.l_observ,
                    an_doc_urba.l_parent,
                    an_doc_urba.l_urldgen,
                    an_doc_urba.l_urlann,
                    an_doc_urba.l_urllex
                   FROM m_urbanisme_doc_v2024.an_doc_urba
                  WHERE an_doc_urba.etat::text <> '03'::text AND an_doc_urba.typedoc::text <> 'PLUI'::text AND an_doc_urba.typedoc::text <> 'SCOT'::text
                UNION ALL
                 SELECT an_doc_urba_com.insee,
                    an_doc_urba.idurba,
                    an_doc_urba.typedoc,
                    an_doc_urba.etat,
                    an_doc_urba.nomproc,
                    an_doc_urba.l_nomprocn,
                    an_doc_urba.datappro,
                    an_doc_urba.datefin,
                    an_doc_urba.siren,
                    an_doc_urba.nomreg,
                    an_doc_urba.urlreg,
                    an_doc_urba.nomplan,
                    an_doc_urba.urlplan,
                    an_doc_urba.urlpe,
                    an_doc_urba.siteweb,
                    an_doc_urba.typeref,
                    an_doc_urba.dateref,
                    an_doc_urba.l_meta,
                    an_doc_urba.l_moa_proc,
                    an_doc_urba.l_moe_proc,
                    an_doc_urba.l_moa_dmat,
                    an_doc_urba.l_moe_dmat,
                    an_doc_urba.l_observ,
                    an_doc_urba.l_parent,
                    an_doc_urba.l_urldgen,
                    an_doc_urba.l_urlann,
                    an_doc_urba.l_urllex
                   FROM m_urbanisme_doc_v2024.an_doc_urba
                     LEFT JOIN m_urbanisme_doc_v2024.an_doc_urba_com ON an_doc_urba.siren::text = "left"(an_doc_urba_com.idurba::text, 9)
                  WHERE an_doc_urba.etat::text <> '03'::text AND an_doc_urba.typedoc::text = 'PLUI'::text AND an_doc_urba.typedoc::text <> 'SCOT'::text
                )
         SELECT req_plu.insee,
            an_geo_1.libgeo,
            string_agg(((((((((('<tr><td align="center">'::text || req_plu.typedoc::text) || '</td><td align="center">'::text) ||
                CASE
                    WHEN req_plu.datappro::text = ''::text OR req_plu.datappro IS NULL THEN ''::text
                    ELSE to_char(req_plu.datappro::date::timestamp with time zone, 'DD-MM-YYYY'::text)
                END) || '</td><td align="center">'::text) || lt_etat.valeur::text) || '</td><td align="center">'::text) || lt_nomproc.valeur::text) ||
                CASE
                    WHEN req_plu.l_nomprocn IS NULL THEN ''::text
                    ELSE ' n° '::text || req_plu.l_nomprocn
                END) ||
                CASE
                    WHEN req_plu.urlreg::text = ''::text OR req_plu.urlreg IS NULL THEN '</td><td align="center">Aucun règlement disponible</td>'::text
                    ELSE ('</td><td align="center"><a href="'::text || req_plu.urlreg::text) || '" target="_blank">Ouvrir</a></td>'::text
                END) ||
                CASE
                    WHEN req_plu.urlplan::text = ''::text OR req_plu.urlplan IS NULL THEN '<td align="center">Aucun plan disponible</td></tr>'::text
                    ELSE ('<td align="center"><a href="'::text || req_plu.urlplan::text) || '" target="_blank">Ouvrir</a></td></tr>'::text
                END, ''::text ORDER BY req_plu.datappro DESC) AS ancien_reg
           FROM req_plu
             LEFT JOIN m_urbanisme_doc.lt_etat ON lt_etat.code = req_plu.etat::bpchar
             LEFT JOIN m_urbanisme_doc.lt_nomproc ON req_plu.nomproc::text = lt_nomproc.code::text
             LEFT JOIN r_administratif.an_geo an_geo_1 ON an_geo_1.insee::text = req_plu.insee
          GROUP BY req_plu.insee, an_geo_1.libgeo
        )
 SELECT
        CASE
            WHEN req_t.insee IS NOT NULL THEN req_t.insee::character varying
            ELSE duc.insee
        END AS insee,
        CASE
            WHEN req_t.insee IS NOT NULL THEN ('<center><i>Historique des procédures d''urbanisme pour la commune de<b> '::text || req_t.libgeo::text) || '</b></i></center>'::text
            ELSE ('<center><i>Historique des procédures d''urbanisme pour la commune de<b> '::text || an_geo.libgeo::text) || '</b></i></center>'::text
        END AS commune,
        CASE
            WHEN req_t.insee IS NOT NULL THEN ('<table border=1 align="center" width=100%><tr><td align="center"><b>Document </b></td><td align="center"><b>Approbation </b></td><td align="center"><b> Etat </b></td><td align="center"><b> Version </b></td><td align="center"><b>Règlement écrit</b></td><td align="center"><b>Plan de zonage</b></td></tr>'::text || req_t.ancien_reg) || '</table>'::text
            ELSE '<table border=1 align="center" width=100%><tr><td align="center"><b>Document </b></td><td align="center"><b>Approbation </b></td><td align="center"><b> Etat </b></td><td align="center"><b> Version </b></td><td align="center"><b>Règlement écrit</b></td><td align="center"><b>Plan de zonage</b></td></tr>
   <tr><td colspan="6" align="center">Aucune procédure antérieure n''a été trouvée pour cette commune.</td></tr></table>'::text
        END AS affiche_liste
   FROM req_t
     RIGHT JOIN m_urbanisme_doc_v2024.an_doc_urba_com duc ON req_t.insee = duc.insee::text
     LEFT JOIN r_administratif.an_geo ON an_geo.insee::text = duc.insee::text
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_docurba_h IS 'Vue matérialisée listant les anciennes procédures d''urbanisme par commune';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xapps_an_vmr_docurba_h OWNER TO sig_edit;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_docurba_h TO sig_edit;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_docurba_h TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_docurba_h TO sig_create;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_docurba_h TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_docurba_h TO postgres;


-- ####################################################### VUE - xapps_an_vmr_p_information_plu ##################################################

-- m_urbanisme_doc_v2024.xapps_an_vmr_p_information_plu source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_p_information_plu
TABLESPACE pg_default
AS WITH r_p AS (
         WITH r_pct AS (
                 SELECT DISTINCT "PARCELLE"."IDU" AS idu,
                    ((((geo_p_info_pct.libelle::text ||
                        CASE
                            WHEN length(geo_p_info_pct.l_nom::text) <> 0 THEN ' : '::text || geo_p_info_pct.l_nom::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_pct.l_dateins) <> 0 THEN (chr(10) || ' Instauré(e) le : '::text) || to_char(to_date(geo_p_info_pct.l_dateins::text, 'YYYYMMDD'::text)::timestamp without time zone, 'DD/MM/YYYY'::text)::character varying::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_pct.l_gen::text) <> 0 THEN (chr(10) || ' Générateur : '::text) || geo_p_info_pct.l_gen::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_pct.l_valrecul::text) <> 0 THEN (chr(10) || ' Emprise : '::text) || geo_p_info_pct.l_valrecul::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_pct.l_typrecul::text) <> 0 THEN (chr(10) || ' Type : '::text) || geo_p_info_pct.l_typrecul::text
                            ELSE ''::text
                        END AS libelle,
                    geo_p_info_pct.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc_v2024.geo_p_info_pct
                  WHERE st_intersects("PARCELLE"."GEOM", geo_p_info_pct.geom)
                ), r_surf AS (
                 SELECT DISTINCT "PARCELLE"."IDU" AS idu,
                    ((((geo_p_info_surf.libelle::text ||
                        CASE
                            WHEN length(geo_p_info_surf.l_nom::text) <> 0 THEN ' : '::text || geo_p_info_surf.l_nom::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_surf.l_dateins) <> 0 THEN (chr(10) || ' Instauré(e) le : '::text) || to_char(to_date(geo_p_info_surf.l_dateins::text, 'YYYYMMDD'::text)::timestamp without time zone, 'DD/MM/YYYY'::text)::character varying::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_surf.l_gen::text) <> 0 THEN (chr(10) || ' Générateur : '::text) || geo_p_info_surf.l_gen::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_surf.l_valrecul::text) <> 0 THEN (chr(10) || ' Emprise : '::text) || geo_p_info_surf.l_valrecul::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN length(geo_p_info_surf.l_typrecul::text) <> 0 THEN (chr(10) || ' Type : '::text) || geo_p_info_surf.l_typrecul::text
                            ELSE ''::text
                        END AS libelle,
                    geo_p_info_surf.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc_v2024.geo_p_info_surf
                  WHERE geo_p_info_surf.typeinf::text <> '04'::text AND geo_p_info_surf.typeinf::text <> '32'::text AND geo_p_info_surf.typeinf::text <> '05'::text AND geo_p_info_surf.libelle::text <> 'Zonage d''assainissement pluviale'::text AND st_intersects("PARCELLE"."GEOM", geo_p_info_surf.geom1)
                )
         SELECT r_pct.idu,
            r_pct.libelle,
            r_pct.urlfic
           FROM r_pct
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

COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_p_information_plu IS 'Vue matérialisée formatant les données les données informations jugées utiles provenant des données intégrées dans les données des PLU (cette vue est ensuite assemblée avec celle des infos hors PLU pour être accessible dans la fiche de renseignements d''urbanisme dans GEO)';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information_plu OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information_plu TO create_sig;
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information_plu TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information_plu TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information_plu TO sig_create;

-- ####################################################### VUE - xapps_an_vmr_p_information_horsplu ##################################################

-- m_urbanisme_doc.xapps_an_vmr_p_information_horsplu source

CREATE MATERIALIZED VIEW m_urbanisme_doc.xapps_an_vmr_p_information_horsplu
TABLESPACE pg_default
AS WITH r_p AS (
         WITH r_natura2000_zps AS (
                 SELECT p."IDU" AS idu,
                        CASE
                            WHEN zps.nom IS NOT NULL THEN (('Site Natura2000 : '::text || zps.nom::text) || chr(10)) || 'Remarque : les données présentées sont issues de l''arrêté de janvier 2006 (les demandes de modifications sont en cours)'::text
                            ELSE NULL::text
                        END AS libelle,
                    'http://geo.compiegnois.fr/documents/metiers/urba/2006-0501_arrete_ministeriel_zps_compiegne_laigue_ourscamps.pdf'::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_environnement.geo_env_n2000_zps_zinf_s_r22 zps
                  WHERE st_intersects(p."GEOM", zps.geom)
                ), r_natura2000_sic AS (
                 SELECT p."IDU" AS idu,
                        CASE
                            WHEN zsc.nom_site IS NOT NULL THEN (('Site Natura2000 : ZCS : '::text || zsc.nom_site::text) || chr(10)) || 'Remarque : les données présentées sont issues des données modifiées (demande de 2010) et validées par l''Etat.'::text
                            ELSE NULL::text
                        END AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_environnement.geo_env_n2000_zsc_m2010 zsc
                  WHERE st_intersects(p."GEOM", zsc.geom)
                UNION ALL
                 SELECT p."IDU" AS idu,
                        CASE
                            WHEN zsc.nom IS NOT NULL THEN (('Site Natura2000 : ZCS : '::text || zsc.nom::text) || chr(10)) || 'Remarque : les données présentées sont les données validées par la DREAL en janvier 2016.'::text
                            ELSE NULL::text
                        END AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_environnement.geo_env_n2000_zsc_zinf_s_r22 zsc
                  WHERE st_intersects(p."GEOM", zsc.geom) AND zsc.id_rn <> 2200382
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
                ), r_q100 AS (
                 SELECT p."IDU" AS idu,
                    q100.libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_risque.an_parcelle_q100_ru q100
                  WHERE p."IDU"::text = q100.idu::text
                ), r_sageba_zh AS (
                 SELECT DISTINCT "PARCELLE"."IDU" AS idu,
                    'Zone humide SAGEBA (V5.1) : Zone humide avérée'::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_environnement.geo_env_sageba_zhv51
                  WHERE st_intersects("PARCELLE"."GEOM", geo_env_sageba_zhv51.geom)
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
                    ((('Espace naturel sensible (ENS) : '::text || geo_env_ens.nom) || ' ('::text) || geo_env_ens.hierar) || ')'::text AS libelle,
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
                ), r_coulee_boue AS (
                 SELECT p."IDU" AS idu,
                    'Aléa coulées de boue : '::text || string_agg(DISTINCT a.alea::text, ' , '::text) AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_risque.an_risq_alea_couleeboue_geo a
                  WHERE p."IDU"::text = a.idu::text
                  GROUP BY p."IDU"
                ), r_remonte_nappe AS (
                 SELECT p."IDU" AS idu,
                    'Sensibilité remontée de nappe : '::text || string_agg(DISTINCT a.alea::text, ' et '::text) AS libelle,
                    'http://infoterre.brgm.fr/rapports//RP-65452-FR.pdf'::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_risque.an_risq_alea_nappe_geo a
                  WHERE p."IDU"::text = a.idu::text AND a.alea::text <> 'Pas de débordement de nappe ni d''inondation de cave'::text
                  GROUP BY p."IDU"
                ), r_inv_patri AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    ('Inventaire des éléments du patrimoine bâti vernaculaire'::text || ' - '::text) || geo_patri_verna.descriptif::text AS libelle,
                    geo_patri_verna.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_reg.geo_patri_verna
                  WHERE st_intersects("PARCELLE"."GEOM", geo_patri_verna.geom1)
                ), r_zass AS (
                 SELECT p."IDU" AS idu,
                    'Zonage d''assainissement : '::text || z.zone::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_reseau_humide.an_eu_zonage_geo z
                  WHERE p."IDU"::text = z.idu::text AND "left"(p."IDU"::text, 5) <> '60023'::text AND "left"(p."IDU"::text, 5) <> '60067'::text AND "left"(p."IDU"::text, 5) <> '60068'::text AND "left"(p."IDU"::text, 5) <> '60070'::text AND "left"(p."IDU"::text, 5) <> '60151'::text AND "left"(p."IDU"::text, 5) <> '60156'::text AND "left"(p."IDU"::text, 5) <> '60159'::text AND "left"(p."IDU"::text, 5) <> '60323'::text AND "left"(p."IDU"::text, 5) <> '60325'::text AND "left"(p."IDU"::text, 5) <> '60326'::text AND "left"(p."IDU"::text, 5) <> '60337'::text AND "left"(p."IDU"::text, 5) <> '60338'::text AND "left"(p."IDU"::text, 5) <> '60382'::text AND "left"(p."IDU"::text, 5) <> '60402'::text AND "left"(p."IDU"::text, 5) <> '60447'::text AND "left"(p."IDU"::text, 5) <> '60578'::text AND "left"(p."IDU"::text, 5) <> '60579'::text AND "left"(p."IDU"::text, 5) <> '60597'::text AND "left"(p."IDU"::text, 5) <> '60600'::text AND "left"(p."IDU"::text, 5) <> '60665'::text AND "left"(p."IDU"::text, 5) <> '60667'::text AND "left"(p."IDU"::text, 5) <> '60674'::text AND "left"(p."IDU"::text, 5) <> '60569'::text AND "left"(p."IDU"::text, 5) <> '60145'::text AND "left"(p."IDU"::text, 5) <> '60569'::text AND "left"(p."IDU"::text, 5) <> '60569'::text AND "left"(p."IDU"::text, 5) <> '60569'::text
                ), r_proc AS (
                 SELECT DISTINCT p."IDU" AS idu,
                        CASE
                            WHEN (z.date_crea::text IS NULL OR z.date_crea::text = ''::text) AND z.z_proced::text <> '10'::text THEN (('Procédure d''urbanisme (autre qu''une ZAC) : '::text || zl.valeur::text) || ' - '::text) || z.nom::text
                            WHEN z.z_proced::text = '10'::text AND (z.idsite::text = '60382ad'::text OR z.idsite::text = '60156aa'::text OR z.idsite::text = '60151ha'::text OR z.idsite::text = '60159ag'::text OR z.idsite::text = '60159ha'::text OR z.idsite::text = '60159aa'::text OR z.idsite::text = '60159af'::text OR z.idsite::text = '60159aa'::text) THEN 'Zone d''aménagement concerté : '::text || z.nom::text
                            WHEN (z.date_crea::text IS NOT NULL OR z.date_crea::text <> ''::text) AND z.z_proced::text <> '10'::text THEN (((('Procédure d''urbanisme (autre qu''une ZAC) : '::text || zl.valeur::text) || ' - '::text) || z.nom::text) || ', créée le '::text) || to_char(to_date(z.date_crea::text, 'YYYYMMDD'::text)::timestamp without time zone, 'DD-MM-YYYY'::text)
                            ELSE ''::text
                        END AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_urbanisme_reg.geo_proced z,
                    m_urbanisme_reg.lt_proc_typ zl
                  WHERE z.z_proced::text = zl.code::text AND z.z_proced::text <> '10'::text AND st_intersects(p."GEOM", z.geom1)
                UNION ALL
                 SELECT DISTINCT p."IDU" AS idu,
                    'Zone d''aménagement concerté : '::text || z.nom::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_urbanisme_reg.geo_proced z,
                    m_urbanisme_reg.lt_proc_typ zl
                  WHERE z.z_proced::text = zl.code::text AND z.z_proced::text = '10'::text AND z.idproc::text = 'PR34'::text AND st_intersects(p."GEOM", z.geom1)
                ), r_zarcheo AS (
                 SELECT DISTINCT p."IDU" AS idu,
                    ('La commune dispose d'' un zonage archéologique'::text || chr(10)) || '(cliquez sur + d''infos pour accéder à l''arrêté et à la cartographie communale pour vérifier le positionnement de la parcelle)'::text AS libelle,
                    za.urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_urbanisme_reg.geo_zonage_archeologique za
                  WHERE "left"(p."IDU"::text, 5) = za.insee::text
                ), r_fibre_rte AS (
                 SELECT DISTINCT p."IDU" AS idu,
                    'La parcelle est traversée ou à proximité immédiate du réseau fibre RTE reliant le poste de Clairoix au centre de commande de Coudun '::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_reseau_sec.geo_ftth_cable ftth
                     JOIN m_reseau_sec.an_ftth_objet a ON a.idftth = ftth.idftth
                  WHERE a.gexploit::text = 'RTE'::text AND st_intersects(p."GEOM", ftth.geom)
                ), r_bta AS (
                 SELECT DISTINCT p."IDU" AS idu,
                    ('La parcelle est traversée ou à proximité immédiate du Réseau '::text || bta.exploitant::text) || ' Basse Tension en ligne aérienne.'::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_reseau_sec.old_geo_ele_b_bta bta
                  WHERE st_intersects(p."GEOM", bta.geom)
                ), r_bts AS (
                 SELECT DISTINCT p."IDU" AS idu,
                    ('La parcelle est traversée ou à proximité immédiate du Réseau '::text || bts.exploitant::text) || ' Basse Tension en ligne souterraine.'::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_reseau_sec.geo_ele_b_bts bts
                  WHERE st_intersects(p."GEOM", bts.geom)
                ), r_htaa AS (
                 SELECT DISTINCT p."IDU" AS idu,
                    ('La parcelle est traversée ou à proximité immédiate du Réseau '::text || htaa.exploitant::text) || ' Moyenne Tension en ligne aérienne.'::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_reseau_sec.geo_ele_b_htaa htaa
                  WHERE st_intersects(p."GEOM", htaa.geom)
                ), r_htas AS (
                 SELECT DISTINCT p."IDU" AS idu,
                    ('La parcelle est traversée ou à proximité immédiate du Réseau '::text || htas.exploitant::text) || ' Moyenne Tension en ligne souterraine.'::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_reseau_sec.old_geo_ele_b_htas htas
                  WHERE st_intersects(p."GEOM", htas.geom)
                ), r_cana_prive AS (
                 SELECT DISTINCT p."IDU" AS idu,
                    ((('La parcelle peut être soumise à une bande de sécurité de '::text || round(cana_prive.zpose, 2)) || ' mètre(s) générée par une canalisation du réseau '::text) || r.valeur::text) || '.'::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_reseau_humide.geo_resh_domaineprive cana_prive,
                    m_reseau_humide.lt_resh_natresh r
                  WHERE st_intersects(p."GEOM", cana_prive.geom1) AND cana_prive.typres::text = r.code::text AND (cana_prive.typsup::text = ANY (ARRAY['10'::character varying::text, '11'::character varying::text, '20'::character varying::text, '40'::character varying::text]))
                ), r_opah_ru AS (
                 SELECT DISTINCT p."IDU" AS idu,
                    'La parcelle est comprise en partie ou entièrement dans le périmètre OPAH-RU de l''Agglomération de la Région de Compiègne.'::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_habitat.geo_hab_opahru o
                  WHERE st_intersects(p."GEOM", o.geom1)
                ), r_zae AS (
                 SELECT DISTINCT p."IDU" AS idu,
                    'La parcelle est comprise dans une zone d''activité économique : '::text || o.site_nom::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_activite_eco.geo_eco_site o
                  WHERE st_intersects(p."GEOM", o.geom1) IS TRUE AND o.typsite::text = '10'::text AND o.epci::text = 'arc'::text
                ), r_dup_csne AS (
                 SELECT DISTINCT p."IDU" AS idu,
                    'La parcelle est impactée dans la DUP du Canal Seine Nord Europe : '::text AS libelle,
                    ''::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_amenagement.geo_csne_dup d
                  WHERE st_intersects(p."GEOM", d.geom) IS TRUE
                ), r_dup_mageo AS (
                 SELECT DISTINCT p."IDU" AS idu,
                    'La parcelle est impactée dans la DUP du projet MAGEO : '::text AS libelle,
                    'https://www.oise.gouv.fr/Publications/Publications-legales/Enquetes-publiques/2021/MAGEO'::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_amenagement.geo_csne_mageo_dup_s d
                  WHERE st_intersects(p."GEOM", d.geom) IS TRUE
                ), r_merule AS (
                 SELECT DISTINCT p."IDU" AS idu,
                    m.libelle,
                    m.urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_urbanisme_reg.geo_zonage_lutte_merule m
                  WHERE st_intersects(p."GEOM", m.geom1) IS TRUE
                ), r_peri_500_gare_statio AS (
                 SELECT DISTINCT p."IDU" AS idu,
                    ('La parcelle est comprise dans le périmètre de 500m de la gare de '::text || m.nom_gare::text) || ' et peut-être concernée par l''application de l''article L151-35 et L. 151-36 du code de l''urbanisme en matière de règles de stationnement.'::text AS libelle,
                    'https://www.legifrance.gouv.fr/codes/article_lc/LEGIARTI000037670829'::text AS urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_urbanisme_reg.geo_gare_peri_statio m
                  WHERE st_intersects(p."GEOM", m.geom1) IS TRUE
                ), r_hab_peril AS (
                 SELECT DISTINCT '60'::text || p.idu AS idu,
                    (('L''unité foncière, auquelle appartient la parcelle, est concernée par un arrêté de péril.'::text || chr(10)) || 'Contactez le servie Habitat pour plus de précisions : '::text) || h.nm_doc::text AS libelle,
                    ''::text AS urlfic
                   FROM r_cadastre.geo_parcelle p,
                    r_cadastre.geo_unite_fonciere uf,
                    m_habitat.xapps_geo_v_hab_indigne_peril h
                  WHERE st_intersects(h.geom, uf.geom) IS TRUE AND uf.id = p.iduf
                ), r_saisine_archeo AS (
                 SELECT DISTINCT p."IDU" AS idu,
                    (('Modalités de saisine du préfet en matière archéologique préventive : <br>'::text ||
                        CASE
                            WHEN m.art1 IS NOT NULL THEN ('&#8226; '::text || m.art1::text) || '<br>'::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN m.art2 IS NOT NULL THEN ('&#8226; '::text || m.art2::text) || '<br>'::text
                            ELSE ''::text
                        END) ||
                        CASE
                            WHEN m.art3 IS NOT NULL THEN '&#8226; '::text || m.art3::text
                            ELSE ''::text
                        END AS libelle,
                    m.urlfic
                   FROM r_bg_edigeo."PARCELLE" p,
                    m_urbanisme_reg.geo_archeo_saisine m
                  WHERE st_intersects(p."GEOM", m.geom1) IS TRUE
                ), r_zonage_pluv AS (
                 WITH req_zonage AS (
                         SELECT DISTINCT p."IDU" AS idu,
                            'Zonage d''assainissement pluvial : '::text || string_agg(zp.bv::text, ', '::text) AS libelle
                           FROM r_bg_edigeo."PARCELLE" p,
                            ( SELECT geo_plui_zonagepluvial.gid,
                                    geo_plui_zonagepluvial.bv,
                                    (st_dump(geo_plui_zonagepluvial.geom)).geom AS geom
                                   FROM m_urbanisme_reg.geo_plui_zonagepluvial) zp
                          WHERE st_intersects(p."GEOM", zp.geom) IS TRUE AND (p."CCOCOM"::text = ANY (ARRAY['60023'::character varying::text, '60067'::character varying::text, '60068'::character varying::text, '60070'::character varying::text, '60151'::character varying::text, '60156'::character varying::text, '60159'::character varying::text, '60323'::character varying::text, '60325'::character varying::text, '60326'::character varying::text, '60337'::character varying::text, '60338'::character varying::text, '60382'::character varying::text, '60402'::character varying::text, '60447'::character varying::text, '60578'::character varying::text, '60579'::character varying::text, '60597'::character varying::text, '60600'::character varying::text, '60665'::character varying::text, '60667'::character varying::text, '60674'::character varying::text]))
                          GROUP BY p."IDU"
                        ), req_alea AS (
                         SELECT DISTINCT p."IDU" AS idu,
                            'Zonage d''aléa ruissellement : '::text || string_agg(ap.alea::text, ' et '::text) AS libelle
                           FROM r_bg_edigeo."PARCELLE" p,
                            ( SELECT geo_plui_zonagepluvial_alea_v2.gid,
                                    geo_plui_zonagepluvial_alea_v2.alea,
                                    (st_dump(geo_plui_zonagepluvial_alea_v2.geom)).geom AS geom
                                   FROM m_urbanisme_reg.geo_plui_zonagepluvial_alea_v2) ap
                          WHERE st_intersects(p."GEOM", ap.geom) IS TRUE AND (p."CCOCOM"::text = ANY (ARRAY['60023'::character varying::text, '60067'::character varying::text, '60068'::character varying::text, '60070'::character varying::text, '60151'::character varying::text, '60156'::character varying::text, '60159'::character varying::text, '60323'::character varying::text, '60325'::character varying::text, '60326'::character varying::text, '60337'::character varying::text, '60338'::character varying::text, '60382'::character varying::text, '60402'::character varying::text, '60447'::character varying::text, '60578'::character varying::text, '60579'::character varying::text, '60597'::character varying::text, '60600'::character varying::text, '60665'::character varying::text, '60667'::character varying::text, '60674'::character varying::text]))
                          GROUP BY p."IDU"
                        )
                 SELECT z.idu,
                    z.libelle ||
                        CASE
                            WHEN a.libelle IS NOT NULL THEN '<br>'::text || a.libelle
                            ELSE ''::text
                        END AS libelle,
                    ''::text AS urlfic
                   FROM req_zonage z
                     LEFT JOIN req_alea a ON z.idu::text = a.idu::text
                )
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
         SELECT r_q100.idu,
            r_q100.libelle,
            r_q100.urlfic
           FROM r_q100
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
         SELECT r_proc.idu,
            r_proc.libelle,
            r_proc.urlfic
           FROM r_proc
        UNION ALL
         SELECT r_zarcheo.idu,
            r_zarcheo.libelle,
            r_zarcheo.urlfic
           FROM r_zarcheo
        UNION ALL
         SELECT r_bta.idu,
            r_bta.libelle,
            r_bta.urlfic
           FROM r_bta
        UNION ALL
         SELECT r_bts.idu,
            r_bts.libelle,
            r_bts.urlfic
           FROM r_bts
        UNION ALL
         SELECT r_htaa.idu,
            r_htaa.libelle,
            r_htaa.urlfic
           FROM r_htaa
        UNION ALL
         SELECT r_htas.idu,
            r_htas.libelle,
            r_htas.urlfic
           FROM r_htas
        UNION ALL
         SELECT r_cana_prive.idu,
            r_cana_prive.libelle,
            r_cana_prive.urlfic
           FROM r_cana_prive
        UNION ALL
         SELECT r_opah_ru.idu,
            r_opah_ru.libelle,
            r_opah_ru.urlfic
           FROM r_opah_ru
        UNION ALL
         SELECT r_zae.idu,
            r_zae.libelle,
            r_zae.urlfic
           FROM r_zae
        UNION ALL
         SELECT r_remonte_nappe.idu,
            r_remonte_nappe.libelle,
            r_remonte_nappe.urlfic
           FROM r_remonte_nappe
        UNION ALL
         SELECT r_coulee_boue.idu,
            r_coulee_boue.libelle,
            r_coulee_boue.urlfic
           FROM r_coulee_boue
        UNION ALL
         SELECT r_dup_csne.idu,
            r_dup_csne.libelle,
            r_dup_csne.urlfic
           FROM r_dup_csne
        UNION ALL
         SELECT r_dup_mageo.idu,
            r_dup_mageo.libelle,
            r_dup_mageo.urlfic
           FROM r_dup_mageo
        UNION ALL
         SELECT r_merule.idu,
            r_merule.libelle,
            r_merule.urlfic
           FROM r_merule
        UNION ALL
         SELECT r_saisine_archeo.idu,
            r_saisine_archeo.libelle,
            r_saisine_archeo.urlfic
           FROM r_saisine_archeo
        UNION ALL
         SELECT r_peri_500_gare_statio.idu,
            r_peri_500_gare_statio.libelle,
            r_peri_500_gare_statio.urlfic
           FROM r_peri_500_gare_statio
        UNION ALL
         SELECT r_zonage_pluv.idu,
            r_zonage_pluv.libelle,
            r_zonage_pluv.urlfic
           FROM r_zonage_pluv
        UNION ALL
         SELECT r_fibre_rte.idu,
            r_fibre_rte.libelle,
            r_fibre_rte.urlfic
           FROM r_fibre_rte
        UNION ALL
         SELECT r_hab_peril.idu,
            r_hab_peril.libelle,
            r_hab_peril.urlfic
           FROM r_hab_peril
        )
 SELECT row_number() OVER () AS gid,
    r_p.idu,
    r_p.libelle,
    r_p.urlfic
   FROM r_p
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_urbanisme_doc.xapps_an_vmr_p_information_horsplu IS 'Vue matérialisée formatant les données d''informations jugées utiles provenant des données non intégrées dans les données des PLU (cette vue est ensuite assemblée avec celle des infos PLU pour être accessible dans la fiche de renseignements d''urbanisme dans GEO)';

-- ####################################################### VUE - xapps_an_vmr_p_information ##################################################

-- m_urbanisme_doc_v2024.xapps_an_vmr_p_information source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_p_information
TABLESPACE pg_default
AS WITH r_t AS (
         SELECT xapps_an_vmr_p_information_plu.idu,
            xapps_an_vmr_p_information_plu.libelle,
            xapps_an_vmr_p_information_plu.urlfic
           FROM m_urbanisme_doc_v2024.xapps_an_vmr_p_information_plu
          WHERE xapps_an_vmr_p_information_plu.libelle <> ''::text AND xapps_an_vmr_p_information_plu.libelle !~~ '%taxe%'::text AND xapps_an_vmr_p_information_plu.libelle !~~ '%Zone humide%'::text
        UNION ALL
         SELECT xapps_an_vmr_p_information_horsplu.idu,
            xapps_an_vmr_p_information_horsplu.libelle,
            xapps_an_vmr_p_information_horsplu.urlfic
           FROM m_urbanisme_doc_v2024.xapps_an_vmr_p_information_horsplu
          WHERE xapps_an_vmr_p_information_horsplu.libelle <> ''::text
        )
 SELECT row_number() OVER () AS gid,
    r_t.idu,
    r_t.libelle,
    r_t.urlfic
   FROM r_t
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_p_information IS 'Vue matérialisée formatant les données les données informations jugées utiles pour la fiche de renseignements d''urbanisme (assemblage des vues infos PLU et hors PLU)';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information TO create_sig;
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information TO sig_create;

-- ####################################################### VUE - xapps_an_vmr_p_information_dpu ##################################################

-- m_urbanisme_doc_v2024.xapps_an_vmr_p_information_dpu source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_p_information_dpu
TABLESPACE pg_default
AS WITH r_p AS (
         WITH r_surf AS (
                 SELECT "PARCELLE"."IDU" AS idu,
                    geo_p_info_surf.libelle,
                    geo_p_info_surf.l_nom,
                    geo_p_info_surf.l_bnfcr,
                    geo_p_info_surf.l_dateins,
                    geo_p_info_surf.l_gen,
                    geo_p_info_surf.urlfic
                   FROM r_bg_edigeo."PARCELLE",
                    m_urbanisme_doc_v2024.geo_p_info_surf
                  WHERE geo_p_info_surf.typeinf::text = '04'::text AND st_intersects("PARCELLE"."GEOM", geo_p_info_surf.geom1)
                )
         SELECT p."IDU" AS idu,
            r_surf.libelle,
            r_surf.l_nom,
            r_surf.l_bnfcr,
            r_surf.l_dateins,
            r_surf.l_gen,
            r_surf.urlfic
           FROM r_bg_edigeo."PARCELLE" p
             LEFT JOIN r_surf ON p."IDU"::text = r_surf.idu::text
        )
 SELECT row_number() OVER () AS gid,
    r_p.idu,
        CASE
            WHEN r_p.l_nom::text = ''::text OR r_p.l_nom IS NULL THEN ''::character varying
            ELSE r_p.l_nom
        END AS l_nom,
        CASE
            WHEN r_p.libelle IS NULL OR r_p.libelle::text = ''::text THEN 'Parcelle non concernée'::character varying
            ELSE
            CASE
                WHEN r_p.l_nom IS NULL OR r_p.l_nom::text = ''::text THEN r_p.l_gen
                ELSE r_p.l_nom
            END
        END AS application,
        CASE
            WHEN r_p.l_bnfcr::text = ''::text OR r_p.l_bnfcr IS NULL THEN ''::character varying
            ELSE r_p.l_bnfcr
        END AS beneficiaire,
        CASE
            WHEN r_p.l_dateins::text = ''::text OR r_p.l_dateins::text IS NULL THEN ''::text
            ELSE to_char(to_date(r_p.l_dateins::text, 'YYYYMMDD'::text)::timestamp without time zone, 'DD-MM-YYYY'::text)
        END AS date_ins,
    r_p.urlfic
   FROM r_p
  ORDER BY (
        CASE
            WHEN r_p.libelle IS NULL OR r_p.libelle::text = ''::text THEN 'Parcelle non concernée'::character varying
            ELSE
            CASE
                WHEN r_p.l_nom IS NULL OR r_p.l_nom::text = ''::text THEN r_p.l_gen
                ELSE r_p.l_nom
            END
        END) DESC
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_p_information_dpu IS 'Vue matérialisée formatant les données les données des DPU pour la fiche de renseignements d''''urbanisme (fiche d''''information de GEO).
ATTENTION : cette vue est reformatée à chaque mise à jour de cadastre dans FME (Y:\\\\Ressources\\\\4-Partage\\\\3-Procedures\\\\FME\\prod\\\\URB\\\\00_MAJ_COMPLETE_SUP_INFO_UTILES.fmw) 
afin de conserver le lien vers le bon schéma de cadastre suite au rennomage de ceux-ci durant l''''intégration. Si cette vue est modifiée ici pensez à répercuter la mise à jour dans le trans former SQLExecutor.';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information_dpu OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information_dpu TO create_sig;
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information_dpu TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information_dpu TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_information_dpu TO sig_create;

-- ####################################################### VUE - xapps_an_vmr_p_planche_graphique_plu ##################################################

-- m_urbanisme_doc_v2024.xapps_an_vmr_p_planche_graphique_plu source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_p_planche_graphique_plu
TABLESPACE pg_default
AS WITH req_tot AS (
         WITH req_par AS (
                 SELECT row_number() OVER () AS gid,
                    '60'::text || c.idu AS idu,
                    p.id_maille,
                    'pluih_arc'::text AS plu
                   FROM m_urbanisme_doc_v2024.geo_p_planche_pluiarc p,
                    r_cadastre.geo_parcelle c
                  WHERE c.lot = 'arc'::text AND p.insee::text = ('60'::text || "left"(c.idu, 3)) AND st_intersects(p.geom, st_pointonsurface(c.geom)) IS TRUE
                ), req_plu AS (
                 SELECT 'pluih_arc'::text AS plu,
                    d.siren,
                    d.datappro,
                    d.idurba
                   FROM m_urbanisme_doc_v2024.an_doc_urba d
                  WHERE d.etat::text = '03'::text AND d.siren::text = '200067965'::text
                )
         SELECT row_number() OVER () AS gid,
            req_par.idu,
            'Planche(s) graphique(s) n°'::text || string_agg(((('<a href="'::text ||
                CASE
                    WHEN req_par.id_maille = 10 OR req_par.id_maille = 11 THEN ((((('https://geo.compiegnois.fr/documents/metiers/urba/docurba/'::text || replace(req_plu.idurba::text, 'PLUI'::text, 'PLUi'::text)) || '/Pieces_ecrites/3_Reglement/'::text) || req_plu.siren::text) || '_reglement_graphique_10_11_'::text) || req_plu.datappro::text) || '.pdf'::text
                    ELSE ((((((('https://geo.compiegnois.fr/documents/metiers/urba/docurba/'::text || replace(req_plu.idurba::text, 'PLUI'::text, 'PLUi'::text)) || '/Pieces_ecrites/3_Reglement/'::text) || req_plu.siren::text) || '_reglement_graphique_'::text) || req_par.id_maille) || '_'::text) || req_plu.datappro::text) || '.pdf'::text
                END) || '" target="_blank">'::text) || req_par.id_maille) || '</a>'::text, ', '::text ORDER BY req_par.id_maille) AS num_planche
           FROM req_par,
            req_plu
          WHERE req_par.plu = req_plu.plu
          GROUP BY req_par.idu
        UNION ALL
         SELECT row_number() OVER () AS gid,
            '60'::text || p.idu AS idu,
            'Planche(s) graphique(s) : '::text || string_agg(((('<a href="'::text || rg.urlfic::text) || '" target="_blank">'::text) || rg.echelleplan::text) || '</a>'::text, ', '::text ORDER BY rg.numplan) AS num_planche
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_doc_v2024.an_doc_urba_com_plan rg
          WHERE (p.lot = ANY (ARRAY['ccpe'::text, 'cclo'::text, 'cc2v'::text])) AND p.insee::text = rg.insee::text
          GROUP BY ('60'::text || p.idu)
        )
 SELECT row_number() OVER () AS gid,
    req_tot.idu,
    req_tot.num_planche
   FROM req_tot
WITH DATA;

-- View indexes:
CREATE INDEX idx_xapps_an_vmr_p_planche_gra ON m_urbanisme_doc_v2024.xapps_an_vmr_p_planche_graphique_plu USING btree (idu);


COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_p_planche_graphique_plu IS 'Vue matérialisée formatant l''accès aux planches du règlement graphique des PLU (cette vue est ensuite liée dans GEO pour accessiiblité à la parcelle dans la fiche de renseignements d''urbanisme dans GEO)';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_planche_graphique_plu OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_planche_graphique_plu TO create_sig;
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_planche_graphique_plu TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_planche_graphique_plu TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_planche_graphique_plu TO sig_create;


-- ####################################################### VUE - xapps_an_vmr_p_prescription ##################################################

-- m_urbanisme_doc_v2024.xapps_an_vmr_p_prescription source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_p_prescription
TABLESPACE pg_default
AS WITH r_p AS (
         WITH r_pct AS (
                 SELECT DISTINCT "PARCELLE"."IDU" AS idu,
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
                    m_urbanisme_doc_v2024.geo_p_prescription_pct
                  WHERE st_intersects("PARCELLE"."GEOM", geo_p_prescription_pct.geom)
                ), r_lin AS (
                 SELECT DISTINCT "PARCELLE"."IDU" AS idu,
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
                    m_urbanisme_doc_v2024.geo_p_prescription_lin
                  WHERE st_intersects("PARCELLE"."GEOM", geo_p_prescription_lin.geom1) AND geo_p_prescription_lin.l_insee::text = "left"("PARCELLE"."IDU"::text, 5)
                ), r_surf AS (
                 SELECT DISTINCT "PARCELLE"."IDU" AS idu,
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
                    m_urbanisme_doc_v2024.geo_p_prescription_surf
                  WHERE st_intersects("PARCELLE"."GEOM", geo_p_prescription_surf.geom1) AND geo_p_prescription_surf.l_insee::text = "left"("PARCELLE"."IDU"::text, 5) AND geo_p_prescription_surf.idurba::text !~~ '%_PLUI_%'::text
                ), r_surf_horsoapplui AS (
                 SELECT DISTINCT "PARCELLE"."IDU" AS idu,
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
                    m_urbanisme_doc_v2024.geo_p_prescription_surf
                  WHERE st_intersects("PARCELLE"."GEOM", geo_p_prescription_surf.geom1) AND geo_p_prescription_surf.l_insee::text = "left"("PARCELLE"."IDU"::text, 5) AND geo_p_prescription_surf.idurba::text ~~ '%_PLUI_%'::text AND geo_p_prescription_surf.typepsc::text <> '18'::text
                ), r_surf_oapplui AS (
                 SELECT DISTINCT "PARCELLE"."IDU" AS idu,
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
                    m_urbanisme_doc_v2024.geo_p_prescription_surf
                  WHERE st_intersects("PARCELLE"."GEOM", geo_p_prescription_surf.geom1) AND geo_p_prescription_surf.idurba::text ~~ '%_PLUI_%'::text AND geo_p_prescription_surf.typepsc::text = '18'::text
                )
         SELECT DISTINCT p."IDU" AS idu,
                CASE
                    WHEN r_pct.libelle IS NULL AND r_lin.libelle IS NULL AND r_surf.libelle IS NULL AND r_surf_horsoapplui.libelle IS NULL AND r_surf_oapplui.libelle IS NULL THEN 'Aucune'::text
                    ELSE NULL::text
                END AS libelle,
                CASE
                    WHEN r_pct.urlfic IS NULL AND r_lin.urlfic IS NULL AND r_surf.urlfic IS NULL AND r_surf_horsoapplui.urlfic IS NULL AND r_surf_oapplui.urlfic IS NULL THEN NULL::text
                    ELSE NULL::text
                END AS urlfic
           FROM r_bg_edigeo."PARCELLE" p
             LEFT JOIN r_pct ON p."IDU"::text = r_pct.idu::text
             LEFT JOIN r_lin ON p."IDU"::text = r_lin.idu::text
             LEFT JOIN r_surf ON p."IDU"::text = r_surf.idu::text
             LEFT JOIN r_surf_horsoapplui ON p."IDU"::text = r_surf_horsoapplui.idu::text
             LEFT JOIN r_surf_oapplui ON p."IDU"::text = r_surf_oapplui.idu::text
          WHERE r_pct.libelle IS NULL AND r_lin.libelle IS NULL AND r_surf.libelle IS NULL AND r_surf_horsoapplui.libelle IS NULL AND r_surf_oapplui.libelle IS NULL
        UNION ALL
         SELECT DISTINCT r_pct.idu,
            r_pct.libelle,
            r_pct.urlfic
           FROM r_pct
        UNION ALL
         SELECT DISTINCT r_lin.idu,
            r_lin.libelle,
            r_lin.urlfic
           FROM r_lin
        UNION ALL
         SELECT DISTINCT r_surf.idu,
            r_surf.libelle,
            r_surf.urlfic
           FROM r_surf
        UNION ALL
         SELECT DISTINCT r_surf_horsoapplui.idu,
            r_surf_horsoapplui.libelle,
            r_surf_horsoapplui.urlfic
           FROM r_surf_horsoapplui
        UNION ALL
         SELECT DISTINCT r_surf_oapplui.idu,
            r_surf_oapplui.libelle,
            r_surf_oapplui.urlfic
           FROM r_surf_oapplui
        )
 SELECT row_number() OVER () AS gid,
    r_p.idu,
    r_p.libelle,
    r_p.urlfic
   FROM r_p
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_p_prescription IS 'Vue matérialisée formatant les données les données des prescriptions pour la fiche de renseignements d''urbanisme (fiche d''information de GEO).
ATTENTION : cette vue est reformatée à chaque mise à jour de cadastre dans FME (Y:\Ressources\4-Partage\3-Procedures\FME\prod\URB/00_MAJ_COMPLETE_SUP_INFO_UTILES.fmw) afin de conserver le lien vers le bon schéma de cadastre suite au rennomage de ceux-ci durant l''intégration. Si cette vue est modifiée ici pensez à répercuter la mise à jour dans le trans former SQLExecutor.';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_prescription OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_prescription TO create_sig;
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_prescription TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_prescription TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_p_prescription TO sig_create;

-- ####################################################### VUE - xapps_an_vmr_parcelle_plu ##################################################

-- m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_plu source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_plu
TABLESPACE pg_default
AS WITH req_par AS (
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
         SELECT geo_p_zone_urba.l_insee,
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
            geo_p_zone_urba.l_urlfic,
            lt_formdomi.valeur,
            geo_p_zone_urba.l_surf_cal,
                CASE
                    WHEN geo_p_zone_urba.fermreco::text = 'oui'::text THEN 'Oui'::text
                    WHEN geo_p_zone_urba.fermreco::text = 'non'::text THEN 'Non'::text
                    ELSE NULL::text
                END AS fermreco,
                CASE
                    WHEN an_doc_urba.typedoc::text = 'PLU'::text OR an_doc_urba.typedoc::text = 'POS'::text THEN geo_p_zone_urba.typezone
                    WHEN an_doc_urba.typedoc::text = 'CC'::text THEN 'sans objet'::character varying
                    ELSE NULL::character varying
                END AS type_zone,
            geo_p_zone_urba.l_observ,
                CASE
                    WHEN length(geo_p_zone_urba.idurba::text) = 23 THEN to_char("substring"(geo_p_zone_urba.idurba::text, 16, 8)::timestamp without time zone, 'DD/MM/YYYY'::text)
                    ELSE to_char("right"(geo_p_zone_urba.idurba::text, 8)::timestamp without time zone, 'DD/MM/YYYY'::text)
                END AS datappro,
            st_buffer(geo_p_zone_urba.geom, '-1.5'::numeric::double precision) AS geom1
           FROM m_urbanisme_doc_v2024.geo_p_zone_urba,
            m_urbanisme_doc_v2024.lt_formdomi,
            m_urbanisme_doc_v2024.an_doc_urba,
            r_osm.geo_osm_commune
          WHERE geo_osm_commune.insee::text = geo_p_zone_urba.l_insee::text AND geo_p_zone_urba.idurba::text = an_doc_urba.idurba::text AND an_doc_urba.etat::bpchar = '03'::bpchar AND geo_p_zone_urba.formdomi::bpchar = lt_formdomi.code::bpchar
        )
 SELECT row_number() OVER () AS id,
    now() AS datextract,
    '60'::text || req_par.idu AS idu,
    '60'::text || "substring"(req_par.idu, 1, 3) AS insee_par,
    req_plu.l_insee AS insee_plu,
    req_plu.commune,
    req_plu.libelle,
    req_plu.libelong,
    req_plu.type_zone,
    req_plu.valeur AS destdomi_lib,
    req_plu.fermreco,
    sum(req_plu.l_surf_cal) AS l_surf_cal,
    req_plu.l_observ,
    req_plu.datappro,
        CASE
            WHEN length(req_plu.l_urlfic::text) > 0 THEN req_plu.l_urlfic
            ELSE req_plu.urlfic
        END AS urlfic
   FROM req_par,
    req_plu
  WHERE st_intersects(req_par.geom, req_plu.geom1) AND ('60'::text || "substring"(req_par.idu, 1, 3)) = req_plu.l_insee::text
  GROUP BY ('60'::text || req_par.idu), ('60'::text || "substring"(req_par.idu, 1, 3)), req_plu.l_insee, req_plu.commune, req_plu.libelle, req_plu.libelong, req_plu.type_zone, req_plu.valeur, req_plu.fermreco, req_plu.l_observ, req_plu.datappro, req_plu.urlfic, req_plu.l_urlfic
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_plu IS 'Vue matérialisée contenant les informations pré-formatés pour la constitution de la fiche d''information Renseignements d''urbanisme y compris version imprimable dans GEO.
Cette vue permet de récupérer pour chaque parcelle les informations du PLU et traiter les pbs liés aux zones entre commune et les zonages se touchant.
ATTENTION : cette vue est reformatée à chaque mise à jour de cadastre dans FME (Y:\Ressources\4-Partage\3-Procedures\FME\prod\URB\00_MAJ_COMPLETE_SUP_INFO_UTILES.fmw) afin de conserver le lien vers le bon schéma de cadastre suite au rennomage de ceux-ci durant l''intégration. Si cette vue est modifiée ici pensez à répercuter la mise à jour dans le trans former SQLExecutor.';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_plu OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_plu TO create_sig;
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_plu TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_plu TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_plu TO sig_create;

-- ####################################################### VUE - xapps_an_vmr_parcelle_ru ##################################################

-- m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_ru source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_ru
TABLESPACE pg_default
AS SELECT "NBAT_10"."IDU" AS idu,
    "left"("NBAT_10"."IDU"::text, 5) AS insee,
    "NBAT_10"."CCOSEC" AS section_cad_bg,
    "NBAT_10"."BG_NUMPARC" AS numpar_cad_bg,
    "NBAT_10"."DCNTPA" AS surf_cad_bg,
    "NBAT_10"."BG_FULL_ADDRESS" AS adresse_cad_bg,
    "NBAT_10"."BG_PROP_RECORDS" AS proprio_cad_bg,
    string_agg(((p."DDENOM"::text || ' ('::text) || dp."DESIGNATION"::text) || ')'::text, '<br>'::text) AS proprio_cad_ru
   FROM r_bg_majic."NBAT_10",
    r_bg_majic."PROP" p,
    r_bg_majic."DROIT" dp
  WHERE "NBAT_10"."DNUPRO"::text = p."DNUPRO"::text AND dp."CO_DROIT"::text = p."CCODRO"::text AND p."CCOCOM"::text = "left"("NBAT_10"."IDU"::text, 5)
  GROUP BY "NBAT_10"."IDU", "NBAT_10"."CCOSEC", "NBAT_10"."BG_NUMPARC", "NBAT_10"."DCNTPA", "NBAT_10"."BG_FULL_ADDRESS", "NBAT_10"."BG_PROP_RECORDS"
WITH DATA;

-- View indexes:
CREATE INDEX idx_4790_idu ON m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_ru USING btree (idu);


COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_ru IS 'Vue matérialisée extrayant de la table PARCELLE de BG les informations essentielles pour la note d''urbanisme. Evite d''utiliser les données intégrées via le module GEOCADASTRE pour des pbs de mises à jour et de reconstructions applicatives';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_ru OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_ru TO create_sig;
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_ru TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_ru TO sig_read;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xapps_an_vmr_parcelle_ru TO sig_create;

-- ####################################################### VUE - xapps_geo_vmr_docurba ##################################################

-- m_urbanisme_doc_v2024.xapps_geo_vmr_docurba source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_geo_vmr_docurba
TABLESPACE pg_default
AS WITH req_a AS (
         SELECT "left"(an_doc_urba.idurba::text, 5) AS insee,
            an_doc_urba.idurba,
            an_doc_urba.typedoc,
            an_doc_urba.etat,
            an_doc_urba.nomproc,
            an_doc_urba.l_nomprocn,
            an_doc_urba.datappro,
            an_doc_urba.datefin,
            an_doc_urba.siren,
            an_doc_urba.nomreg,
            an_doc_urba.urlreg,
            an_doc_urba.nomplan,
            an_doc_urba.urlplan,
            an_doc_urba.urlpe,
            an_doc_urba.siteweb,
            an_doc_urba.typeref,
            an_doc_urba.dateref,
            an_doc_urba.l_meta,
            an_doc_urba.l_moa_proc,
            an_doc_urba.l_moe_proc,
            an_doc_urba.l_moa_dmat,
            an_doc_urba.l_moe_dmat,
            an_doc_urba.l_observ,
            an_doc_urba.l_parent,
            an_doc_urba.l_urldgen,
            an_doc_urba.l_urlann,
            an_doc_urba.l_urllex,
            an_doc_urba.nom,
            an_doc_urba.rapport,
            an_doc_urba.padd,
            an_doc_urba.doo,
            an_doc_urba.urlrapport,
            an_doc_urba.urlpadd,
            an_doc_urba.urldoo
           FROM m_urbanisme_doc_v2024.an_doc_urba
          WHERE an_doc_urba.typedoc::text = ANY (ARRAY['PLU'::character varying::text, 'CC'::character varying::text, 'POS'::character varying::text])
        UNION ALL
         SELECT g.insee,
            u.idurba,
            u.typedoc,
            u.etat,
            u.nomproc,
            u.l_nomprocn,
            u.datappro,
            u.datefin,
            u.siren,
            u.nomreg,
            u.urlreg,
            u.nomplan,
            u.urlplan,
            u.urlpe,
            u.siteweb,
            u.typeref,
            u.dateref,
            u.l_meta,
            u.l_moa_proc,
            u.l_moe_proc,
            u.l_moa_dmat,
            u.l_moe_dmat,
            u.l_observ,
            u.l_parent,
            u.l_urldgen,
            u.l_urlann,
            u.l_urllex,
            u.nom,
            u.rapport,
            u.padd,
            u.doo,
            u.urlrapport,
            u.urlpadd,
            u.urldoo
           FROM m_urbanisme_doc_v2024.an_doc_urba u,
            r_administratif.an_geo g,
            r_osm.geo_osm_epci e
          WHERE u.siren::text = e.cepci::text AND g.epci::text = e.cepci::text AND u.typedoc::text = 'PLUI'::text
        )
 SELECT row_number() OVER () AS gid,
    req_a.insee,
    c.commune,
    req_a.idurba,
    req_a.typedoc,
    req_a.etat,
    req_a.nomproc,
    req_a.l_nomprocn,
    req_a.datappro,
    req_a.datefin,
    req_a.siren,
    req_a.nomreg,
    req_a.urlreg,
    req_a.nomplan,
    req_a.urlplan,
    req_a.urlpe,
    req_a.siteweb,
    req_a.typeref,
    req_a.dateref,
    req_a.l_meta,
    req_a.l_moa_proc,
    req_a.l_moe_proc,
    req_a.l_moa_dmat,
    req_a.l_moe_dmat,
    req_a.l_observ,
    req_a.l_parent,
    req_a.l_urldgen,
    req_a.l_urlann,
    req_a.l_urllex,
    req_a.nom,
    req_a.rapport,
    req_a.padd,
    req_a.doo,
    req_a.urlrapport,
    req_a.urlpadd,
    req_a.urldoo,
    c.geom
   FROM req_a,
    r_osm.geo_vm_osm_commune_grdc c
  WHERE req_a.insee = c.insee::text
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_geo_vmr_docurba IS 'Vue matérialisée listant toutes les procédures d''urbanisme par commune';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xapps_geo_vmr_docurba OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_geo_vmr_docurba TO create_sig;
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE m_urbanisme_doc_v2024.xapps_geo_vmr_docurba TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xapps_geo_vmr_docurba TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_geo_vmr_docurba TO sig_create;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_geo_vmr_docurba TO postgres;

-- ####################################################### VUE - xapps_geo_vmr_p_zone_urba ##################################################

-- m_urbanisme_doc_v2024.xapps_geo_vmr_p_zone_urba source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_geo_vmr_p_zone_urba
TABLESPACE pg_default
AS SELECT geo_p_zone_urba.idzone,
    geo_p_zone_urba.libelle,
    geo_p_zone_urba.libelong,
    geo_p_zone_urba.typezone,
    geo_p_zone_urba.formdomi AS destdomi,
    geo_p_zone_urba.typesect,
    geo_p_zone_urba.fermreco,
    geo_p_zone_urba.l_surf_cal,
    geo_p_zone_urba.l_observ,
    geo_p_zone_urba.nomfic,
    geo_p_zone_urba.urlfic,
    geo_p_zone_urba.l_nomfic,
    geo_p_zone_urba.l_urlfic,
    geo_p_zone_urba.l_insee AS insee,
        CASE
            WHEN length(geo_p_zone_urba.idurba::text) = 23 THEN to_char("substring"(geo_p_zone_urba.idurba::text, 16, 8)::timestamp without time zone, 'DD/MM/YYYY'::text)
            ELSE to_char("right"(geo_p_zone_urba.idurba::text, 8)::timestamp without time zone, 'DD/MM/YYYY'::text)
        END AS datappro,
    geo_p_zone_urba.datvalid,
    st_multi(geo_p_zone_urba.geom)::geometry(MultiPolygon,2154) AS geom
   FROM m_urbanisme_doc_v2024.geo_p_zone_urba
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xapps_geo_vmr_p_zone_urba IS 'Vue matérialisée des zones du PLU servant dans les recherches par zonage ou type dans GEO.';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xapps_geo_vmr_p_zone_urba OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_geo_vmr_p_zone_urba TO create_sig;
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE m_urbanisme_doc_v2024.xapps_geo_vmr_p_zone_urba TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xapps_geo_vmr_p_zone_urba TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xapps_geo_vmr_p_zone_urba TO sig_create;

-- ####################################################### VUE - xappspublic_an_vmr_parcelle_plui_ru ##################################################

-- m_urbanisme_doc_v2024.xappspublic_an_vmr_parcelle_plui_ru source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xappspublic_an_vmr_parcelle_plui_ru
TABLESPACE pg_default
AS WITH req_tot AS (
         WITH req_par AS (
                 SELECT geo_parcelle.geo_parcelle,
                    geo_parcelle.idu,
                    a.libgeo AS commune,
                        CASE
                            WHEN "right"(geo_parcelle.geo_section, 2) ~~ '0%'::text THEN "right"(geo_parcelle.geo_section, 1)
                            ELSE "right"(geo_parcelle.geo_section, 2)
                        END AS section,
                    geo_parcelle.tex AS num_par,
                    geo_parcelle.supf,
                    geo_parcelle.geom
                   FROM r_cadastre.geo_parcelle,
                    r_administratif.an_geo a
                  WHERE geo_parcelle.lot = 'arc'::text AND a.insee::text = ('60'::text || "left"(geo_parcelle.idu, 3))
                ), req_plu AS (
                 SELECT p.libelle,
                    p.libelong,
                    p.l_insee,
                    p.urlfic,
                    p.l_urlfic,
                    u.urlpe,
                    u.l_urldgen,
                    u.l_urlann,
                    u.l_urllex,
                    to_char(u.datappro::date::timestamp with time zone, 'DD TMmonth YYYY'::text) AS datappro,
                    st_buffer(p.geom, - 1.5::integer::double precision) AS geom1
                   FROM m_urbanisme_doc_v2024.geo_v_p_zone_urba_arc p,
                    m_urbanisme_doc_v2024.an_doc_urba u
                  WHERE u.idurba::text = p.idurba::text
                )
         SELECT '60'::text || req_par.idu AS idu,
            req_par.section,
            req_par.num_par,
            req_par.supf,
            '60'::text || "substring"(req_par.idu, 1, 3) AS insee_par,
            req_plu.l_insee AS insee_plu,
            req_plu.datappro,
            req_par.commune,
            req_plu.libelle,
            req_plu.libelong,
            req_plu.urlfic,
            req_plu.l_urlfic,
            req_plu.l_urldgen,
            req_plu.l_urlann,
            req_plu.l_urllex,
            req_plu.urlpe
           FROM req_par,
            req_plu
          WHERE st_intersects(req_par.geom, req_plu.geom1)
        )
 SELECT row_number() OVER () AS id,
    req_tot.idu,
    req_tot.section,
    req_tot.num_par,
    req_tot.supf,
    req_tot.insee_par,
    req_tot.insee_plu,
    req_tot.datappro,
    req_tot.commune,
    req_tot.libelle,
    req_tot.libelong,
    req_tot.urlfic,
    req_tot.l_urlfic,
    req_tot.l_urldgen,
    req_tot.l_urlann,
    req_tot.l_urllex,
    req_tot.urlpe
   FROM req_tot
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xappspublic_an_vmr_parcelle_plui_ru IS 'Vue matérialisée contenant les informations pré-formatés du PLUi communes à toutes les communes pour la fiche de Renseignements d''urbanisme (données de production) ';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_parcelle_plui_ru OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_parcelle_plui_ru TO create_sig;
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_parcelle_plui_ru TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_parcelle_plui_ru TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_parcelle_plui_ru TO sig_create;

-- ####################################################### VUE - xappspublic_geo_vmr_fichegeo_plui_ru ##################################################

-- m_urbanisme_doc_v2024.xappspublic_geo_vmr_fichegeo_plui_ru source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xappspublic_geo_vmr_fichegeo_plui_ru
TABLESPACE pg_default
AS WITH req_par AS (
         SELECT geo_parcelle.geo_parcelle,
            geo_parcelle.idu,
            geo_parcelle.supf,
            geo_parcelle.geom
           FROM r_cadastre.geo_parcelle
          WHERE geo_parcelle.lot = 'arc'::text
        ), req_zonage AS (
         SELECT DISTINCT xappspublic_an_vmr_parcelle_plui_ru.idu,
            count(*) AS nb_zone,
            xappspublic_an_vmr_parcelle_plui_ru.section,
            xappspublic_an_vmr_parcelle_plui_ru.num_par,
            xappspublic_an_vmr_parcelle_plui_ru.commune,
            xappspublic_an_vmr_parcelle_plui_ru.datappro,
            xappspublic_an_vmr_parcelle_plui_ru.l_urldgen,
            xappspublic_an_vmr_parcelle_plui_ru.l_urlann,
            xappspublic_an_vmr_parcelle_plui_ru.l_urllex,
            xappspublic_an_vmr_parcelle_plui_ru.urlpe,
            string_agg(((('<a href="'::text || xappspublic_an_vmr_parcelle_plui_ru.l_urlfic::text) || '" target="_blank"><b><u>'::text) || xappspublic_an_vmr_parcelle_plui_ru.libelle::text) || '</b></u></a>'::text, '<font size=2> et </font>'::text) AS reg_zone
           FROM m_urbanisme_doc_v2024.xappspublic_an_vmr_parcelle_plui_ru
          WHERE xappspublic_an_vmr_parcelle_plui_ru.insee_par = xappspublic_an_vmr_parcelle_plui_ru.insee_plu::text
          GROUP BY xappspublic_an_vmr_parcelle_plui_ru.idu, xappspublic_an_vmr_parcelle_plui_ru.section, xappspublic_an_vmr_parcelle_plui_ru.num_par, xappspublic_an_vmr_parcelle_plui_ru.commune, xappspublic_an_vmr_parcelle_plui_ru.l_urldgen, xappspublic_an_vmr_parcelle_plui_ru.l_urlann, xappspublic_an_vmr_parcelle_plui_ru.l_urllex, xappspublic_an_vmr_parcelle_plui_ru.urlpe, xappspublic_an_vmr_parcelle_plui_ru.datappro
          ORDER BY xappspublic_an_vmr_parcelle_plui_ru.idu
        )
 SELECT DISTINCT row_number() OVER () AS gid,
    '60'::text || req_par.idu AS idu,
    req_zonage.section,
    req_zonage.num_par,
    req_par.supf,
    req_zonage.commune,
    req_zonage.datappro,
    req_zonage.reg_zone,
    req_zonage.l_urldgen,
    req_zonage.l_urlann,
    req_zonage.l_urllex,
    req_zonage.urlpe AS url_zip,
        CASE
            WHEN req_zonage.nb_zone IS NULL THEN 0::bigint::numeric
            ELSE req_zonage.nb_zone::numeric
        END AS nb_zone,
    req_par.geom
   FROM req_par
     LEFT JOIN req_zonage ON req_zonage.idu = ('60'::text || req_par.idu)
  GROUP BY ('60'::text || req_par.idu), req_zonage.section, req_zonage.num_par, req_zonage.commune, req_zonage.datappro, req_zonage.reg_zone, req_zonage.l_urldgen, req_zonage.l_urlann, req_zonage.l_urllex, req_zonage.urlpe, req_zonage.nb_zone, req_par.geom, req_par.supf
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xappspublic_geo_vmr_fichegeo_plui_ru IS 'Vue géographique matérialisée contenant les informations pour l''application Gd Public PLUi Interactif (données de production)';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xappspublic_geo_vmr_fichegeo_plui_ru OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xappspublic_geo_vmr_fichegeo_plui_ru TO create_sig;
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE m_urbanisme_doc_v2024.xappspublic_geo_vmr_fichegeo_plui_ru TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xappspublic_geo_vmr_fichegeo_plui_ru TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xappspublic_geo_vmr_fichegeo_plui_ru TO sig_create;

-- ####################################################### VUE - xappspublic_an_vmr_nru ##################################################

-- m_urbanisme_doc_v2024.xappspublic_an_vmr_nru source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xappspublic_an_vmr_nru
TABLESPACE pg_default
AS WITH req_princ AS (
         SELECT ru.idu,
            upper(ru.commune::text) AS nru_commune,
            ru.section AS nru_section,
            ru.num_par AS nru_numpar,
                CASE
                    WHEN length(ru.supf::character varying::text) >= 1 AND length(ru.supf::character varying::text) <= 3 THEN ru.supf::text
                    WHEN length(ru.supf::character varying::text) = 4 THEN replace(to_char(ru.supf, 'FM9G999'::text), ','::text, ' '::text)
                    WHEN length(ru.supf::character varying::text) = 5 THEN replace(to_char(ru.supf, 'FM99G999'::text), ','::text, ' '::text)
                    WHEN length(ru.supf::character varying::text) = 6 THEN replace(to_char(ru.supf, 'FM999G999'::text), ','::text, ' '::text)
                    WHEN length(ru.supf::character varying::text) = 7 THEN replace(to_char(ru.supf, 'FM9G999G999'::text), ','::text, ' '::text)
                    WHEN length(ru.supf::character varying::text) = 8 THEN replace(to_char(ru.supf, 'FM99G999G999'::text), ','::text, ' '::text)
                    ELSE ru.supf::text
                END || ' mètres carrés'::text AS nur_supf,
            ru.reg_zone AS nur_regzone,
            ru.l_urldgen AS nru_urldgen,
            ru.l_urlann AS nru_urlann,
            ru.l_urllex AS nru_urllex
           FROM m_urbanisme_doc_v2024.xappspublic_geo_vmr_fichegeo_plui_ru ru
        ), req_oap AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            string_agg((((((('<img src="http://geo.compiegnois.fr/documents/metiers/urba/divers/geo_legende_plu/picto_legende/s1800.png" width=34 heigth=21>'::text || ' <a href="'::text) || spct.urlfic::text) || '" target="_blank"><b>'::text) || spct.libelle::text) || ' (Nature : '::text) || spct.l_nature::text) || ')</b></a>'::text, '<br>'::text) AS oap
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_doc_v2024.geo_v_p_prescription_surf_arc spct
          WHERE st_intersects(p.geom, spct.geom1) IS TRUE AND spct.typepsc::text = '18'::text
          GROUP BY ('60'::text || p.idu), (spct.typepsc::text), spct.libelle
        ), req_q100 AS (
         SELECT p."IDU" AS idu,
            'Aléa inondation : la parcelle est concernée par la crue centennale (modélisation de décembre 2016).'::text AS libelle,
            ''::text AS urlfic
           FROM r_bg_edigeo."PARCELLE" p,
            m_risque.an_parcelle_q100_ru q100
          WHERE p."IDU"::text = q100.idu::text
        ), req_dpu AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            ('<a href="'::text || tinfo.urlfic::text) || '" target="_blank"><b>Droit de préemption urbain au bénéfice de l''Agglomération de la Région de Compiègne suite à la délibération du conseil d''Agglomération du 30 mars 2017.</b></a>'::text AS dpu
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_doc_v2024.geo_v_p_info_surf_arc tinfo
          WHERE st_intersects(p.geom, tinfo.geom1) IS TRUE AND tinfo.typeinf::text = '04'::text
          GROUP BY ('60'::text || p.idu), (tinfo.typeinf::text), tinfo.urlfic
        ), req_a5 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            (sup.code::text || ' : '::text) || sup.libelle::text AS a5
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo sup
          WHERE ('60'::text || p.idu) = sup.idu::text AND sup.code::text = 'A5'::text
          GROUP BY ('60'::text || p.idu), sup.libelle, sup.code
        ), req_ac1 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            (sup.code::text || ' : '::text) || sup.libelle::text AS ac1
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo sup
          WHERE ('60'::text || p.idu) = sup.idu::text AND sup.code::text = 'AC1'::text
          GROUP BY ('60'::text || p.idu), sup.libelle, sup.code
        ), req_ac4 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            'AC4 : Règlement d''aire de mise en valeur de l''architecture et du patrimoine (AVAP) et de zone de protection du patrimoine architectural, urbain et paysager (ZPPAUP)<br>Site patrimonial remarquable de la ville de Compiègne'::text AS ac4
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.geo_sup_ac4_assiette_sup_s sup
          WHERE st_intersects(st_pointonsurface(p.geom), sup.geom) IS TRUE AND p.lot = 'arc'::text
          GROUP BY p.idu
          ORDER BY ('60'::text || p.idu)
        ), req_pm1 AS (
         SELECT DISTINCT sup.idu,
            (('PM1 : Plan de Prévention des risques d''inondation, zone(s) '::text || string_agg(sup.l_zone::text, ' et '::text)) || '<br>'::text) || sup1.l_url::text AS pm1
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo_pm1 sup,
            m_urbanisme_reg.an_sup_geo sup1
          WHERE ('60'::text || p.idu) = sup.idu::text AND ('60'::text || p.idu) = sup1.idu::text AND p.lot = 'arc'::text AND sup1.code::text = 'PM1'::text
          GROUP BY sup.idu, sup1.l_url
          ORDER BY sup.idu
        ), req_a4 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            string_agg(sup.ligne_aff::text, '<br>'::text) AS a4
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo sup
          WHERE ('60'::text || p.idu) = sup.idu::text AND sup.code::text = 'A4'::text
          GROUP BY ('60'::text || p.idu)
        ), req_ac2 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            string_agg((sup.code::text || ' : '::text) || sup.libelle::text, '<br>'::text) AS ac2
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo sup
          WHERE ('60'::text || p.idu) = sup.idu::text AND sup.code::text = 'AC2'::text
          GROUP BY ('60'::text || p.idu)
        ), req_as1 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            (sup.code::text || ' : '::text) || sup.libelle::text AS as1
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo sup
          WHERE ('60'::text || p.idu) = sup.idu::text AND sup.code::text = 'AS1'::text
          GROUP BY ('60'::text || p.idu), ((sup.code::text || ' : '::text) || sup.libelle::text)
          ORDER BY ('60'::text || p.idu)
        ), req_el3 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            (sup.code::text || ' : '::text) || sup.libelle::text AS el3
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo sup
          WHERE ('60'::text || p.idu) = sup.idu::text AND sup.code::text = 'EL3'::text
          GROUP BY ('60'::text || p.idu), ((sup.code::text || ' : '::text) || sup.libelle::text)
        ), req_el7 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            (sup.code::text || ' : '::text) || sup.libelle::text AS el7
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo sup
          WHERE ('60'::text || p.idu) = sup.idu::text AND sup.code::text = 'EL7'::text
          GROUP BY ('60'::text || p.idu), ((sup.code::text || ' : '::text) || sup.libelle::text)
        ), req_i3 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            (sup.code::text || ' : '::text) || sup.libelle::text AS i3
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo sup
          WHERE ('60'::text || p.idu) = sup.idu::text AND sup.code::text = 'I3'::text
          GROUP BY ('60'::text || p.idu), ((sup.code::text || ' : '::text) || sup.libelle::text)
          ORDER BY ('60'::text || p.idu)
        ), req_i4 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            (sup.code::text || ' : '::text) || sup.libelle::text AS i4
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo sup
          WHERE ('60'::text || p.idu) = sup.idu::text AND sup.code::text = 'I4'::text
          GROUP BY ('60'::text || p.idu), ((sup.code::text || ' : '::text) || sup.libelle::text)
          ORDER BY ('60'::text || p.idu)
        ), req_pt1 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            (sup.code::text || ' : '::text) || sup.libelle::text AS pt1
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo sup
          WHERE ('60'::text || p.idu) = sup.idu::text AND sup.code::text = 'PT1'::text
          GROUP BY ('60'::text || p.idu), ((sup.code::text || ' : '::text) || sup.libelle::text)
          ORDER BY ('60'::text || p.idu)
        ), req_pt2 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            (sup.code::text || ' : '::text) || sup.libelle::text AS pt2
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo sup
          WHERE ('60'::text || p.idu) = sup.idu::text AND sup.code::text = 'PT2'::text
          GROUP BY ('60'::text || p.idu), ((sup.code::text || ' : '::text) || sup.libelle::text)
          ORDER BY ('60'::text || p.idu)
        ), req_pt2lh AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            (sup.code::text || ' : '::text) || sup.libelle::text AS pt2lh
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo sup
          WHERE ('60'::text || p.idu) = sup.idu::text AND sup.code::text = 'PT2LH'::text
          GROUP BY ('60'::text || p.idu), ((sup.code::text || ' : '::text) || sup.libelle::text)
          ORDER BY ('60'::text || p.idu)
        ), req_t1 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            (sup.code::text || ' : '::text) || sup.libelle::text AS t1
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo sup
          WHERE ('60'::text || p.idu) = sup.idu::text AND sup.code::text = 'T1'::text
          GROUP BY ('60'::text || p.idu), ((sup.code::text || ' : '::text) || sup.libelle::text)
          ORDER BY ('60'::text || p.idu)
        ), req_t4t5 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            (sup.code::text || ' : '::text) || sup.libelle::text AS t5
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.an_sup_geo sup
          WHERE ('60'::text || p.idu) = sup.idu::text AND sup.code::text = 'T4-T5'::text
          GROUP BY ('60'::text || p.idu), ((sup.code::text || ' : '::text) || sup.libelle::text)
          ORDER BY ('60'::text || p.idu)
        ), req_supcom AS (
         SELECT DISTINCT an_sup_geo_commune_synthese.idu,
                CASE
                    WHEN an_sup_geo_commune_synthese.ligne_aff::text ~~ 'Aucune%'::text THEN 'Aucune'::text
                    ELSE replace(an_sup_geo_commune_synthese.ligne_aff::text, 'Atlas des Zones inondables'::text, ''::text)
                END AS sup_com
           FROM m_urbanisme_reg.an_sup_geo_commune_synthese
          WHERE "left"(an_sup_geo_commune_synthese.idu::text, 5) = ANY (ARRAY['60023'::text, '60070'::text, '60067'::text, '60068'::text, '60151'::text, '60156'::text, '60159'::text, '60323'::text, '60325'::text, '60326'::text, '60337'::text, '60338'::text, '60382'::text, '60402'::text, '60447'::text, '60578'::text, '60579'::text, '60597'::text, '60600'::text, '60665'::text, '60667'::text, '60674'::text])
          ORDER BY an_sup_geo_commune_synthese.idu
        ), req_psc_pct AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            string_agg(DISTINCT ((((('<img src="http://geo.compiegnois.fr/documents/metiers/urba/divers/geo_legende_plu/picto_legende/p'::text || ppct.typepsc::text) || ppct.stypepsc::text) || '.png" width=17 heigth=17>'::text) || ' '::text) || ppct.libelle::text) ||
                CASE
                    WHEN ppct.l_nature IS NULL OR ppct.l_nature::text = ''::text THEN ''::text
                    ELSE '<br> Nature : '::text || ppct.l_nature::text
                END, '<br>'::text) AS psc_pct
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_doc.geo_v_p_prescription_pct_arc ppct
          WHERE st_intersects(p.geom, ppct.geom) IS TRUE
          GROUP BY ('60'::text || p.idu)
        ), req_psc_lin AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
                CASE
                    WHEN lpct.l_nature::text = 'Cône de vue'::text THEN ''::text
                    ELSE string_agg(DISTINCT ((((('<img src="http://geo.compiegnois.fr/documents/metiers/urba/divers/geo_legende_plu/picto_legende/l'::text || lpct.typepsc::text) || lpct.stypepsc::text) || '.png" width=41 heigth=11>'::text) || ' '::text) || lpct.libelle::text) ||
                    CASE
                        WHEN lpct.l_nature IS NULL OR lpct.l_nature::text = ''::text THEN ''::text
                        ELSE '<br> Nature : '::text || lpct.l_nature::text
                    END, '<br>'::text)
                END AS psc_lin
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_doc.geo_v_p_prescription_lin_arc lpct
          WHERE st_intersects(p.geom, lpct.geom1) IS TRUE
          GROUP BY ('60'::text || p.idu), lpct.l_nature
        ), req_psc_lin_cv_01 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            string_agg(DISTINCT (('<img src="http://geo.compiegnois.fr/documents/metiers/urba/divers/geo_legende_plu/picto_legende/l0701cv.png" width=41 heigth=11>'::text || ' '::text) || lpct.libelle::text) ||
                CASE
                    WHEN lpct.l_nature IS NULL OR lpct.l_nature::text = ''::text THEN ''::text
                    ELSE '<br> Nature : '::text || lpct.l_nature::text
                END, '<br>'::text) AS psc_lin
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_doc.geo_v_p_prescription_lin_arc lpct
          WHERE st_intersects(p.geom, lpct.geom1) IS TRUE AND lpct.l_nature::text ~~ '%de vue%'::text AND (lpct.typepsc::text || lpct.stypepsc::text) = '0701'::text
          GROUP BY ('60'::text || p.idu)
        ), req_psc_lin_cv_03 AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            string_agg(DISTINCT (('<img src="http://geo.compiegnois.fr/documents/metiers/urba/divers/geo_legende_plu/picto_legende/l0703cv.png" width=41 heigth=11>'::text || ' '::text) || lpct.libelle::text) ||
                CASE
                    WHEN lpct.l_nature IS NULL OR lpct.l_nature::text = ''::text THEN ''::text
                    ELSE '<br> Nature : '::text || lpct.l_nature::text
                END, '<br>'::text) AS psc_lin
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_doc.geo_v_p_prescription_lin_arc lpct
          WHERE st_intersects(p.geom, lpct.geom1) IS TRUE AND lpct.l_nature::text ~~ '%de vue%'::text AND ((lpct.typepsc::text || lpct.stypepsc::text) = ANY (ARRAY['0701'::text, '0702'::text, '0703'::text, '0704'::text, '0705'::text]))
          GROUP BY ('60'::text || p.idu)
        ), req_psc_surf AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            string_agg(DISTINCT ((((('<img src="http://geo.compiegnois.fr/documents/metiers/urba/divers/geo_legende_plu/picto_legende/s'::text || spct.typepsc::text) || spct.stypepsc::text) || '.png" width=34 heigth=21>'::text) || ' '::text) || spct.libelle::text) ||
                CASE
                    WHEN spct.l_nature IS NULL OR spct.l_nature::text = ''::text THEN ''::text
                    ELSE '<br> Nature : '::text || spct.l_nature::text
                END, '<br>'::text) AS psc_surf
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_doc.geo_v_p_prescription_surf_arc spct
          WHERE st_intersects(p.geom, spct.geom1) IS TRUE AND spct.typepsc::text <> '18'::text
          GROUP BY ('60'::text || p.idu)
        ), req_zac AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            string_agg((('<img src="http://geo.compiegnois.fr/documents/metiers/urba/divers/geo_legende_plu/picto_legende/is0200.png" width=34 heigth=21>'::text || ' '::text) || 'Zone d''aménagement concerté'::text) ||
                CASE
                    WHEN isurf.nom IS NULL OR isurf.nom::text = ''::text THEN ''::text
                    ELSE ' - Nom : '::text || isurf.nom::text
                END, '<br>'::text) AS zac
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.geo_proced isurf
          WHERE isurf.z_proced::text = '10'::text AND st_intersects(p.geom, isurf.geom1)
          GROUP BY ('60'::text || p.idu)
        ), req_infosurf AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            string_agg(
                CASE
                    WHEN isurf.typeinf::text = '14'::text THEN (((isurf.libelle::text || ' ('::text) || isurf.l_gen::text) || ')'::text)::character varying
                    WHEN isurf.typeinf::text = '19'::text THEN (('Zonage d''assainissement ('::text || isurf.l_nom::text) || ')'::text)::character varying
                    ELSE isurf.libelle
                END::text, '<br>'::text) AS isurf
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_doc.geo_v_p_info_surf_arc isurf
          WHERE (isurf.typeinf::text = '14'::text OR isurf.typeinf::text = '19'::text OR isurf.typeinf::text = '20'::text OR isurf.typeinf::text = '38'::text) AND st_intersects(p.geom, isurf.geom1) IS TRUE
          GROUP BY ('60'::text || p.idu)
        ), req_archeo AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
            'Zonage archéologique'::text AS archeo
           FROM r_cadastre.geo_parcelle p,
            m_urbanisme_reg.geo_zonage_archeologique za
          WHERE "left"('60'::text || p.idu, 5) = za.insee::text AND p.lot = 'arc'::text
          ORDER BY ('60'::text || p.idu)
        ), req_txamt AS (
         SELECT DISTINCT '60'::text || p.idu AS idu,
                CASE
                    WHEN tx.taux::text = 'Non renseigné'::text THEN 'Taxe d''aménagement (taux non connue)'::text
                    ELSE ('Taxe d''aménagement au taux de '::text || replace(tx.taux::text, '.00'::text, ''::text)) || '%'::text
                END AS txamt
           FROM r_cadastre.geo_parcelle p,
            x_apps.xapps_an_fisc_geo_taxe_amgt tx
          WHERE ('60'::text || p.idu) = tx.idu::text AND p.lot = 'arc'::text
          ORDER BY ('60'::text || p.idu)
        )
 SELECT DISTINCT req_princ.idu,
    upper(req_princ.nru_commune) AS nru_commune,
    req_princ.nru_section,
    req_princ.nru_numpar,
    req_princ.nur_supf,
    req_princ.nur_regzone,
    req_princ.nru_urldgen,
    req_princ.nru_urlann,
    req_princ.nru_urllex,
        CASE
            WHEN req_oap.oap IS NULL THEN 'nc'::text
            ELSE string_agg(req_oap.oap, '<br>'::text)
        END AS oap,
        CASE
            WHEN req_dpu.dpu IS NULL THEN 'nc'::text
            ELSE req_dpu.dpu
        END AS dpu,
        CASE
            WHEN req_a5.a5 IS NULL THEN 'nc'::text
            ELSE req_a5.a5
        END AS a5,
        CASE
            WHEN req_ac1.ac1 IS NULL THEN 'nc'::text
            ELSE req_ac1.ac1
        END AS ac1,
        CASE
            WHEN req_ac4.ac4 IS NULL THEN 'nc'::text
            ELSE req_ac4.ac4
        END AS ac4,
        CASE
            WHEN req_pm1.pm1 IS NULL THEN 'nc'::text
            ELSE req_pm1.pm1
        END AS pm1,
        CASE
            WHEN req_a4.a4 IS NULL THEN 'nc'::text
            ELSE req_a4.a4
        END AS a4,
        CASE
            WHEN req_ac2.ac2 IS NULL THEN 'nc'::text
            ELSE req_ac2.ac2
        END AS ac2,
        CASE
            WHEN req_as1.as1 IS NULL THEN 'nc'::text
            ELSE req_as1.as1
        END AS as1,
        CASE
            WHEN req_el3.el3 IS NULL THEN 'nc'::text
            ELSE req_el3.el3
        END AS el3,
        CASE
            WHEN req_el7.el7 IS NULL THEN 'nc'::text
            ELSE req_el7.el7
        END AS el7,
        CASE
            WHEN req_i3.i3 IS NULL THEN 'nc'::text
            ELSE req_i3.i3
        END AS i3,
        CASE
            WHEN req_i4.i4 IS NULL THEN 'nc'::text
            ELSE req_i4.i4
        END AS i4,
        CASE
            WHEN req_pt1.pt1 IS NULL THEN 'nc'::text
            ELSE req_pt1.pt1
        END AS pt1,
        CASE
            WHEN req_pt2.pt2 IS NULL THEN 'nc'::text
            ELSE req_pt2.pt2
        END AS pt2,
        CASE
            WHEN req_pt2lh.pt2lh IS NULL THEN 'nc'::text
            ELSE req_pt2lh.pt2lh
        END AS pt2lh,
        CASE
            WHEN req_t1.t1 IS NULL THEN 'nc'::text
            ELSE req_t1.t1
        END AS t1,
        CASE
            WHEN req_t4t5.t5 IS NULL THEN 'nc'::text
            ELSE req_t4t5.t5
        END AS t5,
        CASE
            WHEN req_supcom.sup_com IS NULL THEN 'nc'::text
            ELSE req_supcom.sup_com
        END AS sup_com,
        CASE
            WHEN req_psc_pct.psc_pct IS NULL THEN 'nc'::text
            ELSE req_psc_pct.psc_pct
        END AS psc_pct,
        CASE
            WHEN req_psc_lin.psc_lin IS NULL OR req_psc_lin.psc_lin = ''::text THEN 'nc'::text
            ELSE req_psc_lin.psc_lin
        END AS psc_lin,
        CASE
            WHEN req_psc_lin_cv_01.psc_lin IS NULL THEN 'nc'::text
            ELSE req_psc_lin_cv_01.psc_lin
        END AS req_psc_lin_cv_01,
        CASE
            WHEN req_psc_lin_cv_03.psc_lin IS NULL THEN 'nc'::text
            ELSE req_psc_lin_cv_03.psc_lin
        END AS req_psc_lin_cv_03,
        CASE
            WHEN req_psc_surf.psc_surf IS NULL THEN 'nc'::text
            ELSE req_psc_surf.psc_surf
        END AS psc_surf,
        CASE
            WHEN req_zac.zac IS NULL THEN 'nc'::text
            ELSE req_zac.zac
        END AS zac,
        CASE
            WHEN req_infosurf.isurf IS NULL THEN 'nc'::text
            ELSE req_infosurf.isurf
        END AS isurf,
        CASE
            WHEN req_archeo.archeo IS NULL THEN 'nc'::text
            ELSE req_archeo.archeo
        END AS archeo,
        CASE
            WHEN req_txamt.txamt IS NULL THEN 'nc'::text
            ELSE req_txamt.txamt
        END AS txamt,
        CASE
            WHEN req_q100.libelle IS NULL THEN 'nc'::text
            ELSE req_q100.libelle
        END AS q100
   FROM req_princ
     LEFT JOIN req_oap ON req_princ.idu = req_oap.idu
     LEFT JOIN req_dpu ON req_princ.idu = req_dpu.idu
     LEFT JOIN req_a5 ON req_princ.idu = req_a5.idu
     LEFT JOIN req_ac1 ON req_princ.idu = req_ac1.idu
     LEFT JOIN req_ac4 ON req_princ.idu = req_ac4.idu
     LEFT JOIN req_pm1 ON req_princ.idu = req_pm1.idu::text
     LEFT JOIN req_a4 ON req_princ.idu = req_a4.idu
     LEFT JOIN req_ac2 ON req_princ.idu = req_ac2.idu
     LEFT JOIN req_as1 ON req_princ.idu = req_as1.idu
     LEFT JOIN req_el3 ON req_princ.idu = req_el3.idu
     LEFT JOIN req_el7 ON req_princ.idu = req_el7.idu
     LEFT JOIN req_i3 ON req_princ.idu = req_i3.idu
     LEFT JOIN req_i4 ON req_princ.idu = req_i4.idu
     LEFT JOIN req_pt1 ON req_princ.idu = req_pt1.idu
     LEFT JOIN req_pt2 ON req_princ.idu = req_pt2.idu
     LEFT JOIN req_pt2lh ON req_princ.idu = req_pt2lh.idu
     LEFT JOIN req_t1 ON req_princ.idu = req_t1.idu
     LEFT JOIN req_t4t5 ON req_princ.idu = req_t4t5.idu
     LEFT JOIN req_supcom ON req_princ.idu = req_supcom.idu::text
     LEFT JOIN req_psc_pct ON req_princ.idu = req_psc_pct.idu
     LEFT JOIN req_psc_lin ON req_princ.idu = req_psc_lin.idu
     LEFT JOIN req_psc_lin_cv_01 ON req_princ.idu = req_psc_lin_cv_01.idu
     LEFT JOIN req_psc_lin_cv_03 ON req_princ.idu = req_psc_lin_cv_03.idu
     LEFT JOIN req_psc_surf ON req_princ.idu = req_psc_surf.idu
     LEFT JOIN req_zac ON req_princ.idu = req_zac.idu
     LEFT JOIN req_infosurf ON req_princ.idu = req_infosurf.idu
     LEFT JOIN req_archeo ON req_princ.idu = req_archeo.idu
     LEFT JOIN req_txamt ON req_princ.idu = req_txamt.idu
     LEFT JOIN req_q100 ON req_princ.idu = req_q100.idu::text
  GROUP BY req_q100.libelle, req_princ.idu, req_princ.nru_commune, req_princ.nru_section, req_princ.nru_numpar, req_princ.nur_supf, req_princ.nur_regzone, req_princ.nru_urldgen, req_princ.nru_urlann, req_princ.nru_urllex, req_oap.oap, req_dpu.dpu, req_a5.a5, req_ac1.ac1, req_ac4.ac4, req_pm1.pm1, req_a4.a4, req_ac2.ac2, req_el3.el3, req_as1.as1, req_el7.el7, req_i3.i3, req_i4.i4, req_pt1.pt1, req_pt2.pt2, req_pt2lh.pt2lh, req_t1.t1, req_t4t5.t5, req_supcom.sup_com, req_psc_pct.psc_pct, req_psc_lin.psc_lin, req_psc_lin_cv_01.psc_lin, req_psc_lin_cv_03.psc_lin, req_psc_surf.psc_surf, req_zac.zac, req_infosurf.isurf, req_archeo.archeo, req_txamt.txamt
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xappspublic_an_vmr_nru IS 'Vue matérialisée contenant les informations pré-formatés du PLUi communes à toutes les communes pour la note de renseignements d''urbanisme';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_nru OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_nru TO create_sig;
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_nru TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_nru TO sig_read;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_nru TO sig_create;

-- ####################################################### VUE - xappspublic_an_vmr_p_planche_graphique_plui_arc ##################################################

-- m_urbanisme_doc_v2024.xappspublic_an_vmr_p_planche_graphique_plui_arc source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xappspublic_an_vmr_p_planche_graphique_plui_arc
TABLESPACE pg_default
AS WITH req_par AS (
         SELECT row_number() OVER () AS gid,
            '60'::text || c.idu AS idu,
            p.id_maille,
            'pluih_arc'::text AS plu
           FROM m_urbanisme_doc_v2024.geo_p_planche_pluiarc p,
            r_cadastre.geo_parcelle c
          WHERE c.lot = 'arc'::text AND p.insee::text = ('60'::text || "left"(c.idu, 3)) AND st_intersects(p.geom, st_pointonsurface(c.geom)) IS TRUE
        ), req_plu AS (
         SELECT 'pluih_arc'::text AS plu,
            d.siren,
            d.datappro,
            d.idurba
           FROM m_urbanisme_doc_v2024.an_doc_urba d
          WHERE d.etat::text = '03'::text AND d.siren::text = '200067965'::text
        )
 SELECT row_number() OVER () AS gid,
    req_par.idu,
    'Planche(s) graphique(s) n°'::text || string_agg(((('<a href="'::text ||
        CASE
            WHEN req_par.id_maille = 10 OR req_par.id_maille = 11 THEN ((((('https://geo.compiegnois.fr/documents/metiers/urba/docurba/'::text || replace(req_plu.idurba::text, 'PLUI'::text, 'PLUi'::text)) || '/Pieces_ecrites/3_Reglement/'::text) || req_plu.siren::text) || '_reglement_graphique_10_11_'::text) || req_plu.datappro::text) || '.pdf'::text
            ELSE ((((((('https://geo.compiegnois.fr/documents/metiers/urba/docurba/'::text || replace(req_plu.idurba::text, 'PLUI'::text, 'PLUi'::text)) || '/Pieces_ecrites/3_Reglement/'::text) || req_plu.siren::text) || '_reglement_graphique_'::text) || req_par.id_maille) || '_'::text) || req_plu.datappro::text) || '.pdf'::text
        END) || '" target="_blank">'::text) || req_par.id_maille) || '</a>'::text, ', '::text ORDER BY req_par.id_maille) AS num_planche
   FROM req_par,
    req_plu
  WHERE req_par.plu = req_plu.plu
  GROUP BY req_par.idu
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xappspublic_an_vmr_p_planche_graphique_plui_arc IS 'Vue matérialisée formatant l''accès aux planches du règlement graphique du PLUiH (cette vue est ensuite liée dans GEO pour accessiiblité à la parcelle dans la fiche de renseignements d''urbanisme dans GEO)';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_p_planche_graphique_plui_arc OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_p_planche_graphique_plui_arc TO create_sig;
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_p_planche_graphique_plui_arc TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_p_planche_graphique_plui_arc TO sig_read;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xappspublic_an_vmr_p_planche_graphique_plui_arc TO sig_create;

-- ####################################################### VUE - xappspublic_geo_vmr_commune_plui_ru ##################################################

-- m_urbanisme_doc_v2024.xappspublic_geo_vmr_commune_plui_ru source

CREATE MATERIALIZED VIEW m_urbanisme_doc_v2024.xappspublic_geo_vmr_commune_plui_ru
TABLESPACE pg_default
AS SELECT "left"(p.idurba::text, 5) AS insee,
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
                WHEN np.code::text = 'E'::text THEN 'd''une <b>'::text || lower(np.valeur::text)
                WHEN np.code::text = 'M'::text THEN 'de la <b>'::text || lower(np.valeur::text)
                WHEN np.code::text = 'MEC'::text THEN 'de la <b>'::text || lower(np.valeur::text)
                WHEN np.code::text = 'MAJ'::text THEN 'de la <b>'::text || lower(np.valeur::text)
                WHEN np.code::text = 'MS'::text THEN 'de la <b>'::text || lower(np.valeur::text)
                WHEN np.code::text = 'R'::text THEN 'd''une <b>'::text || lower(np.valeur::text)
                WHEN np.code::text = 'RS'::text THEN 'de la <b>'::text || lower(np.valeur::text)
                WHEN np.code::text = 'RA'::text THEN 'de la <b>'::text || lower(np.valeur::text)
                ELSE NULL::text
            END
        END ||
        CASE
            WHEN p.l_nomprocn IS NULL OR p.l_nomprocn = 0 THEN '</b></font>'::text
            ELSE (' n°'::text || p.l_nomprocn) || '</b></font>'::text
        END AS typedoc_l,
    c.geom
   FROM m_urbanisme_doc_v2024.an_doc_urba p,
    r_cadastre.geo_commune c,
    r_administratif.an_geo,
    m_urbanisme_doc_v2024.lt_nomproc np
  WHERE "left"(p.idurba::text, 5) = ('60'::text || c.idu) AND np.code::text = p.nomproc::text AND p.etat::bpchar = '03'::bpchar AND an_geo.insee::text = ('60'::text || c.idu)
WITH DATA;

COMMENT ON MATERIALIZED VIEW m_urbanisme_doc_v2024.xappspublic_geo_vmr_commune_plui_ru IS 'Vue matérialisée contenant les informations pré-formatés pour la constitution de la fiche d''information sur les communes dans l''application PLU Interactif V0.2 (test pour voir où on met les infos d''urbanisme)';

-- Permissions

ALTER TABLE m_urbanisme_doc_v2024.xappspublic_geo_vmr_commune_plui_ru OWNER TO create_sig;
GRANT ALL ON TABLE m_urbanisme_doc_v2024.xappspublic_geo_vmr_commune_plui_ru TO create_sig;
GRANT SELECT, UPDATE, DELETE, INSERT ON TABLE m_urbanisme_doc_v2024.xappspublic_geo_vmr_commune_plui_ru TO sig_edit;
GRANT SELECT ON TABLE m_urbanisme_doc_v2024.xappspublic_geo_vmr_commune_plui_ru TO sig_read;
*/

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                INDEX (sur les tables)                                                        ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

CREATE INDEX geo_p_habillage_lin_geom_idx
  ON m_urbanisme_doc_v2024.geo_p_habillage_lin
  USING gist
  (geom);

CREATE INDEX geo_p_habillage_pct_geom_idx
  ON m_urbanisme_doc_v2024.geo_p_habillage_pct
  USING gist
  (geom);

CREATE INDEX geo_p_habillage_surf_geom_idx
  ON m_urbanisme_doc_v2024.geo_p_habillage_surf
  USING gist
  (geom);

CREATE INDEX geo_p_habillage_txt_geom_idx
  ON m_urbanisme_doc_v2024.geo_p_habillage_txt
  USING gist
  (geom);

CREATE INDEX geo_p_info_lin_geom_idx
  ON m_urbanisme_doc_v2024.geo_p_info_lin
  USING gist
  (geom);

CREATE INDEX geo_p_info_pct_geom_idx
  ON m_urbanisme_doc_v2024.geo_p_info_pct
  USING gist
  (geom);


CREATE INDEX geo_p_info_surf_geom_idx
  ON m_urbanisme_doc_v2024.geo_p_info_surf
  USING gist
  (geom);

CREATE INDEX geo_p_zone_urba_geom_idx
  ON m_urbanisme_doc_v2024.geo_p_zone_urba
  USING gist
  (geom);

