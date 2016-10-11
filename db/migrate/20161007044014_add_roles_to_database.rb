class AddRolesToDatabase < ActiveRecord::Migration
  def change
    Role.constant_role_names.each do |role|
      capitalized_name = (role.to_s.split("_") - ["ROLE"]).map(&:capitalize).join(" ")
      binding.pry
      Role.create(name: capitalized_name, priority: "Role::#{role.to_s}".constantize)
    end
  end
end
