class User < ApplicationRecord
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_secure_password

  before_save { self.email = email.downcase }

  has_many :watchlists
  has_many :movies, through: :watchlists

  EMAIL_FORMAT_REGEX = /\A[\w-]+@([\w-]+\.)+[\w-]{2,4}\z/

  validates :username, presence: true, uniqueness: { message: "Username is already taken", case_sensitive: false }
  validates :email, presence: true, format: { with: EMAIL_FORMAT_REGEX, message: "Please enter a valid email format" },
            uniqueness: { case_sensitive: false, message: "Email is already taken" }
  validates :password, presence: true, length: { minimum: 8, message: "Please add password of minimum 8 characters" }

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"])
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # assuming the user model has a name
      user.username = auth.info.name # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.save!
    end
  end
end
