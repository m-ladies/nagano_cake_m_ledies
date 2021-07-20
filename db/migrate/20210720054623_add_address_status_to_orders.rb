class AddAddressStatusToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :Address_Status, :integer
  end
end
