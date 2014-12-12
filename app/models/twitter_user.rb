class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def tweets_stale?
    if self.tweets.empty? || (Time.now - self.tweets.last.created_at) > 10
      return true
    else
      return false
    end
  end

  def fetch_tweets!
    client.user_timeline(username).each do |t|
      Tweet.create(text: t.text, twitter_user_id: self.id)
    end
  end
end
