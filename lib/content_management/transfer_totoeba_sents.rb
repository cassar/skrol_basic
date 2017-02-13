
require 'pg'

def transfer_totoeba_sents(tar_lan_name, toto_code)
  base_script = lang_by_name('English').base_script
  target_script = lang_by_name(tar_lan_name).base_script
  conn = PG.connect(dbname: 'tatoeba_sents')

  conn.exec("SELECT * FROM links").each do |link|
    english_entry =
      conn.exec("SELECT * FROM sentences WHERE id = #{link['sent_id']};").first
    next if english_entry.nil?
    target_entry =
      conn.exec("SELECT * FROM sentences WHERE id = #{link['trans_id']};").first
    next if target_entry.nil?

    english = base_script.sentences.find_by entry: english_entry['text']

    if english.nil?
      english = base_script.sentences.create(entry: english_entry['text'])
      english.update(group_id: english.id)
    end

    group_id = english.group_id

    next if target_script.sentences.where(group_id: group_id).present?

    target_script.sentences.create(entry: target_entry['text'],
                                   group_id: group_id)
  end
end
