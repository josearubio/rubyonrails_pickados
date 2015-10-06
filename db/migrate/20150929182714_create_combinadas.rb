class CreateCombinadas < ActiveRecord::Migration
  def change

    add_column :picks, :comb, :integer, default: 0

    create_table :combinadas, :id => false do |t|
      t.integer :pick_a, :null => false
      t.integer :pick_b, :null => false
    end

  end
end
