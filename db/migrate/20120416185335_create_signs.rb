class CreateSigns < ActiveRecord::Migration
  def change
    create_table :signs do |t|
      t.belongs_to :report, :null => false
      t.timestamps
    end

    add_foreign_key(:signs, :reports, :dependent => :delete)
  end
end
