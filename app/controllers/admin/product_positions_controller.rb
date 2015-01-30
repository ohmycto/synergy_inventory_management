class Admin::ProductPositionsController < Admin::BaseController
  def update
    @product_position = ProductPosition.where(:product_id => params[:product_id], :taxon_id => params[:taxon_id]).first
    if params[:position] == 'up'
      @product_position.move_higher
    elsif params[:position] == 'down'
      @product_position.move_lower
    end
    redirect_to admin_edit_multiple_products_path(params[:taxon_id])
  end
end