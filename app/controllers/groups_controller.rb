class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy, :join, :quit]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
      flash[:notice]= "你真牛！新增了一个讨论组！"
    else
      render :new
    end
  end

  def update

    if @group.update(group_params)
      redirect_to groups_path
      flash[:notice]= "编辑成功！"
    else
      render :edit
    end
  end

  def destroy

    @group.destroy
    redirect_to groups_path
    flash[:alert] = "删除成功！"
  end

  def join
    @group = Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "成功加入讨论组！"
    else
      flash[:warning] = "你已经是讨论组成员！"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "已退出本讨论组成员！"
    else
      flash[:warning] = "你不是本讨论组成员，怎么退出 xd"
    end

    redirect_to group_path(@group)
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

  def find_group_and_check_permission
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path
      flash[:alert] = "你没有权限，无法操作"
    end
  end


end
