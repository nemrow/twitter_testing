get '/' do
	if session[:user_id]
		@user = User.find(session[:user_id])
		@timeline = Twitter.user_timeline(@user.screen_name)
	else

	end
	erb :index
end

post '/tweet' do
	if session[:user_id]
		@user = User.find(session[:user_id])
		twitter_client = Twitter::Client.new(
		  :oauth_token => @user.access_token,
		  :oauth_token_secret => @user.access_secret
		)
		Thread.new{twitter_client.update(params[:tweet])}
		@timeline = Twitter.user_timeline(@user.screen_name)
	else
		# erb :error_page
	end
	erb :_tweet_list
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  @access_token = access_token
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  puts access_token.params["screen_name"]
  user = User.create(:access_token => access_token.token,
  						:access_secret => access_token.secret,
  						:user_id => access_token.params['user_id'],
  						:screen_name => access_token.params['screen_name']
  						)
  session[:user_id] = user.id
  # at this point in the code is where you'll need to create your user account and store the access token
  redirect to '/'
  
end

