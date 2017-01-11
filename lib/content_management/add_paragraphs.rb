# Takes a bulk of text in two languages and splits them up, and creates sentence
# entries.
def add_paragraphs(base_para, base_script, target_para, target_script)
  base_arr = base_para.split_paragraph
  target_arr = target_para.split_paragraph
  raise Invalid, 'Wrong paragraph counts!' if base_arr.count != target_arr.count
  assign_sents(base_arr, base_script, target_arr, target_script)
end

def assign_sents(base_arr, base_script, target_arr, target_script)
  counter = 0
  base_arr.each do |base_entry|
    base_sent = base_script.sentences.create(entry: base_entry)
    base_sent.update(group_id: base_sent.id)
    targ_sent = target_script.sentences.create(entry: target_arr[counter])
    targ_sent.update(group_id: base_sent.group_id)
    counter += 1
  end
end
