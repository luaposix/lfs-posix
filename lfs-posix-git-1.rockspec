local _MODREV, _SPECREV = 'git', '-1'

package = 'lfs-posix'
version = _MODREV .. _SPECREV

description = {
   summary = 'Pure Lua LFS API over luaposix',
   detailed = [[
      A portable reimplementation of the LuaFileSystem APIs that depends
      only on luaposix.
   ]],
   homepage = 'http://luaposix.github.io/lfs-posix',
   license = 'MIT/X11',
}

dependencies = {
   'lua >= 5.1, < 5.5',
   'luaposix >= 36.0.0',
}

source = {
   url = 'http://github.com/luaposix/lfs-posix/archive/v' .. _MODREV .. '.zip',
   dir = 'lfs-posix-' .. _MODREV,
}

build = {
   type = 'builtin',
   modules = {
      ['posix.lfs'] = 'lib/posix/lfs/init.lua',
   },
   copy_directories = {'doc'},
}

if _MODREV == 'git' then
   build.copy_directories = nil

   source = {
      url = 'git://github.com/luaposix/lfs-posix.git',
   }
end
