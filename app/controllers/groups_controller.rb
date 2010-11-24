class GroupsController < ApplicationController

 before_filter :authenticate_user!
 before_filter :member?, :only => :show
 before_filter :admin?, :only => [:destroy, :edit]
 
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @owner = User.find_by_id(@group.owner_id)
    @requests = @group.membership_requests
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end


  def create
    @group = Group.new(params[:group])
    @group.owner_id = current_user.id
    @group.users << current_user
      if @group.save
        @group_admin = @group.group_admins.build(:user_id => current_user.id)
        @group_admin.save
        redirect_to(@group, :notice => 'Group was successfully created.')
      else
        render :action => "new"
      end
  end


  def update
    @group = Group.find(params[:id])
    respond_to do |format|
      if @group.update_attributes(params[:group])
       redirect_to(@group, :notice => 'Group was successfully updated.')
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to(groups_url)
  end
  
  def apply_to_group
    @group = Group.find(params[:id])
    Membership_request.create(:user_id => current_user.id, :group_id => @group.id)
    redirect_to groups_path
  end
  
 protected
  
  def member?
    @group = Group.find(params[:id])
    if !@group.users.include?(current_user) then
      redirect_to(groups_url :notice => 'You are not a member of this group.')
    end
  end
  
  def admin?
    @group = Group.find(params[:id])
    if !current_user.group_admins.find_by_group_id(@group.id) then
      redirect_to(groups_url :notice => 'You are not a admin of this group.')
    end
  end
  
end 
