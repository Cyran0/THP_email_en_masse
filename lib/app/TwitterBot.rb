require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'resolv-replace'
require 'xpath'



class Getmail

def get_the_email_of_a_townhal_from_its_webpage
page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/95/vaureal.html'))

cloud_elements = page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")

array = []
cloud_elements.each do |cloud_element|
	

	array << cloud_element.text

	File.open("db/email.json","w") do |f|
  	f.write(array.to_json)
end
	

end
end 


end
tata = Getmail.new

tata.get_the_email_of_a_townhal_from_its_webpage



#get_the_email_of_a_townhal_from_its_webpage




def get_all_the_urls_of_val_doise_townhalls

page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))


cloud_elements = page.xpath("//p/a/@href")



array =[]

cloud_elements.each do |cloud_element|

	


	array << "http://annuaire-des-mairies.com#{cloud_element}" 
	puts array

end
end

#get_all_the_urls_of_val_doise_townhalls



