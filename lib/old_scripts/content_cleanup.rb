# Will REMOVE any sentence which has an word entry that is not in the words
# table
def cleanup_sentences!(script)
  script.sentences.each do |sentence|
    sentence.entry.split_sentence.each do |entry|
      next if word_present?(entry, sentence.script)
      d_group_id = sentence.group_id
      Sentence.where(group_id: d_group_id).each(&:destroy)
      break
    end
  end
end
