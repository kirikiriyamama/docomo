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

trs = Array.new
keys = [:start_date, :model, :approach, :end_date, :other]
doc.xpath('//table').first.xpath('tr').each do |tr|
	trs << Hash[keys.zip tr.text.split("\n")]
end
trs.shift

trs.reverse.each do |tr|
	start_date = Date.strptime(tr[:start_date], '%Y年%m月%d日').strftime('%Y-%m-%d')
	end_date = Date.strptime(tr[:end_date], '%Y年%m月%d日まで').strftime('%Y-%m-%d') rescue end_date = 0

	db[:product_update] << {
		:start_date => start_date,
		:model => tr[:model],
		:approach => tr[:approach],
		:end_date => end_date,
		:other => tr[:other],
		:acquisition_date => Time.now.strftime('%Y-%m-%d %H:%M:%S')}
end
