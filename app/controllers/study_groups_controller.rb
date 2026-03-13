class StudyGroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = StudyGroup.recent.includes(:creator, :study_group_memberships).limit(30)
    @my_groups = current_user.study_group_memberships.includes(study_group: :creator)
  end

  def show
    @group = StudyGroup.find(params[:id])
    @members = @group.study_group_memberships.includes(:user)
    @is_member = @group.member?(current_user)
  end

  def create
    @group = StudyGroup.new(group_params)
    @group.creator = current_user
    if @group.save
      @group.study_group_memberships.create!(user: current_user, role: "admin")
      redirect_to study_group_path(@group), notice: "Study group created!"
    else
      redirect_to study_groups_path, alert: @group.errors.full_messages.join(", ")
    end
  end

  def join
    @group = StudyGroup.find(params[:id])
    if @group.full?
      redirect_to study_group_path(@group), alert: "This group is full."
    elsif @group.member?(current_user)
      redirect_to study_group_path(@group), alert: "You're already a member."
    else
      @group.study_group_memberships.create!(user: current_user, role: "member")
      redirect_to study_group_path(@group), notice: "Joined the group!"
    end
  end

  def leave
    @group = StudyGroup.find(params[:id])
    membership = @group.study_group_memberships.find_by(user: current_user)
    if membership
      membership.destroy!
      redirect_to study_groups_path, notice: "Left the group."
    else
      redirect_to study_groups_path, alert: "You're not a member."
    end
  end

  private

  def group_params
    params.require(:study_group).permit(:name, :description, :target_company, :target_role, :max_members)
  end
end
