get '/' do
  erb :index
end

get '/t/:username' do
  @user = TwitterUser.where(username: params[:username].downcase).first_or_create

  if @user.tweets_stale?
    @user.tweets.destroy_all
    redirect to ("/t/" << params[:username] <<  "/load")
  else # not stale
    @tweets = @user.tweets.limit(10)
    redirect to ("/t/" << params[:username] << "/show?scour=false")
  end
end

get '/t/:username/show' do
  @user = TwitterUser.where(username: params[:username].downcase).first
  if params[:scour]
    @user.fetch_tweets!
  end
  @tweets = @user.tweets.limit(10)
  erb :tweet_show
end

get '/t/:username/load' do
  @user = TwitterUser.where(username: params[:username].downcase).first_or_create
  erb :tweet_load
end