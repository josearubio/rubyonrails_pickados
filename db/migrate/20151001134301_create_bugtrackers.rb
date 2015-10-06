class CreateBugtrackers < ActiveRecord::Migration
  def change
    create_table :bugtrackers do |t|
      t.string :usuario
      t.string :gravedad
      t.string :titulo
      t.string :explicacion
      t.string :categoria
      t.string :estado
      t.string :programador
      t.string :solucion

      t.timestamps
    end
  end
end
