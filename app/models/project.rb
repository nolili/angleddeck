class Project < ApplicationRecord
  self.primary_key = :guid

  has_many :topics, foreign_key: :project_guid, dependent: :destroy

  validates :name, presence: true

  before_save :ensure_guid
  after_save :ensure_default_topic

  def ensure_guid
    self.guid = SecureRandom.uuid if guid.blank?
  end

  def ensure_default_topic
    if topics.empty?
      topics.create!(name: nil, url: nil)
    end
  end
end
