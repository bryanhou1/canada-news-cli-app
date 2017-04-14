require_relative "canada_news/version"

module CanadaNews
  class CLI
  	def play
  		greeting
  		Article.scrape
  		input = nil
      body
      exit_greeting
  	end

  	def greeting
  		puts "Welcome back!"
  		puts "Getting your daily canadian news..."
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
  		puts "\n\n"+"Today's trending news:".bold.white.on.black

  		for i in 1..10
  			msg = "#{i}. #{Article.all[i-1].attributes[:title]}"
  			puts i.odd? ? msg.magenta : msg.blue
  		end

  	end

  	def article_options
        print "Enter 1 - 10 to read more about the news, or 'exit' to quit: "
        input = gets.strip
        if !input.match(/^([1-9]|10|exit)$/)
          puts "Option does not exist, please retry. \n\n".red.bold
          input = article_options
        end
      input
  	end
  	
  	def post_article_options
  		print "Enter 1 - 10 to read another news article, 'up' to go up to see the trending news again or 'exit' to quit: "
      input = gets.strip
      if !input.match(/^([1-9]|10|up|exit)$/)
        puts "Option does not exist, please retry. \n\n".red.bold
        input = post_article_options
      end
      input
  	end

  	def display_article(options)
  		puts "Article #{options}".bold.black
  		article = Article.all[options.to_i-1]
  		puts article.attributes[:title].bold.red
  		puts article.attributes[:author].bold
  		puts article.attributes[:time_posted].bold
  		puts article.attributes[:content].strip + "\n\n"
  		puts "[#{article.attributes[:url].bold}]" + "\n\n"
  	end

  	def exit_greeting
      puts "Bye."
    end
  end


  class Article
  	attr_reader :attributes
  	@@all = []

  	def initialize(attributes)
  		@attributes = attributes
  		@@all << self
  	end

  	def self.all
  		@@all
  	end

  	def self.scrape #scrape can be an individual class
  		doc = Nokogiri::HTML(open("http://www.cbc.ca/news/trending"))
  		articles = doc.css('.landing-secondary .lineuproll-item-body a')
  		articles.each {|article|
  			Article.new({
  				title: article.text,
					url: "http://www.cbc.ca#{article.attribute("href").value}"
					})
  		}

  		Article.all.each{ |article| #can seperate this to a different metho
  			node = Nokogiri::HTML(open(article.attributes[:url]))
  			article.attributes[:author] = node.css(".small .spaced").text
  			article.attributes[:time_posted] = node.css(".delimited").text
  			article.attributes[:content] = node.css(".story-content p").collect {|p|
  				"\n\n  " + p.text.strip if p.text.strip != ""
  			}.join
  		}
  	end
  end
end