require 'bundler'
Bundler.setup
Bundler.require

require 'yaml'
require 'open-uri'
require 'pp'

require File.join(__dir__, 'lib', 'Hash')


url = 'http://www.nttdocomo.co.jp/support/utilization/product_update/list/index.html?s=date'
doc = Nokogiri::HTML(open url)

trs = Array.new
keys = [:start_date, :model, :approach, :end_date, :other]
doc.xpath('//table').first.xpath('tr').each do |tr|
	trs << Hash[keys.zip tr.text.split("\n")]
end
trs.shift


acquired_index = trs.size

db = Sequel.connect(YAML.load_file(File.join(__dir__, 'config', 'database.yml')).symbolize_keys)
unless db[:product_update].count.zero?
	db_last_data = db[:product_update].order(:id).last
	db_last_data.delete(:id)
	db_last_data.delete(:acquisition_date)

	trs.each_with_index do |tr, index|
		web_data = tr.dup
		web_data[:start_date] = Date.strptime(web_data[:start_date], '%Y年%m月%d日')
		web_data[:end_date] = Date.strptime(web_data[:end_date], '%Y年%m月%d日まで') rescue web_data[:end_date] = nil

		if db_last_data == web_data
			acquired_index = index
			break
		end
	end
end


trs.slice(0, acquired_index).reverse.each do |tr|
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
