# Extends the String class so that a word can be transalted from a 'base'
# language to any other 'target' languages in the bing library.
# https://msdn.microsoft.com/en-us/library/hh456380.aspx
class String
  def translate(base_code, target_code)
    translator = BingTranslator.new(COGNITIVE_SUBSCRIPTION_KEY)
    translator.translate(self, from: base_code, to: target_code)
  end
end

# Extends the Array class so that each element String can be transalted from a
# 'base' language to any other 'target' languages in the bing library.
# https://msdn.microsoft.com/en-us/library/hh456380.aspx
class Array
  def translate(base_code, target_code)
    translator = BingTranslator.new(COGNITIVE_SUBSCRIPTION_KEY)
    translator.translate_array(self, from: base_code, to: target_code)
  end
end
