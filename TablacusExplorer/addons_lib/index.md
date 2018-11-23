# sqlite3.dll
[32bit](https://www.sqlite.org/index.html)
[64bit](https://www.sqlite.org/index.html)

# sqliteodbc
[sqliteodbc.exe](http://www.ch-werner.de/sqliteodbc/)
[sqliteodbc w64.exe](http://www.ch-werner.de/sqliteodbc/)

# view
```
-- mouse over [target db] -> right click -> [Show sqlite_master]
select * from sqlite_master;
/*
(#index)	type	name	tbl_name	rootpage	sql
# table	labels	labels	2	"CREATE TABLE labels (path TEXT	 label TEXT)"
# table	list	list	3	CREATE TABLE list (label TEXT)
*/

-- mouse over [table name of target db] -> right click -> [Show Table]
select * from labels;
/*
(#index)	path	label
*/
select * from list;
/*
(#index)	label
*/
```
