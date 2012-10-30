class BankTransaction < ActiveRecord::Base
  attr_accessible :amount, :bar_id, :description, :user_id
  default_scope :order => "bank_transactions.created_at DESC"

  belongs_to :user
  belongs_to :bar

  after_save :update_balance

  def update_balance
    self.user.update_balance
  end

  def bar_name
    bar = self.bar
    unless bar.nil?
      bar.name
    else
      "-"
    end
  end
end
