require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib/app", __FILE__)
$:.unshift File.expand_path("./../lib/views", __FILE__)

require 'index'
require 'email_scrapper'
require 'townhalls_adder_to_db'
require 'townhalls_mailer'
require 'twitter_bot'
require 'done'

class MassSpam

	attr_accessor :spam_report, :mail_errors, :mail_sent, :twitter_ok, :twitter_errors
	
	def initialize
		@spam_report = []
		perform
	end

	def perform
		
		#Demande des 3 départements à spammer
		spam_request = Index.new
		spam_request.perform
		department_to_spam = spam_request.formatted_departments

		#Puis pour chaque département
		department_to_spam.each_with_index { |department, i|

			#Scrapping json pour chaque département
			scrapping = Scrapper.new(department)
			scrapping.perform

			#Création du json par département
			Db_adder.new(scrapping.result_hash)

			#Envoi des emails
			mailing = Email.new(department)
			mailing.perform

			#Suivi Twitter et update des pseudos Twitter dans le json
			twitter = TwitterBot.new(department)
			twitter.perform

			#Ajout du hash lié au département au array de rapport final
			spam_report << {
				"department" => spam_request.chosen_departments[i],
				"mail_errors" => mailing.mail_errors,
				"mail_ok" => mailing.mail_ok,
				"twitter_errors" => twitter.twitter_errors,
				"twitter_ok" => twitter.twitter_ok
			}
		}
		Report.new(spam_report).perform
	end
end