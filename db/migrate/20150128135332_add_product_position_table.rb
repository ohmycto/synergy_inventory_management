class AddProductPositionTable < ActiveRecord::Migration
  def self.up
    create_table :product_positions do |t|      
      t.integer :product_id
      t.integer :taxon_id
      t.integer :position
      t.timestamps      
    end
  end

  def self.down
    drop_table :product_positions
  end
end
