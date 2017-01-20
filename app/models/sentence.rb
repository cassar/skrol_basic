class Sentence < ApplicationRecord
  validates :entry, :script_id, presence: true
  validates :entry, uniqueness: { scope: :script_id }
  belongs_to :script
  has_one :language, through: :script
  has_many :scores, as: :entriable, dependent: :destroy

  # Creates a new phonetic entry for a particular sentence record.
  def create_phonetic
    p_script = script.phonetic
    update(group_id: id) if group_id.nil?
    phonetic_entry = entry.translate(script.lang_code, 'ipa')
    p_script.sentences.create(entry: phonetic_entry, group_id: group_id)
  end

  # Will retrieve the STS for a sentence given a base_script
  def retrieve_score(name, base_script)
    score = scores.where(name: name, map_to_id: base_script.id,
                         map_to_type: 'Script')
    raise Invalid, "No #{name} for sentence.id: #{id} found!" if score.count < 1
    score.first
  end

  # Returns the phonetic version of a sentence record
  def phonetic
    phonetic = script.phonetic.sentences.where(group_id: group_id).first
    raise Invalid, "No phonetic for sentence.id: #{id} found." if phonetic.nil?
    phonetic
  end

  # Creates or updates an existing score given a name, script, entry
  def create_update_score(name, script, entry)
    score = scores.where(name: name, map_to_id: script.id,
                         map_to_type: 'Script').first
    if score.nil?
      scores.create(name: name, map_to_id: script.id,
                    map_to_type: 'Script', entry: entry)
    else
      score.update(entry: entry)
    end
  end

  # returns a corresponding sentence given a corresponding_script.
  def corresponding(corr_script)
    sent = corr_script.sentences.where(group_id: group_id).first
    raise Invalid, "No corresponding found for sent_id: #{id}" if sent.nil?
    sent
  end
end
