class AddVoteTotalToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :vote_total, :integer, default: 0
    add_index :posts, :vote_total
  end
end
