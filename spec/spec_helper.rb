# -*- encoding: utf-8 -*-

$: << File.join(File.dirname(__FILE__), "/../lib")
require 'edmodo-api'
require 'fakeweb'

FakeWeb.allow_net_connect = false