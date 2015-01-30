namespace :synergy_inventory_management do
  desc "Copies all migrations and assets (NOTE: This will be obsolete with Rails 3.1)"
  task :install do
    Rake::Task['synergy_inventory_management:install:migrations'].invoke
    Rake::Task['synergy_inventory_management:install:assets'].invoke
  end

  namespace :install do
    desc "Copies all migrations (NOTE: This will be obsolete with Rails 3.1)"
    task :migrations do
      source = File.join(File.dirname(__FILE__), '..', '..', 'db')
      destination = File.join(Rails.root, 'db')
      Spree::FileUtilz.mirror_files(source, destination)
    end

    desc "Copies all assets (NOTE: This will be obsolete with Rails 3.1)"
    task :assets do
      source = File.join(File.dirname(__FILE__), '..', '..', 'public')
      destination = File.join(Rails.root, 'public')
      puts "INFO: Mirroring assets from #{source} to #{destination}"
      Spree::FileUtilz.mirror_files(source, destination)
    end

    desc "Initialize products positions"
    task :product_positions => :environment do
      Taxon.find_each do |taxon|
        taxon.products.find_each do |product|
          if (product_position = product.find_position_by_taxon(taxon.id)).present?
            product_position.move_to_bottom
          else
            product.product_positions.create(:taxon_id => taxon.id).move_to_bottom 
          end
        end
      end
    end
  end

end

namespace :spree_enhanced_option_types do
  desc "stub"
  task :install do
  end
end
