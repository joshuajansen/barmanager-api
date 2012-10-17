class BarExpansion < ActiveRecord::Base
  attr_accessible :bar_id, :expansion_id

  belongs_to :bar
  belongs_to :expansion

  def revenue
    bar.daily_visitors * expansion.consumption * expansion.revenue
  end

  def profit
    self.revenue.to_f * ( expansion.profit.to_f / 100 )
  end
end
