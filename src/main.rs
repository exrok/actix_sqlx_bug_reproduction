const DB_URI: &'static str = "mysql://bug_repo:password@localhost/bug_repo_db";
use actix_web::{get, web::Data, App, HttpServer, Responder};
use sqlx::{MySqlPool, query};

#[get("/crash")]
async fn crash(db: Data<MySqlPool>) -> impl Responder {
    query("SELECT * FROM ticket_messages WHERE ticket_id = 6 LIMIT 60")
        .fetch_all(&**db).await.ok();
    eprintln!("/crash: This message is printed, but the request panics.");
    "OUTPUT"
}

#[get("/no_crash")]
async fn no_crash(db: Data<MySqlPool>) -> impl Responder {
    query("SELECT * FROM ticket_messages WHERE ticket_id = ? LIMIT 50")
        .fetch_all(&**db).await.ok();
    "OUTPUT"
}

#[actix_web::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let db = Data::new(MySqlPool::connect(DB_URI).await
        .expect("Failed connection to mysql database"));

    HttpServer::new(move ||{
        App::new()
            .app_data(db.clone())
            .service(crash)
            .service(no_crash)
            .service(no_crash2)
            .service(no_crash3)
            .service(crash2)
    }).bind("127.0.0.1:8002")?.run().await?;
    Ok(())
}


// ==== MORE CASES ===

#[get("/crash2")]
async fn crash2(db: Data<MySqlPool>) -> impl Responder {
    let mut rows = query("SELECT * FROM ticket_messages WHERE ticket_id = 6")
        .fetch(&**db);
    use futures::TryStreamExt;
    let mut i = 0;
    let limit = 60;
    while let Some(_) = rows.try_next().await.unwrap() {
        i+=1;
        if i > limit {
            break;
        }
    }
    eprintln!("/crash2: This message is printed, but the request panics.");
    "OUTPUT"
}

#[get("/no_crash2")]
async fn no_crash2(db: Data<MySqlPool>) -> impl Responder {
    let mut rows = query("SELECT * FROM ticket_messages WHERE ticket_id = 6")
        .fetch(&**db);
    use futures::TryStreamExt;
    let mut i = 0;
    let limit = 55;
    while let Some(_) = rows.try_next().await.unwrap() {
        i+=1;
        if i > limit {
            break;
        }
    }
    "OUTPUT"
}

#[get("/no_crash3")]
async fn no_crash3(db: Data<MySqlPool>) -> impl Responder {
    query("SELECT * FROM ticket_messages WHERE ticket_id = ? LIMIT 60 OFFSET 10")
        .fetch_all(&**db).await.ok();
    "OUTPUT"
}
