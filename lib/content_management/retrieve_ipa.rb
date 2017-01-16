require 'httparty'

def retrieve_ipa_from_wiktionary(base_word)
  base_script = base_word.script
  response = retrieve_response(base_script.lang_code, base_word.entry)
  slash_scan = populate_slash_scan(base_script, response)
  return nil if slash_scan.first.nil?
  first_array_entry(slash_scan)
end

def first_array_entry(word_array)
  numberless_array = []
  word_array.flatten.each do |element|
    numberless_array << element if (/[0-9]/ =~ element).nil?
  end
  return nil if numberless_array.first.nil?
  numberless_array.first.gsub(%r{(\/|\s|\(|\))}, '')
end

def retrieve_response(lang_code, entry)
  uri = URI.encode("https://#{lang_code}.wiktionary.org/w/index.php?title=#{entry}&printable=yes".strip)
  HTTParty.get(uri)
end

def populate_slash_scan(base_script, response)
  slash_scan = []
  base_script.regexes.each do |regex|
    slash_scan << response.scan(Regexp.new(regex.entry))
  end
  slash_scan
end
