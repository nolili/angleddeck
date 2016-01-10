class CreateBuilds < ActiveRecord::Migration[5.0]
  def change
    create_table :builds do |t|
      t.references :topic, null: false

      t.string :name, null: false

      t.string :bundle_identifier, null: false
      t.string :bundle_version, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
