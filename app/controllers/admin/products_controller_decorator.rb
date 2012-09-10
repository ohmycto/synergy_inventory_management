Admin::ProductsController.class_eval do
  skip_before_filter :load_resource, :only => [:edit_multiple, :update_multiple, :destroy_multiple]
  before_filter :load_multiple, :only => [:update_multiple, :destroy_multiple]


  def edit_multiple
    session[:im_per_page] = params[:per_page].to_i if !params[:per_page].nil?
    @taxon = params[:id].present? ? Taxon.find(params[:id]) : Taxon.root
    product_ids = @taxon.present? ? @taxon.self_and_descendants.map { |tax| tax.product_ids }.flatten.uniq : []

    params[:search] ||= {}
    params[:search][:deleted_at_is_null] = "1" if params[:search][:deleted_at_is_null].nil?
    params[:search][:meta_sort] ||= "name.asc"

    @search = Product.where(:id => product_ids).metasearch(params[:search])
    pagination_options = {:per_page => (session[:im_per_page] || 10), :page => params[:page]}
    @collection = @search.relation.group_by_products_id.paginate(pagination_options)

    respond_with(@collection) do |format|
      format.html
      format.json { render :json => json_data }
    end
  end

  def update_multiple
    @collection.each { |pr| pr.update_attributes!(params[:product]) }
    flash[:notice] = I18n.t('sim.products_successfully_updated')
    respond_with(@collection) do |format|
      format.html { redirect_to admin_edit_multiple_products_url(:id => params[:id]) }
      format.json { render :json => json_data }
    end
  end

  def destroy_multiple
    authorize! :destroy, Product
    @collection.each do |pr|
      pr.update_attributes!(:deleted_at => Time.zone.now)
      pr.variants.each { |v| v.update_attributes!(:deleted_at => Time.zone.now) }
    end
    flash[:notice] = I18n.t('sim.products_successfully_deleted')
    respond_with(@collection) do |format|
      format.html { redirect_to admin_edit_multiple_products_url(:id => params[:id]) }
      format.json { render :json => json_data }
    end
  end

  def load_multiple
    @collection = Product.where(:id => params[:product_ids])
  end

  private :load_multiple

end
