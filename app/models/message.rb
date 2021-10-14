class Message < ApplicationRecord
  belongs_to :messagable, polymorphic: true
  belongs_to :user
  validates :body, :user, presence: true

  after_create_commit { MessageBroadcastJob.perform_later self }
end
