module FeedbacksHelper
    def feedback_belongs_to_user?(feedback)
        feedback.booking.user == current_user || feedback.booking.box.boxhouse.user == current_user
    end
end
