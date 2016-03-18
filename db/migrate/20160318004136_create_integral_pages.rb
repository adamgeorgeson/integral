class CreateIntegralPages < ActiveRecord::Migration
  def change
    create_table :integral_pages do |t|
      t.string :title
      t.string :path
      t.text :description
      t.text :body

      t.timestamps null: false
    end
  end
end
