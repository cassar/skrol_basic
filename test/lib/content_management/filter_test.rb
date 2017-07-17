require 'test_helper'

class FilterTest < ActiveSupport::TestCase
  test 'word_good?' do
    assert(word_good?(Word.first), 'Incorrect result returned.')
    puts Word.find(21).phonetic.entry
    puts NONE
    assert(!word_good?(Word.find(21)), 'Incorrect result returned.')
  end

  test 'sent_good?' do
    assert(sent_good?(Sentence.third), 'Incorrect result returned.')
    Sentence.third.phonetic.update(entry: 'hhhh [none]')
    assert(!sent_good?(Sentence.third), 'Incorrect result returned.')
  end
end
