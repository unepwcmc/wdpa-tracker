class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :allocations
  belongs_to :role

  validates :role, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
