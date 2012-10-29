class BarFeature < ActiveRecord::Base
  attr_accessible :bar_id, :feature_id

  belongs_to :bar
  belongs_to :feature
  after_create :charge

  def charge
    BankTransaction.create!(:bar_id => self.bar.id, :user_id => self.bar.user_id, :description => "Geinvesteerd in #{self.feature.name}", :amount => -self.feature.investment)
  end

  def active
    expires_on = self.created_at + self.feature.duration.day

    if Time.now < expires_on
      return true
    else
      return false
    end
  end

end
