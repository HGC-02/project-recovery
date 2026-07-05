use std::thread;
use std::time::Duration;
use std::process::Command;
use std::path::Path;
use clap::{Parser, Subcommand};

#[derive(Parser)]
struct Args {
    #[clap(subcommand)]
    command: Command,
}

#[derive(Subcommand)]
enum Command {
    Test,
}

fn main(){
    println!("testing");
    thread::sleep(Duration::from_secs(5));
    println!("done");
}