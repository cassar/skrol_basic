require 'pg'

def transfer_totoeba_sents
  base_script = lang_by_name('English').base_script
  target_script = lang_by_name('Spanish').base_script
  conn = PG.connect( dbname: 'tatoeba_sents' )
  conn.exec("SELECT * FROM sentences;").each do |record|
    next if record['lang'] != 'eng'
    group = conn.exec("SELECT * FROM links WHERE sent_id = #{record['id']};")
    english = record
    spanish = nil
    group.each do |link|
      cores =
        conn.exec("SELECT * FROM sentences WHERE id = #{link['trans_id']};").first
      next if cores.nil? || cores['lang'] != 'spa'
      spanish = cores
    end
    next if spanish.nil?
    eng_sent = base_script.sentences.create(entry: english['text'])
    eng_sent.update(group_id: eng_sent.id)
    spa_sent = target_script.sentences.create(entry: spanish['text'], group_id: eng_sent.group_id)
  end
end
