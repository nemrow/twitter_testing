class User < ActiveRecord::Base
  has_many :tweets
  def tweet(status)
    tweet = tweets.create!(:tweet => status)
    # job = TweetWorker.perform_async(tweet.id)
    job = TweetWorker.perform_in(50.seconds, tweet.id)
    job.inspect
  end
end
