require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#index' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :index, {:loan_id => loan.id}
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    let(:payment) { Payment.create!(amount: 60,paid_on: "11/11/2015",loan_id: loan.id)}

    it 'responds with a 200' do
      get :show, loan_id: loan.id, id: payment.id
      expect(response).to have_http_status(:ok)
      expect(loan.outstanding_balance).to eq(40)
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, loan_id: loan.id, id: 10000
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    context 'if payment is valid' do
      it 'responds with a 200' do
        expect{
          post :create, {:loan_id => loan.id, :payment => {:amount => 60} }
        }.to change(Payment,:count).by(1)
        expect(loan.outstanding_balance).to eq(40)
        expect(response).to have_http_status(:ok)
        expect{
          post :create, {:loan_id => loan.id, :payment => {:amount => 20} }
        }.to change(Payment,:count).by(1)
        expect(loan.outstanding_balance).to eq(20)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'if payment is invalid' do
      it 'responds with a 422' do
        post :create, {:loan_id => loan.id, :payment => {:amount => 101} }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end

end
