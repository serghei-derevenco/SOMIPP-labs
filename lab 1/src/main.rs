extern crate os_type;
use std::io;
use std::io::{Write, stdout};
use crossterm::{
    ExecutableCommand,
};
use std::fs::{read_dir};
use std::{thread, time};

fn os_loading() {
    println!("Checking Hardware... DONE!");
    thread::sleep(time::Duration::from_secs(1));
    println!("Loading the operating system...");
    thread::sleep(time::Duration::from_secs(1));
    println!("Starting up daemons...");
    thread::sleep(time::Duration::from_secs(1));
    println!(" ****        ******            ******        **** ");
    println!(" ****       ********          ********       **** ");
    println!("           ***    ***        ***    ***           ");
    println!(" ****     ***  **  ***      ***  **  ***     **** ");
    println!(" ****    ***  ****  ***    ***  ****  ***    **** ");
    println!(" ****     ***  **  ***      ***  **  ***     **** ");
    println!("           ***    ***        ***    ***           ");
    println!(" ****       ********          ********       **** ");
    println!(" ****        ******            ******        **** ");
    thread::sleep(time::Duration::from_secs(1));
}

enum Functions {
    Help,
    TypeOS,
    Ls,
    Clear,
    Quit,
}

fn main() {
    os_loading();
    let mut pass = String::new();

    loop {
        println!("Please log in:");
        print!("> ");
        io::stdout().flush().unwrap();
        io::stdin().read_line(&mut pass).expect("Something went wrong");
        pass = pass.trim().to_string();
        match pass.as_str() {
            "admin" => { println!("Welcome!"); break; },
            _ => { println!("Wrong, please try again!"); pass = String::new(); }
        }
    }

    loop {
        print!("> ");
        io::stdout().flush().unwrap();
        let mut inp = String::new();
        io::stdin().read_line(&mut inp).expect("Something went wrong...");
        let args: Vec<&str>;

        if inp.contains("do") {
            args = inp.trim().splitn(3, ' ').collect();
        } else {
            args = inp.trim().splitn(2, ' ').collect();
        }

        let command = match args[0]{
            "ls" => Functions::Ls,
            "clear" => Functions::Clear,
            "quit" => Functions::Quit,
            "os-info" => Functions::TypeOS,
            "help" => Functions::Help,
            _ => { println!("You need to provide an available command"); Functions::Help },
        };

        match command {
            Functions::Help => {
                println!();
                println!("Available commands: ");
                println!();
                //help
                println!("'help'     Displays available commands.");
                println!();
                //os-info
                println!("'os-info'  Displays the current OS version.");
                println!();
                //ls
                println!("'ls'       Displays a list of files from the directory.");
                println!();
                //clear
                println!("'clear'    Clears the screen.");
                println!();
                //quit
                println!("'quit'     Shuts down the operating system.");
                println!();
            },
            Functions::TypeOS => {
                let os = os_type::current_platform();
                println!("Type: {:?}", os.os_type);
                println!("Version: {}", os.version);
            },
            Functions::Clear => {
                print!("\x1B[2J");
                stdout().execute(crossterm::cursor::MoveTo(0, 0)).expect("Something went wrong");
            },
            Functions::Ls => {
                let paths = read_dir("files/").unwrap();
                for path in paths {
                    println!("{}", path.unwrap().path().display());
                }
            },
            Functions::Quit => {
                println!("Goodbye!");
                thread::sleep(time::Duration::from_secs(1));
                break;
            }
            _=> {}
        }
    }
}
