class PaymentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    loan = Loan.find(params["loan_id"])
    render json: loan.payments.all, methods: :outstanding_balance
  end

  def create
    payment = Payment.new(payment_params)
    payment.loan_id = params["loan_id"]
    if payment.save
      render json: payment
    else
      render json: payment.errors, status: :unprocessable_entity
    end
  end

  private
    def payment_params
      params.require(:payment).permit(:amount, :paid_on)
    end

end
