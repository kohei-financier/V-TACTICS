class TechniqueCategory < ApplicationRecord
  belongs_to :technique
  belongs_to :category
end
