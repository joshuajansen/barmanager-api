class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :provider, :uid, :balance

  has_many :bars
  has_many :bank_transactions

  after_create :add_own_money

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)  
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    
    unless user
      user = User.create(
          name: auth.extra.raw_info.name,
          provider: auth.provider,
          uid: auth.uid,
          email: auth.info.email,
          password: Devise.friendly_token[0,20]
        )
    end

    user
  end

  def update_balance
    self.balance = bank_transactions.sum(&:amount).to_f
    self.save!
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def add_own_money
    BankTransaction.create!(:amount => 1000, :description => "Eigen vermogen ingebracht.", :user_id => self.id)
  end
end
