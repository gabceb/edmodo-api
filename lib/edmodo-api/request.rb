# -*- encoding: utf-8 -*-

require 'open-uri'

module Edmodo
  module API
    class Request

      def post uri
        uri = URI(uri)
        req = Net::HTTP::Post.new(uri.path)
        
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req)
        end
        
        res.body.to_s
      end

      def get uri
        uri = URI(uri)
        req = Net::HTTP::Get.new(uri.path)
        
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req)
        end
        
        res.body.to_s
      end

    end
  end
end