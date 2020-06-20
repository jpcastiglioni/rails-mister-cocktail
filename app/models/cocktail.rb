class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy

end
