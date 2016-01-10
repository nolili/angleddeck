class Topic < ApplicationRecord
  belongs_to :project, foreign_key: :project_guid
  has_many :builds, dependent: :destroy

  scope :master, -> { where(name: nil) }
end
