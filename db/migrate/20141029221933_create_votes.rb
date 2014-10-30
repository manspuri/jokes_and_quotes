class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :user
      t.integer    :value, default: 0
      t.integer    :voteable_id
      t.string     :voteable_type

      t.timestamps
    end
  end
end