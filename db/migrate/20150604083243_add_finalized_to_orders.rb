class AddFinalizedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :finalized, :boolean
  end
end
