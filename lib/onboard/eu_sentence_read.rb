def process_sentences
  english = lang_by_name('English').standard_script
  maltese = lang_by_name('Maltese').standard_script
  next_english = false
  next_maltese = false
  new_english = ''
  new_maltese = ''
  File.new('./lib/content_management/output.tmx', 'r').each do |line|
    if line.include? '<tuv xml:lang="EN-GB">'
      next_english = true
    elsif next_english
      new_english = line.scan(/(?<=<seg>)(.*)(?=<\/seg>)/).first.first
      puts new_english
      next_english = false
    elsif line.include? '<tuv xml:lang="MT-01">'
      next_maltese = true
    elsif next_maltese
      new_maltese = line.scan(/(?<=<seg>)(.*)(?=<\/seg>)/).first.first
      puts new_maltese
      next_maltese = false
    end

    next if new_english == '' && new_maltese == ''
    english_sent = english.sentences.create(entry: new_english)
    english_sent.update(group_id: english_sent.id)
    maltese.sentences.create(entry: new_maltese, group_id: english_sent.id)
    new_english = ''
    new_maltese = ''
  end
end
