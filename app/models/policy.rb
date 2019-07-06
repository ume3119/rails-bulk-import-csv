class Policy < ApplicationRecord
  belongs_to :company
  has_and_belongs_to_many :employees

  # validates :name, uniqueness: true
  # The validation would be scoped by company
  validates :name, uniqueness: { scope: :company_id }
end
