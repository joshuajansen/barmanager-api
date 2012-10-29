class SellsController < ApplicationController

  def index
    @bars = Bar.all
  end

  def process_sells
    Bar.all.each do |bar|
      
      profit = 0
      sells_made = 0

      bar.bar_expansions.each do |bar_expansion|
        if Sell.find_by_bar_expansion_id_and_date(bar_expansion.id, Date.yesterday).nil?
          sells_made += 1
          sell = Sell.new()
          sell.bar_expansion = bar_expansion
          sell.amount = bar_expansion.amount.round(0)
          sell.revenue = bar_expansion.revenue
          sell.profit = bar_expansion.profit
          sell.date = Date.yesterday
          if sell.save
            profit += sell.profit
          end
        end
      end

      if sells_made > 0
        BankTransaction.create!( :user_id => bar.user_id, :bar_id => bar.id, :description => "Resultaat voor bar #{bar.name}", :amount => profit )
      end
    end

    render :text => "Verwerkt"
  end

end
