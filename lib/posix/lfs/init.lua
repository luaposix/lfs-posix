
--[[
  lfs reimplementation using luaposix only
--]]

local M = {}
local posix = require'posix'
local unistd = posix.unistd
local stat = posix.sys.stat

M.chdir = unistd.chdir
M.currentdir = unistd.getcwd
M.touch = posix.utime.utime
M.mkdir = posix.sys.stat.mkdir
M.rmdir = unistd.rmdir
M.link = unistd.link
M.dir = posix.dirent.files

local S_ISBLK = stat.S_ISBLK
local S_ISCHR = stat.S_ISCHR
local S_ISDIR = stat.S_ISDIR
local S_ISFIFO = stat.S_ISFIFO
local S_ISLNK = stat.S_ISLNK
local S_ISSOCK = stat.S_ISSOCK
local S_ISREG = stat.S_ISREG

local mode2permT = {
  ['0'] = '---'
  ,['1'] = '--x'
  ,['2'] = '-w-'
  ,['3'] = '-wx'
  ,['4'] = 'r--'
  ,['5'] = 'r-x'
  ,['6'] = 'rw-'
  ,['7'] = 'rwx'
}

local Format = string.format

local Convert = function -- table --
(
  T -- table --
) local R = {}
  R.dev = T.st_dev
  R.ino = T.st_ino
  R.nlink = T.st_nlink
  R.uid = T.st_uid
  R.gid = T.st_gid
  R.rdev = T.st_rdev
  R.access = T.st_atime
  R.modification = T.st_mtime
  R.size = T.st_size
  R.change = T.st_ctime
  R.blksize = T.st_blksize
  R.blocks = T.st_blocks
  local mode = T.st_mode
  R.mode =
    S_ISDIR(mode)~=0 and 'directory'
    or S_ISBLK(mode)~=0 and 'block device'
    or S_ISCHR(mode)~=0 and 'char device'
    or S_ISFIFO(mode)~=0 and 'named pipe'
    or S_ISLNK(mode)~=0 and 'link'
    or S_ISSOCK(mode)~=0 and 'socket'
    or S_ISREG(mode)~=0 and 'file'
  R.permissions = Format('%o',mode):match'...$':gsub('.',mode2permT)
  return R
end

local MakeAttributes = function -- function --
(
  Stat -- function --
) return function -- table -- of attributes
  (
    filepath -- string --
    ,key -- string|falsy|optional -- gettable
  )
    if type(filepath)~=string then
      return nil
    end
    local T, msg, code = Convert(Stat(filepath))
    if msg then
      return T, msg, code
    end
    if key then
      T = T[key]
      assert(T, "invalid attribute name '" .. key .. "'")
    end
    return T, msg, code
  end
end

M.attributes = MakeAttributes(stat.stat)
M.symlinkattributes = MakeAttributes(stat.lstat)

return M
