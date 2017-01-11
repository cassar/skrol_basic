require 'pg'
#
# def transfer_words
#   conn = PG.connect(dbname: 'skrol_basic')
#   english = lang_by_name('English')
#   conn.exec('SELECT * FROM words').each do |word|
#     next if word['language'] != 'en'
#     next if english.words.where(entry: word['base']).count > 0
#     new_word = english.base_script.words.create(entry: word['base'])
#     new_word.create_phonetic(word['phonetic'])
#   end
# end
#
# def transfer_spanish_words
#   conn = PG.connect(dbname: 'skrol_basic')
#   spanish = lang_by_name('Spanish')
#   conn.exec('SELECT * FROM words').each do |word|
#     next if word['language'] != 'es'
#     next if spanish.words.where(entry: word['base']).count > 0
#     en_equiv = nil
#     unless word['en_equiv'].nil? || word['en_equiv'] == '[none]'
#       en_word = Word.where(entry: word['en_equiv']).first
#       en_equiv = en_word.id unless en_word.nil?
#     end
#
#     new_word = spanish.base_script.words.create(entry: word['base'], group_id: en_equiv)
#     new_phonetic = new_word.create_phonetic(word['phonetic'])
#   end
# end
