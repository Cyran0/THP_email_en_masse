require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'

puts "Il-y-a entre 2 et 4 minutes de chargement avant la création du fichier, patience :)"

class Scrapper #création de la classe scrapper pour récupérer les adresses mails
  attr_accessor :department, :email_array, :city_urls  #création des variables d'instances

  def initialize(department) #création de la méthode appelée par .new pour définir les variables d'instances utilisées dans la classe
    @department = department
    @email_array = []
    @city_urls = []
  end

  def get_the_email_of_a_townhall_from_its_webpage(city_url) #méthode permettant scrapper l'adresse mail d'une page donnée (variabilisée en city_url)
    doc = Nokogiri::HTML(open(city_url))
    return doc.css(".tr-last")[3].text.split(" ")[2]
  end

  def get_all_the_urls_of_townhalls #création de la méthode permettant de créer toutes les adresses urls d'un département donné
    begin  #initialisation de la méthode rescue pour éviter l'erreur 404
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{@department}.html"))
    get_urls = doc.css("a[class=lientxt]")
    get_urls.each{ |url| 
     @city_urls << "http://annuaire-des-mairies.com"+url['href'][1...url['href'].length] #Retrait du premier caractère du href pour obtenir l'url
      }    
      rescue OpenURI::HTTPError => e #Permet d'éviter l'erreur 404 et de repartir dans la boucle
    end
  end

  def perform #création de la méthode permettant de consolider les autres et de lister toutes les adresses mails, noms et départements d'un département donné
   get_all_the_urls_of_townhalls 
   @city_urls.each do |city_url| 
     nom = Nokogiri::HTML(open(city_url)).css('main h1').text.split(" ")[0]
     @email_array << { #création d'un array de hash comprenant les couples key/value demandés en exercice
       :nom => nom.capitalize, 
       :email => get_the_email_of_a_townhall_from_its_webpage(city_url), 
       :departement => @department.capitalize
       }
    end
  end
end