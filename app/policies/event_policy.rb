class EventPolicy < ApplicationPolicy
  def create?
    user.user.present?
  end

  def destroy?
    update?
  end

  def edit?
    update?
  end

  def show?
    return true if user_is_owner? || !record.pincode.present?
    correct_pincode?
  end

  def update?
    user_is_owner?
  end

  private

  def correct_pincode?
    if user.params[:pincode].present? && record.pincode_valid?(user.params[:pincode])
      user.params[:cookies].permanent["events_#{record.id}_pincode"] = user.params[:pincode]
    end

    record.pincode_valid?(user.params[:cookies].permanent["events_#{record.id}_pincode"])
  end

  def user_is_owner?
    user.user.present? && (record.try(:user) == user.user)
  end
end
