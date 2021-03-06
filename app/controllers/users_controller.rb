class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  #elofelteltel az updatehez
  before_filter :correct_user, :only => [:edit, :update]
  #elofeltetel az admin torlesi jogához
  before_filter :admin_user,   :only => :destroy


  
  #ez a kiindexelés
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      # Handle a successful save.
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  #profile edit
  def edit
    @title = "Edit user"
  end
  
  #update gomb
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def printout
    @title = "printout"
    @users = User.paginate(:page => params[:page])
  end


  
  private
    def authenticate 
      deny_acces unless signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

     


end
