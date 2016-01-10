class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects, id: false do |t|
      t.string :guid, null: false
      t.string :name, null: false

      t.timestamps

      t.index :guid, unique: true
    end
  end
end
