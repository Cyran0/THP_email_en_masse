require 'json'
require_relative 'email_scrapper.rb'

class Db_adder

    attr_accessor mail_db

    def initialize(mail_db)
        @mail_db = mail_db
    end

    def json
        File.open("../db/departement.json","w") do |f|
            f.write(JSON.pretty_generate(@mail_db))
        end
    end
    
    def csv
        CSV.open("myfile.csv", "w") do |csv|
            csv << ["nom", "email", "departement"]
            csv << [:nom, :email]
        end
    end
    
end