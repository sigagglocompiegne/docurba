![picto](img/Logo_web-GeoCompiegnois.png)

# Documentation d'administration de l'application #

# Généralité

|Représentation| Nom de l'application |Résumé|
|:---|:---|:---|
|![picto](/doc/img/picto_docurba.png)|Cadastre-Urbanisme|Cette application est dédiée à la consultation des données cadastrales ainsi qu'à la consultation des règles d'urbanisme et utilise l'ensemble de la base de données des documents d'urbanisme. Cependant les recherches et informations liées à cette application ont été intégrées également dans d'autres applications métiers afin que les utilisateurs puissent avoir accès à ses informations dans leurs propres applicatifs au lieu de se connecter à l'application Cadastre-Urbanisme.|
|![picto](/doc/img/picto_docurba1.png)|Urbanisme|Cette application est identique à l'application Cadastre-Urbanisme à la différence que les personnes se connectant à cette application n'ont pas accès aux informations détaillées de la matrice cadastrale.|

# Accès

|Public|Métier|Accès restreint|
|:-:|:-:|:---|
||X|Accès réservé aux personnels des communes et des EPCI ayant les droits d'accès. 2 profils cohabitent, ceux qui ont accès à la consultation de la matrice cadastrale et ceux qui ne l'ont pas.|

# Droit par profil de connexion

* **Prestataires**

Sans Objet

* **Personnes du service métier**

|Fonctionnalités|Lecture|Ecriture|Précisions|
|:---|:-:|:-:|:---|
|Toutes|x||L'ensemble des fonctionnalités (recherches, cartographie, fiches d'informations, ...) sont accessibles par tous les utilisateurs connectés.|
|Modification géométrique - PPRi zonage (projet) - remarque|x||Cette fonctionnalité est uniquement visible par les utilisateurs inclus dans les groupes ADMIN et PPRI_EDIT|

* **Autres profils**

Sans objet

# Les données

Sont décrites ici les Géotables et/ou Tables intégrées dans GEO pour les besoins de l'application. Les autres données servant d'habillage (pour la cartographie ou les recherches) sont listées dans les autres parties ci-après. Le tableau ci-dessous présente uniquement les changements (type de champ, formatage du résultat, ...) ou les ajouts (champs calculés, filtre, ...) non présents dans la donnée source. 

## Table : `r_bg_edigeo.PARCELLE`

Cette table est intégrée via le module GeoCadastre et est donc formatée par l'intégrateur. Aucune modification réalisée par l'ARC. Les relations forcées avec d'autres tables induites par cette intégration ne sont pas relatés dans cette documentation.

## Table : `r_bg_majic.NBAT_10 (Parcelle (Alpha) V3 dans GEO`

Cette table est intégrée via le module GeoCadastre et est donc formatée par l'intégrateur. Aucune modification réalisée par l'ARC. Sur cette table est reliée l'ensemble des autres tables ou geotable issues de la base de données de l'ARC pour affichage dans la fiche de renseignements d'urbanisme.

## Table : `an_v_docurba_valide`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|datappro||x|Approbation|Formate la date du dernier en contrôle en dd/mm/yyyy|Fiche de renseignements d'urbanisme||
|format_datappro|x|x||Formate la date du dernier en contrôle en dd/mm/yyyy (code sql)|champ calculé tableau_doc_vigueur pour test Fiche de renseignements d'urbanisme en HTML||
|l_version||x|Version||Fiche de renseignements d'urbanisme||
|tableau_doc_vigueur|x|x|null|Déclaré en HTML. Formate un tableau HTML contenant les éléments de la procédure actuelle|Test Fiche de renseignements d'urbanisme en HTML||
|titre_ac4 |x|x|null|Déclaré en HTML. Formatage du titre pour la SUP AC4|Fiche de renseignements d'urbanisme||
|titre_doc_urba_valide_html  |x|x|null|Déclaré en HTML. Formatage du titre pour la partie sur la procédure actuelle|Fiche de renseignements d'urbanisme||
|titre_dpu_html |x|x|null|Déclaré en HTML. Formatage du titre pour la partie sur les DPU|Fiche de renseignements d'urbanisme||
|titre_info_utile_html |x|x|null|Déclaré en HTML. Formatage du titre pour la partie sur les informations jugées utiles|Fiche de renseignements d'urbanisme||
|titre_liste_sup_com |x|x|null|Déclaré en HTML. Formatage du titre pour la partie sur la liste des SUP devant encore être intégrées à la commune|Fiche de renseignements d'urbanisme||
|titre_prescription_html  |x|x|null|Déclaré en HTML. Formatage du titre pour la partie sur les prescriptions|Fiche de renseignements d'urbanisme||
|titre_sup_html   |x|x|null|Déclaré en HTML. Formatage du titre pour la partie sur les SUP intégrées|Fiche de renseignements d'urbanisme||
|titre_sup_impact   |x|x|null|Déclaré en HTML. Formatage du sous-titre pour la partie sur les SUP intégrées|Fiche de renseignements d'urbanisme||
|titre_taxe_amgt   |x|x|null|Déclaré en HTML. Formatage du titre pour la partie sur la taxe d'aménagement|Fiche de renseignements d'urbanisme||
|titre_zonage_html   |x|x|null||Déclaré en HTML. Utilisée pour les anciennes fiches de renseignements d'urbanisme||

   * filtres : aucun
   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
| r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3 dans GEO | CCOCOM = insee | 1 (égal) |

   * particularité(s) : les champs calculés permettant d'afficher les titres des différentes rubriques de la fiche de renseignements d'urbanisme ont été intégrés dans cette table, car c'est la seule a remonté toujours un enregistrement à chaque parcelle intérogée car elle appartient forcément à une commune avec ou sans procédure d'urbanisme en vigueur.
   
## Table : `xapps_an_vmr_p_information_dpu`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|beneficiaire||x|Bénéficiaire||Fiche de renseignements d'urbanisme||
|date_ins||x|Instauré le||Fiche de renseignements d'urbanisme||
|urlfic||x|+ d'infos|Déclaré en lien. Texte de remplacement dans GEO : Document lié|Fiche de renseignements d'urbanisme||

   * filtres : aucun
   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
| r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3 dans GEO | idu | 0 à n (égal) |

   * particularité(s) : aucune

## Table : `xapps_an_vmr_p_information`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|libelle||x|Libellé||Fiche de renseignements d'urbanisme||
|lien|x|x|+ d'infos|Déclaré en lien. Affiche le lien du document si il existe autrement rien.Texte de remplacement dans GEO : Document lié|Fiche de renseignements d'urbanisme||

   * filtres : aucun
   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
| r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3 dans GEO | idu | 0 à n (égal) |

   * particularité(s) : aucune
   
## Table : `xapps_an_vmr_p_prescription`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|libelle||x|Libellé||Fiche de renseignements d'urbanisme||
|lien|x|x|+ d'infos|Déclaré en lien. Affiche le lien du document si il existe autrement rien.Texte de remplacement dans GEO : Document lié|Fiche de renseignements d'urbanisme||

   * filtres : aucun
   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
| r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3 dans GEO | idu | 0 à n (égal) |

   * particularité(s) : aucune
   
## Table : `m_fiscalite.an_fisc_geo_taxe_amgt`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_taux|x|x||Gestion de l'affichage du taux `Si taux=9999 alors Non renseigné sinon taux %`|Fiche de renseignements d'urbanisme||
|affiche_url|x|x||Déclaré en lien. Affiche le lien de l'arrêté municipal si il existe autrement rien|Fiche de renseignements d'urbanisme||
|taux_num |x|x||Formate l'affichage numérique du taux pour intégration dela champ calculé affiche_taux|Fiche de renseignements d'urbanisme||

   * filtres : aucun
   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
| r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3 dans GEO | idu | 0 à 1 (égal) |

   * particularité(s) : aucune
   
## Table : `xapps_an_vmr_parcelle_plu`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|datappro ||x|Date d'approbation||Fiche POS-PLU-CC||
|destdomi_lib ||x|Destination dominante||Fiche POS-PLU-CC||
|fermreco  ||x|Secteur fermé à la reconstruction (pour carte communale)||Fiche POS-PLU-CC||
|l_observ ||x|Observation(s)||Fiche POS-PLU-CC||
|l_surf_cal ||x|Surface calculée (en ha)||Fiche POS-PLU-CC||
|libelle  ||x|Zonage||Fiche POS-PLU-CC||
|libelong  ||x|Libellé||Fiche POS-PLU-CC||
|type_zone  ||x|Type de zone||Fiche POS-PLU-CC||
|urlfic   ||x|+ d'infos|Déclaré en lien. Texte de remplacement dans GEO : Accès au règlement|Fiche POS-PLU-CC||

   * filtres : aucun
   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
| r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3 dans GEO | idu | 0 à n (égal) |

   * particularité(s) : aucune
   
## Table : `m_urbanisme_reg.an_sup_geo`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|l_url  ||x|+ d'infos|Déclaré en lien. Texte de remplacement dans GEO : Document lié|Fiche de renseignements d'urbanisme||
|ligne_aff   ||x|Libellé de la servitude||Fiche de renseignements d'urbanisme||

   * filtres : aucun
   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
| r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3 dans GEO | idu | 1 à n (égal) |

   * particularité(s) : cette table est issue d'un traitement FME qui génère pour toutes les parcelles les SUP les impactant
   
## Table : `m_urbanisme_reg.an_sup_geo_commune_synthese`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_liste_sup_com  ||x||Supprime les caractères blancs à la fin de la chaîne de l'attribut ligne_aff (traitement sql)Fiche de renseignements d'urbanisme||

   * filtres : aucun
   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
| r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3 dans GEO | idu | 1 (égal) |

   * particularité(s) : cette table est issue d'un traitement FME qui génère pour toutes les parcelles les SUP les impactant
   
## Table : `m_urbanisme_reg.an_sup_ac4_geo_protect`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|demol  ||x|Démoli depuis l'approbation de la ZPPAUP|Formatage du booléen Vrai = Oui et Faux = Non non validé|ZPPAUP de Compiègne - Mesure de protection||
|message    ||x|Libellé||ZPPAUP de Compiègne - Mesure de protection||
|nomplan     ||x|Plan de secteur|Déclaré en lien. Texte de remplacement dans GEO : Accès|ZPPAUP de Compiègne - Mesure de protection||
|nomreg     ||x|Règlement|Déclaré en lien. Texte de remplacement dans GEO : Accès|ZPPAUP de Compiègne - Mesure de protection||
|photos      ||x|Planche photo|Déclaré en lien. Texte de remplacement dans GEO : Accès|ZPPAUP de Compiègne - Mesure de protection||
|protec       ||x|Objet||ZPPAUP de Compiègne - Mesure de protection||
|typeprotec        ||x|Mesure||ZPPAUP de Compiègne - Mesure de protection||

   * filtres : aucun
   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
| r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3 dans GEO | idu | 1 à n (égal) |

   * particularité(s) : cette table est issue d'un traitement FME qui génère pour toutes les parcelles les SUP les impactant

## Geotable : `m_urbanisme_reg.geo_sup_pm1_ppri_projet_rq (PPRi zonage (projet) - remarque)`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affichage_result   |x|||Formatage de l'affichage du titre du résultat dans le menu du même nom|PPRi zonage (projet) - remarque||
|affiche_info   |x|||Déclaré en HTML. Formatage en HTML du résultat de la recherche(observation, date de saisie, date de mise à jour,nom)|PPRi zonage (projet) - remarque||
|date_maj   ||x|Mise à jour le||PPRi zonage (projet) - remarque||
|date_sai    ||x|Saisie le||PPRi zonage (projet) - remarque||
|id_rq   ||x|N°||PPRi zonage (projet) - remarque||
|info_bulle    |x|||Déclaré en HTML. Formatage en HTML de l'affichage de l'info bulle au survol de la remarque|PPRi zonage (projet) - remarque||
|message    |x|||Déclaré en HTML. Formatage en HTML d'un message d'aide affiché dans le résultat de la recherche|PPRi zonage (projet) - remarque||
|nom    ||x|Annotée par||PPRi zonage (projet) - remarque||
|observ     ||x|Commentaire||PPRi zonage (projet) - remarque||
|type_rq      ||x|Type||PPRi zonage (projet) - remarque||
|url_aide       |x|||Contient le lien de la fiche d'aide|PPRi zonage (projet) - remarque||

   * filtres : aucun
   * relations : aucune
   * particularité(s) : les droits de cette table sont limitées aux groupes ADMIN et PPRI_EDIT en lecture, écriture et Ajout-Supression 
   
## Geotable : x_apps_geo_vmr_p_zone_urba

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|datappro_date   |x|x|Date d'approbation|Formatage de l'affichage de la date en sql|Fiche POS-PLU-CC||
|datvalid    ||x|Date de validité de l'objet|Formatage de la date en dd-mm-yyyy|Fiche POS-PLU-CC||
|fermreco     ||x|Secteur fermé à la reconstruction (pour carte communale)|Formatage du booléen Vrai = Oui et Faux = Non|Fiche POS-PLU-CC||
|gestion_libelle_long     |x|x|Libellé long| Formate (en sql) l'affichage du libellé long `si typesect=ZZ alors libelong sinon affiche typesect (décodé)`|Fiche POS-PLU-CC||
|l_observ     ||x|Observation(s)| |Fiche POS-PLU-CC||
|l_surf_cal      ||x|Surface calculée (ha)| |Fiche POS-PLU-CC||
|libelle       ||x|Zonage| |Fiche POS-PLU-CC||
|typezone        ||x|Type de zone| |Fiche POS-PLU-CC||
|urlfic        ||x|Règlement. |Déclaré en lien. Texte de remplacement dans GEO : Accès au règlement|Fiche POS-PLU-CC||

   * filtres : aucun
   * relations :
   
|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
| commune - BG | insee = ccocom | 1 (égal) |
| lt_typezone | typezone | 1 (égal) |
| lt_destdomi | destdomi | 1 (égal) |
   
   * particularité(s) : aucune

# Les fonctionnalités

Sont présentées ici uniquement les fonctionnalités spécifiques à l'application.

## Recherche : `Toutes les recherches cadastrales`

L'ensemble des recherches cadastrales ont été formatées et intégrées par l'éditeur via son module GeoCadastre.
Seul le nom des certaines recherches a été modifié par l'ARC pour plus de compréhension des utilisateurs.

  * Configuration :

Source : `r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3`

|Libellé d'origine|Nouveau libellé|
|:---|:---|
|Parcelles par adresse|Parcelles par adresse fiscale|
|Parcelles par propriétaire|Parcelles par nom du propriétaire|
|Parcelles par propriétairesde locaux|Parcelles par nom du propriétaire d'un local|

## Recherche (clic sur la carte) : `Parcelle(s) sélectionnée(s)`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations de la parcelle et d'accéder soit à la fiche de renseignement d'urbanisme ou de la fiche parcelle détaillée (si les droits).

  * Configuration :

Source : `r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3`

Les champs affichés par défaut par le module intégrateur de l'éditeur ont été conservés ici.

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Bg Emplacement|x|||||
|Bg Full Address|x|||||

L'attribut de géométrie (geom) utilisé est celui de la couche `Parcelle V3 (r_bg_edigeo.PARCELLE)`.
(la détection des doublons n'est pas activée ici)

 * Filtres :

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|SECU|x|ccocom|est égale à une valeur du contexte `ccocom`|||||Ce champ est lié au profil utilisateur et contient le ou les code(s) insee lui permettant d'accéder aux données du cadastre de la ou des commune(s) en question|

(1) si liste de domaine

 * Fiches d'information active : Renseignements d'urbanisme, Renseignements d'urbanisme (non DGFIP)
 
 ## Recherche (clic sur la carte) : `PPRi zonage (projet) - remarque`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations de la parcelle et d'accéder soit à la fiche de renseignement d'urbanisme ou de la fiche parcelle détaillée (si les droits).

  * Configuration :

Source : `m_urbanisme_reg.geo_sup_pm1_ppri_projet_rq (PPRi zonage (projet) - remarque)`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_result|x|||||
|message|x|||||

(la détection des doublons n'est pas activée ici)

 * Filtres :

Sans objet

(1) si liste de domaine

 * Fiches d'information active : PPRi zonage (projet) - remarque

## Recherche : `Par libellé de zone PLU`

Cette recherche permet à l'utilisateur de faire une recherche sur les zonages d'une commune.

  * Configuration :

Source : `x_apps_geo_vmr_p_zone_urba`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Zonage|x|||||
|libellé de voie|x|||||
|libelon|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Commune|x|insee|est égale à une valeur de liste de choix|Liste de domaine (Commune APC (sans filtre))|commune_m|insee|insee|||
|zonage|x||Prédéfinis filtre à liste de choix|||||||

(1) si liste de domaine

 * Fiches d'information active : Fiche détaillée POS-PLU-CC
 
## Recherche : `Par type de zone PLU`

Cette recherche permet à l'utilisateur de faire une recherche sur les types de zones d'une commune.

  * Configuration :

Source : `x_apps_geo_vmr_p_zone_urba`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Zonage|x|||||
|libellé de voie|x|||||
|libelon|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Commune|x|insee|est égale à une valeur de liste de choix|Liste de domaine (Commune APC (sans filtre))|commune_m|insee|insee|||
|Type de zonage|x|typezone|est égale à une valeur de liste de choix|Liste de domaine (Type de zone PLU)|typezone_lib|typezone|typezone|||

(1) si liste de domaine

 * Fiches d'information active : Fiche détaillée POS-PLU-CC
 
## Recherche : `Recherche avancée d'une adresse`

Cette recherche permet à l'utilisateur de faire une recherche guidée d'une adresse contrairement à la recherche globale par saisie libre.

Cette recherche a été créée pour l'application RVA. Le détail de celle-ci est donc à visualiser dans le répertoire GitHub rva au niveau de la documentation applicative.
 
 ## Recherche : `Recherche avancée d'une voie`

Cette recherche permet à l'utilisateur de faire une recherche guidée d'une voie contrairement à la recherche globale par saisie libre.

Cette recherche a été créée pour l'application RVA. Le détail de celle-ci est donc à voisualiser dans le répertoire GitHub rva au niveau de la documentation applicative.

## Recherche globale : `Recherche dans la Base Adresse Locale`

Cette recherche permet à l'utilisateur de faire une recherche libre sur une adresse.

Cette recherche a été créée pour l'application RVA. Le détail de celle-ci est donc à visualiser dans le répertoire GitHub rva au niveau de la documentation applicative.

## Recherche globale : `Recherche dans la Base de Voie Locale`

Cette recherche permet à l'utilisateur de faire une recherche libre sur le libellé d'une voie.

Cette recherche a été créée pour l'application RVA. Le détail de celle-ci est donc à visualiser dans le répertoire GitHub rva au niveau de la documentation applicative.

## Recherche globale : `Localiser une commune de l'APC`

Cette recherche permet à l'utilisateur de faire une recherche sur une commune du Pays Compiégnois.

  * Configuration :

Source : `geo_v_osm_commune_apc (pour recherche)`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Commune M|x|x|x|||
|geom||||x||

(Calcul des suggestions par "Contient la chaîne")
(la détection des doublons n'est pas activée ici)

 * Filtres : aucun

 * Fiches d'information active : aucune
 
## Recherche globale : `Localiser un équipement`

Cette recherche permet à l'utilisateur de faire une recherche un équipement localisé dans une commune du Pays Compiégnois.

  * Configuration :

Source : `geo_plan_refpoi (usage APC)`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|recherche_poi|x|x|x|||
|geom||||x||

(Calcul des suggestions par "Contient les mots entiers (Postgres Full-TextSearch)")
(la détection des doublons n'est pas activée ici)

 * Filtres : aucun

 * Fiches d'information active : Fiche équipement

## Fiche d'information : `Fiche adresse`

Source : `xapps_geo_vmr_adresse`

Cette fiche est issus de l'application RVA. Consultez le répertoire rva sur GitHub pour plus de précisions.

## Fiche d'information : `Fiche équipement`

Source : `r_plan.geo_plan_refpoi (usage APC)`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Etablissement|poi_lib|Par défaut|Vertical||INFORMATIONS / CONTACT||

 * Saisie : aucune

 * Modèle d'impression : aucun
 
## Fiche d'information : `Fiche détaillée POI`

Source : `r_plan.an_plan_refcontactpoi`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Etablissement|poi_lib,poi_alias|Par défaut|Vertical||||
|Adresse|adr_compl|Par défaut|Vertical||||
|Contact|tel, fax, mail|Par défaut|Vertical||||
|Lien(s) internet|site,url1,url2|Par défaut|Vertical||||
|Remarques|observ|Par défaut|Vertical||||

 * Saisie : aucune

 * Modèle d'impression : aucun
 * Particularité : cette fiche est liée à la fiche équipement, et n'est accessaible qu'à partir de celle-ci 
 
## Fiche d'information : `Fiche parcelle` et `Fiche local`

Source : `r_bg_majic.NBAT_10 (Parcelle (Alpha) V3)`

Ces fiches sont liées au module GeoCadastre de l'éditeur et ne sont pas modifiable par l'ARC. 

## Fiche d'information : `Fiche détaillée POS-PLU-CC`

Source : `x_apps_geo_vmr_p_zone_urba`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Caractéristiques de la zone|LIBELLE (commune-BG),libelle,gestion_libelle_long,typezone,destdomi_lib,fermreco,l_surf_cal,l_observ|Par défaut|Vertical||||
|Validité du document|datappro_date|Par défaut|Vertical||||
|Accès au réglement|urlfic|Par défaut|Vertical||||

 * Saisie : aucune

 * Modèle d'impression : Fiche standard
 
 ## Fiche d'information : `Fiche adresse` et `Fiche d'information sur la voie`

Ces deux fiches sont issues de l'application RVA. Se référer au répertoire GitHub du même nom pour plus de précisions.

## Fiche d'information : `PPRi zonage (projet) - remarque`

Source : `m_urbanisme_reg.geo_sup_pm1_ppri_projet_rq (PPRi zonage (projet) - remarque)`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Caractéristiques de l'annotation|id_rq,nom,tyep_rq,observ,date_sai,date_maj|Par défaut|Vertical||||

 * Saisie : aucune

 * Modèle d'impression : Fiche standard+carte
 
## Fiche d'information : `Renseignements d'urbanisme`

Source : `r_bg_majic.NBAT_10 (Parcelle (Alpha) V3)`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|600x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|affiche_commune|Masqué|Vertical||||
|(vide)|titre_html|Masqué|Vertical||||
|(vide)|section_parcelle|Masqué|Vertical||||
|(vide)|tableau_proprio|Masqué|Vertical||||
|(vide)|titre_doc_urba_valide_html|Masqué|Vertical||||
|(vide)|tableau_doc_vigueur|Masqué|Vertical||||
|(vide)|libelle(xapps_an_vmr_parcelle_plu),libelong,urlfic (xapps_an_vmr_parcelle_plu)|Masqué|Vertical||Fiche POS-PLU-CC||
|(vide)|titre_prescription_html|Masqué|Vertical||||
|(vide)|libelle(xapps_an_vmr_p_prescription),lien(xapps_an_vmr_p_prescription)|Masqué|Vertical||||
|(vide)|titre_dpu_html|Masqué|Vertical||||
|(vide)|application,beneficiaire,date_ins,urlfic(xapps_an_vmr_p_information_dpu)|Masqué|Vertical||||
|(vide)|titre_info_utile_html|Masqué|Vertical||||
|(vide)|libelle(xapps_an_vmr_p_information),lien(xapps_an_vmr_p_information)|Masqué|Vertical||||
|(vide)|titre_sup_html,titre_sup_impact|Masqué|Vertical||||
|(vide)|ligne_aff(an_sup_geo),l_url(an_sup_geo)|Masqué|Vertical||||
|(vide)|titre_ac4|Masqué|Vertical||||
|(vide)|message,protec,typeprotec(an_sup_ac4_geo_protect)|Masqué|Vertical||||
|(vide)|titre_liste_sup_com|Masqué|Vertical||||
|(vide)|titre_taxe_amgt|Masqué|Vertical||||
|(vide)|affiche_taux,affiche_url(an_fisc_geo_taxe_amgt)|Masqué|Vertical||||

 * Saisie : aucune

 * Modèle d'impression : Fiche standard
 * Particularité : le champ calculé tableau_proprio a été intégré en plus de l'éditeur. Ce champ doit-être recréer à chaque mise à jour du module GeoCadastre et de la création de la structure dans GEO si besoin (champ HTML <b>{BG_FULL_NAME} /st de ligne/
{BG_FULL_ADDRESS}</b>) et renommé Le ou les propriétaire(s).

## Fiche d'information : `Renseignements d'urbanisme (non DGFIP)`

Source : `r_bg_majic.NBAT_10 (Parcelle (Alpha) V3)`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|600x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|affiche_commune|Masqué|Vertical||||
|(vide)|titre_html|Masqué|Vertical||||
|(vide)|section_parcelle|Masqué|Vertical||||
|(vide)|titre_doc_urba_valide_html|Masqué|Vertical||||
|(vide)|tableau_doc_vigueur|Masqué|Vertical||||
|(vide)|libelle(xapps_an_vmr_parcelle_plu),libelong,urlfic (xapps_an_vmr_parcelle_plu)|Masqué|Vertical||Fiche POS-PLU-CC||
|(vide)|titre_prescription_html|Masqué|Vertical||||
|(vide)|libelle(xapps_an_vmr_p_prescription),lien(xapps_an_vmr_p_prescription)|Masqué|Vertical||||
|(vide)|titre_dpu_html|Masqué|Vertical||||
|(vide)|application,beneficiaire,date_ins,urlfic(xapps_an_vmr_p_information_dpu)|Masqué|Vertical||||
|(vide)|titre_info_utile_html|Masqué|Vertical||||
|(vide)|libelle(xapps_an_vmr_p_information),lien(xapps_an_vmr_p_information)|Masqué|Vertical||||
|(vide)|titre_sup_html,titre_sup_impact|Masqué|Vertical||||
|(vide)|ligne_aff(an_sup_geo),l_url(an_sup_geo)|Masqué|Vertical||||
|(vide)|titre_ac4|Masqué|Vertical||||
|(vide)|message,protec,typeprotec(an_sup_ac4_geo_protect)|Masqué|Vertical||||
|(vide)|titre_liste_sup_com|Masqué|Vertical||||
|(vide)|titre_taxe_amgt|Masqué|Vertical||||
|(vide)|affiche_taux,affiche_url(an_fisc_geo_taxe_amgt)|Masqué|Vertical||||

 * Saisie : aucune

 * Modèle d'impression : Fiche standard
 * Particularité : cette fiche est identique à la fiche "Renseignement d'urbanisme" sauf qu'elle n'affiche pas le nom des propriétaires et n'est accessible uniquement pour les profils non DGI à partir des applicatifs GEO.

## Analyse :

Aucune

## Statistique :

Aucune

## Modification géométrique : `PPRi (projet) - remarque`

Cette recherche permet à l'utilisateur de saisir une remarque concernant le projet de nouveau PPRi (annotations provisoires).

  * Configuration :
  
Source : `m_urbanisme_reg.geo_sup_pm1_ppri_projet_rq (PPRi zonage (projet) - remarque)`

 * Filtres : aucun
 * Accrochage : aucun
 * Fiches d'information active : PPRi zonage (projet) - remarque
 * Topologie : aucune 
