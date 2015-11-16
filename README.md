# Payments Exercise

Add in the ability to create payments for a given loan using a JSON API call. You should store the payment date and amount. Expose the outstanding balance for a given loan in the JSON vended for `LoansController#show` and `LoansController#index`. The outstanding balance should be calculated as the `funded_amount` minus all of the payment amounts.

A payment should not be able to be created that exceeds the outstanding balance of a loan. You should return validation errors if a payment can not be created. Expose endpoints for seeing all payments for a given loan as well as seeing an individual payment.


Create a payment for a loan with id 1:

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d '{"payment": {"amount" : "48", "paid_on" : "2015-08-28"}}' http://localhost:3000/loans/1/payments

Create another payment for a loan with id 1:

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d '{"payment": {"amount" : "20", "paid_on" : "2015-08-28"}}' http://localhost:3000/loans/1/payments

Attempt invalid payment (overdraft) and get error:

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d '{"payment": {"amount" : "35", "paid_on" : "2015-08-28"}}' http://localhost:3000/loans/1/payments

Show payment for loan id 1 and payment id 1:

curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://localhost:3000/loans/1/payments/1

Index payments for loan id 1;

curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://localhost:3000/loans/1/payments

Show loan with id 1 and it's outstanding balance:

curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://localhost:3000/loans/1

Index all loans and their outstanding balances:

curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://localhost:3000/loans






