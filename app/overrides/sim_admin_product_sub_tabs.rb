Deface::Override.new(
    :virtual_path => "spree/admin/shared/_product_sub_menu",
    :insert_bottom => "[data-hook='admin_product_sub_tabs']",
    :text => "<li class='<%= 'selected' if params[:action].to_s == 'edit_multiple' %>'><%= link_to I18n.t('sim.edit_multiple_products'), admin_edit_multiple_products_start_path %></li>",
    :name => "sim_admin_product_sub_tabs")
