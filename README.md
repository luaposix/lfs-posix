lfs-posix
=========

By the [lfs-posix project][github]

[![License](https://img.shields.io/:license-mit-blue.svg)](https://mit-license.org)

This is a a pure [Lua][] implementation of [LuaFileSystem][] implemented
over the [luaposix][] bindings to the C APIs on the underlying system;
because of that it won't work on non-POSIX systems.

lfs-posix is released under the [MIT license][mit] (the same license as
Lua itsef).  There is no warranty.

[github]: https://github.com/luaposix/lfs-posix "lfs-posix repository"
[lua]: https://www.lua.org/ "The Lua Project"
[luaposix]: https://github.com/luaposix/luaposix "luaposix repository"
[LuaFileSystem]: https://lunarmodules.github.io/luafilesystem/ "Lua File System Project"
[mit]: https://mit-license.org "MIT license"

Bugs reports and code contributions
-----------------------------------

These libraries are maintained by their users.

Please make bug reports and suggestions as [GitHub issues][issues].
Pull requests are especially appreciated.

But first, please check that your issue has not already been reported by
someone else, and that it is not already fixed on [master][github] in
preparation for the next release.

There is no strict coding style, but please bear in mind the following
points when proposing changes:

0. Follow existing code. There are a lot of useful patterns and
   avoided traps there.

1. 8-character indentation using TABs in C sources; 3-character
   indentation using SPACEs in Lua sources.

2. Simple strings are easiest to type using single-quote delimiters
   saving double-quotes for where a string contains apostrophes.

3. Save horizontal space by only using SPACEs where the parser requires
   them.

4. Use vertical space to separate out compound statements to help the
   coverage reports discover untested lines.

5. Prefer explicit string function calls over object methods, to mitigate
   issues with monkey-patching in caller environment. 

[issues]: http://github.com/lfs-posix/lfs-posix/issues
