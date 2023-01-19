class SubscriptionPolicy < ApplicationPolicy
  def create?
    !user_is_owner? && !user_subscribed?
  end

  def destroy?
    user_is_owner? || user_is_subscriber?
  end

  private

  def user_is_owner?
    user.user.present? && (record.try(:event).user == user.user)
  end

  def user_is_subscriber?
    user.user.present? && (record.try(:user) == user.user)
  end

  def user_subscribed?
    user.user.present? && user.user.subscriptions.find_by(event_id: record.try(:event).id).present?
  end
end
