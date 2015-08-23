class AddPickdateToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :pickdate, :datetime
  end
end
