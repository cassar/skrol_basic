class Script < ApplicationRecord
  validates :name, :language_id, presence: true
  belongs_to :language
  has_many :characters
  has_many :words
  has_many :sentences

  def phonetic
    Script.where(parent_script_id: self['id']).first # when nil?
  end

  def create_phonetic(name)
    language.scripts.create(name: name, parent_script_id: self['id'])
  end
end
