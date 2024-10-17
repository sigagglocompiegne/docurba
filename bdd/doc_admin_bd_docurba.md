![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Documentation d'administration de la base #

## Principes
  * **généralité** :
 la gestion des données des documents d'urbanisme (carte communale,PLU, PLUi et SCoT) est soumis à une norme d'échange du CNIG.
 Cette norme est implantée dans la base de données Igeo Compiègnois de l'Agglomération de la Région de Compiègne. Des ajouts spécifiques ont été réalisés comme l'ajout de champs optionnels ou de nouvelles tables de gestion. De plus, l'Agglomération a mise en oeuvre un système de versionnement afin de conserver toutes les procédures d'urbanisme. La restauration d'une ancienne procédure doit-être possible suite à l'annulation de l'actuelle.
 
 * **résumé fonctionnel** :
 le fonctionnement de la base de données répond à la norme CNIG à la fois sur les attributs et les primitives géographiques (se référer au standard https://cnig.gouv.fr/ressources-dematerialisation-documents-d-urbanisme-a2732.html). Le système de versionnement repose sur une partie production (qui contient l'ensemble des procédures en vigueur), une partie archive (qui contient l'ensemble des procédures annulée,remplacée,abrogée,...) et une partie test (qui contient l'ensemble des documents en cours de création ou de modification). Le basculement des données entre les diverses parties s'effectuent via des Workflow de l'ETL FME. Le dernier standard intégré est celui de 2024.

## Schéma fonctionnel (simplifié)

![schema_fonctionnel](schema_fonctionnel_simple_docurba_v1.png)

## Schéma fonctionnel (détaillé)

![schema_fonctionnel](schema_fonctionnel_docurba_v2.png)

## Modèle conceptuel simplifié

![mcd](MCD.png)

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

   `an_doc_urba` : table issue du standard CNIG 2024  listant l'ensemble des procédures des documents d''urbanisme (y compris les communes en RNU)
   
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
|l_urldgen|Lien vers le fichier PDF contenant les dispositions générales du règlement|character varying(255)| |
|l_urlann|Lien vers le fichier PDF contenant les annexes du règlement|character varying(255)| |
|l_urllex|Lien vers le fichier PDF contenant le lexique du règlement|character varying(255)| |
|nom| 	Dénomination du SCoT (SCOT uniquement)|character varying(254)| |
|rapport|Nom du fichier contenant le rapport de présentation (SCOT uniquement)|character varying(30)| |
|padd|Nom du fichier contenant le projet d'aménagement et de développement durables (SCOT uniquement)|character varying(30)| |
|doo|Nom du fichier contenant le document d'orientation et d'objectifs (SCOT uniquement)|character varying(30)| |
|urlrapport|Lien d'accès au fichier du rapport de présentation sous forme numérique (SCOT uniquement)|character varying(254)| |
|urlpadd| 	Lien d'accès au fichier du PADD|character varying(254) (SCOT uniquement)| |
|urldoo| Lien d'accès au fichier du document d'orientation et d'objectifs (SCOT uniquement)|character varying(254)| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idurba
* Une clé étrangère exsiste sur la table de valeur `lt_etat`
* Une clé étrangère exsiste sur la table de valeur `lt_nomproc`
* Une clé étrangère exsiste sur la table de valeur `lt_typedoc`
* Une clé étrangère exsiste sur la table de valeur `lt_typeref`
---

`an_doc_urba_com` : table issue du standard CNIG 2024 d'appartenance d'une commune à une procédure définie.

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|insee|Code insee de la commune|character varying(5)| |
|epci|Code SIREN de l'EPCI auquel appartient la commune (uniquement pour un SCoT)|character varying(9)| |

Particularité(s) à noter : aucune

---

`an_doc_urba_com_plan` : Table listant l'appartenance des plans du règlement graphique à une procédure définie (approuvée ou non) pour une commune hors du PLUiH de l''ARC. ou autre PLUi disposant d'un tableau d'assemblage

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|insee|Code insee de la commune|character varying(5)| |
|numplan|Numéro du plan|character varying(50)| |
|echelleplan|Echelle du plan|character varying(50)| |
|urlfic|Lien URL vers le plan|character varying(254)| |

Particularité(s) à noter : aucune


---

`an_doc_urba_titre_pieces_ecrites` : Table listant les pièces écrites des procédures d''urbanisme pour export CNIG et fonctionnel GEO d''accès aux documents

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|gid|Identifiant unique interne|integer|nextval('m_urbanisme_doc.an_doc_urba_titre_pieces_ecrites_seq'::regclass)|
|idurba|Identifiant de la procédure d'urbanisme|character varying(30)| |
|code_geo|Code Insee ou siren de l'autorité compétente ou s'applique le document d'urbanisme|character varying(9)| |
|rep_cnig|Code du répertoire CNIG de stockage des fichiers (clé étrangère sur lt_typerep_cnig)|character varying(1)| |
|nomfic|Libellé du fichier avec l'extension .pdf|character varying(80)| |
|titre|Code du libellé générique de la pièce écrite (clé étrangère sur lt_titre_cnig)|character varying(2)| |
|complt|Compléments d'information permettant d'identifier plus précisément la pièce écrites (si plusieurs pièces de type identique). Cette information sera affichée à l'utilisateur dans le fonctionnel GEO de la fiche de RU ou dans la recherche métier|character varying(80)| |

Particularité(s) à noter : aucune

---

`geo_a_habillage_lin` : (archive) Donnée géographique contenant l'habillage linéaire des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage linéaire|character varying(40)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXE (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|MultiLineString,2154| |

Particularité(s) à noter : aucune

---

`geo_a_habillage_pct` : (archive) Donnée géographique contenant l'habillage ponctuel des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage ponctuel|character varying(40)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|MultiPoint,2154| |

Particularité(s) à noter : aucune

---

`geo_a_habillage_surf` : (archive) Donnée géographique contenant l'habillage surfacique des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage surfacique|character varying(40)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|MultiPolygon,2154| |

Particularité(s) à noter : aucune

---

`geo_a_habillage_txt` : (archive) Donnée géographique contenant l'habillage textuel des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage ponctuel|character varying(40)| |
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
|gid|Identifiant unique pour l'ARC|integer|nextval('m_urbanisme_doc.geo_a_habillage_txt_gid_seq'::regclass)|

Particularité(s) à noter :
* Une clé primaire existe sur le champ gid avec une séquence d'incrémentation automatique `m_urbanisme_doc.geo_a_habillage_txt_gid_seq`

---

`geo_a_info_lin` : (archive) Donnée géographique contenant les informations linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information linéaire|character varying(40)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
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

`geo_a_info_pct` : (archive) Donnée géographique contenant les informations ponctuelles des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information ponctuelle|character varying(40)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
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

`geo_a_info_surf` : (archive) Donnée géographique contenant les informations surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information surfacique|character varying(40)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
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
|gid|Identifiant unique spécifique à l'ARC|integer|nextval('m_urbanisme_doc.geo_a_info_surf_gid_seq'::regclass)|


Particularité(s) à noter :
* Une clé primaire existe sur le champ gid avec une séquence d'incrémentation automatique `m_urbanisme_doc.geo_a_info_surf_gid_seq`
* Une clé étrangère existe sur la table de valeur `lt_typeinf` (sur les attributs code et sous-code)

---

`geo_a_prescription_lin` : (archive) Donnée géographique contenant les prescriptions linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription linéaire|character varying(40)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nature|Libellé caractérisant un ensemble de prescriptions de même typepsc et stypepsc|character varying(254)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(254)| |
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

`geo_a_prescription_pct` : (archive) Donnée géographique contenant les prescriptions ponctuelles des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription ponctuelle|character varying(40)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nature|Libellé caractérisant un ensemble de prescriptions de même typepsc et stypepsc|character varying(254)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(254)| |
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

`geo_a_prescription_surf` : (archive) Donnée géographique contenant les prescriptions surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription surfacique|character varying(40)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nature|Libellé caractérisant un ensemble de prescriptions de même typepsc et stypepsc|character varying(254)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(254)| |
|l_nature|Nature / vocation|character varying(254)| |
|l_bnfcr|Bénéficiaire|character varying(80)| |
|l_numero|Numéro|character varying(10)| |
|l_surf_txt|Superficie littérale|character varying(30)| |
|l_gen|Générateur du recul|character varying(80)| |
|l_valrecul|Valeur de recul|character varying(80)| |
|l_typrecul|Type de recul|character varying(80)| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|MultiPolygon,2154| |
|gid|Identifiant unique spécifique à l'ARC|integer|nextval('m_urbanisme_doc.geo_a_prescription_surf_gid_seq'::regclass)|


Particularité(s) à noter :
* Une clé primaire existe sur le champ gid avec une séquence d'incrémentation automatique `m_urbanisme_doc.geo_a_prescription_surf_gid_seq`
* Une clé étrangère existe sur la table de valeur `lt_typepsc` (sur les attributs code et sous-code)

---

`geo_a_zone_urba` : (archive) Donnée géographique contenant les zonages des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idzone|Identifiant unique de zone|character varying(40)| |
|libelle|Nom court de la zone|character varying(12)| |
|libelong|Nom complet de la zone|character varying(254)| |
|typezone|Type de la zone|character varying(3)| |
|formdomi|Forme d'aménagement dominante souhaitée pour la zone|character varying(4)| |
|destoui|Destinations et sous-destinations autorisées|character varying(120)| |
|destcdt|Destinations et sous-destinations conditionnées|character varying(120)| |
|destnon|Destinations et sous-destinations interdites|character varying(120)| |
|nomfic|Nom du fichier du règlement complet|character varying(80)| |
|urlfic|URL ou URI du fichier du règlement complet|character varying(254)| |
|l_nomfic|Nom du fichier du règlement de la zone|character varying(80)| |
|l_urlfic|URL ou URI du fichier du règlement de la zone|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character varying(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
|typesect|Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)|character varying(2)|'ZZ'::character varying|
|fermreco|Secteur fermé à la reconstruction (uniquement pour la carte communale)|character varying(3)|'non'::character varying|
|l_insee|Code INSEE|character varying(5)| |
|l_surf_cal|Surface calculée de la zone en ha|numeric| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|MultiPolygon,2154| |
|gid|Identifiant unique spécifique à l'ARC|integer|nextval('m_urbanisme_doc.geo_a_zone_urba_gid_seq'::regclass)|

Particularité(s) à noter :
* Une clé primaire existe sur le champ gid avec une séquence d'incrémentation automatique `m_urbanisme_doc.geo_a_zone_urba_gid_seq`
* Une clé étrangère existe sur la table de valeur `lt_formdomi`
* Une clé étrangère existe sur la table de valeur `lt_dest_type`
* Une clé étrangère existe sur la table de valeur `lt_typesect`
* Une clé étrangère existe sur la table de valeur `lt_typezone`

---

`geo_a_perimetre_scot` : (archive) Donnée géographique contenant les périmètres de SCOT (format CNIG 2018)

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idurba|Identifiant unique du SCOT|character varying(30)| |
|geom|Géométrie de l'objet|MultiPolygon,2154| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ idurba `geo_a_perimetre_scot_pkey`

---

`geo_p_habillage_lin` : (production) Donnée géographique contenant les habillages linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage linéaire|character varying(40)| |
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

`geo_p_habillage_pct` : (production) Donnée géographique contenant les habillages ponctuels des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage ponctuel|character varying(40)| |
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

`geo_p_habillage_surf` : (production) Donnée géographique contenant les habillages surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage surfacique|character varying(40)| |
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

`geo_p_habillage_txt` : (production) Donnée géographique contenant les habillages textuels des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage ponctuel|character varying(40)| |
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

`geo_p_info_lin` : (production) Donnée géographique contenant les informations linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information linéaire|character varying(40)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
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

`geo_p_info_pct` : (production) Donnée géographique contenant les informations ponctuelles des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information ponctuelle|character varying(40)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
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

`geo_p_info_surf` : (production) Donnée géographique contenant les informations surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information surfacique|character varying(40)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
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


`geo_p_prescription_lin` : (production) Donnée géographique contenant les prescriptions linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription linéaire|character varying(40)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nature|Libellé caractérisant un ensemble de prescriptions de même typepsc et stypepsc|character varying(254)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(254)| |
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

`geo_p_prescription_pct` : (production) Donnée géographique contenant les prescriptions ponctuelles des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription ponctuelle|character varying(40)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nature|Libellé caractérisant un ensemble de prescriptions de même typepsc et stypepsc|character varying(254)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(254)| |
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


`geo_p_prescription_surf` : (production) Donnée géographique contenant les prescriptions surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription surfacique|character varying(40)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nature|Libellé caractérisant un ensemble de prescriptions de même typepsc et stypepsc|character varying(254)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(254)| |
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
|idpau|Identifiant géographique|integer|nextval('m_urbanisme_doc.idpau_seq'::regclass)|
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

`geo_p_zone_urba` : (production) Donnée géographique contenant les zonages des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idzone|Identifiant unique de zone|character varying(40)| |
|libelle|Nom court de la zone|character varying(12)| |
|libelong|Nom complet de la zone|character varying(254)| |
|typezone|Type de la zone|character varying(3)| |
|formdomi|Forme d'aménagement dominante souhaitée pour la zone|character varying(4)| |
|destoui|Destinations et sous-destinations autorisées|character varying(120)| |
|destcdt|Destinations et sous-destinations conditionnées|character varying(120)| |
|destnon|Destinations et sous-destinations interdites|character varying(120)| |
|nomfic|Nom du fichier du règlement complet|character varying(80)| |
|urlfic|URL ou URI du fichier du règlement complet|character varying(254)| |
|l_nomfic|Nom du fichier du règlement de la zone|character varying(80)| |
|l_urlfic|URL ou URI du fichier du règlement de la zone|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character varying(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
|typesect|Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)|character varying(2)|'ZZ'::character varying|
|fermreco|Secteur fermé à la reconstruction (uniquement pour la carte communale)|character varying(3)|'non'::character varying|
|l_insee|Code INSEE|character varying(5)| |
|l_surf_cal|Surface calculée de la zone en ha|numeric| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|Multipolygon,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idzone
* Une clé étrangère existe sur la table de valeur `lt_formdomi`
* Une clé étrangère existe sur la table de valeur `lt_dest_type`
* Une clé étrangère existe sur la table de valeur `lt_typesect`
* Une clé étrangère existe sur la table de valeur `lt_typezone`
* Un index est présent sur le champ geom
* 1 trigger :
  * `l_surf_cal` : calcul de la surface en m² avant l'insert ou la mise à jour d'une géométrie uniquement

---
`geo_p_perimetre_scot` : Donnée géographique contenant les périmètres de SCOT (format CNIG 2018)

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idurba|Identifiant unique du SCOT|character varying(30)| |
|geom|Géométrie de l'objet|MultiPolygon,2154| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ idurba `geo_p_perimetre_scot_pkey`

---

`geo_t_habillage_lin` : (pré-production) Donnée géographique contenant les habillages linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage linéaire|character varying(40)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|Multilinestring,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idhab

---

`geo_t_habillage_pct` : (pré-production) Donnée géographique contenant les habillages ponctuels des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage ponctuel|character varying(40)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|Multipoint,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idhab

---

`geo_t_habillage_surf` : (pré-production) Donnée géographique contenant les habillages surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage surfacique|character varying(40)| |
|nattrac|Nature du tracé|character varying(40)| |
|couleur|Couleur de l'élément graphique, sous forme RVB (255-255-000)|character varying(11)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|l_insee|Code INSEE|character varying(5)| |
|l_couleur|Couleur de l'élément graphique, sous forme HEXA (#000000)|character varying(7)| |
|geom|Géométrie de l'objet|Multipolygon,2154| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ idhab

---

`geo_t_habillage_txt` : (pré-production) Donnée géographique contenant les habillages textuels des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage ponctuel|character varying(40)| |
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


`geo_t_info_lin` : (pré-production) Donnée géographique contenant les informations linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information linéaire|character varying(40)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
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

`geo_t_info_pct` : (pré-production) Donnée géographique contenant les informations ponctuelles des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information ponctuelle|character varying(40)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
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

`geo_t_info_surf` : (pré-production) Donnée géographique contenant les informations surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idinf|Identifiant unique de l'information surfacique|character varying(40)| |
|libelle|Nom de l'information|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typeinf|Type d'information|character varying(2)| |
|stypeinf|Sous type d'information|character varying(2)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
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

`geo_t_prescription_lin` : (pré-production) Donnée géographique contenant les prescriptions linéaires des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription linéaire|character varying(40)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nature|Libellé caractérisant un ensemble de prescriptions de même typepsc et stypepsc|character varying(254)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(254)| |
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


`geo_t_prescription_pct` : (pré-production) Donnée géographique contenant les prescriptions ponctuelles des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription ponctuelle|character varying(40)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nature|Libellé caractérisant un ensemble de prescriptions de même typepsc et stypepsc|character varying(254)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(254)| |
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

`geo_t_prescription_surf` : (pré-production) Donnée géographique contenant les prescriptions surfaciques des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idpsc|Identifiant unique de prescription surfacique|character varying(40)| |
|libelle|Nom de la prescription|character varying(254)| |
|txt|Texte étiquette|character varying(10)| |
|typepsc|Type de la prescription|character varying(2)| |
|stypepsc|Sous type de la prescription|character varying(2)| |
|nature|Libellé caractérisant un ensemble de prescriptions de même typepsc et stypepsc|character varying(254)| |
|nomfic|Nom du fichier|character varying(80)| |
|urlfic|URL ou URI du fichier|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
|l_insee|Code INSEE|character varying(5)| |
|l_nom|Nom|character varying(254)| |
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

`geo_t_zone_urba` : (pré-production) Donnée géographique contenant les zonages des documents d'urbanisme locaux (PLUi, PLU, CC) issue du modèle CNIG 2024

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idzone|Identifiant unique de zone|character varying(40)| |
|libelle|Nom court de la zone|character varying(12)| |
|libelong|Nom complet de la zone|character varying(254)| |
|typezone|Type de la zone|character varying(3)| |
|formdomi|Forme d'aménagement dominante souhaitée pour la zone|character varying(4)| |
|destoui|Destinations et sous-destinations autorisées|character varying(120)| |
|destcdt|Destinations et sous-destinations conditionnées|character varying(120)| |
|destnon|Destinations et sous-destinations interdites|character varying(120)| |
|nomfic|Nom du fichier du règlement complet|character varying(80)| |
|urlfic|URL ou URI du fichier du règlement complet|character varying(254)| |
|l_nomfic|Nom du fichier du règlement de la zone|character varying(80)| |
|l_urlfic|URL ou URI du fichier du règlement de la zone|character varying(254)| |
|idurba|Identifiant du document d'urbanisme|character varying(30)| |
|datvalid|Date de validation (aaaammjj)|character varying(8)| |
|symbole|Symbole alternatif issu du registre des symboles|character(20)| |
|typesect|Type de secteur (uniquement pour la carte communale, ZZ correspond à non concerné)|character varying(2)|'ZZ'::character varying|
|fermreco|Secteur fermé à la reconstruction (uniquement pour la carte communale)|character varying(3)|'non'::character varying|
|l_insee|Code INSEE|character varying(5)| |
|l_surf_cal|Surface calculée de la zone en ha|numeric| |
|l_observ|Observations|character varying(254)| |
|geom|Géométrie de l'objet|Multipolygon,2154| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ idzone
* Une clé étrangère existe sur la table de valeur `lt_formdomi`
* Une clé étrangère existe sur la table de valeur `lt_dest_type`
* Une clé étrangère existe sur la table de valeur `lt_typesect`
* Une clé étrangère existe sur la table de valeur `lt_typezone`
* 1 trigger :
  * `l_surf_cal` : calcul de la surface en m² avant l'insert ou la mise à jour d'une géométrie uniquement

---

`geo_t_perimetre_scot` : (pré-production) Donnée géographique contenant les périmètres de SCOT (format CNIG 2024)

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idurba|Identifiant unique du SCOT|character varying(30)| |
|geom|Géométrie de l'objet|MultiPolygon,2154| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ idurba `geo_t_perimetre_scot_pkey`

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

`geo_v_zone_urba_controle_geom` :   Vue géographique permettant de vérifier les géométries des zonages des communes par union des polygones (permet de vérifier s'il n'y a pas de trous ou de superpositions).

---

 ### classes d'objets applicatives sont classés dans le schéma m_urbanisme_doc :

 #### Vue matérialisée applicative PRO
 
  **ATTENTION** : ces vues sont reformatées à chaque mise à jour de cadastre ou d'un document d'urbanisme dans un Workflow de l'ETL FME.
 
`xapps_an_vmr_p_information` : Vue matérialisée formatant les données les données informations jugées utiles pour la fiche de renseignements d''urbanisme (assemblage des vues infos PLU et hors PLU)

`xapps_an_vmr_p_information_horsplu` : Vue matérialisée formatant les données les données informations jugées utiles hors données intégrées dans les données de PLU (cette vue est fusionnée avec xapps_an_vmr_p_information_plu pour être lisible dans la fiche de renseignement d''urbanisme de GEO).

`xapps_an_vmr_p_information_plu` : Vue matérialisée formatant les données les données informations jugées utiles provenant des données intégrées dans les données des PLU (cette vue est ensuite assemblée avec celle des infos hors PLU pour être accessible dans la fiche de renseignements d''urbanisme dans GEO)


`xapps_an_vmr_p_information_dpu` : Vue matérialisée alphanumérique formatant une liste des parcelles avec l'information d'appartenance ou non à une DPU. Cette vue est liée dans GEO pour récupération de ces informations dans la fiche de renseignements d'urbanisme (cf dossier GitHub correspondant à l'application).

`xapps_an_vmr_p_prescription` :  Vue matérialisée alphanumérique formatant une liste des parcelles avec les prescriptions ponctuelles, surfaciques, linénaires issues des documents d'urbanisme impactant chaque parcelle. Cette vue est liée dans GEO pour récupération de ces informations dans la fiche de renseignements d'urbanisme (cf dossier GitHub correspondant à l'application).

`xapps_an_vmr_parcelle_plu` :  Vue matérialisée contenant les informations pré-formatés pour la constitution de la fiche d'information Renseignements d'urbanisme. Cette vue permet de récupérer pour chaque parcelle les informations du PLU et traiter les pbs liés aux zones entre commune et les zonages se touchant. 

`xapps_an_vmr_parcelle_ru` :  Vue matérialisée extrayant de la table PARCELLE de BG les informations essentielles pour la note d'urbanisme. Evite d'utiliser les données intégrées via le module GEOCADASTRE pour des pbs de mises à jour et de reconstructions applicatives.

`xapps_geo_vmr_p_zone_urba` :  Vue matérialisée des zones du PLU servant dans les recherches par zonage ou type dans les applicatifs GEO. 

`x_apps.xapps_an_vmr_docurba_h` : Vue matérialisée listant les anciennes procédures d''urbanisme par commune

`xapps_geo_vmr_docurba` : Vue matérialisée listant toutes les procédures d''urbanisme par commune

`xapps_an_vmr_p_planche_graphique_plu` : Vue matérialisée formatant l'accès aux planches du règlement graphique des PLU (cette vue est ensuite liée dans GEO pour accessiiblité à la parcelle dans la fiche de renseignements d'urbanisme dans GEO)

 #### Vue matérialisée applicative Grand Public
 
  **ATTENTION** : ces vues sont reformatées à chaque envoi d'une mise à jour du PLUih vers la base déportée de Business Géografic pour le fonctionnel de l'application Grand Public via un Workflow de l'ETL FME.

  `xappspublic_an_vmr_nru` : Vue matérialisée contenant les informations pré-formatés du PLUi communes à toutes les communes pour la note de renseignements d'urbanisme

  `xappspublic_an_vmr_p_planche_graphique_plui_arc` : Vue matérialisée formatant l'accès aux planches du règlement graphique du PLUiH (cette vue est ensuite liée dans GEO pour accessiiblité à la parcelle dans la fiche de renseignements d'urbanisme dans GEO)

  `xappspublic_an_vmr_parcelle_plui_ru` : Vue matérialisée contenant les informations pré-formatés du PLUi communes à toutes les communes pour la fiche de Renseignements d'urbanisme (données de production) 

  `xappspublic_geo_vmr_commune_plui_ru` : Vue matérialisée contenant les informations pré-formatés pour la constitution de la fiche d'information sur les communes dans l'application PLU Interactif V0.2 (test pour voir où on met les infos d'urbanisme)

  `xappspublic_geo_vmr_fichegeo_plui_ru` : Vue géographique matérialisée contenant les informations pour l'application Gd Public PLUi Interactif (données de production)

## Liste de valeurs

`lt_formdomi` : Liste des valeurs de l'attribut formdomi de la donnée zone_urba

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code|character varying(4)| |
|valeur|Valeur|character varying(80)| |
|def|Définition|character varying(1000)| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|Définition|
|:---|:---|:---|
|0000|sans objet ou non encore définie dans le règlement||
|0100|habitat|Tout type d'habitat|
|0101|habitat centre-ville|Petites parcelles étroites – bâti implanté en mitoyen et à l'alignement Rues sinueuses et non structurées.|
|0102|habitat centre-villageois|Tissu compact issu d'une implantation historique - petites parcelles étroites – bâti implanté en mitoyen et/ou à l’alignement. Rues sinueuses et non structurées. Présence d'espaces ou équipements publics fédérateurs, nombre de constructions plus important que les hameaux.|
|0103|habitat faubourg|Tissu compact et dense en extension du centre ancien. Petites parcelles étroites et souvent allongées (autour de 400 m²) en forme parallélogramme – bâti implanté en mitoyen et/ou à l'alignement.|
|0104|habitat hameau|Tissu compact issu d’une implantation historique. Parcelles de taille variable – bâti globalement implanté au contact de l’espace public. Rues sinueuses et étroites.|
|0105|habitat collectif|(R+3 et plus). Bâti discontinu, déconnecté des espaces urbains voisins. Taille des parcelles variables avec une prédominance de grandes parcelles de plus de 1 000 m² – voies de desserte larges – bâti en retrait par rapport aux limites parcellaires.|
|0106|habitat petits collectifs|(R+2 max)Bâti discontinu, déconnecté des espaces urbains voisinsTaille des parcelles variables avec une prédominance de grandes parcelles de plus de 1 000 m² – voies de desserte larges – bâti en retrait par rapport aux limites parcellaires.|
|0107|habitat pavillonnaire dense|Tissus résidentiel discontinu, dense, organisé et présentant une certaine homogénéité. Petites parcelles en forme homogène – bâti implanté en retrait des limites parcellaires.|
|0108|habitat pavillonnaire peu dense|Tissus discontinu, non organisé et hétérogène. Bâti implanté de manière aléatoire – plutôt grandes parcelles - bâti implanté en retrait des limites parcellaires.|
|0109|habitat maitrisé|Bâti isolé au milieu d’un espace naturel, agricole ou forestier Parcelles de forme variable avec prédominance pour les grandes de plus de 1 000 m² - bâti implanté en retrait des limites parcellaires.|
|0200|activité|Tout type d’activité|
|0201|activité industrielle / logistique / commerciale|Zone regroupant des entreprises, usines, entrepôts, surfaces commerciales… visibles et en dehors des zones urbanisées.|
|0202|activité commerces|Espace regroupant des commerces de proximité. Parcelles de taille et forme variables.|
|0203|activité bureaux|Ensembles d’immeubles de bureaux privatisés abritant des entreprises et activités tertiaires Parcelles de taille et de formes variables – surface de parkings importante mais espaces verts présents.|
|0300|mixte habitat / activité|Secteur où une mixité fonctionnelle est soit recherchée, soit à encadrer.|
|0400|loisirs et tourisme|Tout type de loisir et de tourisme|
|0401|loisir parc et jardin|Parcs et jardins en milieu urbain|
|0402|loisir parc d'attraction|Parcs d'attraction|
|0403|loisir balnéaire et nautique|Plages, port de plaisance|
|0404|loisir de montagne|Pistes et domaines orientés vers les loisirs de montagnes (tracés skiables en hiver, espaces de randonnées, activités sportives …)|
|0405|loisir sportif|Ensemble d'équipements sportifs (stades, gymnases, circuit automobile …)|
|0406|tourisme hôtelier|Ensembles d'immeubles d'hébergement hôtelier|
|0407|tourisme camping|Espaces réservés aux activités de camping|
|0500|Equipement public|Tout type d’équipement|
|0501|Equipement de proximité|Crèches, écoles, collèges, lycées, gendarmerie, commissariat, sécurité incendie|
|0502|Equipement généraux|Hopitaux, Universités|
|0503|Equipement de défense nationale|Domaine militaire|
|0600|Enfrastructure de transport|Tout type d’infrastructure de transport|
|0601|Infrastructure autoroutière|Emprise autoroutière et équipements associés|
|0602|Infrastructure ferroviaire|Emprise ferroviaire et équipements associés|
|0603|Infrastructure aéroportuaire|Emprise aéroportuaire et équipements associés|
|0604|Infrastructure portuaire|Port d'ampleur nationale (frêt, marchandises…)|
|0700|Activité agricole|Toutes activités agricoles|
|0701|Terres agricoles non bâties|Terres agricoles dépourvues de toute construction|
|0702|Terres agricoles avec bâtis légers|Terres agricoles pouvant contenir des constructions démontables (serres, tunnels, constructions sans fondation…)|
|0703|Terres agricoles avec bâtis en dur|Terres agricoles avec éventuellement des bâtiments agricoles en dur|
|0704|Terres agricoles avec bâtis agricoles|Terres agricoles avec éventuellement des bâtiments agricoles, le logement des exploitants et des locaux dans le prolongement de l’activité agricole (point de vente à la ferme, atelier de transformation des produits de la ferme...)|
|0705|Terres agricoles avec bâtis divers|Terres agricoles avec éventuellement des bâtiments agricoles, le logement des exploitants, des locaux dans le prolongement de l’activité agricole (point de vente à la ferme, atelier de transformation des produits de la ferme…), des locaux associés à une diversification (touristique, culturelle, éducative…)|
|0800|Espace naturel|Tous espaces naturels|
|0801|Espace naturel remarquable|Espace naturel remarquable|
|0802|Espace naturel montagne ou littoral|Espace naturel caractéristique du patrimoine naturel et relevant de l’application des dispositions montagne / littoral|
|0900|Valorisation des sols et sous-sols|Toutes valorisations des sols et sous-sols|
|0901|Secteur de carrière|Secteur d'activité d'extraction minérale|
|0902|Secteur d'accueil des déchets|Secteur de traitement ou d'enfouissement des déchets|
|0903|Secteur de parc photovoltaïque|Secteur susceptible d’accueillir des parcs photovoltaïques|
|9900|Autre|Autre|

---

`lt_etat` : Liste des valeurs de l''attribut état de la donnée doc_urba

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code|character(2)| |
|valeur|Valeur|character varying(80)| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|01|en cours de procédure|
|02|arrêté|
|03|opposable|
|04|annulé|
|05|remplacé|
|06|abrogé|
|07|approuvé|
|08|partiellement annulé|
|09|caduc|


---

`lt_libsect` : Liste des valeurs de l'attribut libelle à saisir pour la carte communale (convention de libellé pour l'affichage cartographique)

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code|character(3)| |
|valeur|Valeur|character varying(100)| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|ZC|Secteur ouvert à la construction|
|ZCa|Secteur réservé aux activités|
|ZnC|Secteur non ouvert à la construction, sauf exceptions prévues par la loi|
|RNU|Zone non couverte par la carte communale (soumise au Règlement National de l'Urbanisme|

---

`lt_nomproc` : Liste des valeurs de l'attribut Nom de la procédure de la donnée doc_urba

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code|character(3)| |
|valeur|Valeur|character varying(80)| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|RNU|Commune soumise au RNU|
|E|Elaboration|
|MEC|Mise en compatibilité|
|MAJ|Mise à jour|
|M|Modification de droit commun|
|MS|Modification simplifiée|
|R|Révision|
|RA|Révision allégée|
|RS|Révision simplifiée|
|A|Abrogation|

---

`lt_typedoc` : Liste des valeurs de l'attribut typedoc de la donnée doc_urba

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code|character(4)| |
|valeur|Valeur|character varying(80)| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|RNU|Règlement national de l'urbanisme|
|PLU|Plan local d'urbanisme|
|PLUI|Plan local d'urbanisme intercommunal|
|POS|Plan d'occupation des sols|
|CC|Carte communale|
|PSMV|Plan de sauvegarde et de mise en valeur|
|SCOT|SCOT|

---

`lt_typeinf` : Liste des valeurs de l''attribut typeinf de la donnée info_surf, info_lin et info_pct

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|code|Code|character(2)| |
|sous_code|Sous code|character varying(2)| |
|valeur|Valeur|character varying(254)| |
|ref_leg|Références législatives du code de l'urbanisme|character varying(80)| |
|ref_reg|Références réglementaires du code de l'urbanisme|character varying(80)| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Sous code|Valeur|Référence législative|Référence réglementaire|
|:---|:---|:---|:---|:---|
|01|Anciennement « Secteur sauvegardé » puis « Site patrimonial remarquable » supprimé car il correspond à une SUP|
|02|Zone d'aménagement concerté|
|03|Zone de préemption dans un espace naturel et sensible (Attention : information facultative non exigée par la loi)|
|04|Périmètre de droit de préemption urbain|
|04|Périmètre de droit de préemption urbain renforcé|
|05|Zone d'aménagement différé|
|07|Périmètre de développement prioritaire économie d'énergie|
|08|Périmètre forestier : interdiction ou réglementation des plantations (code rural et de la pêche maritime), plantations à réaliser et semis d'essence forestière|
|09|Périmètre minier de concession pour l'exploitation ou le stockage|
|10|Zone de recherche et d'exploitation de carrière|
|11|Périmètre des zones délimitées - divisions foncières soumises à déclaration préalable|
|12|Périmètre de sursis à statuer|
|13|Secteur de programme d'aménagement d'ensemble|
|14|Périmètre de voisinage d'infrastructure de transport terrestre|
|15|les Zones Agricoles Protégées abrogées car traitées en SUP A9|
|16|Site archéologique (Attention : information facultative non exigée par la loi)|
|17|Zone à risque d'exposition au plomb|
|19|Zone d'assainissement collectif/non collectif, eaux usées/eaux pluviales, schéma de réseaux eau et assainissement, systèmes d'élimination des déchets|
|19|Emplacements traitement eaux et déchets|
|20|Règlement local de publicité|
|21|Projet de plan de prévention des risques|
|22|Protection des rives des plans d'eau en zone de montagne|
|23|Arrêté du préfet coordonnateur de massif|
|25|Périmètre de protection des espaces agricoles et naturels périurbain|
|26|Lotissement|
|27|Plan d'exposition au bruit des aérodromes|
|30|Périmètre projet urbain partenarial|
|31|Périmètre patrimoniaux d'exclusion des matériaux et énergies renouvelables pris par délibération|
|32|Secteur de taxe d'aménagement|
|33|Droit de préemption commercial (Attention : information facultative non exigée par la loi)|
|34|Périmètre d'opération d'intérêt national (Attention : information facultative non exigée par la loi)|
|35|Périmètre de secteur affecté par un seuil minimal de densité|
|36|Schémas d'aménagement de plage|
|37|Bois ou forêts relevant du régime forestier|
|38|Secteurs d'information sur les sols|
|39|Périmètres de projets AFUP (dans lesquels les propriétaires fonciers sont incités à se regrouper en AFU de projet et les AFU de projet à mener leurs opérations de façon concertée)|
|40|Périmètre d’un bien inscrit au patrimoine mondial|
|40|Zone tampon d’un bien inscrit au patrimoine mondial|
|41|Bande de recul le long des axes à grande circulation|
|42|Secteurs délimités par délibération de l'autorité compétente en matière d'urbanisme, dans lesquels certaines opérations sont soumises à autorisation d'urbanisme.|
|42|secteur dans lequel les travaux de démolition sont soumis à permis de démolir|
|42|Secteur dans lequel l'édification d'une clôture doit être précédée d'une déclaration préalable|
|42|Secteur dans lequel les travaux de ravalement sont soumis à déclaration préalable|
|97|Périmètre d’application d’une pièce écrite territorialisée relative aux annexes (liste des annexes, liste et plan des SUP)|
|98|Périmètre d’annulation partielle du document d’urbanisme (lorsqu’elle impacte le règlement graphique)|
|99|Autre périmètre, secteur, plan, document, site, projet, espace|
|99|Autre relevant de la loi littoral|
|99|Autre relevant de la loi montagne|


---

`lt_typepsc` : Liste des valeurs de l''attribut typepsc de la donnée prescription_surf, prescription_lin et prescription_pct

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|
|code|Code|character(2)| |
|sous_code|Sous code|character varying(2)| |
|valeur|Valeur|character varying(254)| |
|ref_leg|Références législatives du code de l'urbanisme|character varying(80)| |
|ref_reg|Références réglementaires du code de l'urbanisme|character varying(80)| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Sous code|Valeur|Référence législative|Référence réglementaire|
|:---|:---|:---|:---|:---| 
|01|Espace boisé classé|
|01|Espace boisé classé à protéger ou conserver|
|01|Espace boisé classé à créer|
|01|Espace boisé classé significatif au titre de la loi littoral|
|02|Limitations de la constructibilité pour des raisons environnementales, de risques,d'intérêt général|
|02|Secteur avec interdiction de constructibilité pour des raisons environnementales,de risques, d'intérêt général|
|02|Secteur avec conditions spéciales de constructibilité pour des raisons environnementales, de risques, d'intérêt général|
|03|Secteur avec disposition de reconstruction / démolition|
|03|Secteur dans lequel la reconstruction à l'identique d'un bâtiment détruit par un sinistre n'est pas autorisée|
|03|Interdiction de restauration de bâtiment dont il reste l'essentiel des murs porteurs|
|03|Interdiction de reconstruction à l'identique|
|04|Périmètre issu des PDU sur obligation de stationnement|
|05|Emplacement réservé|
|05|Emplacement réservé aux voies publiques|
|05|Emplacement réservé aux ouvrages publics|
|05|Emplacement réservé aux installations d'intérêt général|
|05|Emplacement réservé aux espaces verts/continuités écologiques|
|05|Emplacement réservé logement social/mixité sociale|
|05|Servitude de localisation des voies, ouvrages publics, installations d'intérêt général et espaces verts en zone U ou AU|
|05|Secteur de projet en attente d'un projet d'aménagement global|
|05|Emplacements réservés à la relocalisation d'équipements, de constructions et d'installations exposés au recul du trait de côté|
|06|Secteur à densité maximale pour les reconstructions ou aménagements de bâtiments existants|
|07|Patrimoine bâti, paysager ou éléments de paysages à protéger pour des motifs d'ordre culturel, historique, architectural ou écologique|
|07|Patrimoine bâti à protéger pour des motifs d'ordre culturel, historique, architectural|
|07|Patrimoine paysager à protéger pour des motifs d'ordre culturel, historique, architectural|
|07|Patrimoine paysager correspondant à un espacer boisé à protéger pour des motifs d'ordre culturel, historique, architectural|
|07|Éléments de paysage, (sites et secteurs) à préserver pour des motifs d'ordre écologique|
|07|Éléments de paysage correspondant à un espace boisé, (sites et secteurs) à préserver pour des motifs d'ordre écologique|
|08|Terrain cultivé ou non bâti à protéger en zone urbaine|
|13|Zone à aménager en vue de la pratique du ski|
|14|Secteur de plan de masse|
|15|Règles d'implantation des constructions|
|15|Implantation des constructions par rapport aux voies et aux emprises publiques|
|15|Implantation des constructions par rapport aux limites séparatives latérales|
|15|Implantation des constructions par rapport aux limites des fonds de parcelles|
|15|Implantation alternative des constructions|
|16|Constructions et installations nécessaires à des équipements collectifs|
|16|Bâtiment susceptible de changer de destination|
|16|Bâtiments d'habitation existants pouvant faire l'objet d’extensions ou d’annexes|
|16|Secteur de taille et de capacité d'accueil limitées (STECAL)|
|16|Constructions et installations nécessaires à l'activité agricole en zone A ou N|
|16|Diversification de l'activité agricole : transformation conditionnement et ventes de produits agricoles (activités liées au tourisme exclues|
|17|Secteur à programme de logements mixité sociale en zone U et AU|
|18|Secteur comportant des orientations d'aménagement et de programmation (OAP)|
|18|OAP de projet (sans règlement)|
|18|OAP entrées de ville|
|18|OAP relatives à la réhabilitation, la restructuration, la mise en valeur ou l'aménagement|
|18|OAP d'adaptation des périmètres de transports collectifs|
|18|OAP patrimoniales, architecturales et écologiques|
|18|OAP relatives à l'habitat|
|18|OAP comprenant des dispositions relatives à l'équipement commercial et artisanal|
|18|OAP relatives aux transports et aux déplacements|
|18|OAP relatives aux espaces publics en zone d'aménagement concerté|
|18|OAP relatives aux ouvrages publics, installations d'intérêts général et espaces verts en zone d'aménagements concerté|
|18|OAP valant création de zone d'aménagement concerté|
|18|OAP Secteurs de renaturation|
|18|OAP relatives à la protection des franges urbaines et rurales|
|18|OAP recul du trait de côte|
|18|OAP trames vertes et bleues|
|18|OAP zone d’accélération de la production d’énergies renouvelables|
|19|Secteur protégé en raison de la richesse du sol et du sous-sol|
|20|Secteur à transfert de constructibilité en zone N|
|22|Diversité commerciale à protéger ou à développer|
|22|Diversité commerciale à protéger|
|22|Diversité commerciale à développer|
|22|Linéaire commercial protégé|
|22|Linéaire commercial protégé renforcé|
|23|Secteur avec taille minimale des logements en zone U et AU|
|24|Voies, chemins, transport public à conserver et à créer|
|24|Voies de circulation à créer, modifier ou conserver|
|24|Voies de circulation à modifier|
|24|Voies de circulation à créer|
|24|Voies de circulation à conserver|
|25|Eléments de continuité écologique et trame verte et bleue|
|26|Secteur de performance énergétique|
|26|Secteur de performance énergétique renforcé|
|27|Secteur d’aménagement numérique|
|28|Conditions de desserte|
|28|Conditions permettant une bonne desserte des terrains par les services publics de collecte des déchets|
|29|Secteur avec densité minimale de construction|
|29|Secteur avec densité minimale de construction à proximité des transports collectifs|
|29|Secteur de ZAC avec densité minimale de construction|
|30|Majoration des volumes constructibles|
|30|Majoration des volumes constructibles pour l'habitation|
|30|Majoration des volumes constructibles pour les programmes comportant des logements locatifs sociaux|
|30|Majoration des volumes constructibles pour exemplarité énergétique ou environnementale|
|30|Majoration des volumes constructibles pour les programmes comportant des logements intermédiaires|
|31|Espaces remarquables du littoral|
|31|Dunes, landes côtières, plages et lidos, estrans, falaises et abords|
|31|Forêts et zones boisées proches du rivage de la mer et des plans d'eau intérieurs d'une superficie supérieure à 1 000 hectares|
|31|Ilots inhabités|
|31|Parties naturelles des estuaires, des rias ou abers et des caps|
|31|Marais, vasières, tourbières, plans d'eau, les zones humides et milieux temporairement immergés|
|31|Milieux abritant des concentrations naturelles d'espèces animales ou végétales|
|31|Parties naturelles des sites inscrits ou classés|
|31|Formations géologiques|
|32|Exclusion protection de plans d'eau de faible importance|
|33|Secteur de dérogation aux protections des rives des plans d'eau en zone de montagne|
|34|Espaces, paysage et milieux caractéristiques du patrimoine naturel et culturel montagnard à préserver|
|35|Terres nécessaires au maintien et au développement des activités agricoles, pastorales et forestières à préserver|
|36|Mixité des destinations ou sous-destinations|
|37|Règles différenciées entre le rez-de-chaussée et les étages supérieurs des constructions|
|37|Règles différenciées pour le rez-de-chaussée en raison des risques inondations|
|37|Règles différenciées pour mixité sociale et fonctionnelle|
|38|Emprise au sol|
|38|Emprise au sol minimale|
|38|Emprise au sol maximale|
|38|Emprise au sol règles qualitatives|
|38|Emprise au sol règles alternatives|
|39|Hauteur|
|39|Hauteur minimale|
|39|Hauteur maximale|
|39|Hauteur règles qualitatives|
|39|Hauteur règles alternatives|
|40|Volumétrie|
|40|Volumétrie minimale|
|40|Volumétrie maximale|
|40|Règles volumétriques qualitatives|
|40|Règles volumétriques alternatives|
|41|Aspect extérieur|
|41|Aspect extérieur façades|
|41|Aspect extérieur toitures|
|41|Aspect extérieur clôtures|
|41|Aspect extérieur règles alternatives|
|42|Coefficient de biotope par surface|
|43|Réalisation d'espaces libres, plantations, aires de jeux et de loisir|
|43|Réalisation d'espaces libres|
|43|Réalisation d'aires de jeux et de loisirs|
|43|Réglementation des plantations|
|44|Stationnement|
|44|Stationnement minimal|
|44|Stationnement maximal|
|44|Caractéristiques et type de stationnement|
|44|Minoration des règles de stationnement|
|44|Réalisation d'aires de livraisons imposée|
|44|Stationnement règles alternatives|
|45|Zone d'aménagement concerté (surface de plancher, destination)|
|46|Constructibilité espace boisé antérieur au 20ème siècle|
|47|Desserte par les réseaux|
|47|Réseaux publics d'eau|
|47|Réseaux publics d'électricité|
|47|Réseaux publics d'assainissement|
|47|Conditions de réalisation d'un assainissement non collectif|
|47|Infrastructures et réseaux de communications électroniques|
|48|Mesures pour limiter l'imperméabilisation des sols|
|48|Installations nécessaires à la gestion des eaux pluviales et du ruissellement|
|49|Opération d'ensemble imposée en zone AU|
|49|Urbanisation par opération d'ensemble|
|49|Urbanisation conditionnée à la réalisation des équipements internes à la zone|
|50|Interdiction types d'activités, destinations, sous-destinations|
|51|Autorisation sous conditions types d'activités, destinations, sous-destinations|
|52|Infrastructures et équipements logistiques à préserver ou à développer en zones U et AU|
|53|Dérogation à l’article L.111-6 pour l’implantation des constructions le long des grands axes routiers|
|97|Périmètre d’application d’une pièce écrite territorialisée (rapport de présentation, PADD, règlement, règlement graphique, POA)|
|97|Périmètre couvert par un Plan de secteurs|
|99|Autre|
|99|Autre : affectation des sols et destination des constructions|
|99|Autre : zones naturelles, agricoles ou forestières|
|99|Autre : mixité sociale et fonctionnelle en zones urbaines ou à urbaniser|
|99|Autre : qualité du cadre de vie|
|99|Autre : Qualité urbaine, architecturale, environnementale et paysagère|
|99|Autre : Traitement environnemental et paysager des espaces non bâtis et abords des constructions|
|99|Autre : densité|
|99|Autre : équipements, réseaux et emplacements réservés|
|99|Autre : plan local d'urbanisme tenant lieu de programme local de l'habitat et de plan de déplacements urbains|
|99|Autre : plan local d'urbanisme tenant lieu de programme de déplacements urbains|

---

`lt_typeref` : Liste des valeurs de l'attribut typeref de la donnée doc_urba

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code|character varying(2)| |
|valeur|Valeur|character varying(80)| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|01|PCI|
|02|BD Parcellaire|
|03|RPCU|
|04|Référentiel local|
|05|Orthophoto & Cadastre|

---

`lt_typesect` : Liste des valeurs de l'attribut typesect de la donnée zone_urba

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code|character varying(2)| |
|valeur|Valeur|character varying(100)| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|ZZ|Non concerné|
|01|Secteur ouvert à la construction|
|02|Secteur réservé aux activités|
|03|Secteur non ouvert à la construction, sauf exceptions prévues par la loi|
|99|Zone non couverte par la carte communale|

`lt_typezone` : Liste des valeurs de l'attribut typezone de la donnée zone_urba

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code|character varying(3)| |
|valeur|Valeur|character varying(80)| |


Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|U|Urbaine|
|AUc|A urbaniser|
|AUs|A urbaniser bloquée|
|A|Agricole|
|N|Naturel et forestière|

---

`lt_typerep_cnig` : Liste des valeurs de l'attribut typerep de la donnée an_doc_urba_titre_pieces_ecrites

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code|character varying(2)| |
|valeur|Valeur|character varying(80)| |
|definition|Libellé clair de l'attribut Valeur|character varying(80)| |

Particularité(s) à noter : aucune

Valeurs possibles :

|Code|Valeur|
|:---|:---|:---|
|0|0_Procedure|Procédure|
|1|1_Rapport_de_presentation|Rapport de présentation|
|2|2_PADD|PADD|
|3|3_Reglement|Règlement|
|4|4_Annexes|Annexes|
|5|5_OAP|Orientations d'aménagement|
|6|6_POA|Programme d'orientations et d'actions|
|7|7_Plans_de_secteur|Plans de secteur|

---

`lt_titre_cnig` : Liste des valeurs de l'attribut titre de la donnée an_doc_urba_titre_pieces_ecrites

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code|character varying(2)| |
|valeur|Valeur|character varying(80)| |

Particularité(s) à noter : aucune

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|01|Délibération de l'autorité compétente|
|10|Rapport de présentation|
|20|PADD|
|30|Règlement écrit|
|31|Règlement graphique|
|32|Liste des emplacements réservés|
|39|Autres prescriptions|
|40|Liste des SUP|
|42|Liste des annexes|
|41|Plan des SUP|
|49|Autres annexes|
|50|Orientations d'aménagement|
|43|Notice sanitaire|
|44|Réseaux|

## Traitement automatisé mis en place (Workflow de l'ETL FME)

Plusieurs Workflow ont été mis en place pour gérer à la fois l'intégration ou la mise à jour de nouvelles procédures d'urbanisme ainsi que la mise à jour de la partie applicative lors d'une nouvelle procédure, d'une mise à jour du cadastre, d'une servitude ou de la prise en compte d'une nouvelle information jugée utile non présente dans les documents d'urbanisme.

Les procédures sont décrites dans le GitUhb privé sur les procédures internes au Service d'Information Géographique de l'Agglomération de la Région de Compiègne.

### Gestion des procédures PLU

L'ensemble des fichiers a utilisé est placé ici `R:\Ressources\4-Partage\3-Procedures\FME\metiers\urb\PLU`.

Une série de traitement a été mis en place pour gérer l'ensemble des cas généré par une procédure de mise à jour des données.

**Intégration d'une procédure nouvellement approuvée** `00_PLU_integration_finale_executoire.fmw`
 
Ce traitement fait appel à des traitements secondaires :
   - `\bloc\01_PLU_Prod_à_Archi_sup_Prod_executoire.fmw` : les données des tables de production `geo_p_` sont intégrées dans les tables d' archives `geo_a_` puis supprimées des tables de production `geo_p_`
   - `\bloc\02_PLU_Test_à_Prod_sup_Test_executoire.fmw` : les données des tables de pré-production `geo_t_` sont intégrées dans les tables de production `geo_p_` puis supprimées des tables de pré-production `geo_t_`
   - `\bloc\05_PLU_Export_Format_CNIG.fmw` : les données sont exportées au format CNIG correspondant ici `Y:\fichiers_ref\metiers\urba\docurba`
   - à la fin du traitement les vues matérialisées applicatives, dans le schéma x_apps, concernées sont mises à jour (xapps_an_vmr_p_information, xapps_an_vmr_p_information_dpu, xapps_an_vmr_p_prescription, xapps_geo_vmr_p_zone_urba, xapps_an_vmr_parcelle_plu)
   
**Récupération d'une procédure annulée** `02_PLU_recuperation_annulation.fmw`

Ce traitement fait appel à des traitements secondaires :
   - `\bloc\03_PLU_Prod_à_Archi_sup_Prod_annulation.fmw` : les données des tables de production `geo_p_` sont intégrées dans les tables d'archives `geo_a_` puis supprimées des tables de production `geo_p_`
   - `\bloc\04_PLU_Archi_à_Prod_sup_Archi_annulation.fmw` : les données des tables d'archives `geo_a_` sont intégrées dans les tables de production `geo_p_` puis supprimées des tables d'archive `geo_a_`
   - à la fin du traitement les vues matérialisées applicatives, dans le schéma x_apps, concernées sont mises à jour (xapps_an_vmr_p_information, xapps_an_vmr_p_information_dpu, xapps_an_vmr_p_prescription, xapps_geo_vmr_p_zone_urba, xapps_an_vmr_parcelle_plu)
   
**Intégration de données reçues par un bureau d'étude** `03_PLU_integration_BE_shape_test.fmw`

Les données reçues d'un bureau d'étude doivent être vérifier au préalable dans QGIS avant intégration dans les données de pré-production `geo_t_` via ce traitement. Une fois la vérification et les corrections réalisées, le traitement d'intégration d'une procédure approuvée peut-être lancé.

**Préparation d'une nouvelle procédure à partir des données des tables production** `geo_p_`(pour les procédures gérées en interne) `011_PLU_Prod_à_Test_pour_modification.fmw`

**Préparation d'une nouvelle procédure à partir des données des tables d'archive** `geo_a_`(pour les procédures gérées en interne) `012_PLU_Archi_à_test_pour_modification.fmw`

### Gestion des procédures d'intégration des SUP et des informations jugées utiles (hors PLU)

L'ensemble des fichiers a utilisé est placé ici `R:\Ressources\4-Partage\3-Procedures\FME\metiers\urb`.

Une série de traitement a été mis en place pour créer des tables de références listant l'ensemble des parcelles avec les SUP (sous répertoire `\SUP`)et les informations jugées utiles (hors PLU) s'y appliquant (sous répertoire `Information_jugées_utiles`). Ces procédures doivent être lancées uniquement lors d'une mise à jour du cadastre, d'une servitude, d'une information ou de l'intégration d'une nouvelle servitude ou informations. Des fiches de procédures ont été réalisées pour tous les cas d'usage. A défaut certains traitements peuvent être lancés indépendemment lors d'une SUP ou d'une information ajoutées entre 2 mises à jour cadastrales. Dans ce cas, il faut s'adresser à l'administrateur SIG.

**Traite l'ensemble des informations jugées utiles non intégrées dans les documents d'urbanisme en terme de données SIG à la parcelle** 
`00_INFOJU_integration_globale.fmw.fmw` : ce workflow utilise 2 sous-workflow, `bloc\01_INFO_JUGEE_UTILE_hors_plu.fmw` pour les informations jugées utiles "classiques" et `bloc\02_TAUX_FISCALITE_GEO.fmw` pour le cas spécifique de la taxe d'aménagement.

**Traite l'ensemble des SUP disponibles à la parcelle** 
`00_SUP_integration_globale.fmw` : ce workflow utilise 3 sous-workflow `bloc\01_SUP_mise_a_jour_liste_commune.fmw` pour mettre à jour à partir du fichier Excel (`R:\Projets\Metiers\1306URB-ARC-numSUP\2-PreEtude\servitude_par_commune_restant_a_integrer.xlsx`) la liste des SUP non intégrées et pouvant affecter une parcelle d'une commune, `bloc\03_SUP_generer_table_AC4_ZPPAUP_protect_GEO.fmw` pour la gestion de la SUP AC4 (AVAP), et `bloc\02_SUP_generer_table_idu_sup_GEO.fmw` pour traiter l'ensemble des SUP présentes dans le schéma `m_urbanisme_reg` et créé une table `an_sup_geo` dans ce même schéma.

Le cas particulier de la SUP A5 gérée au sein de l'Agglomération de la Région de Compiègne par les services concernées, nous a obligé à mettre en oeuvre une gestion particulière pour cette information tout en l'intégrant aux fonctionnels existants. L'inventaire des canalisations des réseaux humides en domaine privé fait ressortir 2 sortes d'informations : une information jugée utile de fait, et dans certains cas des servitudes existantes ou en devenir. Selon ces 2 cas de figures, 2 solutions ont été adoptées :
- **dans le cas d'une information jugée utile** (inexistance d'une SUP) : l'information gérée par les services dans la table `m_reseau_humide.geo_resh_domaineprive` est intégrée à la vue matérialisée `x_apps.xapps_an_vmr_p_information_horsplu` traitant toutes les informations non intégrées aux PLU à la parcelle. Cette vue ainsi que la vue `x_apps.xapps_an_vmr_p_information` (informations intégrées aux PLU à la parcelle) sont rafraichies toutes les nuits à partir du fichier `vmat_igeo.sh` sur la VM SIG-SGBD exécutée en tache CRON,
- **dans le cas d'une servitude** : 2 requêtes ont été intégrées au fichier `vmat_igeo.sh` sur la VM SIG-SGBD exécutée en tache CRON pour mettre à jour uniquement la SUP A5 dans la table `m_urbanisme_reg.an_sup_geo`. Une première requête supprime les enregistrements liés à cette servitude et l'autre intègre les données en croisant les parcelles et la géométrie de la bande de sécurité de la table `m_reseau_humide.geo_resh_domaineprive`. 

Ce fonctionnel permet de disposer des informations liées aux canalisations en domaine privé, gérées par les services, à J+1 dans la fiche de renseignements d'urbanisme, soit aux niveaux des informations jugées utiles ou des servitudes.

La publication de cette SUP A5 au format CNIG, sur le géoportail de l'urbanisme, est réalisée par le service SIG lorsque celui-ci est averti par une notification d'email (via les applictions Web) lorsqu'une SUP est créée. Un Workflow FME a été construit pour gérer manuellement cet export. Une fiche de procédure est en cours de réalisation. La validation sur le géoportail restera toujours le privilège du gestionnaire.

**Export de la SUP AC4 au format CNIG** 

`10_SUP_AC4_Export_CNIG.fmw`

**Export de la SUP A5 au format CNIG** 

`11_SUP_A5_Export_CNIG.fmw`

**Mise à jour complète après une intégration d'un nouveau millésime cadastrale** `00_MAJ_COMPLETE_SUP_INFO_UTILES.fmw`
 
Ce traitement fait appel à des traitements secondaires et intègre une série de requêtes directement exécutée dans la base de données :
   - `\SUP\00_SUP_integration_globale.fmw`
   Ce traitement fait appel à des traitements secondaires :
       - `\bloc\01_SUP_mise_a_jour_liste_commune.fmw` : permet d'intégrer le fichier Excel par commune des SUP restant à intégrer (cette liste s'affiche dans la fiche de renseignement d'urbanisme). Le fichier est ici `R:\Projets\Metiers\1306URB-ARC-numSUP\2-PreEtude\servitude_par_commune_restant_a_integrer.xlsx`
       - `\bloc\02_SUP_generer_table_idu_sup_GEO.fmw` : génère la table `m_urbanisme_reg.an_sup_geo` dans la base de données qui est liée dans GEO listant l'ensemble des parcelles et les SUP concernées. Dans le cas d'une nouvelle SUP, son traitement doit-être intégré dans ce WorkFlow et lancé individuellement.
       - `\bloc\03_SUP_generer_table_AC4_protect_GEO.fmw` : génère la table `m_urbanisme_reg.an_sup_ac4_geo_protect` spécifique à la SUP AC4 (ZPPAUP) directement dans la base de données et liée à GEO
   - `\Information_jugées_utiles\00_INFOJU_integration_globale.fmw` : 
   Ce traitement fait appel à des traitements secondaires et refraichit en fin de processus l'ensemble des vues matérialisées des traitements PLU en base de données :
       - `\bloc\01_INFO_JUGEE_UTILE_hors_plu.fmw` : génère des tables spécifiques aux informations dans la base de données qui sont liées à la vue matérialisée `x_apps.xapps_an_vmr_p_information` . Dans le cas d'une nouvelle information à traiter, elle doit-être intégrée dans ce WorkFlow et lancé individuellement.
       - `\bloc\02_TAUX_FISCALITE_GEO.fmw` : génère la table `m_fiscalite.an_fisc_geo_taxe_amgt` formatant les données de la taxe d'aménagement par commune ou infra-communal dans la base de données et qui est liée dans GEO.

---

## Projet QGIS pour la gestion

Aucun projet QGIS a été réalisé pour la gestion interne des données.
       
## Export Open Data

Les données liées aux documents d'urbanisme font l'objet d'un export automatique au standard CNIG en vigueur dans la procédure d'intégration des données (se référer à cette partie ci plus haut pour plus de précisions). Ces données peuvent être téléchargées via les fiches de métadonnées.







