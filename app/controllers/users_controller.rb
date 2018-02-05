class UsersController < ApplicationController
  before_action :set_user , only: [:tweets,:edit,:update,:followings, :followers]
  def tweets
    @tweets = @user.tweets.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "資料更新成功"
      redirect_to tweets_user_path(@user)
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :edit
    end

  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.liked_tweets
  end

  private 

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,:introduction,:avatar)
  end
end
