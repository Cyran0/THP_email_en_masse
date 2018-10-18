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


