class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
       t.references :post, index: true
       t.references :topic, index: true
       t.references :user, index: true
       t.timestamps null: false
     end
     add_foreign_key :comments
  end
end
