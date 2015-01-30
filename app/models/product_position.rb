class ProductPosition < ActiveRecord::Base
  belongs_to :product
  belongs_to :taxon

  acts_as_list :scope => :taxon

  validates :product_id, :taxon_id, :presence => true
end