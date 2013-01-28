module Sploder
	class Setup
		def run (key, secret)
			puts "Setup class loaded?"
			file = File.expand_path('.sploder', '~')
			File.open(file, 'w') do |f|
				f.puts "key: #{key}\nsecret: #{secret}"
			end
			puts "Settings saved"
		end

		def check
			file = File.expand_path('.sploder', '~')
			unless File.exist?(file)
				puts "Please run 'sploder --setup' before using Sploder"
				exit 1
			end
		end
	end
end
