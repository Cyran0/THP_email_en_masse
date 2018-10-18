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
		@mail_errors = []
		@mail_sent = []
		@twitter_errors = []
		@twitter_ok = []
		@spam_report = [@mail_errors, @mail_sent, @twitter_errors, @twitter_ok]
		perform
	end

	def perform
		
		#Demande des départements à spammer
		spam_request = Index.new.perform
		department_to_spam = spam_request.department

		department_to_spam.each { |department|

			path = "db/#{department}.json"

			#Scrapping json pour chaque département
			scrapping = Scrapper.new(department)
			scrapping.perform

			#Création du  parjson département
			Db_adder.new(scrapping.emails_hash)

			#Envoi des emails
			mailing = Email.new(department)
			mail_errors << mailing.count_errors
			mail_sent << mailing.count_mails

			#Suivi Twitter et update des pseudos Twitter
			twitter = Email.new(department)
			twitter_errors << twitter.twitter_errors
			twitter_ok << mailing.twitter_ok
		}
		Report.new.perform(department_to_spam, spam_report)
	end
end

MassSpam.new.perform