class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    if @user
      send(@user.role.presence || :member)
    else
      guest
    end
  end

  def user
    can :manage, UserCalendar, user_id: @user.id
    can :manage, Period
  end

  def guest
  end

  def member
  end
end
