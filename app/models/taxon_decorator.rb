Taxon.class_eval do
  def not_deleted_products_count
    self.self_and_descendants.inject(0) { |sum, x| sum + x.products.not_deleted.size }
  end
end