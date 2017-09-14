class Mention < ActiveRecord::Base
  belongs_to :mentioned_user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :status

  def mark_viewed!
    self.update(viewed_at: Time.now)
  end
end