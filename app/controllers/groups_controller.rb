class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path
      flash[:alert] = "你没有权限，无法操作！"
    end
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      redirect_to groups_path
      flash[:notice]= "你真牛！新增了一个讨论组！"
    else
      render :new
    end
  end

  def update
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path
      flash[:alert] = "你没有权限，无法操作！"
    end

    if @group.update(group_params)
      redirect_to groups_path
      flash[:notice]= "编辑成功！"
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path
      flash[:alert] = "你没有权限，无法操作！"

    @group.destroy
    redirect_to groups_path
    flash[:alert] = "删除成功！"
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

end
