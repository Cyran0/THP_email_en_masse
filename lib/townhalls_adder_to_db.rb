require 'json'
require_relative 'email_scrapper.rb'

class Db_adder

    def initialize(mail_db)
        File.open("departement.json","w") do |f|
            f.write(JSON.pretty_generate(mail_db))
        end
    end
end


departement_test = Scrapper.new("paris")
departement_test.perform

Db_adder.new(departement_test.email_array)
    #
=begin
    def csv
        CSV.open("myfile.csv", "w") do |csv|
            csv << ["nom", "email", "departement"]
            csv << [:nom, :email]
        end
    end
=end