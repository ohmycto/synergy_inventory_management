class SynergyInventoryManagementHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_product_sub_tabs do
    %(<li class='<%= 'selected' if params[:action].to_s == 'edit_multiple' %>'><%= link_to I18n.t('sim.edit_multiple_products'), admin_edit_multiple_products_start_path %></li>)
  end
end