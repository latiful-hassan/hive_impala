------------------------------
-- SQL LOAD DATA STATEMENTS --
------------------------------
-- move specified data (hive/impala use metad. to determine table storage and moves file there):
	LOAD DATA INPATH '/incoming/etl/sales.txt' INTO TABLE sales;
-- LOAD DATA INPATH adds source files to existing files in table dir. and renames automattically 
-- to overwrite:
	LOAD DATA INPATH '/incoming/etl/sales.txt' OVERWRITE INTO TABLE sales;
-- LOAD DATA INPATH works if files are in the system, if not use hdfs dfs -put in command-line
-- REFRESH after

---------------------------
-- SQL INSERT STATEMENTS --
---------------------------
-- insert into:
	INSERT INTO tabname 
        VALUES
            (row1col1value,row1col2value, … ),
            (row2col1value,row2col2value, … ),
            … ;

/* generally, HDFS are immutable so INSERT statement creates new file in table dir. So, inserting,
in small batches creates many small files. This can lead to query inefficiency and performance
is negatively affected. To resolve this we can overwrite the whole dataset. */

 -- insert overwrite
	INSERT OVERWRITE tablename SELECT * FROM tablename;

-----------------------------------------
-- SQL INSERT ... SELECT & CTAS STATEMENTS --
-----------------------------------------
/* 
As SELECT statements result sets have the same basic structure as a table,you can save 
the result of a query to later run another query to analyse or retrieve that result. We do this
but combining INSERT and SELECT into a single command line. INSERT specifies name of table dest and 
follow this up with a SELECT - this is known as a 'compound' statement and this specifically is 
called 'INSERT...SELECT'.
*/

-- example of INSERT...SELECT with OVERWRITE:
	INSERT OVERWRITE chicago_employees
        SELECT * FROM employees WHERE office_id='b';

-- INSERT...SELECT requires dest. table to already exist however CREAT TABLE AS SELECT (CTAS) does not require this
-- CTAS statement creates a table and populates it with the result of a query in one command
-- example of CTAS:
	CREATE TABLE chicago_employees AS
        SELECT * FROM employees WHERE office_id='b';

-- with CTAS formatting defaults so it must be set to how you want it:
	CREATE TABLE chicago_employees
        ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
    AS
        SELECT * FROM employees WHERE office_id='b';

-- if data is being updated regularly you will need to create a job that schedules this 




































