class CoursePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || (user.instructor? && record.instructor_id == user.id) || record.published?
  end

  def create?
    user.admin? || user.instructor?
  end

  def update?
    user.admin? || (user.instructor? && record.instructor_id == user.id)
  end

  def destroy?
    user.admin? || (user.instructor? && record.instructor_id == user.id)
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.instructor?
        scope.where(instructor_id: user.id)
      else
        scope.where(published: true)
      end
    end
  end
end
