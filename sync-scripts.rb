#!/usr/bin/env ruby

require 'etc'

def check_extension(filename,ext)
  return File.extname(filename) == ext
end

$HOME = "/usr/home/" + Etc.getlogin
$DIR = $HOME + "/.local/bin/"
$GIT = $HOME + "/code/refs/ruby/fakedir/"

$SHELL = ".sh"
$RUBY  = ".rb"

if __FILE__ == $0
  filenames = Dir.children($DIR)
  

  # for each filename
  filenames.each do |filename|
    
    from = $DIR + filename
    to   = $GIT + filename
    
    if check_extension(from, $SHELL) || check_extension(from, $RUBY)
      # open file 
      file = File.open(from)
      # read file
      data = file.read
      # close file
      file.close
      
      # write to file
      File.write(to, data)

      puts "#{filename} written #{to}."
    end

  end
end
