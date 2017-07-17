def create_entry_group_obj(script)
  entry_group_obj = {}
  script.words.each { |word| entry_group_obj[word.entry] = word.group_id }
  entry_group_obj
end
