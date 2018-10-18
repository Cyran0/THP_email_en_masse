require 'json'
require_relative 'email_scrapper.rb' #appel du fichier sous-jacent du répertoire

class Db_adder #création de la classe permettant d'exporter les données dans un fichier JSON

    def initialize(mail_db) #création de la méthode appelée par .new
        File.open("departement.json","w") do |f| #création d'un fichier JSON
            f.write(JSON.pretty_generate(mail_db)) #affichage en PP
        end
    end
end


departement_test = Scrapper.new("paris") #execution de la classe scrapper et appel de la fonction permettant de définir les variables d'instances contenues dans le script email_scrapper.rb
departement_test.perform #execution de la méthode permettant de consolider toutes les adresses mail, noms et départements

Db_adder.new(departement_test.email_array) #execution de la classe db_adder et génération du fichier JSON sur la base de l'array de hash créé précedemment