class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read,
        if user.admin?
          can :manage, :all
        else
          can %i[update create destroy], Recipe, user_id: user.id
        end
  end
end
