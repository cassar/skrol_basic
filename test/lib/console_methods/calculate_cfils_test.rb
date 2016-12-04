require 'test_helper'

class CalculateCFILSTest < ActiveSupport::TestCase
  test 'calculate_cfils should result in extra scores' do
    Word.create(base: 'boro', phonetic: 'ˈtɔ.ro', language: 'it', en_equiv: 1)
    Word.create(base: 'bull', phonetic: 'bʊl', language: 'en', en_equiv: 1)
    populate_chars_cfs('en', 'base')
    populate_chars_cfs('it', 'base')
    calculate_cfils('en', 'base', 'it')
    assert_equal(3, Score.where(score_name: 'CFILS').count)
    char = Character.where(entry: 'b', language: 'en', script: 'base').first
    score = char.scores.where(score_name: 'CFILS').first['score']
    assert_equal(0.25, score, 'Different score recorded.')
  end

  test 'clear_old_cfils_scores should return 0' do
    new_char = Character.create(entry: 'h', language: 'en', script: 'base')
    new_char.scores.create(map_to: 'it', score_name: 'CFILS', score: 0.5)
    assert_equal(1, Score.count, "Score didn't create")
    clear_old_cfils_scores('en', 'base', 'it')
    total = 0
    Character.where(language: 'en', script: 'base').each do |char|
      total += 1 if char.scores.where(map_to: 'it', score_name: 'CFILS').nil?
    end
    assert_equal(0, total)
  end

  test 'calculate_total_chars should return correct number' do
    Word.create(base: 'hello', phonetic: 'hɛˈloʊ̯', language: 'en', en_equiv: 1)
    Word.create(base: 'cow', phonetic: 'kaʊ̯', language: 'en', en_equiv: 2)
    assert_equal(8, calculate_total_chars('en', 'base'))
  end

  test "check_all_chars should return false if one isn't there" do
    Character.create(entry: 'h', language: 'en', script: 'base')
    assert_same(false, check_all_chars('en', 'base', 'es'))
  end

  test "check_all_chars should return true if they're both there" do
    Character.create(entry: 'h', language: 'en', script: 'base')
    Character.create(entry: 'a', language: 'it', script: 'base')
    assert_same(true, check_all_chars('en', 'it', 'base'))
  end

  test 'check_avail_chars should return false for absent language' do
    assert_same(false, check_avail_chars('es', 'base'))
  end

  test 'check_avail_chars should return true for present language' do
    Character.create(entry: 'h', language: 'en', script: 'base')
    assert_same(true, check_avail_chars('en', 'base'))
  end
end
