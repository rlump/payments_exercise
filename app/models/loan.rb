class Loan < ActiveRecord::Base
  has_many :payments, dependent: :destroy

  def outstanding_balance
    funded_amount - payments.sum(:amount)
  end

end
