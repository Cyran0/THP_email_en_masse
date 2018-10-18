require 'json'
require_relative 'email_scrapper.rb' #appel du fichier sous-jacent du répertoire

class Db_adder #création de la classe permettant d'exporter les données dans un fichier JSON

    def initialize(mail_db) #création de la méthode appelée par .new

        File.open("./db/departments/#{mail_db["department"]}.json","w") do |f| #création d'un fichier JSON
            f.write(JSON.pretty_generate(mail_db)) #affichage en PP
        end

#		File.write("./db/departments/#{departement}.json",mail_db.to_json)

    end
end