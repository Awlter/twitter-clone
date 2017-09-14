class User < ActiveRecord::Base
  has_secure_password

  has_many :statuses
  has_many :mentions

  has_many :following_relationships, class_name: 'Relationship', foreign_key: 'leader_id'
  has_many :followed_relationships, class_name: 'Relationship', foreign_key: 'follower_id'

  has_many :followers, through: :following_relationships
  has_many :leaders, through: :followed_relationships

  validates :username, presence: true
  validates :email, presence: true

  def unread_mentions
    @m ||= mentions.where(viewed_at: nil)
  end

  def unread_mentions_number
    unread_mentions.count
  end

  def mark_unread_mentions!
    unread_mentions.each do |mention|
      mention.mark_viewed!
    end
  end
end