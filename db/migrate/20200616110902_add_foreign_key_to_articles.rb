class AddForeignKeyToArticles < ActiveRecord::Migration[5.2]
  def up
    add_reference :articles, :user, foreign_key: true
    execute <<-SQL
      UPDATE articles
      SET user_id = 1
    SQL
    change_column_null :articles, :user_id, false
  end

  def down
    remove_reference :articles, :user
  end
end
