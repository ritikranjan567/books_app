class Book < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :authors
  has_one :favorite
end
