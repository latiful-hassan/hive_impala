--------------------------------------
-- STARTING COMMAND LINE IN BEEHIVE --
--------------------------------------

-- start terminal then enter:
beeline -u jdbc:hive2://localhost:10000 -n training -p training

-- special commands: 
!quit or !q
up arrow goes to previous lin
ctrl+l clears console
ctrl+c cancels query 

-------------------------------------------
-- STARTING COMMAND LINE IN IMPALA SHELL --
-------------------------------------------

-- start terminal then enter:
impala-shell
impala-shell -d <ENTER DB NAME>  # to use DB 

-- to quit:
quit;

----------------
-- FUNCTIONS --
----------------

ceil(x) # rounds to lower integer
floor(x) # rounds to upper integer
pow(x,y) # exponentiations x to y
rand() # gives pseudo random int between 0 and 10
cast(min_age AS STRING) # force data conversion

-------------------------------------------
-- USING BEELINE IN NON-INTERACTIVE MODE --
-------------------------------------------

$ beeline -u ... -e 'SELECT * FROM table' # run queries in hive beeline
$ beeline -u ... -f myquery.sql # execute files in hive beeline
$ beeline --silent=true -u ... # option to suppress informsational messages

------------------------------------------------
-- USING IMPALA SHELL IN NON-INTERACTIVE MODE --
------------------------------------------------

$ impala-shell -q 'SELECT * FROM table' # run queries in impala shell
$ impala-shell -f myquery.sql # execute files in impala shell
$ impala-shell --quiet ... # option to suppress informsational messages

----------------------------------------------------------------------------
-- CHANGING OUTPUT OF FORMATTING IN CONSOLE (PRETTY-PRINTING) FOR BEELINE --
----------------------------------------------------------------------------

-- Change output format --
	--outputformat= :
		csv2 (comma delimited)
		tsv2 (tab delimited)
$ beeline -u ... --outputformat=csv2 -e ...  -- example

-- To exclude header in results:
	--showHeader=false 

---------------------------------------------------------------------------------
-- CHANGING OUTPUT OF FORMATTING IN CONSOLE (PRETTY-PRINTING) FOR IMPALA SHELL --
---------------------------------------------------------------------------------

--delimited :
    tab used as default 
    specify others using --output_delimiter=''
$ impala-shell --delimited --output_delimiter=',' -q ...  -- example

-- headers excluded by default, to inlcude headers use: 
	--print_header

$ impala-shell --delimited --print_header -q ...

----------------------------------------
-- SAVING HIVE QUERY RESULTS TO FILES -- 
----------------------------------------

-- When using console there is an 'error' stream and an 'output' stream.
-- You can 'redirect' the output stream and save to a file directly.

-- After your query, enter:
	> file.txt
$ beeline -u ... -e 'SELECT * FROM table' > file.txt  -- example

------------------------------------------
-- SAVING IMPALA QUERY RESULTS TO FILES -- 
------------------------------------------

-- After your query, enter:
	-o file.txt
$ impala-shell -q 'SELECT * FROM table' -o file.txt  -- example

-- You can use Hue to export to CSV or Excel (small results sets only) 

---------------------------
-- IF, NULL AND COALESCE -- 
---------------------------

if(cond_expression, result, else_result)
ifnull(x,y)  -- if x is null, replace with y
nullif(x,y)  -- makes x NULL if it is equal to the value y
COALESCE(x,y)  -- gives y if x is null 

-----------------------------------
-- VARIABLE SUBSTITUTION IN HIVE -- 
-----------------------------------

-- Example 1:
SET hivevar:var=value;  -- set a variable to be used many times in queries, quotes are not needed for strings
SELECT cols FROM table WHERE col = '${hivevar:var}';

-- Example 2:
SELECT hex FROM wax.crayons WHERE color = '${hivevar:color}'
$ beeline -u ... --hivevar color="Red" -f hex_color.sql  -- run in command line

-- Example 3:
SELECT color FROM wax.crayons 
WHERE
	red = ${hivevar:red} AND 
    green = ${hivevar:green} AND
    blue = ${hivevar:blue};

$ beeline -u ... --hivevar red="238" --hivevar green="32" --hivevar blue="77" -f color_from_rgb.sql

-------------------------------------
-- VARIABLE SUBSTITUTION IN IMPALA -- 
-------------------------------------

-- Works exactly the same as in Hive, but this syntax instead:
	'${var:var}'

--------------------------------------------------
-- CALLING BEELINE AND IMPALA SHELL FROM SCRIPTS -- 
--------------------------------------------------

"""
We can create 'Shell Scripts' which contain a series of commands for the shell,
in this case 'BASH', so we can run them with a single line if needed in future tasks
"""

-- Shell scrips will have '.sh' in the file name
-- '#!/bin/bash' this is called a 'Hash Bang' which is the first line in shell scripts and tells OS to use BASH

-- Example:
#!/bin/bash
impala-shell \
--quiet \
--delimited \
--output_delimiter=',' \
--print_header \
-q 'SELECT * FROM fly.flights WHERE air_time = 0;' \
-o zero_air_time.csv
mail \
-a zero_air_time.csv \
-s 'Flights with zero air_time' \
fly@example.com \
<<< 'Do you know why air_time is zero in these rows?'

-- After creating and saving shell script, you need to change permissions on script files to execute it:
	$ chmod 755 email_results.sh
-- Then to execute it:
	$ ./email_results.sh

-- Shell scripts can be executed via a 'Scheduler' or from another script or applicaton (e.g. Python)

----------------------------------------------------------
-- QUERYING HIVE AND IMPALA IN SCRIPTS AND APPLICATIONS -- 
----------------------------------------------------------
"""
There are some other programmatic interfaces you can use to integrate with Hive/Impala. For example ODBC, 
JDBC, and Apache Thrift. These are three interfaces standards that were designed to make it easy and efficient 
to integrate scripts and applications written in any language with Sequel engines and other services. One major 
benefit portability. The drivers or libraries that are required to use them can be installed on virtually any computer. 
To use Beeline or Impala shell, you need a local installation of Beeline or Impala shell, and that's impractical.
"""

-------------------------------------------------------
-- UNDERSTANDING HIVE AND IMPALA VERSION DIFFERENCES --
-------------------------------------------------------
-- To find out version:
	SELECT version();
    
-- Visit the documentation websites for more information on versions and syntax































