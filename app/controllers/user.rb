get '/signin' do
  # After hitting Sign in link, first thing your app must do
  # is to get a request token.
  # See https://dev.twitter.com/docs/auth/implementing-sign-twitter (Step 1)
  token = TwitterSignIn.request_token

  # With request token in hands, you will just redirect
  # the user to authenticate at Twitter
  # See https://dev.twitter.com/docs/auth/implementing-sign-twitter (Step 2)
  redirect TwitterSignIn.authenticate_url(token)
end