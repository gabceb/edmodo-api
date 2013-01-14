module Edmodo
	module API
		module Normalizer
			EDMODO_JSON_NORMALIZER = Proc.new { |query|
					query.map do |key, v|
						value = String.new

						if v.is_a?(Array)
							value = URI.encode(v.to_json, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
						else
							value = URI.encode(v.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
						end

						"#{key}=#{value}"
					end.join('&')
				}
		end
	end
end

