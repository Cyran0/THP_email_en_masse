require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'gmail'
require 'dotenv'
require 'json'

Dotenv.load('../.env')

#=======================================================================================================================

@cities = Array.new

@email = Array.new 
@name = Array.new


json = File.read('../db/townhalls.json')
doc = JSON.parse(json)


doc.each do |list|
  @cities << list["cities"]
end


i = 0
@cities.each do
  j = 0
  @cities[i].each do
    @name << @cities[i][j]["name"]
    @email << @cities[i][j]["email"]
  j += 1
  end
  i += 1
end

#=======================================================================================================================

k = 0

while k < @email.size

  mail = @email[k]
  city = @name[k]

  gmail = Gmail.connect(ENV["email"],ENV["mdp"])

  gmail.deliver do
    to mail
    subject "BG du 54"
    text_part do
      content_type 'text; charset=UTF-8'
      body "Bonjour,
Je m'appelle Henri, je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.

Déjà 500 personnes sont passées par The Hacking Project. Est-ce que la mairie de #{city} veut changer le monde avec nous ?


Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80"
  end

  end
  k += 1
end
