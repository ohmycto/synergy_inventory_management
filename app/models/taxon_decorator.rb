Taxon.class_eval do
  has_many :product_positions
  after_save :update_children_taxonomy, :if => :taxonomy_id_changed?

  def self_and_children_ids
    self.children.map(&:id) + [self.id]
  end

  def not_deleted_products_count
    self.self_and_descendants.map { |tax| tax.products.select(:id).not_deleted }.flatten.uniq.size
  end

  def update_children_taxonomy
    self.children.each { |ch| ch.update_attributes(:taxonomy_id => self.taxonomy.id) }
    true
  end
end