#!/usr/bin/env ruby

require 'socket'
require 'etc'

$HOME = "/home/" + Etc.getlogin + "/"
$REPO = $HOME + "code/repo/dotfiles/"

# $TEST_DIR = "/tmp/test_dir/"

paths_hash = []
paths_hash << { ".Xresources"                   => "xresources"   }
paths_hash << { ".xmonad/config.hs"             => "xmonad"       }
paths_hash << { ".xmonad/xmonadctl.hs"          => "xmonadctl"    }
paths_hash << { ".config/picom.conf"            => "picom"        }
paths_hash << { ".shrc"                         => "shrc"         }
paths_hash << { ".vimrc"                        => "vimrc"        }
paths_hash << { ".ctags"                        => "ctags"        }
paths_hash << { ".gitconfig"                    => "gitconfig"    }
paths_hash << { ".moc/Keymap"                   => "mockeymap"    }
paths_hash << { ".moc/config"                   => "mocconfig"    }
paths_hash << { ".newsboat/urls"                => "newsboaturls" }
paths_hash << { ".newsboat/config"              => "newsboatconf" }
paths_hash << { ".config/qutebrowser/config.py" => "config.py"    }
paths_hash << { ".xinitrc"                      => "xinitrc-"  + Socket.gethostname }
paths_hash << { ".config/xmobar/xmobarrc"       => "xmobarrc-" + Socket.gethostname }

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
end
