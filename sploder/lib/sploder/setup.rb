require 'yaml'

module Sploder
	class Setup
		def run (key, secret)
			file = File.expand_path('.sploder', '~')
			File.open(file, 'w') do |f|
				f.puts "key: #{key}\nsecret: #{secret}"
			end
			puts "Settings saved"
		end

		def load_settings
			settings_file = File.expand_path('.sploder', '~')
			settings = YAML.load_file(settings_file)
			return settings
		end

		def settings_exist
			file = File.expand_path('.sploder', '~')
			unless File.exist?(file)
				puts "Please run 'sploder --setup' before using Sploder"
				exit 1
			end
			return true
		end
	end
end
