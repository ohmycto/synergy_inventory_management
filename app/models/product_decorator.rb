Product.class_eval do
  has_many :product_positions, :dependent => :destroy
  attr_accessor :add_taxon, :delete_taxon
  after_save :update_taxon_save, :update_product_positions

  def active?
    self.deleted_at.nil? and available?
  end

  def available?
    available_on.nil? ? false : available_on < Time.zone.now
  end 

  def find_position_by_taxon(taxon_id)
    self.product_positions.where(:taxon_id => taxon_id).first
  end

  private

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

    def update_product_positions
      self.taxons.each do |taxon|
        unless (product_position = self.find_position_by_taxon(taxon.id)).present?
          position = self.product_positions.create(:taxon_id => taxon.id)
          position.move_to_bottom 
        end
      end
    end
end
