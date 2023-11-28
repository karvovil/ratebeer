class Message < ApplicationRecord
  belongs_to :user

  after_create_commit do
    broadcast_prepend_to "messages_index", partial: "messages/message", target: "messages"
  end

  after_destroy_commit do
    broadcast_remove_to "messages_index"
  end
end
