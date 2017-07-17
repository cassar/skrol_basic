# Compiles all representative sentences for a each word
def compile_reps(base_script)
  word_entry_cat = derive_word_entry_catalogue(base_script)
  base_script.sentences.each do |sentence|
    sentence.entry.split_sentence.each do |entry|
      RepSent.create(word_id: word_entry_cat[entry], rep_sent_id: sentence.id)
    end
  end
end
