# -*- encoding: utf-8 -*-
require 'json'
require 'cgi'

module Edmodo
  module API
    module Request

      private

      # Method to make a request using either GET or POST
      def request method, uri, query
        raw_response = case method
          when :get
            self.class.get(uri, query: query )
          when :post
            self.class.post(uri, query: query, :query_string_normalizer => Edmodo::API::Normalizer::EDMODO_JSON_NORMALIZER)
          else
            raise EdmodoApiError.new "EdmodoAPI Error: Request Method error."
          end

        check_response_for_errors(raw_response) && JSON.parse(raw_response.body)
      end

      # Helper method to make sure the request returned with 200 status and raised an exception otherwise
      def check_response_for_errors response
        unless (success = response.code == 200)
          raise EdmodoApiError.new "EdmodoAPI Error: Request Error. #{response.body} (status: #{response.code})"
        end

        return success
      end

    end
  end
end