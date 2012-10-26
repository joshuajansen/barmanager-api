class Api::BankTransactionsController < Api::ApiController

  def index
    transactions = {}
    transactions[:user] = current_user
    transactions[:bank_transactions] = current_user.bank_transactions

    respond_to do |format|
      format.json { render json: transactions.to_json }
      format.xml { render xml: transactions.to_xml }
    end
  end

end