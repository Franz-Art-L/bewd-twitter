class TweetsController < ApplicationController
    def create
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)

        if session
            user = session.user
            @tweet = user.tweets.new(tweet_params)
            
            if @tweet.save
                render template: 'tweets/create', formats: :json
            else
                render json: { success: false }
            end
            else
                render json: { success: false }
        end
    end

    def destroy
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)

        if session
            user = session.user
            tweet = user.tweets.find_by(id: params[:id])
            
            if tweet.destroy
                render json: { success: true }
            else
                render json: { success: false }
            end
        else
            render json: { success: false }
        end
    end

    def index
        @tweets = Tweet.all.order('id DESC')
        render template: "tweets/index", formats: :json
    end

    def index_by_user
       user = User.find_by(username: params[:username])

       if user
        @tweets = user.tweets
        render template: "tweets/index", formats: :json
       else
        render json: { success: false }
       end
    end

    private
        def tweet_params
            params.require(:tweet).permit(:message)
        end
end
