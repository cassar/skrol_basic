require 'net/http'
require 'uri'
require 'json'

class WordSender
  def initialize(language_name, source, words)
    @hash = { language: language_name, source: source, words: words }
  end

  def send
    uri = URI.parse('http://localhost:3000')
    http = Net::HTTP.new(uri.host, uri.port)
    header = { 'Content-Type' => 'application/json' }
    http.post('/words', @hash.to_json, header)
  end
end
