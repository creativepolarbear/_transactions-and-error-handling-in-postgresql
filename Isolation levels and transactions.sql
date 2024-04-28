-- Create a new transaction with a serializiable isolation level
START TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Update records with a 50% reduction if greater than 100000
UPDATE ffiec_reci
SET RCON0352 = RCON0352 * 0.5
WHERE RCON0352 > 100000;

-- Commit the transaction
COMMIT;

-- Select a count of records still over 100000
SELECT COUNT(RCON0352)
FROM ffiec_reci
WHERE RCON0352 > 100000;

-- Begin a new transaction
BEGIN;

-- Update RCOP752 to true if RCON2365 is over 5000000
UPDATE ffiec_reci
SET RCONP752 = 'true'
WHERE RCON2365 > 5000000;

-- Commit the transaction
COMMIT;

-- Select a count of records now true
SELECT COUNT(RCONP752)
FROM ffiec_reci
WHERE RCONP752 = 'true';

-- Select a count of records where FIELD48 is now BOTH
SELECT COUNT(FIELD48)
FROM ffiec_reci
WHERE FIELD48 = 'BOTH';

-- Begin a new transaction
BEGIN;

-- Update FIELD48 flag status if US State Government deposits are held
UPDATE ffiec_reci
SET FIELD48 = 'US-STATE-GOV'
WHERE RCON2203 > 0;

-- Update FIELD48 flag status if Foreign deposits are held
UPDATE ffiec_reci
SET FIELD48 = 'FOREIGN'
WHERE RCON2236 > 0;

-- Update FIELD48 flag status if US State Government and Foreign deposits are held
UPDATE ffiec_reci
SET FIELD48 = 'BOTH'
WHERE RCON2203 > 0
AND RCON2236 > 0;

-- Commit the transaction
COMMIT;

-- Create a new transaction with an isolation level of repeatable read
START TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Count of records over 100000000
SELECT COUNT(RCON2210)
FROM ffiec_reci
WHERE RCON2210 > 100000000;

-- Count of records over 100000000
SELECT COUNT(RCON2210)
FROM ffiec_reci
WHERE RCON2210 > 100000000;

-- Commit the transaction
COMMIT;

-- Begin a new transaction
BEGIN;

-- Update RCONP752 to true if RCON2365 is over 5000
UPDATE ffiec_reci
SET RCONP752 = 'true'
WHERE RCON2365 > 5000;

-- Oops that was supposed to be 5000000 undo the statement
ROLLBACK;
