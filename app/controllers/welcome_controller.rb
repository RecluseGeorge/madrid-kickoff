require 'nokogiri'
require 'open-uri'
class WelcomeController < ApplicationController

	before_filter :fetch_data, :only => [:index]
	def index
	end
	private

	def fetch_data
		response = Nokogiri::HTML(open("http://www.realmadrid.com/en/football/schedule"))
		@opponent = response.at_css('.m_highlighted_next_game_team.m_highlighted_next_game_second_team').children[-2].text
		if @opponent = "Real Madrid"
			print "yes"
			@oppponent = response.at_css('.m_highlighted_next_game_team').children[-2].text
		end
        time =  response.css('.m_highlighted_next_game_info_wrapper').children[3].children.text
        date = response.css('.m_highlighted_next_game_header')[0].children[3].children[5].children.first.text
        @location = response.css('.m_highlighted_next_game_location').text
        @year,@month,@day = date.split("/")
        @month = @month.to_i - 1
        @hour,@minute = time.split(":")
        @minute = @minute.gsub("H.","")
	end
end
