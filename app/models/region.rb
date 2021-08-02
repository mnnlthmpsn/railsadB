class Region < ApplicationRecord
  self.table_name = :regions

  # validations
  validates :region_desc, presence: true
  validates :comment, presence: true

  has_many :cities
end
