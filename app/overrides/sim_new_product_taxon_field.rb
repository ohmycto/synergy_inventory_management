Deface::Override.new(
    :virtual_path => "spree/admin/products/new",
    :insert_bottom => '[data-hook="new_product"]',
    :text => "<%= f.hidden_field :add_taxon %>",
    :name => "sim_new_product_taxon_field")
