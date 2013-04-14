class Sentence
	def initialize(name,content)
		@name = name
		@content = content
	end

	def name()
		@name
	end
	def content()
		@content
	end
end

class SentencePersistance
	def add(sentence)

		file_name = sentence.name() + ".txt"
		File.open(file_name,"w+") do |file|
			file.write(sentence.content())
		end
	end
	def to_s
		"<an instance of SentencePersistance>"
	end
end

class SentenceUi
	def initialize(sentence_store,io)
		@store = sentence_store
		@io = io
	end

	def main_menu()
		@io.puts("Welcome to sentence store v1")
		@io.puts("Do you want to (s) store a sentence or (r) retrieve a sentence?:")

		answer = gets().chomp().downcase()

		if answer == "s"

			puts("Name of sentence")
			sentence_name = gets().chomp() + ".txt"

			puts("Content of sentence")
			sentence_content = gets().chomp()

			sentence = Sentence.new(sentence_name,sentence_content)

			@store.add(sentence)

			puts("Sentence #{sentence.name()} has been stored!")

		elsif answer == "r"
		
			puts("sentence name")
			sentence_name = gets().chomp()

			unless Sentence.retrieve?(sentence_name)
			abort("Sentence '#{sentence_name}' does not exsist, sorry") 
		end
			puts("Your sentence is #sentence_name{sentence_content}")

		elsif answer == "l"
			
			Dir.foreach(".") {|x| puts "Got #{sentence_name}" }

# or tell user if there are none 

		else
			@io.puts("Sorry I don't know!")
		end
	end
end

def main(io)

	sentence_ui = SentenceUi.new(
		SentencePersistance.new(),
		io
	)
	sentence_ui.main_menu()
end

main(STDOUT)