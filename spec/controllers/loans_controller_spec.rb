require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  describe '#index' do
    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let!(:loan) { Loan.create!(funded_amount: 100.0) }
    let(:payment) { Payment.create!(amount: 60,paid_on: "11/11/2015",loan_id: loan.id)}

    it 'responds with a 200' do
      expect(payment.amount).to eq(60)
      get :show, id: loan.id
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["outstanding_balance"]).to  eq("40.0")
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, id: 10000
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
