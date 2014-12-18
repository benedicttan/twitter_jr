class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Rtweet.find(tweet_id)
    user = rtweet.user

    # set up Twitter OAuth client here
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here
    client = Twitter::REST::Client.new do |c|
        c.consumer_key        = CONSUMER_KEY
        c.consumer_secret     = CONSUMER_SECRET
        c.access_token        = user.access_token
        c.access_token_secret = user.access_token_secret
    end

    client.update(rtweet.text)

  end
end