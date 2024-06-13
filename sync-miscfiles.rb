#!/usr/bin/env ruby

require 'etc'
require 'fileutils'

$HOME = "/home/" + Etc.getlogin + "/"
$REPO = $HOME + "code/repo/miscfiles/"

# $TEST_DIR = "/home/dang/code/refs/ruby/testdir/"

paths_hash = []
paths_hash << { "/etc/"                      => "rc.conf"         }
paths_hash << { "/etc/"                      => "pf.conf"         }
paths_hash << { "/etc/"                      => "jail.conf"       }

paths_hash << { "/boot/"                     => "loader.conf"     }

paths_hash << { "/usr/local/etc/"            => "dnsmasq.conf"    }

paths_hash << { "/usr/local/libexec/"        => "ps2pcl"          }
paths_hash << { "/usr/local/libexec/"        => "lf2crlf"         }
paths_hash << { "/usr/local/libexec/"        => "enscript"        }

paths_hash << { "/usr/local/etc/devd/"       => "ipod.conf"       }
paths_hash << { "/usr/local/etc/devd/"       => "usbdrive.conf"   }

count = 0

if __FILE__ == $0
  paths_hash.each do |path_values|
    path_values.each do |key, value|

      from = key + value
      to   = $REPO + value
      # tries to run risky execution              (try)
      begin
        FileUtils.copy(from, to)
      # runs when execution raises exception      (catch)
      rescue
        if File.exist?(to)
          puts "[~] !!! #{to} exists, but does NOT have write priveledges to be overwritten. Skipped. !!!"
        else
          if File.exist?(from)
            puts "[-] !!! #{from} exists, but CANNOT be copied (check permissions). Skipped. !!!"
          else
            puts "[-] !!! #{from} does NOT exist thus #{to} CANNOT exist. Skipped. !!!"
          end
        end
      # runs when execution is successful
      else
        count = count + 1
        puts "[+] #{from} successfully written to #{to}."
      # always runs                               (finally)
      ensure
        puts " "
      end

    end
  end

  puts "#{count} of " + paths_hash.size.to_s + " files successfully written."
end
