class Articles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :preview
    add_column :articles, :preview, :text, array: true, default: []
  end
end
