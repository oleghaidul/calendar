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
    can :manage, CalendarColor
  end

  def admin
    can :access, :rails_admin
    can :dashboard
    can :manage, UserCalendar
    can :manage, Period
    can :manage, PaymentNotification
    can :manage, CalendarColor
  end

  def guest
  end

  def member
  end
end
