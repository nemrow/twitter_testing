get '/' do
  @timeline = Twitter.user_timeline("nemrow")
  erb :index
end

post '/tweet' do
	if Twitter.update(params[:tweet])
		@timeline = Twitter.user_timeline("nemrow")
		erb :_tweet_list, :layout => false
	else
		erb :error_page
	end
end
