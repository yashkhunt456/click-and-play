# class BoxPolicy < ApplicationPolicy
#   def create?
#     user.has_role?(:boxhouse) && record.boxhouse.user == user
#   end

#   def new?
#     create?  # If the user can create, they can also create a new box
#   end

#   def update?
#     user.has_role?(:boxhouse) && record.boxhouse.user == user
#   end

#   def destroy?
#     user.has_role?(:boxhouse) && record.boxhouse.user == user
#   end
# end

