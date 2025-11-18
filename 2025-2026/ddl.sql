------------------------------------------------------------
-- TAX SECTION
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tax_section (
    id BIGSERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL,
    title VARCHAR(200),
    description TEXT,
    deduction_type VARCHAR(50),
    financial_year VARCHAR(10) NOT NULL,
    old_regime_allowed BOOLEAN DEFAULT TRUE,
    new_regime_allowed BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_tax_section UNIQUE (code, financial_year)
);

------------------------------------------------------------
-- TAX SECTION RULE
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tax_section_rule (
    id BIGSERIAL PRIMARY KEY,
    section_id BIGINT REFERENCES tax_section(id),
    rule_type VARCHAR(50),
    min_value INT,
    max_value INT,
    fixed_deduction DECIMAL(12,2),
    max_amount DECIMAL(12,2),
    percent_limit DECIMAL(6,2),
    percent_limit_of VARCHAR(50),
    notes TEXT,
    window_condition VARCHAR(20),
    age_limit VARCHAR(20),
    employee_type VARCHAR(50),
    tenure VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    financial_year VARCHAR(20),
    donation_category VARCHAR(75),
    sub_category VARCHAR(100)
);

ALTER TABLE tax_section_rule
ADD COLUMN IF NOT EXISTS rule_hash VARCHAR(64);

CREATE UNIQUE INDEX IF NOT EXISTS uq_tax_section_rule_hash_idx
ON tax_section_rule (rule_hash);

------------------------------------------------------------
-- TAX SECTION GROUP
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tax_section_group (
    id BIGSERIAL PRIMARY KEY,
    group_code VARCHAR(50) NOT NULL,
    title VARCHAR(200),
    max_amount DECIMAL(12,2),
    financial_year VARCHAR(10) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT uq_tax_section_group UNIQUE (group_code, financial_year)
);

------------------------------------------------------------
-- TAX SECTION GROUP MAP
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tax_section_group_map (
    id BIGSERIAL PRIMARY KEY,
    group_id BIGINT REFERENCES tax_section_group(id),
    section_id BIGINT REFERENCES tax_section(id),
    financial_year VARCHAR(10) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT unique_group_section_fy UNIQUE (group_id, section_id, financial_year)
);

ALTER TABLE tax_section
DROP COLUMN IF EXISTS remarks;

ALTER TABLE tax_section
ADD COLUMN IF NOT EXISTS is_group_limit BOOLEAN DEFAULT FALSE;













