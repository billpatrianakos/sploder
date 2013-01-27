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
	end
end
