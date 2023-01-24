class PhotoPolicy < ApplicationPolicy
  def create?
    user.user.present?
  end
end
