class Payment < ActiveRecord::Base
  belongs_to :loan
  validates_presence_of :loan, :message => "loan does not exist"
  validate :payment_cannot_exceed_outstanding_baclance

  def payment_cannot_exceed_outstanding_baclance
    errors.add(:amount, "payment would result in a negative outstanding balance") if
      loan and (0 > loan.outstanding_balance - amount)
  end

end
