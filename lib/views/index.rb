require 'colorize'
require 'json'
require 'rubygems'

class Index

	attr_accessor :chosen_departments, :formatted_departments, :department

	def initialize
		@chosen_departments = []
		@formatted_departments = []
	end

#demande du département à scrapper
	def launch
		puts "Salut, aujourd'hui on va faire du sale.".bold.red.on_white
		puts "Dans quelques instants, vous allez lancer une campagne de mailing pour promouvoir THP dans les campagnes hexagonales."
		puts "Et puisqu'un mail ne suffit pas, vous allez aussi gazouiller à l'oreille des maires de France."
	end

	def department_choices
		puts "Pour commencer, tu vas choisir les trois départements qui seront la cible de la promo THP."
		while @formatted_departments.size < 1
			print "Choisis un département en tapant son nom ou numéro : > "
			number = gets.chomp
			number_to_name_conversion(number)
		end
	end

	def number_to_name_conversion(number)
		json = File.read('./db/department_list.json')
		list = JSON.parse(json)
		@chosen_departments << list[number]["departement"]
		@formatted_departments << list[number]["formatted"]
	end

	def perform
		launch
		department_choices
		puts "Parfait, nous allons promouvoir thp auprès des maires de toutes les communes des départements suivants :"
		puts @chosen_departments
	end
end
