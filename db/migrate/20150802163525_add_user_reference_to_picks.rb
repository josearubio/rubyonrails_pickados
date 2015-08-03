class AddUserReferenceToPicks < ActiveRecord::Migration
  def change
    add_reference :picks, :user, index: true, foreign_key: true
    add_index :picks, [:user_id, :created_at]
  end
end
