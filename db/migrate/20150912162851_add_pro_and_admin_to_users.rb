class AddProAndAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pro, :integer, default:0
    add_column :users, :admin, :boolean, default:false
  end
end
