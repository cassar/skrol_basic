class WordAssociate < ApplicationRecord
  validates :associate_a, :associate_b, presence: true
  validates :associate_a, uniqueness: { scope: :associate_b }
  belongs_to :associate_a, class_name: 'Word'
  belongs_to :associate_b, class_name: 'Word'
  has_many :meta_data, as: :contentable, dependent: :destroy

  def corresponding(script)
    return associate_a if associate_a.script_id == script.id
    associate_b
  end
end
