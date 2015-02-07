class AddVoteTotalToComments < ActiveRecord::Migration
  def change
    add_column :comments, :vote_total, :integer, default: 0
    add_index :comments, :vote_total
  end
end
