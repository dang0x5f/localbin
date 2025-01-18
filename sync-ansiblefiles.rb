#!/usr/bin/env ruby

# require 'socket'
require 'etc'

def check_extension(filename,ext)
  return File.extname(filename) == ext
end

$HOME = "/home/" + Etc.getlogin + "/"
$REPO = $HOME + "code/repo/ansible_pull/tasks/files/"

$BIN = $HOME + "/.local/bin/"
$REPO2 = $HOME + "code/repo/ansible_pull/tasks/bin/"
$SHELL = ".sh"
$RUBY  = ".rb"

# $TEST_DIR = "/tmp/test_dir/"

paths_hash = []
paths_hash << { ".Xresources"                     => "xresources"         }
paths_hash << { ".xmonad/config.hs"               => "xmonad"             }
paths_hash << { ".xmonad/xmonadctl.hs"            => "xmonadctl"          }
paths_hash << { ".config/picom.conf"              => "picom"              }
# paths_hash << { ".config/qutebrowser/config.py"   => "config.py"          }
paths_hash << { ".shrc"                           => "shrc"               }
paths_hash << { ".vimrc"                          => "vimrc"              }
paths_hash << { ".gitconfig"                      => "gitconfig"          }
paths_hash << { ".vim/after/syntax/c.vim"         => "c.vim"              }
paths_hash << { ".vim/after/ftplugin/vimwiki.vim" => "vimwiki.vim"        }
paths_hash << { ".vim/colors/solarized.vim"       => "solarized.vim"      }
paths_hash << { ".vim/colors/seoul256.vim"        => "seoul256.vim"       }
paths_hash << { ".vim/colors/seoul256-light.vim"  => "seoul256-light.vim" }

if __FILE__ == $0
  paths_hash.each do |path_values|
    path_values.each do |key, value|

      from = $HOME + key
      to   = $REPO + value

      file = File.open(from)
      data = file.read
      file.close

      File.write(to, data)

      puts "From: #{from}"
      puts "  To: #{to}"

    end
  end


  filenames = Dir.children($BIN)

  # for each filename
  filenames.each do |filename|
    
    from = $BIN + filename
    to   = $REPO2 + filename
    
    if check_extension(from, $SHELL) || check_extension(from, $RUBY)
      # open file 
      file = File.open(from)
      # read file
      data = file.read
      # close file
      file.close
      
      # write to file
      File.write(to, data)

      #puts "#{filename} written to #{to}"
      puts "From: #{from}"
      puts "  To: #{to}"
    end

  end

end
