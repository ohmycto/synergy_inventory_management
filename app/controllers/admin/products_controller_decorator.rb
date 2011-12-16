Admin::ProductsController.class_eval do
  skip_before_filter :load_resource, :only => [:edit_multiple, :update_multiple]

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
    @collection = Product.where(:id => params[:product_ids])
    if @collection.any?
      case params[:products_action]
        when 'hide'
          @collection.each { |pr| pr.update_attributes(:available_on => nil) }
          flash[:notice] = I18n.t('sim.products_successfully_hidden')
        when 'delete'
          @collection.each { |pr| pr.update_attributes(:deleted_at => Time.zone.now) }
          flash[:notice] = I18n.t('sim.products_successfully_deleted')
        when 'add_taxon'
          tax = Taxon.find params[:products_options][:taxon]
          @collection.each { |pr| pr.taxons << tax }
          flash[:notice] = I18n.t('sim.taxon_successfully_added')
        when 'publish_from'
          @collection.each { |pr| pr.update_attributes(:available_on => params[:products_options][:available_on]) }
          flash[:notice] = I18n.t('sim.products_successfully_published')
        else
          flash[:error] = I18n.t('sim.action_not_selected')
      end
    else
      flash[:error] = I18n.t('sim.products_not_selected')
    end
    respond_with(@collection) do |format|
      format.html  { redirect_to admin_edit_multiple_products_url(:id => params[:id]) }
      format.json { render :json => json_data }
    end

  end


  def switch_availability
    @object.available_on = @object.available_on.nil? ? Time.zone.now : nil
    @object.save
    respond_with(@object)
  end
end
