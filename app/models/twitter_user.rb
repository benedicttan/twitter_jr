class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def tweets_stale?
    (Time.now - self.tweets.last.created_at)/60 > 15
  end

  def fetch_tweets!
    client.user_timeline(username, {count: 10}).each do |t|
      Tweet.create(text: t.text, twitter_user_id: self.id)
    end
  end
end
