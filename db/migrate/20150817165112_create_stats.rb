class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.float :acierto, default: 0
      t.float :yield, default: 0
      t.integer :acertadas, default: 0
      t.integer :falladas, default: 0
      t.integer :anuladas, default: 0
      t.integer :totalpicks, default: 0
      t.float :profit, default: 0
      t.float :totalstaked, default: 0
      t.float :cuotaavg, default: 0
      t.float :totalcuota, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end

  end
end
