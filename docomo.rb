require 'bundler'
Bundler.setup
Bundler.require

require 'yaml'
require 'open-uri'
require 'pp'

require File.join(__dir__, 'lib', 'Hash')


db = Sequel.connect(YAML.load_file(File.join(__dir__, 'config', 'database.yml')).symbolize_keys)

url = 'http://www.nttdocomo.co.jp/support/utilization/product_update/list/index.html?s=date'
doc = Nokogiri::HTML(open url)
doc.xpath('//table').first.xpath('tr').each do |tr|
	pp tr.text.split("\n")
end
