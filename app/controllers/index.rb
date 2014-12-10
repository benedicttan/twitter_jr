
get '/' do
  # @output_array = []
  # client.search("to:justinbieber marry me", :result_type => "recent").take(3).collect do |tweet|
  #   @output_string << "#{tweet.user.screen_name}: #{tweet.text}" << "\n"
  # end

  erb :index
end

get '/:username' do
  @user = TwitterUser.where(username: params[:username].downcase).first_or_create
  # puts @user.tweets_stale?
  # puts Time.now()
  if @user.tweets_stale?
    # User#fetch_tweets! should make an API call
    # and populate the tweets table
    #
    # Future requests should read from the tweets table
    # instead of making an API call
    @user.tweets.destroy_all
    @user.fetch_tweets!
  end

  @tweets = @user.tweets.limit(10)
  # @tweets = @user.tweets_stale?
  erb :tweet
end