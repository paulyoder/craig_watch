require 'nokogiri'
require 'open-uri'

BASE_URL = 'http://omaha.craigslist.org'
search_url = "#{BASE_URL}/search/rva?query=pop+up"

class Result
  attr_accessor :id, :url, :date, :title
  def initialize(element)
    @id    = element['data-pid']
    @url   = element.css('span.pl a').first['href']
    @url   = "#{BASE_URL}#{@url}" if @url[0] == '/'
    @date  = Date.strptime element.css('span.date').text, '%b %d'
    @title = element.css('span.pl a').first.text
    #todo
    #description
    #images
  end
end

doc = Nokogiri::HTML open(search_url)
results = doc.css('p[data-pid]').map {|node| Result.new(node) }

results[0..5].each {|x| p x }.length
