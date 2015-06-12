  * 2010/5/15 : **0.2.5 released**
    * [mosh-0.2.5-1.tar.gz](http://mosh-scheme.googlecode.com/files/mosh-0.2.5-1.tar.gz)
    * This release introduces "nmosh" another R6RS environment.
    * Changes
      * Introduce nmosh by OKUMURA Yuki. nmosh is a port of Andre van Tonder's R6RS macro and runtime[1](1.md) and R6RS record from Larceny[2](2.md) with additional expander-cache (ACC) and debugging feature such as runtime stack trace. Although nmosh is intended to a drop-in replacement of previous psyntax based mosh, it is still lacks some mosh specific enhancements against R6RS standard such as SRFI-38, shared namespace with expand/run phases and more. In this version, standard build process(./configure && make) and MSVC solution build both binary which "mosh" is for previous psyntax based runtime and "nmosh" is for nmosh runtime.
        * [1](1.md) http://www.het.brown.edu/people/andre/macros/
        * [2](2.md) http://www.larcenists.org/
      * Configure script now supports out-of-tree building.
      * updated library
        * (irregex) : 0.8.1 (Alex Shinn's irregex library)
        * (mosh process) : Added "exec"
      * new library
        * (shorten) : the shorten formed lambda like Gauche
          * (^a (+ 1 a)) == (lambda (a) (+ 1 a)) etc.
        * (rnrs load) : ERR5RS load (nmosh only)
      * BoehmGC: MIPS32 processor support.
      * MSVC build now depends on MPIR instead of GMP.
        * Download MPIR from http://www.mpir.org and extract to win/mpir. mosh.sln will load and build them together.
        * Note that building MPIR will require yasm installed. see
        * MPIR's own document (mpir/build.vc9/readme.txt) for detail.
      * Bug fixes.
        * Fixed [Issue 141](https://code.google.com/p/mosh-scheme/issues/detail?id=141) reported by mrc.mgg: Profiler(-p) no longer causes sporadic SEGVs while startup.
        * Fixed [Issue 140](https://code.google.com/p/mosh-scheme/issues/detail?id=140) reported by mrc.mgg: R6RS write now uses normal write procedure instead of SRFI-38 printer introduced in 0.2.4.
        * Fixed [Issue 136](https://code.google.com/p/mosh-scheme/issues/detail?id=136) reported by Will.Donnelly: (mosh process) library now exports exec procedure among its friends.
  * 2010/4/15 : 0.2.4 released
    * [mosh-0.2.4.tar.gz](http://mosh-scheme.googlecode.com/files/mosh-0.2.4.tar.gz)
    * Maintenance release
      * Changed Fasl format to handle correctly shared structures.
      * Fixed SEGV on un-closed #| style comment.
      * Added TAIL\_CALL and LOCAL\_TAIL\_CALL instruction. SHIFT instruction is no more used.
      * Replaced R6RS records implmentation.
      * Changed Fasl format to handle shared structures.
      * read/write handle shared structures with srfi-38 style.
      * Fixed [Issue 135](https://code.google.com/p/mosh-scheme/issues/detail?id=135): problem with `letrec*` binding value from function argument, through define, too reported by mrc.mgg.
      * Fixed [Issue 133](https://code.google.com/p/mosh-scheme/issues/detail?id=133): infinite loop in library serialisation reported by mrc.mgg.
      * Fixed [Issue 130](https://code.google.com/p/mosh-scheme/issues/detail?id=130): incorrect error message detail with syntax error reported by mrc.mgg.
      * Fixed [Issue 129](https://code.google.com/p/mosh-scheme/issues/detail?id=129): incorrect handling of imported record types reported by mrc.mgg.
      * Fixed [Issue 97](https://code.google.com/p/mosh-scheme/issues/detail?id=97): variable reference error on `letrec*` reported by tabe.fixedpoint.
      * Fixed [Issue 48](https://code.google.com/p/mosh-scheme/issues/detail?id=48): Extended syntax must raise exception in #!r6rs mode. reported by dico.leque.comicron.
      * Fixed a bug on `letrec*` on backend reported by .mjt.
      * Fixed a bug on reading number by .mjt.
  * 2010/2/28 : **0.2.3 released**
    * [mosh-0.2.3.tar.gz](http://mosh-scheme.googlecode.com/files/mosh-0.2.3.tar.gz)
    * Maintenance release
      * Changed Fasl format to handle correctly shared structures.
      * Fixed SEGV on un-closed #| style comment.
      * Added TAIL\_CALL and LOCAL\_TAIL\_CALL instruction. SHIFT instruction is no more used.

  * 2010/2/9 : **0.2.2 released**
    * [mosh-0.2.2.tar.gz](http://mosh-scheme.googlecode.com/files/mosh-0.2.2.tar.gz)
    * Bug fixes.
      * Fixed VMTest.
      * Fixed named-let which has internal define.
      * Fixed iform-count-size-upto for $UNDEF iform.
      * Fixed a wrong string construction on fasl-read.
      * Fixed [issue 120](https://code.google.com/p/mosh-scheme/issues/detail?id=120) : -v option by mrc.mgg.
      * Fixed [issue 121](https://code.google.com/p/mosh-scheme/issues/detail?id=121) : Wrong validation of arguments for vector-ref by mrc.mgg.
      * Fixed [issue 122](https://code.google.com/p/mosh-scheme/issues/detail?id=122) : Unwanted output characters from time by mrc.mgg.
      * Fixed [issue 123](https://code.google.com/p/mosh-scheme/issues/detail?id=123) : Bad REPL input causes assertion failure, reader does not catch missing closing by mrc.mgg.
      * Fixed [issue 124](https://code.google.com/p/mosh-scheme/issues/detail?id=124) : Bug on multi-line string parse patch by dico.leque.
      * Fixed [issue 125](https://code.google.com/p/mosh-scheme/issues/detail?id=125) : mismatchd paren and bracket patch by dico.leque.
      * Fixed [issue 127](https://code.google.com/p/mosh-scheme/issues/detail?id=127) : An external representation of \f pointed out by dico.leque.
      * Fixed [issue 128](https://code.google.com/p/mosh-scheme/issues/detail?id=128) : Error with sole call/cc pointed out by tabe.
    * New library.
      * Added Alex shinn's IrRegex library (0.7.5) by okuoku.
  * 2009/11/30 : Switched our code repository to [github](http://github.com/higepon/mosh)
    * We switched only the repository, we continue to use Google code for distribution or issue tracking.
  * 2009/08/07 : **0.2.0 released**([release note](http://code.google.com/p/mosh-scheme/source/browse/tags/mosh-0.2.0/RELNOTE))
    * [mosh-0.2.0.tar.gz](http://mosh-scheme.googlecode.com/files/mosh-0.2.0.tar.gz)
    * [mosh-0.2.0-setup-win32.exe](http://mosh-scheme.googlecode.com/files/mosh-0.2.0-setup-win32.exe)
    * Added (mosh concurrent) library.
      * (mosh concurrent) offeres "Erlang (or termite) like" message passing concurrent system.
      * This is alpha version. Please give us your feedback.
      * You can see some samples on mosh/example directory.
    * Added auto-compilation-cache.
      * Loaded libraries will be compiled automatically and stored to the cache directory on first execution.
      * This offers far greater efficiency.
      * --disable-acc and --clean-acc option are avalable.
    * Added (mosh file) library which exports as following procedures.
      * create-directory, delete-directory, rename-file, create-symbolic-link
      * file-directory?, file-symbolic-link?, file-regular?, file-readable?
      * file-executable?, file-writable?, file-size-in-bytes, file-stat-mtime
      * fille-stat-atime, file-stat-ctime,
    * Improved (mosh ffi).
      * Now FFI works on Windows too. (by OKUMURA Yuki)
      * Added pointer procedures.
        * pointer?, shared-errno, pointer->integer, integer->pointer
        * pointer-set-c-int8!, pointer-set-c-int16!,
        * pointer-set-c-int32!, pointer-set-c-int64!, pointer-ref-c-uint8,
        * pointer-ref-c-uint16, pointer-ref-c-uint32, pointer-ref-c-uint64,
        * pointer-ref-c-int8, pointer-ref-c-int16, pointer-ref-c-int32,
        * pointer-ref-c-int64, pointer-ref-c-signed-char, pointer-ref-c-unsigned-char,
        * pointer-ref-c-signed-short, pointer-ref-c-unsigned-short, pointer-ref-c-signed-int,
        * pointer-ref-c-unsigned-int, pointer-ref-c-signed-long, pointer-ref-c-unsigned-long,
        * pointer-ref-c-signed-long-long, pointer-ref-c-unsigned-long-long, pointer-ref-c-float,
        * pointer-ref-c-double, pointer-ref-c-pointer, pointer-set-c-char!, pointer-set-c-short!,
        * pointer-set-c-int!, pointer-set-c-long!, pointer-set-c-long-long!,
        * pointer-set-c-float!, pointer-set-c-double!, pointer-set-c-pointer!,
        * pointer-null, pointer-null?, pointer-diff, pointer-add,
        * pointer=?, pointer<?, pointer>?, pointer<=?, pointer>=?, pointer<>?
    * Rewrite equal? for perfomance reason.
      * Using Efficient Nondestructive Equality Checking for Trees and Graphs Michael D. Adams and R. Kent Dybvig.
    * Improved compilation time.
      * Some critical procedures are rewritten in C++.
    * Updated (lambda wiki).
      * See example/wiki
    * Many bug fixes.
      * Thanks to Marco Maggi, he gave us many detailed bug reports.

  * 2009/05/13 : **0.1.2 released**([release note](http://code.google.com/p/mosh-scheme/source/browse/tags/mosh-0.1.2/RELNOTE))
    * [mosh-0.1.2.tar.gz](http://mosh-scheme.googlecode.com/files/mosh-0.1.2.tar.gz)
    * [mosh-0.1.2-setup-win32.exe](http://mosh-scheme.googlecode.com/files/mosh-0.1.2-setup-win32.exe)
  * 2009/05/03 : **0.1.0 released**([release note](http://code.google.com/p/mosh-scheme/source/browse/tags/mosh-0.1.0/RELNOTE))
    * [mosh-0.1.0.tar.gz](http://mosh-scheme.googlecode.com/files/mosh-0.1.0.tar.gz)
    * [mosh-0.0.1-setup-win32.exe](http://mosh-scheme.googlecode.com/files/mosh-0.0.1-setup-win32.exe)
  * 2008/10/31 : **[version 0.0.7](http://mosh-scheme.googlecode.com/files/mosh-0.0.7.tar.gz) released**([release note](http://code.google.com/p/mosh-scheme/source/browse/tags/mosh-0.0.7/RELNOTE))
  * 2008/08/28 : **[version 0.0.6](http://mosh-scheme.googlecode.com/files/mosh-0.0.6.tar.gz) released**([release note](http://code.google.com/p/mosh-scheme/source/browse/tags/mosh-0.0.6/RELNOTE))
  * 2008/07/18 : **[version 0.0.5](http://mosh-scheme.googlecode.com/files/mosh-0.0.5.tar.gz) released**([release note](http://code.google.com/p/mosh-scheme/source/browse/tags/mosh-0.0.5/RELNOTE))
  * 2008/06/12 : **[version 0.0.4](http://mosh-scheme.googlecode.com/files/mosh-0.0.4.tar.gz) released**([release note](http://code.google.com/p/mosh-scheme/source/browse/tags/mosh-0.0.4/RELNOTE))
  * 2008/05/20 : [version 0.0.3](http://mosh-scheme.googlecode.com/files/mosh-0.0.3.tar.gz) released ([release note](http://code.google.com/p/mosh-scheme/source/browse/tags/mosh-0.0.3/RELNOTE))
  * 2008/05/14 : [version 0.0.2](http://mosh-scheme.googlecode.com/files/mosh-0.0.2.tar.gz) released
  * 2008/05/13 : [version 0.0.1](http://mosh-scheme.googlecode.com/files/mosh-0.0.1.tar.gz) released