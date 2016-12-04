class Word < ApplicationRecord
  validates :entry, :script_id, presence: true
  validates :entry, uniqueness: { scope: :script_id }
  belongs_to :script
  has_one :language, through: :script
  has_many :scores, as: :entriable, dependent: :destroy

  def create_phonetic(entry)
    p_script = script.phonetic # find the phonetic script.
    update(group_id: id) if group_id.nil?
    p_script.words.create(entry: entry, group_id: group_id)
  end

  # Returns phonetic word of given word.
  # The method currently assumes a word only has one phonetic entry.
  def phonetic
    p_script = script.phonetic
    p_script.words.where(group_id: self['group_id']).first
    # What if nil?
  end
end
