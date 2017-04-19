class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :matches


  def name
    "#{first_name} #{last_name}"
  end

  def todays_match
    matches.find{|hash| hash[:date] === Date.today}
  end

  def past_matches
    matches.select{|hash| hash[:date] < Date.today}
  end
end
