class BarExpansion < ActiveRecord::Base
  attr_accessible :bar_id, :expansion_id

  belongs_to :bar
  belongs_to :expansion


  def amount
    bar.daily_visitors * expansion.consumption
  end

  def revenue
    self.amount * expansion.revenue
  end

  def profit
    self.revenue.to_f * ( expansion.profit.to_f / 100 )
  end
end
