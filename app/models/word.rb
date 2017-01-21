class Word < ApplicationRecord
  validates :entry, :script_id, presence: true
  belongs_to :script
  has_one :language, through: :script
  has_many :scores, as: :entriable, dependent: :destroy
  has_many :ranks

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
  def retrieve_score(name, map_to)
    score = scores.where(name: name, map_to_id: map_to.id,
                         map_to_type: map_to.class.to_s).first
    raise Invalid, "No #{name} found for word: #{entry}" if score.nil?
    score
  end

  # Creates or updates an existing score given a name, script, entry
  def create_update_score(name, map_to, entry)
    score = scores.where(name: name, map_to_id: map_to.id,
                         map_to_type: map_to.class.to_s).first
    if score.nil?
      scores.create(name: name, map_to_id: map_to.id,
                    map_to_type: map_to.class.to_s, entry: entry)
    else
      score.update(entry: entry)
    end
  end

  # Creates a REP score in order to be able to retrive sentences associated
  # with the word.
  def create_rep(sentence)
    scores.create(name: 'REP', map_to_id: sentence.id, map_to_type: 'Sentence',
                  entry: 0)
  end

  # Returns all the representative sentence_ids related to a word.
  def reps
    ids = []
    scores.where(name: 'REP').each do |score|
      ids << score.map_to_id
    end
    ids
  end
end
