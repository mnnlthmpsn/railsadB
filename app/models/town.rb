class Town < ApplicationRecord
  self.table_name = :towns

  # validations
  validates :town_desc, presence: true
  validates :comment, presence: true

  belongs_to :city, primary_key: :id, foreign_key: :city_id
  has_many :contacts
end
