module Edmodo
	module API
		module Config

			class << self
				attr_accessor :endpoint
				attr_accessor :version
			end

			self.version = "v1"
			self.endpoint = {
				:production => "https://appsapi.edmodo.com/#{version}/",
				:sandbox => "https://appsapi.edmodobox.com/#{version}/"
			}
		end
	end
end