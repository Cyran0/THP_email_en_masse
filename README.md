Ultimate_Townhall

L'équipe est composée de 6 moussaillons de la session 6 de The Hacking Project a réalisé ce programme est composée de :
- Shayane Yakataly
- Victor Rattanasmay
- Enes Unal
- Hugo Riviere
- Evan Bourgouin
- Recep Karabulut

Le programme est activé par 2 commandes :
- bundle install
puis rb app.rb

Son but est de promouvoir The Hacking Project auprès des maires de départements français que vous allez choisir.
App.rb administre le programme en faisant appel à toutes les classes du dossier lib, dans cet ordre :
- Index vous demande les départements que vous souhaitez toucher.
- Scrapper crée la base de données provisoire des villes et emails de maires d'un département
- Db_adder ajoute cette base provisoire à la base de données globale (fichier json)
- Gmail_spam envoie un mail à tous les mails selon un template prédéfini
- Twitter_follow suit les comptes Twitter de toutes les municipalités du département et ajouter leur handle Twitter à la base globale
- Done vous donne le bilan du spamming

Le git contient les éléments :
- d'administation (identifiants des API, Gemfile)
- app.rb pour lancer le programme
- db : contenant toutes les bases de données nécessaires à l'exécution du programme
- lib : contenant toutes les classes éxécutées dans le programme (divisé en app et views)

Les gems utilisées sont :
- 

Le handle twitter qui va follow les mairies est : @yakataly1
Les emails sont envoyés par l'adresse : leskebabistesdu11@gmail.com. 
Ils contiennent le texte suivant :
"
Bonjour,
Je m'appelle Henri, je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.

Déjà 500 personnes sont passées par The Hacking Project. Est-ce que la mairie de #{city} veut changer le monde avec nous ?

Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80
"

Le nombre de mairies touchés est reporté par le done.rb en fin d'exécution du programme.