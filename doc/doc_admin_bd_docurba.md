![picto](/doc/img/Logo_web-GeoCompiegnois.png)

# Documentation d'administration de la base (en cours de rédaction) #

## Principes
  * **généralité** :
 la gestion des données des documents d'urbanisme (carte communale,PLU, PLUi et SCoT) est soumis à une norme d'échange du CNIG.
 Cette norme est implantée dans la base de données Igeo Compiègnois de l'Agglomération de la Région de Compiègne. Des ajouts spécifiques ont été réalisés comme l'ajout de champs optionnels ou de nouvelles tables de gestion. De plus, l'Agglomération a mise en oeuvre un système de versionnement afin de conserver toutes les procédures d'urbanisme. La restauration d'une ancienne procédure doit-être possible suite à l'annulation de l'actuelle.
 
 * **résumé fonctionnel** :
 le fonctionnement de la base de données répond à la norme CNIG à la fois sur les attributs et les primitives géographiques (se référer au standard http://cnig.gouv.fr/?page_id=2732). Le système de versionnement repose sur une partie production (qui contient l'ensemble des procédures en vigueur), une partie archive (qui contient l'ensemble des procédures annulée,remplacée,abrogée,...) et une partie test (qui contient l'ensemble des documents en cours de création ou de modification). Le basculement des données entre les diverses parties s'effectuent via des Workflow de l'ETL FME.

## Dépendances (non critiques)

La base de données des documents d'urbanisme s'appui sur des référentiels préexistants uniquement pour les vues applicatives constituant autant de dépendances nécessaires pour l'implémentatation des vues de cette base. Il n'y a donc pas de dépendances critiques pour la gestion des données des documents d'urbanisme.


## Classes d'objets

L'ensemble des classes d'objets de gestion sont stockés dans le schéma m_urbanisme_doc et celles applicatives dans les schémas x_apps ou x_apps_public.

 ### classes d'objets de gestion :
  
   `an_ads_commune` : table des attributs sur l'état de l'ADS ARC sur les communes.
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|insee|Code INSEE|character(5)| |
|docurba|Présence d'un document d'urbanisme (PLUi,PLU,POS,CC)|boolean| |
|ads_arc|Gestion de l'ADS par l'ARC|boolean| |
|l_rev|Information sur la révision en cours ou non du document d'urbanisme|character varying(30)| |
|l_daterev|Date de prescripiton de la révision|timestamp without time zone| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ insee
---

   `an_doc_urba` : table issue du standard CNIG 2017  listant l'ensemble des procédures des documents d''urbanisme (y compris les communes en RNU)
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|typedoc|Type du document concerné|character varying(4)| |
|etat|Etat juridique du document|character varying(2)| |
|nomproc|Codage de la version du document concerné|character varying(10)| |
|l_nomprocn|N° d'ordre de la procédure|integer| |
|datappro|Date d'approbation|character varying(8)| |
|datefin|date de fin de validité|character varying(8)| |
|siren|Code SIREN de l'intercommunalité|character varying(9)| |
|nomreg|Nom du fichier de règlement|character varying(80)| |
|urlreg|URL ou URI du fichier du règlement|character varying(254)| |
|nomplan|Nom du fichier du plan scanné|character varying(80)| |
|urlplan|URL ou URI du fichier du plan scanné|character varying(254)| |
|urlpe|Lien d'accès à l'archive zip comprenant l'ensemble des pièces écrites|character varying(254)| |
|siteweb|Site web du service d'accès|character varying(254)| |
|typeref|Type de référentiel utilisé|character varying(2)| |
|dateref|Date du référentiel de saisie|character varying(8)| |
|l_moa_proc|Maitre d'ouvrage de la procédure|character varying(80)| |
|l_moe_proc|Maitre d'oeuvre de la procédure|character varying(80)| |
|l_moa_dmat|Maitre d'ouvrage de la dématérialisation|character varying(80)| |
|l_moe_dmat|Maitre d'oeuvre de la dématérialisation|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|l_parent|Identification des documents parents pour recherche des historiques entre version de documents (1 pour le premier document (élaboration, modif, mise à jour), 2 pour la révision (révision n°1, modif, mise à jour), 3 pour le 2nd révision, ...|integer||

Particularité(s) à noter :
* Une clé primaire existe sur le champ idurba
* Une clé étrangère exsiste sur la table de valeur `lt_etat`
* Une clé étrangère exsiste sur la table de valeur `lt_nomproc`
* Une clé étrangère exsiste sur la table de valeur `lt_typedoc`
* Une clé étrangère exsiste sur la table de valeur `lt_typeref`
---

`an_doc_urba_com` : table issue du standard CNIG 2017 d'appartenance d'une commune à une procédure définie.

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|insee|Code insee de la commune|character varying(5)| |

Particularité(s) à noter : aucune

---

`geo_a_habillage_lin` : (archive) Donnée géographique contenant l'habillage linéaire des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage linéaire|character varying(10)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXE (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|MultiLineString,2154| |

Particularité(s) à noter : aucune

---

`geo_a_habillage_pct` : (archive) Donnée géographique contenant l'habillage ponctuel des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage ponctuel|character varying(10)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|MultiPoint,2154| |

Particularité(s) à noter : aucune

---

`geo_a_habillage_surf` : (archive) Donnée géographique contenant l'habillage surfacique des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage surfacique|character varying(10)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|MultiPolygon,2154| |

Particularité(s) à noter : aucune

---

`geo_a_habillage_txt` : (archive) Donnée géographique contenant l'habillage textuel des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage ponctuel|character varying(10)| |
|natecr|Nature de l'écriture|character varying(40)| |
|txt|Texte de l'écriture|character varying(80)| |
|police|Police de l'écriture|character varying(40)| |
|taille|Taille de l'écriture|integer| |
|style|Style de l'écriture|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|angle|Angle de l'écriture exprimé en degré, par rapport à l'horizontale, dans le sens trigonométrique|integer| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|MultiPoint,2154| |
|gid|Identifiant unique pour l'ARC|integer|nextval('m_urbanisme_doc_cnig2017.geo_a_habillage_txt_gid_seq'::regclass)|

Particularité(s) à noter :
* Une clé primaire existe sur le champ gid avec une séquence d'incrémentation automatique `m_urbanisme_doc_cnig2017.geo_a_habillage_txt_gid_seq`

---

`geo_a_info_lin` : (archive) Donnée géographique contenant les informations linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information linéaire|character varying(10)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_dateins|Date d'instauration|character(8)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_datdlg|Date de délégation|character(8)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|MultiLineString,2154| |


Particularité(s) à noter :
* Une clé étrangère existe sur la table de valeur `lt_typeinf` (sur les attributs code et sous-code)

---

`geo_a_info_pct` : (archive) Donnée géographique contenant les informations ponctuelles des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information ponctuelle|character varying(10)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_dateins|Date d'instauration|character(8)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_datdlg|Date de délégation|character(8)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|MultiPoint,2154| |


Particularité(s) à noter :
* Une clé étrangère existe sur la table de valeur `lt_typeinf` (sur les attributs code et sous-code)

---

`geo_a_info_surf` : (archive) Donnée géographique contenant les informations surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information surfacique|character varying(10)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_dateins|Date d'instauration|character(8)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_datdlg|Date de délégation|character(8)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|MultiPolygon,2154| |
|gid|Identifiant unique spécifique à l'ARC|integer|nextval('m_urbanisme_doc_cnig2017.geo_a_info_surf_gid_seq'::regclass)|


Particularité(s) à noter :
* Une clé primaire existe sur le champ gid avec une séquence d'incrémentation automatique `m_urbanisme_doc_cnig2017.geo_a_info_surf_gid_seq`
* Une clé étrangère existe sur la table de valeur `lt_typeinf` (sur les attributs code et sous-code)

---

`geo_a_prescription_lin` : (archive) Donnée géographique contenant les prescriptions linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription linéaire|character varying(10)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_nature|Nature / vocation|character varying(254)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_numero|Numéro|character varying(10)| |
|l_surf_txt|Superficie littérale|character varying(30)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|MultiLineString,2154| |


Particularité(s) à noter :
* Une clé étrangère existe sur la table de valeur `lt_typepsc` (sur les attributs code et sous-code)

---

`geo_a_prescription_pct` : (archive) Donnée géographique contenant les prescriptions ponctuelles des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription ponctuelle|character varying(10)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_nature|Nature / vocation|character varying(254)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_numero|Numéro|character varying(10)| |
|l_surf_txt|Superficie littérale|character varying(30)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|MultiPoint,2154| |


Particularité(s) à noter :
* Une clé étrangère existe sur la table de valeur `lt_typepsc` (sur les attributs code et sous-code)

---

`geo_a_prescription_surf` : (archive) Donnée géographique contenant les prescriptions surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription surfacique|character varying(10)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_nature|Nature / vocation|character varying(254)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_numero|Numéro|character varying(10)| |
|l_surf_txt|Superficie littérale|character varying(30)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|MultiPolygon,2154| |
|gid|Identifiant unique spécifique à l'ARC|integer|nextval('m_urbanisme_doc_cnig2017.geo_a_prescription_surf_gid_seq'::regclass)|


Particularité(s) à noter :
* Une clé primaire existe sur le champ gid avec une séquence d'incrémentation automatique `m_urbanisme_doc_cnig2017.geo_a_prescription_surf_gid_seq`
* Une clé étrangère existe sur la table de valeur `lt_typepsc` (sur les attributs code et sous-code)

---

`geo_a_zone_urba` : (archive) Donnée géographique contenant les zonages des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idzone|Identifiant unique de zone|character varying(10)| |
|libelle|Nom court de la zone|character varying(12)| |
|libelong|Nom complet de la zone|character varying(254)| |
|typezone|Type de la zone|character varying(3)| |
|nomfic|Nom du fichier du règlement complet|character varying(80)| |
|urlfic|URL ou URI du fichier du règlement complet|character varying(254)| |
|l_nomfic|Nom du fichier du règlement de la zone|character varying(80)| |
|l_urlfic|URL ou URI du fichier du règlement de la zone|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character varying(8)| |
|typesect|Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)|character varying(2)|'ZZ'::character varying|
|fermreco|Secteur fermé à la reconstruction (uniquement pour la carte communale)|character varying(3)|'non'::character varying|
|l_destdomi|Vocation de la zone|character varying(2)| |
|l_insee|Code INSEE|character varying(5)| |
|l_surf_cal|Surface calculée de la zone en ha|numeric| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|MultiPolygon,2154| |
|gid|Identifiant unique spécifique à l'ARC|integer|nextval('m_urbanisme_doc_cnig2017.geo_a_zone_urba_gid_seq'::regclass)|

Particularité(s) à noter :
* Une clé primaire existe sur le champ gid avec une séquence d'incrémentation automatique `m_urbanisme_doc_cnig2017.geo_a_zone_urba_gid_seq`
* Une clé étrangère existe sur la table de valeur `lt_destdomi`
* Une clé étrangère existe sur la table de valeur `lt_typesect`
* Une clé étrangère existe sur la table de valeur `lt_typezone`

---

`geo_p_habillage_lin` : (production) Donnée géographique contenant les habillages linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage linéaire|character varying(10)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|MultiLineString,2154| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ idhab
* Un index est présent sur le champ geom

---

`geo_p_habillage_pct` : (production) Donnée géographique contenant les habillages ponctuels des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage ponctuel|character varying(10)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|MultiPoint,2154| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ idhab
* Un index est présent sur le champ geom

---

`geo_p_habillage_surf` : (production) Donnée géographique contenant les habillages surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage surfacique|character varying(10)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|MultiPolygon,2154| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ idhab
* Un index est présent sur le champ geom

---

`geo_p_habillage_txt` : (production) Donnée géographique contenant les habillages textuels des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage ponctuel|character varying(10)| |
|natecr|Nature de l'écriture|character varying(40)| |
|txt|Texte de l'écriture|character varying(80)| |
|police|Police de l'écriture|character varying(40)| |
|taille|Taille de l'écriture|integer| |
|style|Style de l'écriture|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|angle|Angle de l'écriture exprimé en degré, par rapport à l'horizontale, dans le sens trigonométrique|integer| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|Multipoint,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idhab
* Un index est présent sur le champ geom

---

`geo_p_info_lin` : (production) Donnée géographique contenant les informations linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information linéaire|character varying(10)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_dateins|Date d'instauration|character(8)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_datdlg|Date de délégation|character(8)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|Multilinestring,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idinf
* Une clé étrangère existe sur la table de valeur `lt_typeinf` (sur les attributs code et sous-code)
* Un index est présent sur le champ geom

---

`geo_p_info_pct` : (production) Donnée géographique contenant les informations ponctuelles des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information ponctuelle|character varying(10)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_dateins|Date d'instauration|character(8)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_datdlg|Date de délégation|character(8)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|Multipoint,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idinf
* Une clé étrangère existe sur la table de valeur `lt_typeinf` (sur les attributs code et sous-code)
* Un index est présent sur le champ geom

---

`geo_p_info_surf` : (production) Donnée géographique contenant les informations surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information surfacique|character varying(10)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_dateins|Date d'instauration|character(8)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_datdlg|Date de délégation|character(8)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|USER-DEFINED| |
|geom1|Géométrie de l'objet avec un buffer de -0.5 pour calcul de la vue an_vmr_p_information pour GEO. Champ mis à jour en automatique par un trigger à l'insertion, mise à jour du champ geom|Multipolygon,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idinf
* Une clé étrangère existe sur la table de valeur `lt_typeinf` (sur les attributs code et sous-code)
* Un index est présent sur le champ geom
* Un index est présent sur le champ geom1

---


`geo_p_prescription_lin` : (production) Donnée géographique contenant les prescriptions linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription linéaire|character varying(10)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_nature|Nature / vocation|character varying(254)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_numero|Numéro|character varying(10)| |
|l_surf_txt|Superficie littérale|character varying(30)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|multilinestring,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idpsc
* Une clé étrangère existe sur la table de valeur `lt_typepsc` (sur les attributs code et sous-code)

---

`geo_p_prescription_pct` : (production) Donnée géographique contenant les prescriptions ponctuelles des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription ponctuelle|character varying(10)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_nature|Nature / vocation|character varying(254)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_numero|Numéro|character varying(10)| |
|l_surf_txt|Superficie littérale|character varying(30)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|Multipoint,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idpsc
* Une clé étrangère existe sur la table de valeur `lt_typepsc` (sur les attributs code et sous-code)

---


`geo_p_prescription_surf` : (production) Donnée géographique contenant les prescriptions surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription surfacique|character varying(10)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_nature|Nature / vocation|character varying(254)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_numero|Numéro|character varying(10)| |
|l_surf_txt|Superficie littérale|character varying(30)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|Multipolygon,2154| |
|geom1|Géométrie de l'objet avec un buffer de -0.5 pour calcul de la vue an_vmr_prescription pour GEO.Champ mis à jour en automatique par un trigger à l'insertion, mise à jour du champ geom|Multipolygon,2154| |



Particularité(s) à noter :
* Une clé primaire existe sur le champ idpsc
* Une clé étrangère existe sur la table de valeur `lt_typepsc` (sur les attributs code et sous-code)

---


`geo_p_zone_pau` : Donnée géographique contenant les parties actuellement urbanisées pour les communes en RNU

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpau|Identifiant géographique|integer|nextval('m_urbanisme_doc_cnig2017.idpau_seq'::regclass)|
|date_sai|Date de saisie des données|timestamp without time zone| |
|date_maj|Date de mise à jour|timestamp without time zone| |
|op_sai|Opérateur de saisie|character varying(50)| |
|org_sai|Organisme de saisie|character varying(100)| |
|insee|Code Insee de la commune|character varying(5)| |
|commune|Libellé de la commune|character varying(100)| |
|src_geom|Référentiel spatila utilisé pour la saisie|character varying(2)|'00'::character varying|
|sup_m2|Surface brute de l'objet en m²|double precision| |
|l_type|Type de bâti intégré à la PAU|character varying(50)| |
|l_statut|Prise en compte de la PAU (oui : en RNU, non : documents d'urbaniusme en vigieur)|boolean|true|
|geom|Champ contenant la géométrie des objets|Multipolygon,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idpau
* Une clé étrangère existe sur la table de valeur `r_objet.lt_src_geom`
* Un index est présent sur le champ geom
* 4 triggers :
  * `t_t1_pau_inseecommune` : intégration du code insee et du nom de la commune avant l'insert
  * `t_t2_pau_insert_date_sai` : intégration de la date de saisie avant l'insert
  * `t_t2_pau_insert_date_maj` : intégration de la date de mise à jour avant l'insert
  * `t_t4_pau_surface` : calcul de la surface en m² avant l'insert ou la mise à jour
  
---

`geo_p_zone_urba` : (production) Donnée géographique contenant les zonages des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idzone|Identifiant unique de zone|character varying(10)| |
|libelle|Nom court de la zone|character varying(12)| |
|libelong|Nom complet de la zone|character varying(254)| |
|typezone|Type de la zone|character varying(3)| |
|nomfic|Nom du fichier du règlement complet|character varying(80)| |
|urlfic|URL ou URI du fichier du règlement complet|character varying(254)| |
|l_nomfic|Nom du fichier du règlement de la zone|character varying(80)| |
|l_urlfic|URL ou URI du fichier du règlement de la zone|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character varying(8)| |
|typesect|Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)|character varying(2)|'ZZ'::character varying|
|fermreco|Secteur fermé à la reconstruction (uniquement pour la carte communale)|character varying(3)|'non'::character varying|
|l_destdomi|Vocation de la zone|character varying(2)| |
|l_insee|Code INSEE|character varying(5)| |
|l_surf_cal|Surface calculée de la zone en ha|numeric| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|Multipolygon,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idzone
* Une clé étrangère existe sur la table de valeur `lt_destdomi`
* Une clé étrangère existe sur la table de valeur `lt_typesect`
* Une clé étrangère existe sur la table de valeur `lt_typezone`
* Un index est présent sur le champ geom
* 1 trigger :
  * `l_surf_cal` : calcul de la surface en m² avant l'insert ou la mise à jour d'une géométrie uniquement

---

`geo_t_habillage_lin` : (pré-production) Donnée géographique contenant les habillages linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage linéaire|character varying(10)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|Multilinestring,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idhab

---

`geo_t_habillage_pct` : (pré-production) Donnée géographique contenant les habillages ponctuels des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage ponctuel|character varying(10)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|Multipoint,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idhab

---

`geo_t_habillage_surf` : (pré-production) Donnée géographique contenant les habillages surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage surfacique|character varying(10)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|Multipolygon,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idhab

---

`geo_t_habillage_txt` : (pré-production) Donnée géographique contenant les habillages textuels des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage ponctuel|character varying(10)| |
|natecr|Nature de l'écriture|character varying(40)| |
|txt|Texte de l'écriture|character varying(80)| |
|police|Police de l'écriture|character varying(40)| |
|taille|Taille de l'écriture|integer| |
|style|Style de l'écriture|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|angle|Angle de l'écriture exprimé en degré, par rapport à l'horizontale, dans le sens trigonométrique|integer| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|Multipoint,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idhab

---


`geo_t_info_lin` : (pré-production) Donnée géographique contenant les informations linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information linéaire|character varying(10)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_dateins|Date d'instauration|character(8)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_datdlg|Date de délégation|character(8)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|Multilinestring| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ idinf
* Une clé étrangère existe sur la table de valeur `lt_typeinf` (sur les 2 attributs code et sous-code)

---

`geo_t_info_pct` : (pré-production) Donnée géographique contenant les informations ponctuelles des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information ponctuelle|character varying(10)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_dateins|Date d'instauration|character(8)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_datdlg|Date de délégation|character(8)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|Multipoint,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idinf
* Une clé étrangère existe sur la table de valeur `lt_typeinf` (sur les 2 attributs code et sous-code)

---

`geo_t_info_surf` : (pré-production) Donnée géographique contenant les informations surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information surfacique|character varying(10)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_dateins|Date d'instauration|character(8)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_datdlg|Date de délégation|character(8)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|Multipolygon,2154| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ idinf
* Une clé étrangère existe sur la table de valeur `lt_typeinf` (sur les 2 attributs code et sous-code)

---

`geo_t_prescription_lin` : (pré-production) Donnée géographique contenant les prescriptions linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription linéaire|character varying(10)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_nature|Nature / vocation|character varying(254)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_numero|Numéro|character varying(10)| |
|l_surf_txt|Superficie littérale|character varying(30)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|Multilinestring,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idpsc
* Une clé étrangère existe sur la table de valeur `lt_typepsc` (sur les 2 attributs code et sous-code)

---


`geo_t_prescription_pct` : (pré-production) Donnée géographique contenant les prescriptions ponctuelles des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription ponctuelle|character varying(10)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_nature|Nature / vocation|character varying(254)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_numero|Numéro|character varying(10)| |
|l_surf_txt|Superficie littérale|character varying(30)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|multipoint,2154| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ idpsc
* Une clé étrangère existe sur la table de valeur `lt_typepsc` (sur les 2 attributs code et sous-code)

---

`geo_t_prescription_surf` : (pré-production) Donnée géographique contenant les prescriptions surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription surfacique|character varying(10)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(80)| |
|l_nature|Nature / vocation|character varying(254)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_numero|Numéro|character varying(10)| |
|l_surf_txt|Superficie littérale|character varying(30)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|Multipolygon,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idpsc
* Une clé étrangère existe sur la table de valeur `lt_typepsc` (sur les 2 attributs code et sous-code)

---

`geo_t_zone_urba` : (pré-production) Donnée géographique contenant les zonages des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idzone|Identifiant unique de zone|character varying(10)| |
|libelle|Nom court de la zone|character varying(12)| |
|libelong|Nom complet de la zone|character varying(254)| |
|typezone|Type de la zone|character varying(3)| |
|nomfic|Nom du fichier du règlement complet|character varying(80)| |
|urlfic|URL ou URI du fichier du règlement complet|character varying(254)| |
|l_nomfic|Nom du fichier du règlement de la zone|character varying(80)| |
|l_urlfic|URL ou URI du fichier du règlement de la zone|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character varying(8)| |
|typesect|Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)|character varying(2)|'ZZ'::character varying|
|fermreco|Secteur fermé à la reconstruction (uniquement pour la carte communale)|character varying(3)|'non'::character varying|
|l_destdomi|Vocation de la zone|character varying(2)| |
|l_insee|Code INSEE|character varying(5)| |
|l_surf_cal|Surface calculée de la zone en ha|numeric| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|Multipolygon,2154| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ idzone
* Une clé étrangère existe sur la table de valeur `lt_destdomi`
* Une clé étrangère existe sur la table de valeur `lt_typesect`
* Une clé étrangère existe sur la table de valeur `lt_typezone`
* 1 trigger :
  * `l_surf_cal` : calcul de la surface en m² avant l'insert ou la mise à jour d'une géométrie uniquement

---

`an_v_docurba_arcba` : Vue ARC simplifiée de la table an_doc_urba à usage interne. Ajout nom de la commune et du libellé de l'état du document

`an_v_docurba_cclo` : Vue CCLO simplifiée de la table an_doc_urba à usage interne. Ajout nom de la commune et du libellé de l''état du document

`an_v_docurba_ccpe` : Vue CCPE simplifiée de la table an_doc_urba à usage interne. Ajout nom de la commune et du libellé de l''état du document

`an_v_docurba_valide` : Liste des documents d''urbanisme valide sur les communes du Pays Compiégnois

`geo_v_docurba` : Vue géographique présentant le types de document d'urbanisme valide par commune du Pays Compiégnois

`geo_v_p_habillage_lin_arc` : Vue géographique des habillages linéaires PLU filtrée sur les communes de l'ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l'application PLU Interactif

`geo_v_p_habillage_txt_arc` : Vue géographique des habillages textuels PLU filtrée sur les communes de l'ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l'application PLU Interactif

`geo_v_p_info_lin_arc` : Vue géographique des informations linéaires PLU filtrée sur les communes de l'ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l'application PLU Interactif

`geo_v_p_info_pct_arc` : Vue géographique des informations ponctuelles PLU filtrée sur les communes de l'ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l'application PLU Interactif

`geo_v_p_info_surf_arc` : Vue géographique des informations surfaciques PLU filtrée sur les communes de l'ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l'application PLU Interactif

`geo_v_p_prescription_lin_arc` : Vue géographique des prescriptions linéaires PLU filtrée sur les communes de l'ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l'application PLU Interactif

`geo_v_p_prescription_pct_arc` : Vue géographique des prescriptions ponctuelles PLU filtrée sur les communes de l'ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l'application PLU Interactif

`geo_v_p_prescription_surf_arc` : Vue géographique des prescriptions surfaciques PLU filtrée sur les communes de l'ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l'application PLU Interactif

`geo_v_p_zone_urba_arc` : Vue géographique des zonages PLU filtrée sur les communes de l'ARC pour la création du flux GeoServer DocUrba_ARC utilisée notamment dans l'application PLU Interactif

`geo_v_urbreg_ads_commune` :   Vue géographique sur l'état de l'ADS par l'ARC sur les communes du Pays Compiégnois

---

 ### classes d'objets applicatives sont classés dans le schéma x_apps :
 
 Les classes d'objets applicatives pour l'application de Renseignements d'urbanisme pour le Grand Public seront intégrés plus tard (en cours de réalisation et de tests fonctionnels).
 
 **ATTENTION** : ces vues sont reformatées à chaque mise à jour de cadastre ou d'une document d'urbanisme dans un Workflow de l'ETL FME.
 
`xapps_an_vmr_p_information` : Vue matérialisée alphanumérique formatant une liste des parcelles avec les informations ponctuelles, surfaciques (hors DPU et ZAD), linénaires issues des documents d'urbanisme et d'autres informations jugées utiles issues d'autres données métiers (Natura 2000,ZICO, ZNIEFF, ...) impactant chaque parcelle. Cette vue est liée dans GEO pour récupération de ces informations dans la fiche de renseignements d'urbanisme (cf dossier GitHub correspondant à l'application).

`xapps_an_vmr_p_information_dpu` : Vue matérialisée alphanumérique formatant une liste des parcelles avec l'information d'appartenance ou non à une DPU. Cette vue est liée dans GEO pour récupération de ces informations dans la fiche de renseignements d'urbanisme (cf dossier GitHub correspondant à l'application).

`xapps_an_vmr_p_prescription` :  Vue matérialisée alphanumérique formatant une liste des parcelles avec les prescriptions ponctuelles, surfaciques, linénaires issues des documents d'urbanisme impactant chaque parcelle. Cette vue est liée dans GEO pour récupération de ces informations dans la fiche de renseignements d'urbanisme (cf dossier GitHub correspondant à l'application).

`xapps_an_vmr_parcelle_plu` :  Vue matérialisée contenant les informations pré-formatés pour la constitution de la fiche d'information Renseignements d'urbanisme. Cette vue permet de récupérer pour chaque parcelle les informations du PLU et traiter les pbs liés aux zones entre commune et les zonages se touchant. 

`xapps_geo_vmr_p_zone_urba` :  Vue matérialisée des zones du PLU servant dans les recherches par zonage ou type dans les applicatifs GEO. 

## Liste de valeurs

`lt_euep_cc_bien` : Liste des types de bien contrôlé

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code interne des types de bien|character(2)| |
|valeur|Libellé des types de bien|character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|00|Non renseigné|
|10|Neuf|
|20|Ancien|

---

`lt_euep_cc_certificateur` : Liste des certificateurs agrées pour les contrôles de conformité assainissement

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code interne du donneur d'ordre|integer| |
|valeur|Libellé du donneur d'ordre|character varying(80)| |
|exist|Information sur le prestataire agréé qui excerce toujours ou non (filtre dans GEO (par rapport à la connexion du prestataire) pour afficher la fiche et l'éditer)|boolean|true|
|adresse|Adresse du certificateur agréé|character varying(150)| |
|tel|Téléphone fixe du certificateur agréé|character varying(10)| |
|tel_port|Téléphone portable du certificateur agréé|character varying(10)| |
|email|Email de contact du prestataire|character varying(80)| |
|etat|Etat de la certification (true : agréé, false : plus agréé)|boolean|true|
|siret|N° de SIRET|character varying(14)| |
|nom_assur|Libellé de la compagnie d'assurance|character varying(150)| |
|num_assur|N° de la police d'assurance ou du contrat|character varying(150)| |
|date_assur|Date de fin validé du contrat d'assurance|timestamp without time zone| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code avec une séquence d'incrémentation d'un numéro automatique ``lt_euep_cc_certificateur_code_seq``

Valeurs possibles : données non diffusables pour cette liste pour des raisons de confidentialités des données


---

`lt_euep_cc_eval` : Liste des types de réponse aux questions pour les contrôles de conformité assainissement

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|code|Code interne des types de réponse|character(2)| |
|valeur|Libellé des types de réponse|character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|00|Non renseigné (cf formulaire PDF)|
|10|Oui|
|20|Non|
|30|Non visible|
|ZZ|Sans objet|

---

`lt_euep_cc_ordre` : Liste des donneurs d'ordre pour les contrôles de conformité assainissement

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|code|Code interne des types de donneurs d'ordre|character(2)| |
|valeur|Libellé des types de donneurs d'ordre|character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|00|Non renseigné (cf formulaire PDF)|
|10|Propriétaire|
|99|Autre|

---

`lt_euep_cc_pat` : Liste des types de patronyme

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|code|Code interne des types de patronyme|character(2)| |
|valeur|Libellé des types de patronyme|character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|00|Non renseigné|
|10|M|
|20|Mme|
|30|M et Mme|
|40|Autre (précisez)|

---

`lt_euep_cc_tnidcc` : Liste des types de suivi des n° dossier pour un nouveau contrôle. Cette table est utilisée pour gérer la constitution d'un nouveau n° de dossier à l'enregistrement

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|code|Code interne des types de suivi des n° dossier pour un nouveau contrôle|character(2)| |
|valeur|Libellé des types de suivi des n° dossier pour un nouveau contrôle|character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|10|Nouveau dossier|
|20|Suivi du dossier n°|

---

`lt_euep_cc_typebati` : Liste des types de bâtiments pour les contrôles de conformité assainissement

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|code|Code interne des types de bâtiments|character(2)| |
|valeur|Libellé des types de bâtiments|character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|00|Non renseigné (cf formulaire PDF)|
|10|Maison individuelle|
|20|Appartement|
|30|Local commercial|
|40|Local agricole|
|99|Autre|

---

`lt_euep_cc_typeres` : Liste des types de réseau raccordé au domaine public pour les contrôles de conformité assainissement

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|code|Code interne des types de réseau|character(2)| |
|valeur|Libellé des types de réseau|character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|10|Séparatif|
|20|Unitaire|
|30|Sous vide|
|ZZ|Sans objet|

---

`lt_euep_doc` : Liste des types documents joints au dossier de contrôle de conformité assainissement

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|code|Code interne des types de documents|character(2)| |
|valeur|Libellé des types de documents|character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|00|Non renseigné|
|10|Contrôle de conformité|
|20|Photographies ou planche de photos|
|30|Schéma de l'installation|
|40|Demande de raccordement|
|50|Diagniostic parties communes|
|51|Diagniostic parties privatives|
|99|Autres documents (à préciser ci-dessous)|

---

`lt_euep_sup` : Liste des types de servitude avec une autre propriété

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|code|Code interne des types de sevitudes|character(2)| |
|valeur|Libellé des types de servitudes|character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|00|Non renseigné (cf formulaire PDF)|
|10|Eaux usées|
|20|Eaux pluviales|
|ZZ|Sans objet|

## Export Open Data

Sans objet

---

## Schéma fonctionnel

### Modèle conceptuel simplifié

![mcd](../img/)

### Schéma fonctionnel

![schema_fonctionnel](../img/)

