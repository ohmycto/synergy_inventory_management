Product.class_eval do
  def active?
    self.deleted_at.nil? and available?
  end

  def available?
    available_on.nil? ? false : available_on < Time.zone.now
  end

  def add_taxon=(taxon_id)
    tax = Taxon.find(taxon_id)
    self.taxons << tax if !self.taxons.include? tax
  end
end
