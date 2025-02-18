class BoxhousePolicy < ApplicationPolicy
  def index?
    true  # Anyone can view boxhouses
  end

  def show?
    true  # Anyone can view a single boxhouse
  end

  def new?
    true
  end

  def create?
    true
  end

  def update?
    user.present? && user.has_role?(:boxhouse) && record.user == user
  end

  def destroy?
    user.present? && (user.has_role?(:admin) || (user.has_role?(:boxhouse) && record.user == user))  
    # Admins can delete any boxhouse
    # Boxhouse users can only delete their own boxhouse
  end
end
