Product.class_eval do
  def active?
    self.deleted_at.nil? and available?
  end

  def available?
    available_on.nil? ? false : available_on < Time.zone.now
  end
end
