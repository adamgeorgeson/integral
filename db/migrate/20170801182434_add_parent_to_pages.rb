class AddParentToPages < ActiveRecord::Migration
  def change
    add_column :integral_pages, :parent_id, :integer
  end
end
