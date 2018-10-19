require 'json'
require 'twitter'
require 'dotenv'


class TwitterBot

    attr_accessor :cities, :department, :client, :twitter_errors, :twitter_ok

    def initialize(department)
        @cities = []
        @department = department
        @twitter_errors = 0
        @twitter_ok = 0
    end

    #Authentification sur le compte twitter de @yakataly1 grave au .env
    def twitter_authentification
        Dotenv.load
        @client = Twitter::REST::Client.new do |config|
            config.consumer_key        = ENV["consumer_key"]
            config.consumer_secret     = ENV["consumer_secret"]
            config.access_token        = ENV["access_token"]
            config.access_token_secret = ENV["access_token_secret"]
        end
    end

    #Ouverture du json et parsing
    def json_parsing 
        file = File.read("./db/departments/#{department}.json")  #../../db/#{@departement}.json')
        city_data = JSON.parse(file)
        #Extract d'un array de hash contenant les informations à propos de chaque commune
        @cities = city_data["cities"]
    end

    #Création du handle twitter à partir du résultat de recherche et suivi sur Twitter
    def twitter_handle(search_result)
        twitter_handle = search_result.screen_name
        @client.follow(twitter_handle)
        return "@"+twitter_handle
   end

    #Détection des pseudos Twitter des villes et modification du json
    def json_update
        @cities.each do |city_hash|
            #Résultat de la recherche des users Twitter contenant le nom de la ville
            search_result = @client.user_search(city_hash["name"])[0]
             if search_result != nil
                city_hash["twitter"] = twitter_handle(search_result)
                @twitter_ok += 1
            else #Gestion du cas où la recherche twitter ne renvoie aucun user
                city_hash["twitter"] = ""
                @twitter_errors += 1
            end
        end


        #Reformation du fichier final de scrapping
        final_scrapp = {
            "department" => "#{@department}",
            "cities" => @cities
        }

        #Enregistrement dans le json
        File.open("./db/departments/#{department}.json","w") do |f|
            f.write(JSON.pretty_generate(final_scrapp))
        end
        file 
    end


    def perform
        twitter_authentification
        json_parsing
        json_update
    end
end