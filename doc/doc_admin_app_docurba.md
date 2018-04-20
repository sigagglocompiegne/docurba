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

* **Autres profils**

Sans objet

# Les données

Sont décrites ici les Géotables et/ou Tables intégrées dans GEO pour les besoins de l'application. Les autres données servant d'habillage (pour la cartographie ou les recherches) sont listées dans les autres parties ci-après. Le tableau ci-dessous présente uniquement les changements (type de champ, formatage du résultat, ...) ou les ajouts (champs calculés, filtre, ...) non présents dans la donnée source. 

## Table : `r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3 dans GEO`

Cette table est intégrée via le module GeoCadastre et est donc formatée par l'intégrateur. Aucune modification réalisée par l'ARC. Les relations forcées avec d'autres tables induites par cette intégration ne sont pas relatés dans cette documentation.

## Table : `r_bg_majic.NBAT_10`

Cette table est intégrée via le module GeoCadastre et est donc formatée par l'intégrateur. Aucune modification réalisée par l'ARC. Sur cette table est reliée l'ensemble des autres tables ou geotable issues de la base de données de l'ARC pour affichage dans la fiche de renseignements d'urbanisme.

## Table : `an_v_docurba_valide`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|datappro||x|Approbation|Formate la date du dernier en contrôle en dd/mm/yyyy|Fiche de renseignements d'urbanisme||
|format_datappro|x|x||Formate la date du dernier en contrôle en dd/mm/yyyy (code sql)|champ calculé tableau_doc_vigueur pour test Fiche de renseignements d'urbanisme en HTML||
|l_version||x|Version||Fiche de renseignements d'urbanisme||
|tableau_doc_vigueur|x|x|null|Formate un tableau HTML contenant les éléments de la procédure actuelle|Test Fiche de renseignements d'urbanisme en HTML||
|titre_ac4 |x|x|null|Formatage du titre pour la SUP AC4|Fiche de renseignements d'urbanisme||
|titre_doc_urba_valide_html  |x|x|null|Formatage du titre pour la partie sur la procédure actuelle|Fiche de renseignements d'urbanisme||
|titre_dpu_html |x|x|null|Formatage du titre pour la partie sur les DPU|Fiche de renseignements d'urbanisme||
|titre_info_utile_html |x|x|null|Formatage du titre pour la partie sur les informations jugées utiles|Fiche de renseignements d'urbanisme||
|titre_liste_sup_com |x|x|null|Formatage du titre pour la partie sur la liste des SUP devant encore être intégrées à la commune|Fiche de renseignements d'urbanisme||
|titre_prescription_html  |x|x|null|Formatage du titre pour la partie sur les prescriptions|Fiche de renseignements d'urbanisme||
|titre_sup_html   |x|x|null|Formatage du titre pour la partie sur les SUP intégrées|Fiche de renseignements d'urbanisme||
|titre_sup_impact   |x|x|null|Formatage du sous-titre pour la partie sur les SUP intégrées|Fiche de renseignements d'urbanisme||
|titre_taxe_amgt   |x|x|null|Formatage du titre pour la partie sur la taxe d'aménagement|Fiche de renseignements d'urbanisme||
|titre_zonage_html   |x|x|null||Utilisée pour les anciennes fiches de renseignements d'urbanisme||

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
|urlfic||x|+ d'infos|Texte de remplacement dans GEO : Document lié|Fiche de renseignements d'urbanisme||

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
|lien|x|x|+ d'infos|Affiche le lien du document si il existe autrement rien.Texte de remplacement dans GEO : Document lié|Fiche de renseignements d'urbanisme||

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
|lien|x|x|+ d'infos|Affiche le lien du document si il existe autrement rien.Texte de remplacement dans GEO : Document lié|Fiche de renseignements d'urbanisme||

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
|affiche_url|x|x||Affiche le lien de l'arrêté municipal si il existe autrement rien|Fiche de renseignements d'urbanisme||
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
|urlfic   ||x|+ d'infos|Texte de remplacement dans GEO : Accès au règlement|Fiche POS-PLU-CC||

   * filtres : aucun
   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
| r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3 dans GEO | idu | 0 à n (égal) |

   * particularité(s) : aucune
   
   ## Table : `m_urbanisme_reg.an_sup_geo`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|l_url  ||x|+ d'infos|Texte de remplacement dans GEO : Document lié|Fiche de renseignements d'urbanisme||
|ligne_aff   ||x|Libellé de la servitude||Fiche de renseignements d'urbanisme||

   * filtres : aucun
   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
| r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3 dans GEO | idu | 1 à n (égal) |

   * particularité(s) : cette table est issue d'un traitement FME qui génère pour toutes les parcelles les SUP les impactant
