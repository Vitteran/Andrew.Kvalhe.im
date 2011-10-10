require 'toto'

@config = Toto::Config::Defaults

task :default => :help

desc "Display a help message."
task :help do
  puts 'Nothing here.'
end

def toto msg
  puts "\n  toto ~ #{msg}\n\n"
end

def ask message
  print message
  STDIN.gets.chomp
end

