class UsersController < ApplicationController
    def create
        @user = User.new(user_params)

        if @user.save and @user
            render template: "users/create", formats: :json
        else
            render json: {
                success: false
            }
        end 
    end

    private

        def user_params
            params.require(:user).permit(:username, :email, :password)
        end
end
