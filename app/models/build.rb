class Build < ApplicationRecord
  belongs_to :topic, touch: true

  validates :name, presence: true

  validates :bundle_identifier, presence: true
  validates :bundle_version, presence: true
  validates :url, presence: true
end
