# class BookingPolicy < ApplicationPolicy
#   class Scope < Scope
#     def resolve
#       if user.has_role?(:admin)
#         scope.all # Admin can see all bookings
#       elsif user.has_role?(:boxhouse)
#         scope.joins(:box).where(boxes: { boxhouse_id: user.boxhouses.ids }) # Boxhouse owner can see bookings in their Boxhouse
#       elsif user.has_role?(:player)
#         scope.where(user: user) # Players can see only their own bookings
#       else
#         scope.none # If the user has no relevant role, show nothing
#       end
#     end
#   end

#   def index?
#     user.has_role?(:admin) || user.has_role?(:boxhouse) || user.has_role?(:player)
#   end

#   def show?
#     # Admin can see all bookings
#     return true if user.has_role?(:admin)

#     # Boxhouse owner can see bookings for their box
#     if user.has_role?(:boxhouse)
#       return true if record.box.boxhouse.user == user
#     end

#     # Player can only see their own bookings
#     record.user == user
#   end

#   def create?
#     # Only players can create a booking
#     user.has_role?(:player)
#   end

#   def update?
#     # Cannot update a confirmed booking
#     return false if record.status == "Confirmed"

#     # Admin can update any booking
#     return true if user.has_role?(:admin)

#     # Boxhouse owner can update bookings in their boxhouse
#     if user.has_role?(:boxhouse) && record.box.boxhouse.user == user
#       return true
#     end

#     # Player can update their own bookings
#     record.user == user
#   end

#   def destroy?
#     # Admin can delete any booking
#     return true if user.has_role?(:admin)

#     # Boxhouse owner can delete any booking for their box
#     if user.has_role?(:boxhouse) && record.box.boxhouse.user == user
#       return true
#     end

#     # Player can delete their own booking
#     record.user == user
#   end
# end
