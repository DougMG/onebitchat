class Team < ApplicationRecord
  belongs_to :user
  has_many :talks, dependent: :destroy
  has_many :channels, dependent: :destroy
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  validates_presence_of :slug, :user
  validates :slug, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  before_save :general_channel

  def general_channel
    channels << Channel.create(slug: 'general', user_id: user.id)
  end

  def my_users
    users + [user]
  end
end
