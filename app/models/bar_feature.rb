class BarFeature < ActiveRecord::Base
  attr_accessible :bar_id, :feature_id

  belongs_to :bar
  belongs_to :feature

  def active
    expires_on = self.created_at + self.feature.duration.day - 1.day

    if Time.now < expires_on
      return true
    else
      return false
    end
  end

end
