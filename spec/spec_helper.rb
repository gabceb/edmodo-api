# -*- encoding: utf-8 -*-

$: << File.join(File.dirname(__FILE__), "/../lib")
require 'edmodo-api'
require 'fakeweb'
require 'uri'

@api_key = "1234567890abcdefghijklmn"
@invalid_api_key = "invalid_key"

FakeWeb.allow_net_connect = false

require 'requests/get_requests'
require 'requests/post_requests'
