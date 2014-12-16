enable  :sessions

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

    client = Twitter::REST::Client.new do |c|
      c.consumer_key        = CONSUMER_KEY
      c.consumer_secret     = CONSUMER_SECRET
      c.access_token        = access_token.token
      c.access_token_secret = access_token.secret
    end

    client.update("Hi Rizal C.S.yaml")
    @sometext = "ello"
    erb :callback
  end

end