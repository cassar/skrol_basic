require 'net/http'
require 'uri'
require 'json'

class WordSender
  def initialize(language_name, source, words)
    @hash = { language: language_name, source: source,
              words: words, key: SKROL_KEY }
  end

  def send(address)
    uri = URI.parse(address)
    http = Net::HTTP.new(uri.host, uri.port)
    header = { 'Content-Type' => 'application/json' }
    http.post('/words', @hash.to_json, header)
  end
end
