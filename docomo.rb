require 'bundler'
Bundler.setup
Bundler.require

require 'open-uri'
require 'pp'


url = 'http://www.nttdocomo.co.jp/support/utilization/product_update/list/index.html?s=date'
doc = Nokogiri::HTML(open url)
