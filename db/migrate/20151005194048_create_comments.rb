class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :usuario
      t.string :comentario

      t.timestamps
    end
  end
end
