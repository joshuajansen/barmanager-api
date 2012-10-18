class BankTransaction < ActiveRecord::Base
  attr_accessible :amount, :bar_id, :description, :user_id
  default_scope :order => "bank_transactions.created_at ASC"

  belongs_to :user
  belongs_to :bar

  def bar_name
    bar = self.bar
    unless bar.nil?
      bar.name
    else
      "-"
    end
  end
end
