# Actix/SQLx Panic Bug

I am using Mariadb on Arch linux.

Sql to create the datebase and user: 
# Reproductions Steps
## Step 1: Create Database
I just paste this into `sudo mysql`
```sql
CREATE DATABASE bug_repo_db;
CREATE USER 'bug_repo'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON bug_repo_db.* TO 'bug_repo'@'localhost';
FLUSH PRIVILEGES;
```

## Step 2: Create Table
Then load table
```sh
mysql -v -u bug_repo -p bug_repo_db --password=password < ./table_dump.sql
```

## Step 3: Start the webserver
Now run `cargo run`

## Step 4: Goto http://127.0.0.1:8002/crash
Observe panic in output of webserver, and failure to connect
page.

# Observations

The endpoint http://127.0.0.1:8002/no_crash does not panic by
limiting the results. 

The endpoint http://127.0.0.1:8002/crash2 streams the results
using `fetch` and still panics.

The endpoint http://127.0.0.1:8002/no_crash2 streams the results
using `fetch` but breaks out of the loop earlier and does not crash.
