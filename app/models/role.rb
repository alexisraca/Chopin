class Role < ActiveRecord::Base
  # Actual role numbers
  MASTER_ROLE = 800
  ADMIN_ROLE  = 900
  SELLER_ROLE = 1000

  ROLES = [MASTER_ROLE, ADMIN_ROLE, SELLER_ROLE] # validations
  validates :name, :priority, presence: true

  has_many :users

  def is_dist?
    is_distributor?
  end

  def is_master?
    has_role(MASTER_ROLE) || is_super_master?
  end

  def to_i
    self.priority
  end

  def ==(integer_role)
    self.to_i == integer_role
  end

  def <=(object)
    compare_error(object)
    self.to_i <= object.to_i
  end

  def >(object)
    compare_error(object)
    self.to_i > object.to_i
  end

  def compare_error(object)
    raise ArgumentError.
      new('comparison with role failed') unless object.respond_to? :to_i
  end

  def self.common_admin_roles
    where(priority: [ADMIN_ROLE])
  end

  def self.all_admin_roles
    where(priority: [ADMIN_ROLE, MASTER_ROLE])
  end

  def self.all_non_admin_roles
    where(priority: [SELLER_ROLE])
  end

  def self.assignable_roles
    where(priority: [ADMIN_ROLE, SELLER_ROLE])
  end

  ###########
  private
  ###########


  def constantized constant_name
    "#{self.class.name}::#{constant_name}".constantize
  end

  class << self
    def generate_is_method_name constant_name
      "is_#{constant_name.to_s.downcase.gsub('_role', '')}?"
    end

    def constant_role_names
      constants.select { |constant| constant.to_s.end_with?('_ROLE')  }
    end

    def instance_method_defined? method_name_as_string
      instance_methods.include?(method_name_as_string.to_sym)
    end

    # This method define instance methods for Role  with the
    # is_role? syntax
    #
    #   e.g. 
    #
    #   role = Role.new
    #
    #   role.is_master?
    #   role.is_sales_rep?
    #
    #   etc.
    #
    def define_is_role_methods
      constant_role_names.each do |constant_name|
        method_name = generate_is_method_name(constant_name)
        next if instance_method_defined?(method_name)
        define_method(method_name) do
          has_role( constantized(constant_name) )
        end
      end
    end

    # define methods to obtain intances of each of the defined roles
    #   e.g.
    #
    #     OleCore::Role.master  => retrieve the master role object
    #
    Role.constant_role_names.each do |constant_name|
      method_name = constant_name.to_s.downcase.gsub('_role', '')
      define_method(method_name) do
        find_by_priority(  "#{name}::#{constant_name}".constantize )
      end
    end
  end # class

  #########################
  # call to define is_role? methods when class loads
  define_is_role_methods
  #########################

  def has_role(role)
    self.priority == role
  end
end
