require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'

puts "
Il-y-a au moins 3-4 minutes de chargement avant la création du fichier, patience :)"

def get_the_email_of_a_townhal_from_its_webpage(url)
  doc = Nokogiri::HTML(open(url))
  email = doc.css(".tr-last")[3].text.split(" ")[2]
end

def get_all_the_urls_of_townhalls(url)
  doc = Nokogiri::HTML(open(url))
  urls = []
  get_urls = doc.css("a[class=lientxt]")
  get_urls.each{|url| urls.push("http://annuaire-des-mairies.com"+url['href'][1...url['href'].length])}
  urls
end

def mix(departement)
  mairies = []
  getmails = get_all_the_urls_of_townhalls("http://annuaire-des-mairies.com/#{departement}.html")
  getmails.each do |url|
      nom = Nokogiri::HTML(open(url)).css('main h1').text.split(" ")[0]
      mairies.push({:nom => nom, :email => get_the_email_of_a_townhal_from_its_webpage(url), :departement => departement.capitalize})
  end
  return mairies
end

def mix2
  ary = []
  departement = ["yvelines", "gard", "morbihan"]
  departement.each do |url|
      ary << mix(url)
    end
    return ary.join
end

def json
  File.open("temp.json","w") do |f|
    f.write(JSON.pretty_generate(mix2))
  end
end

json