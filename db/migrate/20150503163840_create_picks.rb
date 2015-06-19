class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.string :pronostico
      t.string :deporte
      t.float :cuota
      t.string :categoria
      t.string :evento
      t.float :stake
      t.text :explicacion

      t.timestamps
    end
  end
end
