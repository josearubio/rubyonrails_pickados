class AddBugtrackerReferenceToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :bugtracker, index: true, foreign_key: true
    add_index :comments, [:bugtracker_id, :created_at]
  end
end
