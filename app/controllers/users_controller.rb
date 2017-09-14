class UsersController < ApplicationController
  before_action :require_user, only: [:follow, :unfollow, :metions]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user.username)
    else
      render :new
    end
  end

  def show
    @user = User.find_by username: params[:username]
  end

  def follow
    leader = User.find(params[:id])

    if leader
      leader.followers << current_user
      flash['notice'] = "You have followed #{leader.username}!"
      redirect_to user_path(leader.username)
    else
      wrong_path
    end
  end

  def unfollow
    leader = User.find(params[:id])
    rel = Relationship.where(leader: leader, follower: current_user).first

    if leader && rel
      rel.destroy
      flash['notice'] = "You are no longer following #{leader.username}"
      redirect_to user_path(leader.username)
    else
      wrong_path
    end
  end

  def timeline
    @statuses = []
    current_user.leaders.each do |leader|
      @statuses << leader.statuses
    end
    @statuses.flatten!
    @statuses += current_user.statuses
    @statuses.sort_by! {|status| status.created_at }.reverse!
  end

  def mentions
    current_user.mark_unread_mentions!
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end