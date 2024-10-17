/*PLU V1.0*/
/*Creation du fichier trace qui permet de suivre l'évolution du code*/
/* plu_00_trace.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Grégory Bodet */

/*
#################################################################### SUIVI CODE SQL ####################################################################
-- Le développement originel a débuté en 2010. Le développement a évolué et a été optimisé depuis sans qu'il n'y est de documentation.

###################################################################
-- 2024-10-17 : GB / passage du standard PLU 2017d au standard 2024
###################################################################

-- mise à jour de la structure de données au format 2024, ajout des attributs supplémentaires :
-- ...........................................................................................

-- SYMOBLE : pour les classes informations, prescriptions et zone_urba
-- NATURE : pour les classes prescriptions (passage d'un character de longueur 50 à 254)
-- FORMDOMI : pour la classe zone_urba
-- DESTOUI : pour la classe zone_urba
-- DESTCDT : pour la classe zone_urba
-- DESTNON : pour la classe zone_urba

-- mise à jour des listes de valeurs (types énumérés)
-- ...........................................................................................

-- référentiel de saisies
-- type de procédure d'urbanisme
-- type d'informations
-- type de prescriptions

-- migration des données du format 2017d au format 2024
-- ...........................................................................................

-- ajustement des valeurs des types de procédures dans la classe zone_urba : valeur MC en MEC, valeur MJ en MAJ
-- suppression de l'attribut métier L_DESTDOMI au profit de l'attribut FORMDOMI dans la classe zone_urba : ajustement des valeurs avec la nouvelle liste des types énumérés (passage d'un codage de 2 caractères à 4 caractères)
-- les nouveaux attributs SYMBOLE, DESTOUI, DESTCDT et DESTNON ont été initialisés avec une valeur NULL
-- l'attribut NATURE a été complété par l'attribut L_NATURE en minuscule et les blancs remplacés par des '_' (du fait des recommandations de contenus du standard, mot séparé par le caractère '_' et non d'un espace)
-- l'attribut L_NATURE reste un attribut métier à compléter pour un affichage utilisateur clair. L'attribut NATURE pour le standard est complété automatiquement à la saisie ou à la mise jour
-- les valeurs des attributs NOMFIC et URLFIC ont été modifiées pour la classe d'objets des prescriptions surfaciques concernant les OAP : remplacements de 'orientations_aménagement' par oap dans le nom du fichiers et le répertoire '5_Orientations_amenagement' par '5_OAP'

-- divers
-- ......

-- le script de migrations a été initialisé pour migrer le schéma 'm_urbanisme_doc' vers un schéma 'm_urbanisme_doc_v2024'
-- les parties du script ne faisant pas parties du standard CNIG ont été commentées pour être adaptés par les différents partenaires
-- les droits des différentes classes ont également été commentées pour être adaptés par les différents partenaires
