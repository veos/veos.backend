class AddAddressToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :privacy_officer_address, :string
  end
end
