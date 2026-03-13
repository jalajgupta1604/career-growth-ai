class BadgesController < ApplicationController
  before_action :authenticate_user!

  def index
    @badges = current_user.skill_badges.recent
    @all_badge_types = SkillBadge::BADGE_TYPES
    BadgeService.check_and_award(current_user)
  end
end
