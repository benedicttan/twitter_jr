set :protection, except: :session_hijacking

get '/oauth/request_token' do
  callback_url = "http://codedivben.ngrok.com/callback"

  consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, :site => "https://api.twitter.com")
  puts CONSUMER_KEY
  puts CONSUMER_SECRET
  session[:consumer] = consumer if consumer
  request_token = consumer.get_request_token(:oauth_callback => callback_url)
  session[:request_token] = request_token.token
  session[:request_token_secret] = request_token.secret
  redirect to request_token.authorize_url
end

get '/callback' do
  token = params[:oauth_token]
  verifier = params[:oauth_verifier]

  if token
    request_token = OAuth::RequestToken.new(session[:consumer],session[:request_token], session[:request_token_secret])
    access_token =  request_token.get_access_token(oauth_verifier: verifier)

    new_user = User.where(access_token: access_token.token, access_token_secret: access_token.secret).first_or_create

    new_user.client(access_token.token, access_token.secret)

    session[:user_id] = new_user.id
    @screen_name = new_user.twitter_client.user.screen_name
    erb :main
  end

end

get '/status/:job_id' do
  # return the status of a job to an AJAX call
  # jid = params[:job_id]
  # if job_is_complete(jid)
  #   erb :somethinghere
  # end
end