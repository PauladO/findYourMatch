class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :matches

  validates :first_name, presence: true
  validates :last_name, presence: true



  def name
    "#{first_name} #{last_name}"
  end

  def todays_match
    matches.find{|hash| hash[:date] === Date.today}
  end

  def past_matches
    matches.select{|hash| hash[:date] < Date.today}
  end

  def self.toggle_admin(id)
    selected_user = User.find(id)
    admin_status = !selected_user.admin
    selected_user.update(admin: admin_status)
  end
end
