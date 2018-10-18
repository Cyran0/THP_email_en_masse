class Report

	attr_accessor :spam_report
	
	def initialize(spam_report)
		@spam_report = spam_report
	end

	#Enoncé du rapport d'activité
	def perform
		puts "Le programme s'est achevé comme prévu."
		puts "Les maires des communes des départements suivants ont été visés par le spam THP."
		puts "Voici le rapport :"
		@spam_report.each { |city_report|
			puts "Dans le département #{city_report["department"]} :"
			puts "-#{city_report["mail_ok"]} maires touchés par mail, #{city_report["mail_errors"]} non touchés"
			puts "-#{city_report["twitter_ok"]} mairies suivies sur Twitter, #{city_report["twitter_errors"]} non retrouvées"
		}
	end
end
