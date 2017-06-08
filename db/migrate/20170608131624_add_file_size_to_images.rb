class AddFileSizeToImages < ActiveRecord::Migration
  def change
    add_column :integral_images, :file_size , :integer
  end
end
