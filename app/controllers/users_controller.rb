class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :show, :create]
  before_action :load_user, except: [:create, :new, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.activated.paginate page: params[:page],
      per_page: Settings.perpage
  end

  def show
    @microposts = @user.microposts.news_feed.paginate(page: params[:page],
      per_page: 6)
    return if @user.activated?
    flash[:danger] = t "controllers.users.user_not_active"
    redirect_to root_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t "controllers.users.check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t "controllers.users.success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controllers.users.destroy_success"
    else
      flash[:warning] = t "controllers.users.destroy_fail"
    end
    redirect_to request.referrer
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = t "controllers.users.findfail", id: params[:id]
    redirect_to root_path
  end

  def admin_user
    return if current_user.admin?
    flash[:danger] = t "controllers.users.not_delete"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

  def correct_user
    return edit if @user == current_user
    flash[:danger] = t "controllers.users.can_not"
    redirect_to root_path
  end
end
