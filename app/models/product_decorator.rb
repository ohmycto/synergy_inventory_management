Product.class_eval do
  attr_accessor :add_taxon, :delete_taxon
  after_save :update_taxon_save

  def active?
    self.deleted_at.nil? and available?
  end

  def available?
    available_on.nil? ? false : available_on < Time.zone.now
  end

  def update_taxon_save
    if add_taxon.present?
      taxon = Taxon.find(add_taxon)
      self.taxons << taxon if !self.taxons.include? taxon
    elsif delete_taxon.present?
      taxon = Taxon.find(delete_taxon)
      self.taxons.delete(taxon) if self.taxons.include? taxon
    end
    true
  end
end
