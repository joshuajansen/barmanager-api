class BarEnlargement < ActiveRecord::Base
  attr_accessible :bar_id, :enlargement_id

  belongs_to :bar
  belongs_to :enlargement

  after_create :charge

  validates :enlargement_id, :presence => true, :uniqueness => {:scope => :bar_id}

  def charge
    BankTransaction.create!(:bar_id => self.bar.id, :user_id => self.bar.user_id, :description => "Geinvesteerd in #{self.enlargement.name}", :amount => -self.enlargement.investment)
  end
end
