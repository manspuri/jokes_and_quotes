class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to  :user
      t.string      :type_name
      t.text        :text

      t.timestamps
    end
  end
end
