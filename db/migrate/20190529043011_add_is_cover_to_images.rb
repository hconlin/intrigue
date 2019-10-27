class AddIsCoverToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :is_cover, :boolean, :default => false
  end
end
