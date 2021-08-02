class Contact < ApplicationRecord
  self.table_name = 'contacts'

  attr_accessor :region, :city

  # validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :contact_number, presence: true
  validates :town_id, presence: true
  validates :region, presence: true, on: :create
  validates :city, presence: true, on: :create

  belongs_to :town, primary_key: :id, foreign_key: :town_id

  def get_full_name
    "#{first_name} #{last_name}"
  end
end
