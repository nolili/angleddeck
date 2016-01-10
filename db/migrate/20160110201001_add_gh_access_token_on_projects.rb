class AddGhAccessTokenOnProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :gh_access_token, :string
  end
end
