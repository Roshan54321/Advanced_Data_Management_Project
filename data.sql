-- ============================================================
-- Synthetic sample data (Darwin, NT scenario)
-- ============================================================

INSERT INTO CUSTOMER (first_name, last_name, date_of_birth, email, phone, street, suburb, state, postcode, employment_status, annual_income) VALUES
('Liam','Anderson','1988-03-14','liam.anderson@example.com','0412 111 222','12 Casuarina Dr','Casuarina','NT','0810','Full-Time',95000),
('Sophie','Baker','1990-07-22','sophie.baker@example.com','0412 222 333','5 Nightcliff Rd','Nightcliff','NT','0810','Full-Time',112000),
('Ethan','Chen','1985-11-02','ethan.chen@example.com','0412 333 444','8 Fannie Bay Cres','Fannie Bay','NT','0820','Self-Employed',145000),
('Olivia','Davies','1993-05-30','olivia.davies@example.com','0412 444 555','21 Palmerston Cir','Palmerston','NT','0830','Part-Time',58000),
('Noah','Evans','1979-09-18','noah.evans@example.com','0412 555 666','3 Larrakeyah St','Larrakeyah','NT','0820','Full-Time',102000),
('Ava','Foster','1996-01-08','ava.foster@example.com','0412 666 777','44 Marrara Dr','Marrara','NT','0812','Casual',48000),
('Jack','Grant','1982-06-25','jack.grant@example.com','0412 777 888','17 Rapid Creek Rd','Rapid Creek','NT','0810','Full-Time',128000),
('Mia','Harris','1991-12-12','mia.harris@example.com','0412 888 999','9 Coconut Grove Rd','Coconut Grove','NT','0810','Self-Employed',89000);

INSERT INTO BROKER (first_name, last_name, license_number, email, phone) VALUES
('Aashish','Sharma','NTFB-1001','aashish.sharma@ntbroking.com.au','0428 100 100'),
('Komal','Poudel','NTFB-1002','komal.poudel@ntbroking.com.au','0428 100 200'),
('Roshan','Neupane','NTFB-1003','roshan.neupane@ntbroking.com.au','0428 100 300'),
('Usha','Lamsal','NTFB-1004','usha.lamsal@ntbroking.com.au','0428 100 400');

INSERT INTO LENDER (lender_name, abn, contact_email, contact_phone) VALUES
('Top End Community Bank','11 222 333 444','lending@topendbank.com.au','1300 111 222'),
('Territory Home Finance','22 333 444 555','loans@territoryhf.com.au','1300 222 333'),
('Northern Mutual Credit Union','33 444 555 666','info@northernmutual.com.au','1300 333 444');

INSERT INTO LOAN_PRODUCT (lender_id, product_name, interest_rate_type, base_interest_rate, max_lvr, min_loan_amount, max_loan_amount) VALUES
(1,'TEB Basic Variable','Variable',6.10,80,50000,1500000),
(1,'TEB Fixed 3yr','Fixed',5.85,80,50000,1500000),
(2,'THF Flexi Home Loan','Variable',6.35,90,50000,2000000),
(2,'THF Investor Fixed','Fixed',6.55,80,80000,2000000),
(3,'NMCU Members Variable','Variable',5.95,85,40000,1200000),
(3,'NMCU First Home Fixed','Fixed',5.75,95,40000,800000);

INSERT INTO PROPERTY (street, suburb, state, postcode, property_type, land_size_sqm, estimated_value) VALUES
('12 Casuarina Dr','Casuarina','NT','0810','Residential',650,620000),
('5 Nightcliff Rd','Nightcliff','NT','0810','Residential',480,545000),
('8 Fannie Bay Cres','Fannie Bay','NT','0820','Residential',900,890000),
('21 Palmerston Cir','Palmerston','NT','0830','Residential',550,410000),
('3 Larrakeyah St','Larrakeyah','NT','0820','Residential',720,715000),
('44 Marrara Dr','Marrara','NT','0812','Residential',500,375000),
('101 Cavenagh St','Darwin City','NT','0800','Commercial',300,980000),
('17 Rapid Creek Rd','Rapid Creek','NT','0810','Residential',600,505000);

INSERT INTO PROPERTY_VALUATION (property_id, valuation_number, valuation_date, valuation_amount, valuer_name, valuation_method) VALUES
(1,1,'2026-01-15',600000,'Darwin Valuations Pty Ltd','Full Inspection'),
(1,2,'2026-06-20',620000,'Darwin Valuations Pty Ltd','Desktop'),
(2,1,'2026-02-10',530000,'NT Property Valuers','Full Inspection'),
(3,1,'2026-01-25',870000,'Top End Valuation Services','Full Inspection'),
(4,1,'2026-03-05',400000,'NT Property Valuers','Kerbside'),
(5,1,'2026-02-18',700000,'Darwin Valuations Pty Ltd','Full Inspection'),
(6,1,'2026-04-01',360000,'NT Property Valuers','Kerbside'),
(7,1,'2026-01-30',950000,'Top End Valuation Services','Full Inspection'),
(8,1,'2026-05-12',495000,'Darwin Valuations Pty Ltd','Full Inspection');

-- PROPERTY_OWNERSHIP: M:N between CUSTOMER and PROPERTY.
-- Demonstrates both directions of the many-to-many: property_id=2 has two
-- joint owners, and customer_id=1 owns two properties (1 and 6).
INSERT INTO PROPERTY_OWNERSHIP (customer_id, property_id, ownership_percentage, ownership_type) VALUES
(1,1,100.00,'Sole'),
(2,2,50.00,'Joint Tenants'),
(3,2,50.00,'Joint Tenants'),
(3,3,100.00,'Sole'),
(4,4,100.00,'Sole'),
(5,5,70.00,'Tenants in Common'),
(6,5,30.00,'Tenants in Common'),
(1,6,100.00,'Sole'),
(7,7,100.00,'Sole'),
(8,8,100.00,'Sole');

INSERT INTO MORTGAGE_APPLICATION (customer_id, broker_id, property_id, product_id, application_date, requested_amount, application_status) VALUES
(1,1,1,1,'2026-02-01',500000,'Approved'),
(2,2,2,3,'2026-02-10',430000,'Approved'),
(3,1,3,4,'2026-02-15',700000,'Approved'),
(4,3,4,6,'2026-03-01',330000,'Approved'),
(5,2,5,2,'2026-03-05',560000,'Approved'),
(6,4,6,5,'2026-03-10',300000,'Rejected'),
(7,1,7,1,'2026-03-15',780000,'Approved'),
(8,3,8,3,'2026-03-20',400000,'Pending'),
(1,1,1,2,'2026-04-01',500000,'Withdrawn'),
(3,2,3,5,'2026-04-05',150000,'Rejected');

INSERT INTO LOAN (application_id, loan_amount, interest_rate, loan_term_years, start_date, loan_status) VALUES
(1,500000,6.10,30,'2026-03-01','Active'),
(2,430000,6.35,30,'2026-03-10','Active'),
(3,700000,6.55,25,'2026-03-15','Active'),
(4,330000,5.75,30,'2026-04-01','Active'),
(5,560000,5.85,20,'2026-04-05','Active'),
(7,780000,6.10,30,'2026-04-15','Active');

-- TRANSACTION_ + subtype rows: one disbursement per loan, then several repayments
INSERT INTO TRANSACTION_ (loan_id, transaction_date, amount, transaction_type, description) VALUES
(1,'2026-03-01',500000,'Disbursement','Initial loan disbursement to settlement agent'),
(2,'2026-03-10',430000,'Disbursement','Initial loan disbursement to settlement agent'),
(3,'2026-03-15',700000,'Disbursement','Initial loan disbursement to settlement agent'),
(4,'2026-04-01',330000,'Disbursement','Initial loan disbursement to settlement agent'),
(5,'2026-04-05',560000,'Disbursement','Initial loan disbursement to settlement agent'),
(6,'2026-04-15',780000,'Disbursement','Initial loan disbursement to settlement agent'),
(1,'2026-04-01',3038.15,'Repayment','Monthly repayment'),
(1,'2026-05-01',3038.15,'Repayment','Monthly repayment'),
(1,'2026-06-01',3038.15,'Repayment','Monthly repayment'),
(2,'2026-04-10',2680.50,'Repayment','Monthly repayment'),
(2,'2026-05-10',2680.50,'Repayment','Monthly repayment'),
(3,'2026-04-15',4820.90,'Repayment','Monthly repayment'),
(3,'2026-05-15',4820.90,'Repayment','Monthly repayment'),
(4,'2026-05-01',1928.40,'Repayment','Monthly repayment'),
(5,'2026-05-05',3980.70,'Repayment','Monthly repayment'),
(5,'2026-06-05',3980.70,'Repayment','Monthly repayment'),
(6,'2026-05-15',4735.20,'Repayment','Monthly repayment'),
(6,'2026-06-15',4735.20,'Repayment','Monthly repayment');

INSERT INTO DISBURSEMENT (transaction_id, disbursement_method, purpose_description) VALUES
(1,'EFT','Property settlement funds transfer'),
(2,'EFT','Property settlement funds transfer'),
(3,'Bank Cheque','Property settlement funds transfer'),
(4,'EFT','Property settlement funds transfer'),
(5,'EFT','Property settlement funds transfer'),
(6,'EFT','Property settlement funds transfer');

INSERT INTO REPAYMENT (transaction_id, principal_portion, interest_portion, payment_method) VALUES
(7,540.32,2497.83,'Direct Debit'),
(8,543.06,2495.09,'Direct Debit'),
(9,545.82,2492.33,'Direct Debit'),
(10,401.10,2279.40,'Direct Debit'),
(11,403.25,2277.25,'Direct Debit'),
(12,780.44,4040.46,'BPAY'),
(13,784.68,4036.22,'BPAY'),
(14,384.55,1543.85,'Direct Debit'),
(15,1076.90,2903.80,'Direct Debit'),
(16,1082.24,2898.46,'Direct Debit'),
(17,861.35,3873.85,'Direct Debit'),
(18,865.75,3869.45,'Direct Debit');
