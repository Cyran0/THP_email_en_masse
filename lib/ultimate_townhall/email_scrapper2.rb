require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_the_email_of_a_townhal_from_its_webpage(url)
  doc = Nokogiri::HTML(open(url))
  email = doc.css(".tr-last")[3].text.split(" ")[2]
end

def get_all_the_urls_of_val_doise_townhalls(url)
  doc = Nokogiri::HTML(open(url))
  urls = []
  get_urls = doc.css("a[class=lientxt]")
  get_urls.each{|url| urls.push("http://annuaire-des-mairies.com"+url['href'][1...url['href'].length])}
  urls
end

def mix(departement)
  mairies = []
  getmails = get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/#{departement}.html")
  getmails.each do |url|
      nom = Nokogiri::HTML(open(url)).css('main h1').text.split(" ")[0]
      mairies.push({:nom => nom, :email => get_the_email_of_a_townhal_from_its_webpage(url), :departement => departement})
      puts mairies
  end
end

def mix2
    departement = ["yvelines", "gard", "morbihan"]
    departement.each do |url|
        mix(url)
    end
end
puts mix2