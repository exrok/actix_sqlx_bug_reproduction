# Actix/SQLx Panic Bug

I am using Mariadb for mysql on Arch linux.

I also reproduced the issue using this repo on Debian 11;

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

I tried to creating TCP server the simulated the mysql
traffic to avoid using SQLx for the reproduction but could
not get the bug to reproduce.

# Output With Backtrace
```
thread 'actix-rt|system:0|arbiter:3' panicked at 'dispatcher should not be in keep-alive phase if write_buf is not empty', /home/user/.cargo/registry/src/github.com-1ecc6299db9ec823/actix-http-3.0.0-rc.3/src/h1/dispatcher.rs:934:13
stack backtrace:
   0: std::panicking::begin_panic
   1: actix_http::h1::dispatcher::InnerDispatcher<T,S,B,X,U>::poll_ka_timer
   2: actix_http::h1::dispatcher::InnerDispatcher<T,S,B,X,U>::poll_timers
   3: <actix_http::h1::dispatcher::Dispatcher<T,S,B,X,U> as core::future::future::Future>::poll
   4: <actix_http::service::HttpServiceHandlerResponse<T,S,B,X,U> as core::future::future::Future>::poll
   5: <actix_service::and_then::AndThenServiceResponse<A,B,Req> as core::future::future::Future>::poll
   6: <actix_server::service::StreamService<S,I> as actix_service::Service<(actix_server::worker::WorkerCounterGuard,actix_server::socket::MioStream)>>::call::{{closure}}
   7: <core::future::from_generator::GenFuture<T> as core::future::future::Future>::poll
   8: tokio::runtime::task::core::CoreStage<T>::poll::{{closure}}
   9: tokio::loom::std::unsafe_cell::UnsafeCell<T>::with_mut
  10: tokio::runtime::task::core::CoreStage<T>::poll
  11: tokio::runtime::task::harness::poll_future::{{closure}}
  12: <core::panic::unwind_safe::AssertUnwindSafe<F> as core::ops::function::FnOnce<()>>::call_once
  13: std::panicking::try::do_call
  14: __rust_try
  15: std::panicking::try
  16: std::panic::catch_unwind
  17: tokio::runtime::task::harness::poll_future
  18: tokio::runtime::task::harness::Harness<T,S>::poll_inner
  19: tokio::runtime::task::harness::Harness<T,S>::poll
  20: tokio::runtime::task::raw::poll
  21: tokio::runtime::task::raw::RawTask::poll
  22: tokio::runtime::task::LocalNotified<S>::run
  23: tokio::task::local::LocalSet::tick::{{closure}}
  24: tokio::coop::with_budget::{{closure}}
  25: std::thread::local::LocalKey<T>::try_with
  26: std::thread::local::LocalKey<T>::with
  27: tokio::task::local::LocalSet::tick
  28: <tokio::task::local::RunUntil<T> as core::future::future::Future>::poll::{{closure}}
  29: tokio::macros::scoped_tls::ScopedKey<T>::set
  30: tokio::task::local::LocalSet::with
  31: <tokio::task::local::RunUntil<T> as core::future::future::Future>::poll
  32: tokio::task::local::LocalSet::run_until::{{closure}}
  33: <core::future::from_generator::GenFuture<T> as core::future::future::Future>::poll
  34: <core::pin::Pin<P> as core::future::future::Future>::poll
  35: tokio::runtime::basic_scheduler::CoreGuard::block_on::{{closure}}::{{closure}}::{{closure}}
  36: tokio::coop::with_budget::{{closure}}
  37: std::thread::local::LocalKey<T>::try_with
  38: std::thread::local::LocalKey<T>::with
  39: tokio::runtime::basic_scheduler::CoreGuard::block_on::{{closure}}::{{closure}}
  40: tokio::runtime::basic_scheduler::Context::enter
  41: tokio::runtime::basic_scheduler::CoreGuard::block_on::{{closure}}
  42: tokio::runtime::basic_scheduler::CoreGuard::enter::{{closure}}
  43: tokio::macros::scoped_tls::ScopedKey<T>::set
  44: tokio::runtime::basic_scheduler::CoreGuard::enter
  45: tokio::runtime::basic_scheduler::CoreGuard::block_on
  46: tokio::runtime::basic_scheduler::BasicScheduler::block_on
  47: tokio::runtime::Runtime::block_on
  48: tokio::task::local::LocalSet::block_on
  49: actix_rt::runtime::Runtime::block_on
  50: actix_rt::arbiter::Arbiter::with_tokio_rt::{{closure}}
```
