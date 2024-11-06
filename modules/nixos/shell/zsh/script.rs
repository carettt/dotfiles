use clap::Parser;

#[derive(Parser)]
#[command(version, about, long_about = None)]
struct Args {
    #[arg(short, long)]
    arg: Option<String>,
}

fn main() {
  let args = Args::parse();

	println!("abracadabra {}!", args.arg.unwrap_or(String::from("")));
}
