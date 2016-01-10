class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.string :project_guid, null: false

      t.string :name
      t.string :url

      t.timestamps

      t.index [:project_guid, :url]
    end
  end
end
