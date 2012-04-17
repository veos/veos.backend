class CreateSignStatedProperties < ActiveRecord::Migration
  def change
    create_table :sign_stated_properties do |t|
      t.belongs_to :sign
      t.string :property, :null => false
      t.timestamps
    end

    add_foreign_key(:sign_stated_properties, :signs, :dependent => :delete)
  end
end
