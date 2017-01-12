require 'httparty'

def retrieve_ipa_word_from_wiktionary(entry)
  slash_scan = []
  uri = URI.encode("https://es.wiktionary.org/w/index.php?title=#{entry}&printable=yes".strip)
  response = HTTParty.get(uri)
  slash_scan << response.scan(/(?<=C1">)(.*?)(?=\<)/)
  slash_scan << response.scan(%r{(?<=>\/)(.*?)(?=\/)})
  slash_scan << response.scan(/(?<=>\[)(.*?)(?=\])/)
  return nil if slash_scan.first.nil?
  first_array_entry(slash_scan)
end

def first_array_entry(word_array)
  numberless_array = []
  word_array.flatten.each do |element|
    numberless_array << element if (/[0-9]/ =~ element).nil?
  end
  return nil if numberless_array.first.nil?
  numberless_array.first.gsub(%r{(\/|\s|\(|\))}, '') if word_array.present?
end
