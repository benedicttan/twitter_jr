post "/post" do
  # puts 'ellllooooo'
  # puts params[:tweetbox]
  client.update(params["tweetbox"])
  redirect to ("/t/benedict_thy")
end