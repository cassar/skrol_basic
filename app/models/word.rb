class Word < ApplicationRecord
  validates :entry, :script_id, presence: true
  belongs_to :script
  has_one :language, through: :script
  has_many :scores, as: :entriable, dependent: :destroy

  # Creates a new phonetic entry for a particular word record.
  def create_phonetic(entry)
    p_script = script.phonetic
    update(group_id: id) if group_id.nil?
    p_script.words.create(entry: entry, assoc_id: id, group_id: group_id)
  end

  # Returns phonetic word of given word.
  # The method currently assumes a word only has one phonetic entry.
  def phonetic
    p_script = script.phonetic
    phonetic = p_script.words.where(assoc_id: id)
    raise Invalid, "No phonetic for '#{entry}' found!" if phonetic.first.nil?
    phonetic.first
  end

  # Returns true if a phoneic word is attached to word record
  def phonetic_present?
    p_script = script.phonetic
    phonetic = p_script.words.where(assoc_id: id).first
    return false if phonetic.nil?
    true
  end

  # Returs the base entry of a phonetic word record.
  def base
    b_script = script.base
    base = b_script.words.where(id: assoc_id).first
    raise Invalid, "No base entry for '#{entry}' found" if base.nil?
    base
  end

  # Returns all word records in the same group
  def return_group
    Word.where(group_id: group_id)
  end

  # Retrieves the WTS for a Word record given a base_script
  def retrieve_wts(base_script)
    score = scores.where(name: 'WTS', map_to_id: base_script.id,
                         map_to_type: 'Script').first
    raise Invalid, "No WTS found for word: #{entry}" if score.nil?
    score
  end
end
