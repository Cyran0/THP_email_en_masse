# poste un tweet

require 'Nokogiri'
require 'xpath'
require 'open-uri'
require 'json'
require 'twitter'
require 'dotenv'


class BotTwitter

def update()

	# ligne très importante qui appelle la gem. Sans elle, le programme ne saura pas appeler Twitter
	

	# Charge le dotenv
	Dotenv.load

	# quelques lignes qui enregistrent les clés d'APIs
	client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = ENV["consumer_key"]
	  config.consumer_secret     = ENV["consumer_secret"]
	  config.access_token        = ENV["access_token"]
	  config.access_token_secret = ENV["access_token_secret"]

end


	  @array_of_screen_name = [] # array sans @
	  array_of_hundle = [] # array avec  @
	  array_of_city_name = []
		file = File.read('test.json')
		city_data = JSON.parse(file)

		# ON VA CHERCHER LES NOM DES VILLE :
	city_data.each do |department|
	  department["cities"].each do |cities_name|
	  	array_of_city_name << cities_name["name"]
	  	
	  end
	end



	#AVEC LES NOM DES VILLE ON CHERCHE LEUR TWITTER :
	array_of_city_name.each do |city|
 		 if client.user_search(city)[0] != nil 

 		 	twitter_handle_0 = client.user_search(city)[0].screen_name
 			@array_of_screen_name << twitter_handle_0 
	 		array_of_hundle << twitter_handle_1 = "@" + "#{twitter_handle_0}"

 		 else
 		 	twitter_handle_0 = ""
 		 	twitter_handle_1 = ""
		 end	

		
	end	

end














def go_to_follow


	client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = ENV["consumer_key"]
	  config.consumer_secret     = ENV["consumer_secret"]
	  config.access_token        = ENV["access_token"]
	  config.access_token_secret = ENV["access_token_secret"]

end



	@array_of_screen_name.each do |x|
    	client.follow(x)
    end

#puts @array

end 

def perform
	update
	go_to_follow
end



end
Test = BotTwitter.new
Test.perform







