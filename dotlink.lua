#!/usr/local/bin/lua54 

package.cpath = package.cpath..";/home/dang/lib/?.so"

-- load shared lib
local home_path  = os.getenv("HOME")
local pgm_name   = "dotlink.lua"
local lib_name   = "dotlinklib"
local lib_path   = home_path.."/lib/"..lib_name
local lib_status, dotlink = pcall(require,lib_name)

-- ansi color
local ESC = "\27"
local RST = "\27[0m"
local R   = "\27[31m"
local G   = "\27[32m"
local B   = "\27[34m"
local C   = "\27[36m"
local M   = "\27[35m"
local Y   = "\27[33m"

-- info tags
local tag_err    = "["..R.."ERR"..RST.."] "
local tag_ok     = "["..G.."OK"..RST.."] "
local tag_so     = "["..Y.."SHARED OBJECT"..RST.."] "
local tag_mkprev = "["..Y.."MK_PREVIEW"..RST.."] "
local tag_rmprev = "["..Y.."RM_PREVIEW"..RST.."] "
local tag_info   = "["..Y.."INFO"..RST.."] "

local DEFAULT_MANIFEST = "MANIFEST.def"
local file_name = nil

local file     = nil
local src_path = nil
local dot_path = nil

function usage()
    print("usage:\n  dotlink.lua [MANIFEST]")
    -- TODO: print MANIFEST format
end

function get_operation()
    repeat
        io.write("Choose operation [1/2]:\n  1. link\n  2. unlink\n  3. exit\n > ")
        input = io.read()
    until input ~= "" and 
          input == "1" or 
          input == "2" or
          input == "3"

    return input
end

function do_operation(op,line)
    if op == "1" then
        mk_link(line)
    elseif op == "2" then
        rm_link(line)
    else
        print(tag_err.."Undefined operation: "..op)
        print(tag_err.."Line skipped: "..line)
    end
end

function mk_preview()
    file = io.open(file_name,"r")
    if file then
        for line in io.lines(file_name) do

            c = string.sub(line,1,1)

            if c == "*" then
                src_path = line:sub(2)
            elseif c == "#" then
                goto continue
            else
                buildpaths(line)
                
                print(tag_mkprev..dst_path.." -> "..dot_path)
            end

            ::continue::
        end
        file:close()
    else
        print(tag_err.."Failed to open file: "..file_name)
        return "n"
    end

    repeat
        io.write("Does this look correct? [y/n] ")
        input = io.read()
    until input ~= "" and 
          input == "y" or 
          input == "n"

    return input
end

function rm_preview()
    file = io.open(file_name,"r")
    if file then
        for line in io.lines(file_name) do

            c = string.sub(line,1,1)

            if c == "*" then
                src_path = line:sub(2)
            elseif c == "#" then
                goto continue
            else
                buildpaths(line)
                
                print(tag_rmprev..dst_path)
            end

            ::continue::
        end
        file:close()
    else
        print(tag_err.."Failed to open file: "..file_name)
        return "n"
    end

    repeat
        io.write("Does this look correct? [y/n] ")
        input = io.read()
    until input ~= "" and 
          input == "y" or 
          input == "n"

    return input
end

function mk_link(line)
    buildpaths(line)

    status, errno = dotlink.mk_link(dot_path,dst_path)
    if status == -1 then
        print(tag_err..dst_path.." : "..errno)
    else
        print(tag_ok..dst_path.." -> "..dot_path)
    end
end

function rm_link(line)
    buildpaths(line)

    status, errno = dotlink.rm_link(dst_path)
    if status == -1 then
        print(tag_err..dst_path.." : "..errno)
    else
        print(tag_ok..dst_path)
    end
end

function buildpaths(line)
    src, dst, ext = dotlink.split_comma(line,line:len())
    if ext == "null" then
        dst_path = home_path .. dst
    else
        dst_path = home_path .. ext .. dst
    end
    dot_path = src_path .. src
end

function main()
    local pgm_path = arg[0]
    if #arg < 1 then
        print(tag_info.."No file parameter.\n"..
              tag_info.."Reverting to default: "..DEFAULT_MANIFEST)
        file_name = pgm_path:gsub(pgm_name,DEFAULT_MANIFEST)
    else
        file_name = arg[1]
    end

    print(tag_so..lib_path..".so")

    if not lib_status then
        print(tag_err.."Dependency NOT loaded: "..lib_path)
        usage()
        goto exit
    end

    print(tag_ok.."Shared Object Loaded.")

    op = get_operation()

    if op == "1" then
        ans = mk_preview()
    elseif op == "2" then
        ans = rm_preview()
    elseif op == "3" then
        goto exit
    end

    if ans == "n" then
        goto exit
    end

    file = io.open(file_name,"r")

    if file then
        for line in io.lines(file_name) do

            c = string.sub(line,1,1)

            if c == "*" then
                src_path = line:sub(2)
            elseif src_path == nil then
                goto exit
            elseif c == "#" then
                goto continue
            else
                do_operation(op,line)
            end

            ::continue::
        end
        file:close()
    end
    ::exit::
end

main()

-- TODO:
-- makefile
-- refactor / cleanup
