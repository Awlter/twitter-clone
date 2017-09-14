class Status < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: 'user_id'

  has_many :mentions

  validates :creator, presence: true
  validates :body, presence: true, length: {minimum: 5}

  after_save :extract_mentions

  def extract_mentions
    usernames_array = self.body.scan(/@(\w*)/)

    usernames_array.each do |username_array|
      username = username_array.first
      user = User.find_by username: username
      # binding.pry
      if user
        Mention.create(status: self, mentioned_user: user)
      end
    end
  end
end