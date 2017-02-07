class Sentence < ApplicationRecord
  validates :entry, :script_id, presence: true
  # validates :entry, uniqueness: { scope: :script_id }
  belongs_to :script
  has_one :language, through: :script
  has_many :scores, as: :entriable, dependent: :destroy
  has_many :ranks, as: :entriable, dependent: :destroy

  # Creates a new phonetic entry for a particular sentence record.
  def create_phonetic
    p_script = script.phonetic
    update(group_id: id) if group_id.nil?
    phonetic_entry = entry.translate(script.lang_code, 'ipa')
    p_script.sentences.create(entry: phonetic_entry, group_id: group_id)
  end

  # Will retrieve the STS for a sentence given a base_script
  def retrieve_score(name, map_to)
    scores.find_by! name: name, map_to_id: map_to.id,
                    map_to_type: map_to.class.to_s
  end

  # Returns the phonetic version of a sentence record
  def phonetic
    script.phonetic.sentences.find_by! group_id: group_id
  end

  # Creates or updates an existing score given a name, script, entry
  def create_update_score(name, map_to, entry)
    score = scores.find_by name: name, map_to_id: map_to.id,
                           map_to_type: map_to.class.to_s
    if score.nil?
      scores.create(name: name, map_to_id: map_to.id,
                    map_to_type: map_to.class.to_s, entry: entry)
    else
      score.update(entry: entry)
    end
  end

  # returns a corresponding sentence given a corresponding_script.
  def corresponding(corr_script)
    corr_script.sentences.find_by! group_id: group_id
  end
end
