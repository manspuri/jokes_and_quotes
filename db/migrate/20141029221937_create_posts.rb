class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to  :user
      t.string      :post_type
      t.text        :text

      t.timestamps
    end
  end
end
