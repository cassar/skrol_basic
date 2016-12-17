class Word < ApplicationRecord
  validates :entry, :script_id, presence: true
  validates :entry, uniqueness: { scope: :script_id }
  belongs_to :script
  has_one :language, through: :script
  has_many :scores, as: :entriable, dependent: :destroy

  # Creates a new phonetic entry for a particular word record.
  def create_phonetic(entry)
    p_script = script.phonetic
    update(group_id: id) if group_id.nil?
    p_script.words.create(entry: entry, group_id: group_id)
  end

  # Returns phonetic word of given word.
  # The method currently assumes a word only has one phonetic entry.
  def phonetic
    p_script = script.phonetic
    phonetic = p_script.words.where(group_id: group_id).first
    raise Invalid, "No phonetic for '#{entry}' found!" if phonetic.nil?
    phonetic
  end

  # Returns true if a phoneic word is attached to word record
  def phonetic_present?
    p_script = script.phonetic
    phonetic = p_script.words.where(group_id: group_id).first
    return false if phonetic.nil?
    true
  end

  # Would like a show group method.
end
