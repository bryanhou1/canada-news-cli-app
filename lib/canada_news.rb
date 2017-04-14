require_relative "canada_news/version"

module CanadaNews
  class CLI
  	def play
  		greeting
  		input = nil
      body
      exit_greeting
  	end

  	def greeting
  		puts "Welcome back!"
  		puts "Getting your daily canadian news..."
  		sleep 0.5
  	end

  	def body
      display_trending
      input = article_options
      while input != "exit"
        if input.match(/^([1-9]|10)/)
          display_article(input)
        end
        input = post_article_options
        if input == 'up'
        	input = self.body
        end
      end
      input
    end

  	def display_trending
  		puts <<-DOC
Today's trending news:
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

  	def article_options #returns 1-10 or exit
        puts "Enter 1 - 10 to read more about the news, or 'exit' to quit"
        input = gets.strip
        if !input.match(/^([1-9]|10|exit)$/)
          puts "Option does not exist, please retry. \n\n\n\n"
          input = article_options
        end
      input
  	end
  	
  	def post_article_options
  		puts "Enter 1 - 10 to read another news article, 'up' to go up to see the trending news again or 'exit' to quit"
      input = gets.strip
      if !input.match(/^([1-9]|10|up|exit)$/)
        puts "Option does not exist, please retry. \n\n\n\n"
        input = post_article_options
      end
      input
  	end

  	def display_article(options)
  		puts "Article #{options}"
  		article = Article.all[options.to_i-1]
  		puts article.attributes[:title]
  		puts article.attributes[:author]
  		puts article.attributes[:time_posted]
  		puts article.attributes[:content]
  		puts article.attributes[:url]
  	end

  	def exit_greeting
      puts "Bye."
    end

  end


  class Article
  	attr_accessor :attributes
  	@@all = []

  	def initialize(attributes)
  		@attributes = attributes
  		@@all << self
  	end

  	def self.all
  		@@all
  	end

  	def self.scrape
  		doc = Nokogiri::HTML(open("http://www.cbc.ca/news/trending"))
  		articles = doc.css('.landing-secondary .lineuproll-item-body a')
  		#assign to individual Article
  		articles.each {|article|
  			Article.new({
  				title: article.text,
					url: "http://www.cbc.ca#{article.attribute("href").value}"
					})
  		}
@@con=1
  		Article.all.each{ |article|
  			
  			node = Nokogiri::HTML(open(article.attributes[:url]))
  			binding.pry if @@con = 1
  			# article.attributes[:author] = node.css(".small .spaced").text
  			# article.attributes[:time_posted] = node.css(".delimited").text
  			# article.attributes[:content] = node.css(".story-content").text
  		}
  		# individual_articles = [Nokogiri::HTML(open("http://www.cbc.ca/news/trending"))]
  	end
  end
end