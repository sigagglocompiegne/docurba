![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Prescriptions spécifiques (locales) pour le suivi des documents d'urbanisme (Carte communale,PLU, PLUi)

Ensemble des éléments constituant la mise en oeuvre de la base de données des documents d'urbanisme et l'exploitation des données pour les différentes applications (ces applications sont détaillées dans d'autres projets GitHub) :.

- Script d'initialisation de la base de données
  * [Script d'initialisation de la base de données métier postgis au format cnig2017d](bdd/init_bd_docurba.sql)
  * [Script de migration des données cnig2014>cnig2017 avec conservation des champs optionnels cnig2014](bdd/mig_bd_docurba.sql)
- [Documentation d'administration de la base](bdd/doc_admin_bd_docurba.md)
- [Documentation d'administration de l'application](app/doc_admin_app_docurba.md)
- [Ressources pour la sémiologie graphique](sld/)

## Contexte

L’ARC est engagée dans un plan de modernisation numérique pour l’exercice de ses missions de services publics. L’objectif poursuivi vise à permettre à la collectivité de se doter d’outil d’aide à la décision et d’optimiser l’organisation de ses services. Ces objectifs se déclinent avec la mise en place d’outils informatiques adaptés au quotidien des services et le nécessaire retour auprès de la collectivité, des informations (données) produites et gérées par ses prestataires. 

L’ARC privilégie donc une organisation dans laquelle l’Interface Homme Machine (IHM) du métier assure l’alimentation d’un entrepôt de données territoriales. Cette stratégie « agile » permet de répondre au plus près des besoins des services dans une trajectoire soutenable assurant à la fois une bonne maitrise des flux d’information et un temps d’acculturation au sein de l’organisation.

## Voir aussi

* [Lire la documentation du standard national CNIG](http://cnig.gouv.fr/?page_id=2732)
* [Sous-groupe SG5 Symbolisation pour les PLU et les PSMV du GT CNIG DDU](https://github.com/GT-CNIG-DDU-team/SG5-SYMBOLISATION)
* [Ressources sur les données AVAP](https://github.com/sigagglocompiegne/avap)

## Jeu de données consolidé

Vous pouvez retrouver un jeu de données à l'échelle du Pays Compiégnois au standard CNIG sur le catalogue GéoCompiégnois en cliquant [ici](https://geo.compiegnois.fr/geonetwork/srv/fre/catalog.search#/metadata/0822db32-0122-41ee-b6fd-a6934c386288).
