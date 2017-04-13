require_relative "canada_news/version"

module CanadaNews
  class CLI
  	def play
  		greeting

  		#implement loop that can be exited with user input and enter previous level
  		display_trending
  		options
  		display_article
  	end

  	def greeting
  
  	end

  	def display_trending
  		puts <<-DOC
1.
2.
3.
4.
5.
6.
7.
8.
9.
10.
DOC
  	end

  	def options
  		input = gets.strip
  		#use input to scrap from article website

  	end
  	

  	def display_article
  		puts "article place holder"
  	end


  	def scrapping
  	end
  end
end