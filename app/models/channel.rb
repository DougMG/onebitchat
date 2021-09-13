class Channel < ApplicationRecord
  has_many :messages, as: :messagable, dependent: :destroy
  belongs_to :team
  belongs_to :user
  validates :slug, :team, :user, presence: true
  validates :slug, format: { with: /\A[a-zA-Z0-9]+\Z/ }
  validates :slug, uniqueness: true, scope: :team_id
end
