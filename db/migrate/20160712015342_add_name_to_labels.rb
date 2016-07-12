class AddNameToLabels < ActiveRecord::Migration
  def change
    add_column :labels, :name, :string
  end
end
