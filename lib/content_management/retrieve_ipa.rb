require 'httparty'

# Searches for an IPA entry given a base entry, will try capitalize and
# downcase, will return '[none]' for IPA entry if it can't find anything.
def search_for_ipa_entry(base_entry, base_script)
  ipa_entry, entry = retrieve_ipa_from_wiktionary(base_entry, base_script)
  if ipa_entry.nil? && base_entry.downcase != base_entry
    ipa_entry, entry =
      retrieve_ipa_from_wiktionary(base_entry.downcase, base_script)
  end
  ipa_entry = NONE if ipa_entry.nil?
  [ipa_entry, entry]
end

# Attemps to retrieve an ipa entry from wiktionary, given a base_entry and
# script
def retrieve_ipa_from_wiktionary(base_entry, base_script)
  response = retrieve_response(base_script.lang_code, base_entry)
  slash_scan = populate_slash_scan(base_script, response)
  return nil if slash_scan.first.nil?
  first_array_entry(slash_scan)
end

# Strips the given word array to see if there is a valid entry
def first_array_entry(word_array)
  numberless_array = []
  word_array.flatten.each do |element|
    numberless_array << element if (/[0-9]/ =~ element).nil?
  end
  return nil if numberless_array.first.nil?
  numberless_array.first.gsub(%r{(\/|\s|\(|\))}, '')
end

# Retrieves teh html in print mode from wiktionary given an entry and lang_code
def retrieve_response(lang_code, entry)
  uri = URI.encode("https://#{lang_code}.wiktionary.org/w/index.php?title=#{entry}&printable=yes".strip)
  HTTParty.get(uri)
end

# Applies all regular expressions attached to a given base_script to a given
# html response.
def populate_slash_scan(base_script, response)
  slash_scan = []
  regexes = base_script.regexes
  raise Invalid, 'No regexs found for base_script!' if regexes.count < 1
  regexes.each do |regex|
    slash_scan << response.scan(Regexp.new(regex.entry))
  end
  slash_scan
end
