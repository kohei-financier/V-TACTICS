# frozen_string_literal: true

class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
    user.admin? || user == record
  end

  def export?
    user.present? && user.admin?
  end

  def show_in_app?
    user.present? && user.admin?
  end

  def create?
    user.admin?
  end

  def new?
    create?
  end

  def update?
    user.admin? || user == record
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? && user != record
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.none
      end
    end
  end
end
