class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new 

    if user.has_role :admin
        can :mange, :all
    elsif user.has_role :commenter
        can :read, :all
    else 
        can :read, :all
    end
  end
end
