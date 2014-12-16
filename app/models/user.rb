class User < ActiveRecord::Base

  def twitter_client(oauth_token, oauth_token_secret)
    twitter_client = Twitter::REST::Client.new do |c|
      c.consumer_key        = "fA5i1jQRP5LRIuhly6TnZFBoI"
      c.consumer_secret     = "bXePQSxh8z4ZmF7VZvUtjOpB4q6NF40N9PA8uAQrZm1Ot8iQrn"
      c.access_token        = oauth_token
      c.access_token_secret = oauth_token_secret
    end
    twitter_client
  end

end
