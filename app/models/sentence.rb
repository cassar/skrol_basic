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
  def retrieve_sts(base_script)
    score = scores.where(name: 'STS', map_to_id: base_script.id,
                         map_to_type: 'Script')
    raise Invalid, "No STS for sentence.id: #{id} found!" if score.count < 1
    score.first
  end

  # Returns the phonetic version of a sentence record
  def phonetic
    phonetic = script.phonetic.sentences.where(group_id: group_id).first
    raise Invalid, "No phonetic for sentence.id: #{id} found." if phonetic.nil?
    phonetic
  end

  # Either updates or creates a new sts score given an entry and base script.
  def create_update_sts(entry, base_script)
    score = scores.where(map_to_id: base_script.id, map_to_type: 'Script',
                         name: 'STS').first
    if score.nil?
      scores.create(map_to_id: base_script.id, map_to_type: 'Script',
                    name: 'STS', entry: entry)
    else
      score.update(entry: entry)
    end
  end
end
