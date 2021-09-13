class Channel < ApplicationRecord
  has_many :messages, as: :messagable, dependent: :destroy
  belongs_to :team
  belongs_to :user
  validates :slug, :team, :user, presence: true
  validates :slug, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\Z/ }
end
