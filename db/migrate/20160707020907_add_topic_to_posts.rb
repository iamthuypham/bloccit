class AddTopicToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :topic_id, :interger
    add_index :posts, :topic_id
  end
end
