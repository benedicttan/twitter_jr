post "/post" do
  new_user = User.find(session[:user_id])
  new_user.client(new_user.access_token, new_user.access_token_secret)
  new_user.twitter_client.update(params["tweetbox"])
  redirect to ("/t/" << new_user.twitter_client.user.screen_name)
end



# post '/tweet_later' do

#   twitteruser = TwitterUser.find(session[:id])
#   job_id = twitteruser.post_tweet_later(params[:tweet_word1], params[:time])
#   redirect to "/status/#{job_id}"
# end

