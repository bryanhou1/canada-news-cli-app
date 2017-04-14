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
  		puts Articles[options].title
  		puts Articles[options].time_written
  		puts Articles[options].content
  		puts Articles[options].url
  	end

  	def exit_greeting
      puts "Bye."
    end

  	def scrapping
  	end
  end

  class Articles

  	attr_accessor :title, :time_written, :content, :url #not sure if url will be used

  end
end