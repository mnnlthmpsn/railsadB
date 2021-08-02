class City < ApplicationRecord
  self.table_name = :cities

  # validations
  validates :city_desc, presence: true
  validates :comment, presence: true

  belongs_to :region
  has_many :towns, primary_key: :id, foreign_key: :city_id
end
