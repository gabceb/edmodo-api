# -*- encoding: utf-8 -*-

require 'timeout'

module Edmodo
  module API
    class Client
      
      include Edmodo::API::Config

      MODES = [
        "sandbox", "production"
      ]

      attr_reader :api_key
      attr_reader :mode

      # Initializes a new instance of the Edmodo API client
      # Options:
      #
      # => mode: Sets the mode to production or sandbox
      #
      def initialize(api_key, options = {})
        options = defaults.merge(options)

        @mode = options[:mode]
        @api_key = api_key

        raise ArgumentError, "Mode not available on Edmodo API" unless MODES.include? @mode.to_s

      end

      private

      def defaults
        {
          :mode => :sandbox
        }
      end

    end
  end
end