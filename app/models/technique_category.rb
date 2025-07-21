class TechniqueCategory < ApplicationRecord
  belongs_to :technique
  belongs_to :category

  after_destroy :destroy_unused_category

  def destroy_unused_category
    category.destroy if category.reload.technique_category.empty?
  end
end
