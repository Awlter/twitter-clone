module ApplicationHelper
  def linkable_hashtag(body)
    body.gsub(/#(\w+)/, '<a href="/hashtags/\1" >#\1</a>').html_safe
  end
end
