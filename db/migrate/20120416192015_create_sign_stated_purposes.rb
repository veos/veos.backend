class CreateSignStatedPurposes < ActiveRecord::Migration
  def change
    create_table :sign_stated_purposes do |t|
      t.belongs_to :sign, :null => false
      t.string :purpose, :null => false
      t.timestamps
    end

    add_foreign_key(:sign_stated_purposes, :signs, :dependent => :delete)
  end
end
