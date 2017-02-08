require 'pg'

def transfer_totoeba_sents(tar_lan_name, toto_code)
  base_script = lang_by_name('English').base_script
  target_script = lang_by_name(tar_lan_name).base_script
  conn = PG.connect(dbname: 'tatoeba_sents')
  conn.exec('SELECT * FROM sentences;').each do |record|
    next if record['lang'] != toto_code



    english = nil
    group = conn.exec("SELECT * FROM links WHERE sent_id = #{record['id']};")
    group.each do |link|
      cores =
        conn.exec("SELECT * FROM sentences WHERE id = #{link['trans_id']};").first
      next if cores.nil? || cores['lang'] != 'eng'
      english = cores
    end
    next if english.nil?
    next if target_script.sentences.where(entry: record['text']).present?

    skrol_record = base_script.sentences.find_by entry: english['text']

    if skrol_record.nil?
      skrol_record = base_script.sentences.create(entry: english['text'])
      skrol_record.update(group_id: skrol_record.id)
    end
    target_script.sentences.create(entry: record['text'], group_id: skrol_record.group_id)
  end
end
