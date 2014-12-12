post "/post" do
  # puts 'ellllooooo'
  # puts params[:tweetbox]
  client.update(params["tweetbox"])
  redirect to ("/benedict_thy")
end