require 'rubygems'
require 'nokogiri'
require 'open-uri'
#
=begin
module UltimateTownhall

  class Departement
    attr_accessor :departement, :code_postal

    def initialize(departement)
    end

  end

  class Commune
      attr_accessor :commune

    def initialize(commune)
    end
  end

  class Email
    attr_accessor :mail
=end
  def perform
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/yvelines.html"))
	  doc.xpath('//tr/td[1]/p/a').each do |node|
	  puts node.text
  end
  puts perform
  #end

 # end
end
