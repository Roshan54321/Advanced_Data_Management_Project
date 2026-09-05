-- ============================================================
-- PRT563 Assessment 2 - Relational Database Implementation
-- Domain: Property Finance / Mortgage Brokering (Darwin, NT)
-- Group: Danala Group 16
-- ============================================================

PRAGMA foreign_keys = ON;

-- ------------------------------------------------------------
-- CUSTOMER
-- ------------------------------------------------------------
CREATE TABLE CUSTOMER (
    customer_id         INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name          TEXT NOT NULL,
    last_name           TEXT NOT NULL,
    date_of_birth       DATE NOT NULL,
    email               TEXT NOT NULL UNIQUE,
    phone               TEXT NOT NULL,
    street              TEXT NOT NULL,
    suburb              TEXT NOT NULL,
    state               TEXT NOT NULL,
    postcode            TEXT NOT NULL,
    employment_status   TEXT NOT NULL CHECK (employment_status IN ('Full-Time','Part-Time','Self-Employed','Casual','Unemployed')),
    annual_income       DECIMAL(12,2) CHECK (annual_income >= 0)
);

-- ------------------------------------------------------------
-- BROKER
-- ------------------------------------------------------------
CREATE TABLE BROKER (
    broker_id           INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name          TEXT NOT NULL,
    last_name           TEXT NOT NULL,
    license_number      TEXT NOT NULL UNIQUE,
    email               TEXT NOT NULL UNIQUE,
    phone               TEXT NOT NULL
);

-- ------------------------------------------------------------
-- LENDER
-- ------------------------------------------------------------
CREATE TABLE LENDER (
    lender_id           INTEGER PRIMARY KEY AUTOINCREMENT,
    lender_name         TEXT NOT NULL,
    abn                 TEXT NOT NULL UNIQUE,
    contact_email       TEXT NOT NULL,
    contact_phone       TEXT NOT NULL
);

-- ------------------------------------------------------------
-- LOAN_PRODUCT (N:1 with LENDER)
-- ------------------------------------------------------------
CREATE TABLE LOAN_PRODUCT (
    product_id          INTEGER PRIMARY KEY AUTOINCREMENT,
    lender_id           INTEGER NOT NULL,
    product_name        TEXT NOT NULL,
    interest_rate_type  TEXT NOT NULL CHECK (interest_rate_type IN ('Fixed','Variable')),
    base_interest_rate  DECIMAL(5,2) NOT NULL CHECK (base_interest_rate > 0),
    max_lvr             DECIMAL(5,2) NOT NULL,
    min_loan_amount     DECIMAL(12,2) NOT NULL,
    max_loan_amount     DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (lender_id) REFERENCES LENDER(lender_id)
);

-- ------------------------------------------------------------
-- PROPERTY
-- ------------------------------------------------------------
CREATE TABLE PROPERTY (
    property_id         INTEGER PRIMARY KEY AUTOINCREMENT,
    street              TEXT NOT NULL,
    suburb              TEXT NOT NULL,
    state               TEXT NOT NULL,
    postcode            TEXT NOT NULL,
    property_type       TEXT NOT NULL CHECK (property_type IN ('Residential','Commercial')),
    land_size_sqm       DECIMAL(10,2),
    estimated_value     DECIMAL(12,2) NOT NULL CHECK (estimated_value > 0)
);

-- ------------------------------------------------------------
-- PROPERTY_VALUATION (WEAK ENTITY, owned by PROPERTY)
-- Partial key = valuation_number; identifying owner = property_id
-- ------------------------------------------------------------
CREATE TABLE PROPERTY_VALUATION (
    property_id         INTEGER NOT NULL,
    valuation_number     INTEGER NOT NULL,
    valuation_date       DATE NOT NULL,
    valuation_amount     DECIMAL(12,2) NOT NULL CHECK (valuation_amount > 0),
    valuer_name          TEXT NOT NULL,
    valuation_method     TEXT NOT NULL CHECK (valuation_method IN ('Kerbside','Full Inspection','Desktop')),
    PRIMARY KEY (property_id, valuation_number),
    FOREIGN KEY (property_id) REFERENCES PROPERTY(property_id) ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- MORTGAGE_APPLICATION
-- ------------------------------------------------------------
CREATE TABLE MORTGAGE_APPLICATION (
    application_id       INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id          INTEGER NOT NULL,
    broker_id            INTEGER NOT NULL,
    property_id          INTEGER NOT NULL,
    product_id           INTEGER NOT NULL,
    application_date     DATE NOT NULL,
    requested_amount     DECIMAL(12,2) NOT NULL CHECK (requested_amount > 0),
    application_status   TEXT NOT NULL CHECK (application_status IN ('Pending','Approved','Rejected','Withdrawn')),
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id),
    FOREIGN KEY (broker_id) REFERENCES BROKER(broker_id),
    FOREIGN KEY (property_id) REFERENCES PROPERTY(property_id),
    FOREIGN KEY (product_id) REFERENCES LOAN_PRODUCT(product_id)
);

-- ------------------------------------------------------------
-- LOAN (1:1 with an APPROVED MORTGAGE_APPLICATION)
-- ------------------------------------------------------------
CREATE TABLE LOAN (
    loan_id              INTEGER PRIMARY KEY AUTOINCREMENT,
    application_id       INTEGER NOT NULL UNIQUE,
    loan_amount          DECIMAL(12,2) NOT NULL CHECK (loan_amount > 0),
    interest_rate        DECIMAL(5,2) NOT NULL CHECK (interest_rate > 0),
    loan_term_years      INTEGER NOT NULL CHECK (loan_term_years > 0),
    start_date           DATE NOT NULL,
    loan_status          TEXT NOT NULL CHECK (loan_status IN ('Active','Closed','Default')),
    FOREIGN KEY (application_id) REFERENCES MORTGAGE_APPLICATION(application_id)
);

-- ------------------------------------------------------------
-- TRANSACTION (superclass / EER specialization root)
-- ------------------------------------------------------------
CREATE TABLE TRANSACTION_ (
    transaction_id        INTEGER PRIMARY KEY AUTOINCREMENT,
    loan_id                INTEGER NOT NULL,
    transaction_date       DATE NOT NULL,
    amount                 DECIMAL(12,2) NOT NULL CHECK (amount > 0),
    transaction_type       TEXT NOT NULL CHECK (transaction_type IN ('Repayment','Disbursement')),
    description             TEXT,
    FOREIGN KEY (loan_id) REFERENCES LOAN(loan_id)
);

-- ------------------------------------------------------------
-- REPAYMENT (EER subtype of TRANSACTION_, disjoint/total)
-- ------------------------------------------------------------
CREATE TABLE REPAYMENT (
    transaction_id        INTEGER PRIMARY KEY,
    principal_portion      DECIMAL(12,2) NOT NULL CHECK (principal_portion >= 0),
    interest_portion       DECIMAL(12,2) NOT NULL CHECK (interest_portion >= 0),
    payment_method         TEXT NOT NULL CHECK (payment_method IN ('Direct Debit','BPAY','Bank Transfer')),
    FOREIGN KEY (transaction_id) REFERENCES TRANSACTION_(transaction_id) ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- DISBURSEMENT (EER subtype of TRANSACTION_, disjoint/total)
-- ------------------------------------------------------------
CREATE TABLE DISBURSEMENT (
    transaction_id         INTEGER PRIMARY KEY,
    disbursement_method     TEXT NOT NULL CHECK (disbursement_method IN ('EFT','Bank Cheque')),
    purpose_description      TEXT NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES TRANSACTION_(transaction_id) ON DELETE CASCADE
);
