const DB_URI: &'static str = "mysql://bug_repo:password@localhost/bug_repo_db";
use std::{time::Duration, process::exit};

use actix_web::{get, web::Data, App, HttpServer, Responder, web::Path};
use sqlx::{MySqlPool, query};

#[get("/query/{cols}/{rows}")]
async fn num_rows(db: Data<MySqlPool>, num: Path<(u64, u64)>) -> impl Responder {
    let (cols,rows) = num.into_inner();
    let v = query(
        match cols {
            1 => "SELECT c1 FROM test_table LIMIT ?",
            2 => "SELECT c1,c2 FROM test_table LIMIT ?",
            3 => "SELECT c1,c2,c3 FROM test_table LIMIT ?",
            4 => "SELECT c1,c2,c3,c4 FROM test_table LIMIT ?",
            5 => "SELECT c1,c2,c3,c4,c5 FROM test_table LIMIT ?",
            6 => "SELECT c1,c2,c3,c4,c5,c6 FROM test_table LIMIT ?",
            _ => panic!("unsported number of rows")
        }
    ).bind(rows)
        .fetch_all(&**db).await
        .expect("DATABASE QUERY FAIL: not part of bug, shouldn't happen.");
    if v.len() != rows as usize {
        eprintln!("MISSING ROWS");
    }
   "OUTPUT" 
}
async fn try_col_row(client: &awc::Client, col:u64, row:u64) -> bool{
    let response = client.get(&format!("http://127.0.0.1:8002/query/{}/{}", col,row))
        .send().await;
    if !response.is_ok() {
        println!("=======================");
        println!("FAILURE COLS: {col}, ROWS: {row}");
        println!("=======================");
        return false
    }
    return true
}
async fn browser() -> Result<(), Box<dyn std::error::Error>> {
    eprintln!("waiting For server to turn on");
    actix_web::rt::time::sleep(Duration::from_millis(750)).await;
    let client = awc::Client::new();
    eprintln!("Trying Known Problematic Row/Column Combinations");
    for (col,row) in [
        (2,60), (2,124), (3,59), (3,123)
    ] {
        if try_col_row(&client, col, row).await {
            eprintln!("cols: {col} rows: {row} unexpectedly exceeded as it should");
        }
    }
    actix_web::rt::time::sleep(Duration::from_millis(1250)).await;
    eprintln!("Trying Combinations");
    for col in 2..6 {
        for row in 1..800 {
            if row &0xf ==0 {
            eprintln!("COL: {col} : {:.2}%", (row as f64 / 500 as f64)*100.0);
            }
            try_col_row(&client, col, row).await;
        }
    }
    eprintln!("done");
    exit(0);
}
async fn create_table_test(db: &MySqlPool) {
    println!("CREATING TEST TABLE");
    query(r#"DROP TABLE IF EXISTS `test_table`"#).execute(db).await.unwrap();
    query(r#"
CREATE TABLE `test_table` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `c1` bigint(20) unsigned,
  `c2` bigint(20) unsigned,
  `c3` bigint(20) unsigned,
  `c4` bigint(20) unsigned,
  `c5` bigint(20) unsigned,
  `c6` bigint(20) unsigned,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
"#).execute(db).await.unwrap();
    for _ in 0..802 {
        query(r#"
INSERT INTO test_table (c1) VALUES (0)
"#).execute(db).await.unwrap();
    }
}

#[actix_web::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    #[cfg(not(debug_assertions))]
    panic!("debug_assertions are required for panic to occour");

    let db = Data::new(MySqlPool::connect(DB_URI).await
        .expect("Failed connection to mysql database"));
    create_table_test(&**db).await;
    actix_web::rt::spawn(async {
        browser().await.unwrap()
    });
    HttpServer::new(move ||{
        App::new()
            .app_data(db.clone())
            .service(num_rows)
    }).bind("127.0.0.1:8002")?.run().await?;
    Ok(())
}


