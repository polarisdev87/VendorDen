class User < ApplicationRecord

  ADMIN_ROLE = 'Admin'
  VENDOR_ROLE = 'Vendor'
  ROLES = [
    ADMIN_ROLE,
    VENDOR_ROLE
  ]

  #--------------------------------------------------------------------
  # Modules Included
  #--------------------------------------------------------------------
  devise :database_authenticatable,
         :recoverable, 
         :rememberable, 
         :confirmable,
         :trackable

  #--------------------------------------------------------------------
  # Associations
  #--------------------------------------------------------------------
  belongs_to :shop
  has_one    :vendor

  #--------------------------------------------------------------------
  # Validations
  #--------------------------------------------------------------------  
  validates :email, presence: true, 
                    format: { with: URI::MailTo::EMAIL_REGEXP }, 
                    uniqueness: {scope: 'shop_id'}
  validates :role, presence: true, inclusion: { in: ROLES }
  validates :password, presence: true, 
                       length: { minimum: 8 },
                       confirmation: true, 
                       if: :validate_password?

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------  

  def is_role_vendor?
    self.role == VENDOR_ROLE
  end

  def is_role_admin?
    self.role == ADMIN_ROLE
  end

  def has_no_password?
    self.password.blank?
  end

  def validate_password!
    @validate_password = true
  end

  private 

    def validate_password?
      @validate_password
    end
end
