use std::process::Command;
use std::path::Path;
use clap::{Parser, Subcommand};

#[derive(Parser)]
#[command(name = "snapshot-core")]
#[command(about = "Android Btrfs Snapshot & Bootloop Defender CLI", long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// 0.1 秒內為指定子卷建立 CoW 快照備份
    Backup {
        #[arg(short, long, default_value = "../mnt_test/@data")]
        target: String,
        #[arg(short, long, default_value = "../mnt_test/@data_snapshot_backup")]
        dest: String,
    },
    /// 刪除損壞分區，並用健康快照秒級還原
    Rollback {
        #[arg(short, long, default_value = "../mnt_test/@data")]
        target: String,
        #[arg(short, long, default_value = "../mnt_test/@data_snapshot_backup")]
        backup: String,
    },
}

fn main() {
    let cli = Cli::parse();
    match &cli.command {
        Commands::Backup { target, dest } => {
            println!("正在建立秒級快照: {} -> {}", target, dest);
            
            if Path::new(dest).exists() {
                let _ = Command::new("btrfs")
                    .args(["subvolume", "delete", dest])
                    .output();
            }

            let output = Command::new("btrfs")
                .args(["subvolume", "snapshot", target, dest])
                .output()
                .expect("無法執行 btrfs 指令");

            if output.status.success() {
                println!("快照建立成功！");
            } else {
                eprintln!("快照失敗: {}", String::from_utf8_lossy(&output.stderr));
            }
        }
        Commands::Rollback { target, backup } => {
            println!("啟動秒級自救還原流程...");

            if !Path::new(backup).exists() {
                eprintln!("錯誤：找不到健康的備份快照 ({})", backup);
                return;
            }

            let _ = Command::new("btrfs").args(["subvolume", "delete", target]).output();

            let output = Command::new("btrfs")
                .args(["subvolume", "snapshot", backup, target])
                .output()
                .expect("無法執行 btrfs 還原");

            if output.status.success() {
                println!("系統完美還原！請重啟系統起死回生。");
            } else {
                eprintln!("還原失敗: {}", String::from_utf8_lossy(&output.stderr));
            }
        }
    }
}
