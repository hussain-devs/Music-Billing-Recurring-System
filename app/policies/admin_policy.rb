class AdminPolicy < ApplicationPolicy
  def show?
    puts "PUNDIT USER: #{user.inspect}"
    user&.admin? || false
  end
end
