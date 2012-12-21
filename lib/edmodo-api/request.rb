# -*- encoding: utf-8 -*-
require 'json'
require 'cgi'

module Edmodo
  module API
    module Request

      def post uri, query
        raw_response = self.class.post(uri, query: query )

        check_response_for_errors(raw_response) && JSON.parse(raw_response.body)
      end

      def get uri, query
        raw_response = self.class.get(uri, query: query)

        check_response_for_errors(raw_response) && JSON.parse(raw_response.body)
      end

      def check_response_for_errors response
        unless (success = response.code == 200)
          raise EdmodoApiError "EdmodoAPI Error: Request Error. #{response.body} (code: #{response.code})"
        end

        return success
      end

    end
  end
end