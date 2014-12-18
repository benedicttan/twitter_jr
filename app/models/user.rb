class User < ActiveRecord::Base
  has_many :rtweets

  def client(oauth_token, oauth_token_secret)
    @twitter_client = Twitter::REST::Client.new do |c|
      c.consumer_key        = CONSUMER_KEY
      c.consumer_secret     = CONSUMER_SECRET
      c.access_token        = oauth_token
      c.access_token_secret = oauth_token_secret
    end
  end

  def tweet(status)
    rtweet = self.rtweets.create!(text: status)
    session[:job_id] = TweetWorker.perform_async(rtweet.id) # returns a job ID number
  end

  def twitter_client
    @twitter_client
  end
end
