class SlotPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present? && record.box.boxhouse.user == user  # Only the boxhouse owner can create slots
  end

  def update?
    user.present? && record.box.boxhouse.user == user  # Only the boxhouse owner can edit slots
  end

  def destroy?
    user.present? && record.box.boxhouse.user == user  # Only the boxhouse owner can delete slots
  end
end
