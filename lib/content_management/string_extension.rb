require 'bing_translator'

# Extenends the string class so that a word can be transalted from a 'base'
# language to any other 'target' languages in the bing library.
# https://msdn.microsoft.com/en-us/library/hh456380.aspx
# Or, if 'ipa' is specified, the Words table will be searched to convert the
# sentence to IPA. If no IPA entry can be found, '[none]' will be inserted into
# the string instead.
class String
  def translate(base_code, target_code)
    phonetic = ''
    if target_code != 'ipa'
      key = 'wQHWbTTe+glxEd5J16lkSgTSNz9C8M5Ca2z98HHG0sg='
      translator = BingTranslator.new('SkrollApp', key)
      phonetic = translator.translate(self, from: base_code, to: target_code)
    else
      to_ipa(base_code, phonetic)
    end
    phonetic.to_s
  end
end

# Will split up a paragraph of text up based on delimiters '.', ',', '!', '?'
class String
  def split_paragraph
    scan(/[^\.,!?]+[\.,!?]/).map(&:strip)
  end
end

# Split sentence into words removing any punctuation
class String
  def split_sentence
    downcase.gsub(/(\.|\!|\?|\-|\:|\,|\;|\'|\¿|\¡|\(|\)|\")/, '').split
  end
end

# Modifies phonetic to return the ipa equivalent of a sting (self) by refering
# to the base_code, and looking through the word table in the DB.
def to_ipa(base_code, phonetic)
  str_arr = split_sentence
  str_arr.each do |entry|
    base_arr = retrieve_base_arr(base_code, entry)
    raise Invalid, "No base entry for #{entry}" if base_arr.first.nil?
    phonetic << base_arr.first.phonetic.entry + ' '
  end
  phonetic[-1] = ''
end

# Retrieves an array of word records for use in to_ipa
def retrieve_base_arr(base_code, entry)
  b_script = Script.find_by lang_code: base_code
  base_arr = b_script.words.where(entry: entry)
  base_arr = b_script.words.where(entry: entry.downcase) if base_arr.first.nil?
  if base_arr.first.nil?
    base_arr = b_script.words.where(entry: entry.capitalize)
  end
  base_arr
end
