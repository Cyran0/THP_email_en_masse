require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'

class Scrapper

  attr_accessor :department, :city_urls, :result_hash

  def initialize(department)
    @department = department
    @city_urls = []
    @result_hash = {"department" => @department, "cities" => []}
  end

  #Scrapping de l'adresse mail d'une mairie à partir d'une page donnée
  def get_the_email_of_a_townhall_from_its_webpage(city_url) 
    city_page = Nokogiri::HTML(open(city_url))
    return city_page.css(".tr-last")[3].text.split(" ")[2]
  end

  #Scrapping des urls de pages de villes à partir pour un département donné
  def get_all_the_urls_of_townhalls 
    
    begin  #Initialisation du rescue en cas d'erreur 404
    
    #Scrapping de la classe contenant le lien
    department_page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{@department}.html"))
    scrapped_links = department_page.css("a[class=lientxt]")
    
    scrapped_links.each{ |url|
      @city_urls << "http://annuaire-des-mairies.com"+url['href'][1...url['href'].length] #Retrait du premier caractère du href pour obtenir l'url
    }
      rescue OpenURI::HTTPError => e #Permet d'éviter l'erreur 404 et de repartir dans la boucle
    end
  end

  #Consolidation de toutes les adresses mails des mairies du département dans result_hash
  def perform 
    get_all_the_urls_of_townhalls 
    @city_urls.each do {|city_url| 
      city_hash = { #création d'un array de hash comprenant les couples key/value demandés en exercice
        :name => city_page.css('main h1').text.split(" ")[0].capitalize, #Scrapping du nom et capitalize
        :email => get_the_email_of_a_townhall_from_its_webpage(city_url)
      }
      result_hash[cities] << city_hash
    end
  end


end