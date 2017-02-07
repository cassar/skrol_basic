class Word < ApplicationRecord
  validates :entry, :script_id, presence: true
  belongs_to :script
  has_one :language, through: :script
  has_many :scores, as: :entriable, dependent: :destroy
  has_many :ranks, as: :entriable, dependent: :destroy
  has_many :rep_sents

  # Creates a new phonetic entry for a particular word record.
  def create_phonetic(entry)
    p_script = script.phonetic
    update(group_id: id) if group_id.nil?
    p_script.words.create(entry: entry, assoc_id: id, group_id: group_id)
  end

  # Returns phonetic word of given word.
  # The method currently assumes a word only has one phonetic entry.
  def phonetic
    script.phonetic.words.find_by! assoc_id: id
  end

  # Returns true if a phoneic word is attached to word record
  def phonetic_present?
    phonetic = script.phonetic.words.find_by assoc_id: id
    return false if phonetic.nil?
    true
  end

  # Returs the base entry of a phonetic word record.
  def base
    script.base.words.find_by! id: assoc_id
  end

  # Returns all word records in the same group
  def return_group
    Word.where(group_id: group_id)
  end

  # Retrieves the WTS for a Word record given a base_script
  def retrieve_score(name, map_to)
    scores.find_by! name: name, map_to_id: map_to.id,
                    map_to_type: map_to.class.to_s
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

  # Creates a REP score in order to be able to retrive sentences associated
  # with the word.
  def create_rep(sentence)
    rep_sents.create(rep_sent_id: sentence.id)
  end
end
