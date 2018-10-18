require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'

puts "Il-y-a entre 2 et 4 minutes de chargement avant la création du fichier, patience :)"

class Scrapper
  attr_accessor :department, :email_array, :city_urls

  def initialize(department)
    @department = department
    @email_array = []
    @city_urls = []
  end

  def get_the_email_of_a_townhall_from_its_webpage(city_url)
    doc = Nokogiri::HTML(open(city_url))
    return doc.css(".tr-last")[3].text.split(" ")[2]
  end

  def get_all_the_urls_of_townhalls
    begin
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{@department}.html"))
    get_urls = doc.css("a[class=lientxt]")
    get_urls.each{ |url| 
     @city_urls << "http://annuaire-des-mairies.com"+url['href'][1...url['href'].length] #Retrait du premier caractère du href pour obtenir l'url
      }    
      rescue OpenURI::HTTPError => e
    end
  end

  def perform
   get_all_the_urls_of_townhalls
   @city_urls.each do |city_url|
     nom = Nokogiri::HTML(open(city_url)).css('main h1').text.split(" ")[0]
     @email_array << {
       :nom => nom.capitalize, 
       :email => get_the_email_of_a_townhall_from_its_webpage(city_url), 
       :departement => @department.capitalize
       }
    end
  end
end

#departement_test = Scrapper.new("paris")
#departement_test.perform
#puts departement_test.email_array