# ACME-Application-SpringBoot 0.8.4.2 (WIP)

Une interface web vous permettant de gérer les commandes et les stocks de l'entreprise.

# Pour démarrer l'application:

#### L'application utilise les technologies suivantes:

##### JAVA 17+

##### Maven (requis si vous souhaitez compiler les sources)
     curl https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.zip
     -> décompresser l'archive à l'emplacement de votre choix
     Ajouter l'emplacement apache-maven-3.8.6/bin à la variable d'environnement %PATH% (windows)

##### Certificat SSL. Initialiser avec:
        keytool -genkeypair -alias jetty -keyalg RSA -keysize 4096 -validity 365 -dname "CN=localhost" -keypass acme12 -keystore jetty.p12 -storeType PKCS12  -storepass acme12

##### BDD SQL. Initialiser avec:
        NET START wampmysqld64
        mysqld --host=localhost --port=3306 --user=root --password=password --database=acme < conf/sql/acme.sql

    ATTENTION !! il faudra créer un utilisteur dans phpmyadmin
    "acme/acme" ayant les droits d'accès à la BDD acme.

        CREATE USER 'acme'@'%' IDENTIFIED WITH mysql_native_password BY 'acme';
        GRANT USAGE ON *.* TO 'acme'@'%';
        ALTER USER 'acme'@'%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;
        GRANT ALL PRIVILEGES ON `acme`.* TO 'acme'@'%';

**OU** importer manuellement la banque de données grâce au fichier sql conf/sql/acme.sql \
Le schéma et le workbench de la BDD sont disponnible dans conf/sql/ \
N'oubliez pas de créer un compte acme/acme ayant les droits sur la banque de données acme 

***^^^^^^^^L'étape précédente est obligatoire pour le bon fonctionnement du programme.^^^^^^^^***

### Executer le programme
**2 solutions** s'offrent à vous: \
 1/ RUN-ME.bat, qui génèrera le fichier .jar à partir des sources en utilisant **Maven** \
 2/ java -jar acme-demo.jar (fichier **pré-compilé** pour démonstrations)
 


## (Super)Admin:
username: user@email.com 
password: user

    [x] Possède tous les droits. (uniquement pour les demo)
    [x] peut ajouter un article
    [x] peut enlever / modifier un article
    [x] memes droits que moderateurs 
    [x] peut ajouter / supprimer un moderateur
    [x] peut modifier un utilisateur (sauf l'admin)
    [ ] lister les logs SQL (avec mise en page)

## Utilisateur :

    [x] peut ajouter / enlever des articles d'un panier utilisateur
    [x] peut commander son panier
    [x] peut visualiser ses commandes
    [x] peut visualiser les détails d'une commande
    [x] peut voir ses propres commandes
    [ ]  peut visualiser le status de la commande
    [ ]  peut visualiser les stocks des entrepôts
    [ ]  invalider/changer le status d'une commande
    [ ]  a une info-bulle pour ses choix d'articles
    [x]  barre de recherche

## Moderateur

    [x] visualiser les commandes d'un utilisateur
    [x] modifier les Details d'un utilisateur
    [ ]  meilleurs vendeur
    [ ]  article +/- populaire
