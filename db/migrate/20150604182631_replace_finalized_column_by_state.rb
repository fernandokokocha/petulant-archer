class ReplaceFinalizedColumnByState < ActiveRecord::Migration
  def change
    remove_column :orders, :finalized
    add_column :orders, :state, :string
  end
end
