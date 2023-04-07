class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # enum role: %i[free basic premium]
  # after_initialize :set_default_role, :if => :new_record?
  # def set_default_role
  #   self.role ||= :free
  # end
  enum role: %i[client author admin]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :client
  end
end
