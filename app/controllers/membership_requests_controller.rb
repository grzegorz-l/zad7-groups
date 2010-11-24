class MembershipRequestsController < ApplicationController
  def create
    @group = Group.find_by_id(params[:group_id])
    @request = @group.membership_requests.build(:user_id => current_user.id)
    @request.save
    redirect_to groups_path
  end

  def accept
    @group = Group.find_by_id(params[:group_id])
    @request = @group.membership_requests.find(params[:id])
    @request.accepted = true
    @request.save
    @group.users << User.find_by_id(@request.user_id)
    redirect_to group_path(params[:group_id])
  end

end