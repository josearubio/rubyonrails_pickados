class AddStatusToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :status, :string, default: 'unstarted'
    add_column :picks, :result, :string, default: 'fail'
  end
end
