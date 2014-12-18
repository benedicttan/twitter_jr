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


  def client
    client = Twitter::REST::Client.new do |c|
        c.consumer_key        = CONSUMER_KEY
        c.consumer_secret     = CONSUMER_SECRET
        c.access_token        = "81753202-ftg7E9uyjrpDaJmEXvQSPHX3Pho8gOKJa0oE6Riuh"
        c.access_token_secret = "QG0rW14JezJVsrx2gt0vuzJCkuHLNt4kS4HETfuvmnslu"
    end
    client
  end



end
