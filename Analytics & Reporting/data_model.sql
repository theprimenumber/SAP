-- Start of Master Table Definitions 
CREATE ROW TABLE regions(
	country_code NVARCHAR(2) PRIMARY KEY,
	country_name NVARCHAR(20),
	currency_code NVARCHAR(2),
	currency_desc NVARCHAR(20)
);

INSERT INTO regions VALUES('IN', 'India', 'RP', 'Indian Rupees');
INSERT INTO regions VALUES('US', 'United States', 'DR', 'American Dollars');
INSERT INTO regions VALUES('JP', 'Japan', 'YN', 'Japanese Yen');

CREATE ROW TABLE market_class(
	market_code NVARCHAR(1) PRIMARY KEY,
	market_desc NVARCHAR(20)
);

INSERT INTO market_class VALUES('G', 'General Consumption');
INSERT INTO market_class VALUES('E', 'Electronics');
INSERT INTO market_class VALUES('M', 'Motorcycles');

CREATE ROW TABLE product_list(
	product_id NVARCHAR(1) PRIMARY KEY,
	product_name NVARCHAR(40),
	product_class NVARCHAR(1),
	product_region NVARCHAR(2),
	product_price INTEGER,
	FOREIGN KEY(product_class) REFERENCES market_class(market_code),
	FOREIGN KEY(product_region) REFERENCES regions(country_code)
);

INSERT INTO product_list VALUES ('1', 'Horizon Organic', 'G', 'IN', 40);
INSERT INTO product_list VALUES ('2', 'Avon 15', 'E', 'US', 400);
INSERT INTO product_list VALUES ('3', 'Helkama', 'M', 'JP', 100500);
INSERT INTO product_list VALUES ('4', 'Krusteaz', 'G', 'US', 10);
INSERT INTO product_list VALUES ('5', 'Raptor MX70', 'E', 'IN', 80500);
INSERT INTO product_list VALUES ('6', 'Kreidler', 'M', 'IN', 120000);
INSERT INTO product_list VALUES ('7', 'Terrot', 'M', 'US', 3000);
INSERT INTO product_list VALUES ('8', 'Greenseas', 'G', 'US', 20);
INSERT INTO product_list VALUES ('9', 'Helkama', 'M', 'US', 2500);
-- End of Master Table Definitions

