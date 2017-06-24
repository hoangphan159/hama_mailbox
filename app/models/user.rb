class User < ApplicationRecord
  has_secure_password

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :messages, foreign_key: "sender_id"

  validates :email, presence: true, uniqueness: true

  def is_friend?(friend)
    (self.friends + self.inverse_friends).include?(friend)
  end

  def all_friends
    (self.friends + self.inverse_friends).sort_by {|friend| friend.name}
  end

  def inbound_messages
    Message.where("recipient_id = ?", id).order('created_at DESC')
  end

  def outbound_messages
    Message.where("sender_id = ?", id).order('updated_at DESC')
  end

  def inbound_unread_messages_count
    Message.where("recipient_id = ? and status = 'unread'", id).size
  end

  def outbound_unread_messages_count
    Message.where("sender_id = ? and status = 'unread'", id).size
  end

  def image_url
    self[:image_url] || "https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=120"
  end

  def to_s
    email
  end
end
