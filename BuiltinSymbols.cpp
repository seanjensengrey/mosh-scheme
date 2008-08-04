// Do not edit this file generated by ./scripts/gen-pre-compiled-cpp.scm.
#include "Builtin.h"

using namespace scheme;

const Object* scheme::getBuiltinSymbols() {
    static const Object builtinSymbols[] = {
        SA("!"),
        SA("$"),
        SA("$asm"),
        SA("$call"),
        SA("$call-cc"),
        SA("$const"),
        SA("$define"),
        SA("$filter-map1"),
        SA("$for-each1-with-rindex"),
        SA("$global-assign"),
        SA("$global-ref"),
        SA("$if"),
        SA("$import"),
        SA("$import-spec"),
        SA("$it"),
        SA("$label"),
        SA("$lambda"),
        SA("$let"),
        SA("$library"),
        SA("$library.append-macro!"),
        SA("$library.macro"),
        SA("$list"),
        SA("$local-assign"),
        SA("$local-ref"),
        SA("$lvar"),
        SA("$lvar.sym-proc"),
        SA("$map1"),
        SA("$map1-with-tail"),
        SA("$receive"),
        SA("$seq"),
        SA("$undef"),
        SA("%cars+cdrs"),
        SA("%get-closure-name"),
        SA("*"),
        SA("*compiler-insn*"),
        SA("*insn*"),
        SA("+"),
        SA("-"),
        SA("..."),
        SA("/"),
        SA("<"),
        SA("<="),
        SA("="),
        SA("=>"),
        SA(">"),
        SA(">="),
        SA("?"),
        SA("@"),
        SA("NUMBER_MINUS"),
        SA("OPEN_INPUT_FILE"),
        SA("_"),
        SA("___"),
        SA("a"),
        SA("a2"),
        SA("abort"),
        SA("abs"),
        SA("accum"),
        SA("acond"),
        SA("adjust-arglist"),
        SA("aif"),
        SA("aif->let"),
        SA("alist"),
        SA("alist-cons"),
        SA("and"),
        SA("anonymous"),
        SA("ans"),
        SA("append"),
        SA("append!"),
        SA("append2"),
        SA("appendA"),
        SA("apply"),
        SA("apply-each-pair"),
        SA("arg"),
        SA("arg1"),
        SA("arg2"),
        SA("arg3"),
        SA("argcount-ok?"),
        SA("args"),
        SA("assoc"),
        SA("assoc-ref"),
        SA("assq"),
        SA("assv"),
        SA("b"),
        SA("begin"),
        SA("binop"),
        SA("body"),
        SA("boolean?"),
        SA("bv"),
        SA("bytevector-for-each"),
        SA("bytevector-length"),
        SA("bytevector-u8-ref"),
        SA("bytevector-u8-set!"),
        SA("c"),
        SA("caaaaar"),
        SA("caaaadr"),
        SA("caaaar"),
        SA("caaadar"),
        SA("caaaddr"),
        SA("caaadr"),
        SA("caaar"),
        SA("caadaar"),
        SA("caadadr"),
        SA("caadar"),
        SA("caaddar"),
        SA("caadddr"),
        SA("caaddr"),
        SA("caadr"),
        SA("caar"),
        SA("cadaaar"),
        SA("cadaadr"),
        SA("cadaar"),
        SA("cadadar"),
        SA("cadaddr"),
        SA("cadadr"),
        SA("cadar"),
        SA("caddaar"),
        SA("caddadr"),
        SA("caddar"),
        SA("cadddar"),
        SA("caddddr"),
        SA("cadddr"),
        SA("caddr"),
        SA("cadr"),
        SA("call"),
        SA("call&envs"),
        SA("call-node"),
        SA("call-process"),
        SA("call-with-bytevector-output-port"),
        SA("call-with-current-continuation"),
        SA("call-with-input-file"),
        SA("call-with-output-file"),
        SA("call-with-string-input-port"),
        SA("call-with-string-io"),
        SA("call-with-string-output-port"),
        SA("call-with-values"),
        SA("call/cc"),
        SA("caller"),
        SA("calls"),
        SA("can-frees"),
        SA("car"),
        SA("car+cdr"),
        SA("car-a"),
        SA("car-arg"),
        SA("car-mode"),
        SA("car-p"),
        SA("case"),
        SA("case->cond"),
        SA("cb"),
        SA("cdaaaar"),
        SA("cdaaadr"),
        SA("cdaaar"),
        SA("cdaadar"),
        SA("cdaaddr"),
        SA("cdaadr"),
        SA("cdaar"),
        SA("cdadaar"),
        SA("cdadadr"),
        SA("cdadar"),
        SA("cdaddar"),
        SA("cdadddr"),
        SA("cdaddr"),
        SA("cdadr"),
        SA("cdar"),
        SA("cddaaar"),
        SA("cddaadr"),
        SA("cddaar"),
        SA("cddadar"),
        SA("cddaddr"),
        SA("cddadr"),
        SA("cddar"),
        SA("cdddaar"),
        SA("cdddadr"),
        SA("cdddar"),
        SA("cddddar"),
        SA("cdddddr"),
        SA("cddddr"),
        SA("cdddr"),
        SA("cddr"),
        SA("cdr"),
        SA("cdr-arg"),
        SA("cdr-mode"),
        SA("cdr-p"),
        SA("char"),
        SA("char->integer"),
        SA("char<=?"),
        SA("char<?"),
        SA("char=?"),
        SA("char>=?"),
        SA("char>?"),
        SA("char?"),
        SA("check-arg"),
        SA("circular-list"),
        SA("circular-list?"),
        SA("clauses"),
        SA("clist"),
        SA("close-input-port"),
        SA("close-output-port"),
        SA("closure"),
        SA("closures"),
        SA("cnt"),
        SA("code"),
        SA("code-builder-append!"),
        SA("code-builder-emit"),
        SA("code-builder-put-extra1!"),
        SA("code-builder-put-extra2!"),
        SA("code-builder-put-extra3!"),
        SA("code-builder-put-extra4!"),
        SA("code-builder-put-extra5!"),
        SA("code-builder-put-insn-arg0!"),
        SA("code-builder-put-insn-arg1!"),
        SA("command-line"),
        SA("compile"),
        SA("compile-library-body!"),
        SA("compile-no-optimize"),
        SA("compile-partial"),
        SA("compiled-body"),
        SA("cond"),
        SA("cond->if"),
        SA("conditions"),
        SA("conditions->if"),
        SA("cons"),
        SA("cons*"),
        SA("consumer"),
        SA("content"),
        SA("copy-identifier"),
        SA("count"),
        SA("current-error-port"),
        SA("current-input-port"),
        SA("current-output-port"),
        SA("d"),
        SA("ddk"),
        SA("default"),
        SA("define"),
        SA("define->lambda"),
        SA("define-const-structure"),
        SA("define-is-lambda?"),
        SA("define-macro"),
        SA("define-simple-struct"),
        SA("define-structure"),
        SA("defmacro"),
        SA("defstruct"),
        SA("descend-quasiquote"),
        SA("descend-quasiquote-pair"),
        SA("descend-quasiquote-vector"),
        SA("digit->integer"),
        SA("disjoint"),
        SA("display"),
        SA("dissolved"),
        SA("div"),
        SA("do"),
        SA("dotpair->list"),
        SA("dotted-list?"),
        SA("drop"),
        SA("drop-right"),
        SA("drop-right!"),
        SA("dummy"),
        SA("dynamic-wind"),
        SA("e"),
        SA("e1"),
        SA("e2"),
        SA("eighth"),
        SA("element"),
        SA("elements"),
        SA("else"),
        SA("embed"),
        SA("env"),
        SA("eof-object"),
        SA("eof-object?"),
        SA("eq-hashtable-copy"),
        SA("eq?"),
        SA("equal-hash"),
        SA("equal?"),
        SA("eqv?"),
        SA("erract"),
        SA("error"),
        SA("errorf"),
        SA("eta"),
        SA("eval"),
        SA("eval-core"),
        SA("even?"),
        SA("exact?"),
        SA("except"),
        SA("exit"),
        SA("exp"),
        SA("expand"),
        SA("expand-clauses"),
        SA("expand-let"),
        SA("expand-quasiquote"),
        SA("export"),
        SA("export-syms"),
        SA("f"),
        SA("fail"),
        SA("fifth"),
        SA("file->string"),
        SA("file-exists?"),
        SA("filename"),
        SA("filter"),
        SA("filter-map"),
        SA("finalize-quasiquote"),
        SA("find"),
        SA("find-serial-from-head"),
        SA("find-with-car"),
        SA("find10"),
        SA("first"),
        SA("first-a"),
        SA("first-p"),
        SA("flag"),
        SA("fm"),
        SA("fold"),
        SA("foldl"),
        SA("foldl1"),
        SA("foldr"),
        SA("foldr1"),
        SA("foldr2"),
        SA("for"),
        SA("for-all"),
        SA("for-each"),
        SA("form"),
        SA("formals"),
        SA("format"),
        SA("found"),
        SA("fourth"),
        SA("free"),
        SA("frees"),
        SA("frees-here"),
        SA("g"),
        SA("g126"),
        SA("g134"),
        SA("g167"),
        SA("g206"),
        SA("generic-assoc"),
        SA("gensym"),
        SA("gentemp"),
        SA("get!"),
        SA("get-bytevector-n"),
        SA("get-closure-name"),
        SA("get-environment-variable"),
        SA("get-environment-variables"),
        SA("get-remaining-input-string"),
        SA("get-timeofday"),
        SA("get-u8"),
        SA("guard"),
        SA("hashtable"),
        SA("hashtable->alist"),
        SA("hashtable-clear!"),
        SA("hashtable-contains?"),
        SA("hashtable-copy"),
        SA("hashtable-delete!"),
        SA("hashtable-entries"),
        SA("hashtable-equivalence-function"),
        SA("hashtable-for-each"),
        SA("hashtable-hash-function"),
        SA("hashtable-keys"),
        SA("hashtable-keys->list"),
        SA("hashtable-map"),
        SA("hashtable-mutable?"),
        SA("hashtable-ref"),
        SA("hashtable-set!"),
        SA("hashtable-set-true!"),
        SA("hashtable-size"),
        SA("hashtable-update!"),
        SA("hashtable?"),
        SA("ht"),
        SA("i"),
        SA("iargs"),
        SA("id"),
        SA("if"),
        SA("iform"),
        SA("iform-copy"),
        SA("iform-copy-lvar"),
        SA("iform-copy-zip-lvs"),
        SA("iform-count-size-upto"),
        SA("iform-list"),
        SA("import"),
        SA("import-specs"),
        SA("import-syms"),
        SA("imports"),
        SA("ind"),
        SA("index"),
        SA("init"),
        SA("init-iforms"),
        SA("init-library-table"),
        SA("init-val"),
        SA("inits"),
        SA("insn"),
        SA("integer->char"),
        SA("interesting-to-quasiquote?"),
        SA("internal-define->letrec"),
        SA("it"),
        SA("iter"),
        SA("j"),
        SA("jcall"),
        SA("jump"),
        SA("k"),
        SA("key"),
        SA("keys"),
        SA("kf"),
        SA("knil"),
        SA("kons"),
        SA("ks"),
        SA("l"),
        SA("l1"),
        SA("l2"),
        SA("labels-seen"),
        SA("lag"),
        SA("lambda"),
        SA("lambda-has-define?"),
        SA("lambda-node"),
        SA("last"),
        SA("last-pair"),
        SA("lead"),
        SA("len"),
        SA("length"),
        SA("length>="),
        SA("let"),
        SA("let*"),
        SA("let*->let"),
        SA("let-exp"),
        SA("let-is-named?"),
        SA("let1"),
        SA("let1->let"),
        SA("letrec"),
        SA("level"),
        SA("lib"),
        SA("libname"),
        SA("libname->symbol"),
        SA("library"),
        SA("library-name"),
        SA("limit"),
        SA("lis"),
        SA("lis1"),
        SA("list"),
        SA("list->string"),
        SA("list->vector"),
        SA("list-a"),
        SA("list-b"),
        SA("list-copy"),
        SA("list-ref"),
        SA("list-tabulate"),
        SA("list-tail"),
        SA("list="),
        SA("list?"),
        SA("lists"),
        SA("ll"),
        SA("load"),
        SA("local"),
        SA("locals"),
        SA("loop"),
        SA("lpad"),
        SA("ls"),
        SA("lst"),
        SA("lv"),
        SA("lv-alist"),
        SA("lvar"),
        SA("lvars"),
        SA("macro"),
        SA("macroexpand"),
        SA("macroexpand-1"),
        SA("make-"),
        SA("make-code-builder"),
        SA("make-custom-binary-input-port"),
        SA("make-empty-library"),
        SA("make-eq-hashtable"),
        SA("make-eqv-hashtable"),
        SA("make-hashtable"),
        SA("make-list"),
        SA("make-raw-"),
        SA("make-record-constructor-descriptor"),
        SA("make-record-type-descriptor"),
        SA("make-string"),
        SA("make-transcoder"),
        SA("make-typed-vector"),
        SA("make-vector"),
        SA("make-vector-type"),
        SA("map"),
        SA("map-with-index"),
        SA("map1"),
        SA("marker"),
        SA("match"),
        SA("match-define"),
        SA("match-expr"),
        SA("match-lambda"),
        SA("match-lambda*"),
        SA("match-let"),
        SA("match-let*"),
        SA("match-let1"),
        SA("match-letrec"),
        SA("match:andmap"),
        SA("match:error"),
        SA("match:make-structure-tag"),
        SA("match:primitive-vector?"),
        SA("match:set-error"),
        SA("match:set-error-control"),
        SA("match:set-runtime-structures"),
        SA("match:set-structure-control"),
        SA("match:structure?"),
        SA("match:syntax-err"),
        SA("maybe-elt"),
        SA("member"),
        SA("memq"),
        SA("memv"),
        SA("merge-libname-sym"),
        SA("meta"),
        SA("mod"),
        SA("mode"),
        SA("more"),
        SA("msg"),
        SA("n"),
        SA("name"),
        SA("named-let->letrec"),
        SA("new"),
        SA("new-b"),
        SA("newline"),
        SA("newval"),
        SA("ninth"),
        SA("node"),
        SA("not"),
        SA("not-pair?"),
        SA("null"),
        SA("null-list?"),
        SA("null?"),
        SA("number->string"),
        SA("number?"),
        SA("obj"),
        SA("obj1"),
        SA("obj2"),
        SA("obj3"),
        SA("object"),
        SA("old"),
        SA("only"),
        SA("open-bytevector-output-port"),
        SA("open-file-input-port"),
        SA("open-file-output-port"),
        SA("open-output-file"),
        SA("open-string-input-port"),
        SA("open-string-output-port"),
        SA("operator"),
        SA("optarg"),
        SA("optarg?"),
        SA("or"),
        SA("orig-lvars"),
        SA("others"),
        SA("p"),
        SA("p1"),
        SA("p2"),
        SA("pad"),
        SA("pair"),
        SA("pair?"),
        SA("parse-lambda-args"),
        SA("parse-lambda-vars"),
        SA("pass1/and->iform"),
        SA("pass1/asm-1-arg"),
        SA("pass1/asm-1-arg-optional"),
        SA("pass1/asm-2-arg"),
        SA("pass1/asm-2-arg-optional"),
        SA("pass1/asm-3-arg"),
        SA("pass1/asm-n-args"),
        SA("pass1/asm-numcmp"),
        SA("pass1/assign"),
        SA("pass1/body->iform"),
        SA("pass1/call"),
        SA("pass1/define"),
        SA("pass1/define-macro"),
        SA("pass1/expand"),
        SA("pass1/find-symbol-in-lvars"),
        SA("pass1/if"),
        SA("pass1/import->iform"),
        SA("pass1/lambda->iform"),
        SA("pass1/let"),
        SA("pass1/letrec"),
        SA("pass1/lib-assign->iform"),
        SA("pass1/lib-refer->iform"),
        SA("pass1/library->iform"),
        SA("pass1/macroexpand"),
        SA("pass1/or->iform"),
        SA("pass1/receive"),
        SA("pass1/refer->iform"),
        SA("pass1/sexp->iform"),
        SA("pass2/$asm"),
        SA("pass2/$call"),
        SA("pass2/$if"),
        SA("pass2/$lambda"),
        SA("pass2/$let"),
        SA("pass2/$local-ref"),
        SA("pass2/$receive"),
        SA("pass2/$seq"),
        SA("pass2/adjust-arglist"),
        SA("pass2/argcount-ok?"),
        SA("pass2/classify-calls"),
        SA("pass2/classify-local-ref-call"),
        SA("pass2/collect-call"),
        SA("pass2/const-inliner"),
        SA("pass2/eliminate-let"),
        SA("pass2/empty"),
        SA("pass2/expand-inlined-procedure"),
        SA("pass2/local-call-embedder"),
        SA("pass2/local-call-inliner"),
        SA("pass2/local-call-optimizer"),
        SA("pass2/optimize"),
        SA("pass2/optimize-closure"),
        SA("pass2/optimize-local-ref"),
        SA("pass2/register"),
        SA("pass2/remove-vars"),
        SA("pass2/self-recursing?"),
        SA("pass2/split-args"),
        SA("pass3"),
        SA("pass3/$asm"),
        SA("pass3/$asm-1-arg"),
        SA("pass3/$asm-2-arg"),
        SA("pass3/$asm-3-arg"),
        SA("pass3/$asm-n-args"),
        SA("pass3/$call"),
        SA("pass3/$call-cc"),
        SA("pass3/$const"),
        SA("pass3/$define"),
        SA("pass3/$global-assign"),
        SA("pass3/$global-ref"),
        SA("pass3/$if"),
        SA("pass3/$import"),
        SA("pass3/$it"),
        SA("pass3/$lambda"),
        SA("pass3/$let"),
        SA("pass3/$library"),
        SA("pass3/$list"),
        SA("pass3/$local-assign"),
        SA("pass3/$local-ref"),
        SA("pass3/$receive"),
        SA("pass3/$seq"),
        SA("pass3/$undef"),
        SA("pass3/collect-free"),
        SA("pass3/compile-arg"),
        SA("pass3/compile-args"),
        SA("pass3/compile-assign"),
        SA("pass3/compile-refer"),
        SA("pass3/exists-in-can-frees?"),
        SA("pass3/find-free"),
        SA("pass3/find-sets"),
        SA("pass3/letrec"),
        SA("pass3/make-boxes"),
        SA("pass3/rec"),
        SA("pass3/register"),
        SA("pass3/return-assign-free"),
        SA("pass3/return-assign-local"),
        SA("pass3/return-refer-free"),
        SA("pass3/return-refer-local"),
        SA("pass3/symbol-lookup"),
        SA("pass4"),
        SA("pass4/fixup-labels"),
        SA("pat"),
        SA("path"),
        SA("pattern"),
        SA("pl"),
        SA("plist"),
        SA("port"),
        SA("pos"),
        SA("pp-lvars"),
        SA("pred"),
        SA("pred?"),
        SA("prefix"),
        SA("pretty-iform"),
        SA("print"),
        SA("proc"),
        SA("procedure?"),
        SA("producer"),
        SA("proper-list?"),
        SA("ps"),
        SA("q"),
        SA("quasiquote"),
        SA("quote"),
        SA("r"),
        SA("raise"),
        SA("raise-continuable"),
        SA("read"),
        SA("read-char"),
        SA("read-line"),
        SA("readdir"),
        SA("rec"),
        SA("rec-calls"),
        SA("receive"),
        SA("record-accessor"),
        SA("record-constructor"),
        SA("record-mutator"),
        SA("record-predicate"),
        SA("ref-count"),
        SA("regexp->string"),
        SA("regexp-replace"),
        SA("regexp-replace-all"),
        SA("regexp?"),
        SA("releq"),
        SA("remove-tail"),
        SA("remp"),
        SA("rename"),
        SA("rename-set"),
        SA("reqargs"),
        SA("rest"),
        SA("result"),
        SA("ret"),
        SA("return"),
        SA("return-free"),
        SA("return-local"),
        SA("reverse"),
        SA("reversed-frees"),
        SA("ri"),
        SA("rl"),
        SA("rpad"),
        SA("rr"),
        SA("run"),
        SA("rxmatch"),
        SA("rxmatch-after"),
        SA("rxmatch-before"),
        SA("rxmatch-end"),
        SA("rxmatch-start"),
        SA("rxmatch-substring"),
        SA("s"),
        SA("sample-count"),
        SA("second"),
        SA("sel"),
        SA("set"),
        SA("set!"),
        SA("set-"),
        SA("set-box!"),
        SA("set-car!"),
        SA("set-cdr!"),
        SA("set-count"),
        SA("set-current-input-port!"),
        SA("set-current-output-port!"),
        SA("set-source-info!"),
        SA("set-symbol-value!"),
        SA("sets"),
        SA("seventh"),
        SA("sexp"),
        SA("sf"),
        SA("show-profile"),
        SA("sixth"),
        SA("size"),
        SA("sort"),
        SA("sort!"),
        SA("source-info"),
        SA("split-at"),
        SA("split-at!"),
        SA("src"),
        SA("stack-size"),
        SA("standard-input-port"),
        SA("start"),
        SA("str"),
        SA("string"),
        SA("string->lines"),
        SA("string->list"),
        SA("string->number"),
        SA("string->regexp"),
        SA("string->symbol"),
        SA("string-append"),
        SA("string-chop"),
        SA("string-ci-hash"),
        SA("string-hash"),
        SA("string-length"),
        SA("string-ref"),
        SA("string-set!"),
        SA("string-split"),
        SA("string=?"),
        SA("string?"),
        SA("suma"),
        SA("sym"),
        SA("symbol"),
        SA("symbol->string"),
        SA("symbol-concat"),
        SA("symbol-hash"),
        SA("symbol-value"),
        SA("symbol?"),
        SA("symbols"),
        SA("syntax-error"),
        SA("sys-display"),
        SA("sys-get-bytevector"),
        SA("sys-get-output-string"),
        SA("sys-open-bytevector-output-port"),
        SA("sys-open-output-string"),
        SA("sys-port-seek"),
        SA("t?"),
        SA("tag"),
        SA("tail"),
        SA("tail-rec"),
        SA("tail?"),
        SA("take"),
        SA("take!"),
        SA("take-right"),
        SA("tenth"),
        SA("test"),
        SA("then"),
        SA("third"),
        SA("thunk"),
        SA("tmpname"),
        SA("to"),
        SA("top"),
        SA("top level :$:$ASM"),
        SA("top level :$:$CALL"),
        SA("top level :$:$CALL-CC"),
        SA("top level :$:$CONST"),
        SA("top level :$:$DEFINE"),
        SA("top level :$:$GLOBAL-ASSIGN"),
        SA("top level :$:$GLOBAL-REF"),
        SA("top level :$:$IF"),
        SA("top level :$:$IMPORT"),
        SA("top level :$:$IMPORT-SPEC"),
        SA("top level :$:$INSN-NUM"),
        SA("top level :$:$IT"),
        SA("top level :$:$LABEL"),
        SA("top level :$:$LAMBDA"),
        SA("top level :$:$LET"),
        SA("top level :$:$LIBRARY"),
        SA("top level :$:$LIST"),
        SA("top level :$:$LOCAL-ASSIGN"),
        SA("top level :$:$LOCAL-REF"),
        SA("top level :$:$LVAR"),
        SA("top level :$:$RECEIVE"),
        SA("top level :$:$SEQ"),
        SA("top level :$:$UNDEF"),
        SA("top level :$:$asm"),
        SA("top level :$:$call"),
        SA("top level :$:$call-cc"),
        SA("top level :$:$const"),
        SA("top level :$:$define"),
        SA("top level :$:$filter-map1"),
        SA("top level :$:$for-each1-with-rindex"),
        SA("top level :$:$global-assign"),
        SA("top level :$:$global-ref"),
        SA("top level :$:$if"),
        SA("top level :$:$import"),
        SA("top level :$:$import-spec"),
        SA("top level :$:$it"),
        SA("top level :$:$label"),
        SA("top level :$:$lambda"),
        SA("top level :$:$let"),
        SA("top level :$:$library"),
        SA("top level :$:$list"),
        SA("top level :$:$local-assign"),
        SA("top level :$:$local-ref"),
        SA("top level :$:$lvar"),
        SA("top level :$:$lvar.sym-proc"),
        SA("top level :$:$map1"),
        SA("top level :$:$map1-with-tail"),
        SA("top level :$:$receive"),
        SA("top level :$:$seq"),
        SA("top level :$:$undef"),
        SA("top level :$:%cars+cdrs"),
        SA("top level :$:*command-line-args*"),
        SA("top level :$:*free-vars-decl*"),
        SA("top level :$:SMALL_LAMBDA_SIZE"),
        SA("top level :$:abs"),
        SA("top level :$:adjust-arglist"),
        SA("top level :$:aif->let"),
        SA("top level :$:alist-cons"),
        SA("top level :$:apply-each-pair"),
        SA("top level :$:argcount-ok?"),
        SA("top level :$:assoc"),
        SA("top level :$:assoc-ref"),
        SA("top level :$:assq"),
        SA("top level :$:assv"),
        SA("top level :$:bytevector-for-each"),
        SA("top level :$:caaaaar"),
        SA("top level :$:caaaadr"),
        SA("top level :$:caaaar"),
        SA("top level :$:caaadar"),
        SA("top level :$:caaaddr"),
        SA("top level :$:caaadr"),
        SA("top level :$:caaar"),
        SA("top level :$:caadaar"),
        SA("top level :$:caadadr"),
        SA("top level :$:caadar"),
        SA("top level :$:caaddar"),
        SA("top level :$:caadddr"),
        SA("top level :$:caaddr"),
        SA("top level :$:caadr"),
        SA("top level :$:caar"),
        SA("top level :$:cadaaar"),
        SA("top level :$:cadaadr"),
        SA("top level :$:cadaar"),
        SA("top level :$:cadadar"),
        SA("top level :$:cadaddr"),
        SA("top level :$:cadadr"),
        SA("top level :$:cadar"),
        SA("top level :$:caddaar"),
        SA("top level :$:caddadr"),
        SA("top level :$:caddar"),
        SA("top level :$:cadddar"),
        SA("top level :$:caddddr"),
        SA("top level :$:cadddr"),
        SA("top level :$:caddr"),
        SA("top level :$:cadr"),
        SA("top level :$:call-with-bytevector-output-port"),
        SA("top level :$:call-with-input-file"),
        SA("top level :$:call-with-output-file"),
        SA("top level :$:call-with-string-input-port"),
        SA("top level :$:call-with-string-io"),
        SA("top level :$:call-with-string-output-port"),
        SA("top level :$:call-with-values"),
        SA("top level :$:car+cdr"),
        SA("top level :$:case->cond"),
        SA("top level :$:cdaaaar"),
        SA("top level :$:cdaaadr"),
        SA("top level :$:cdaaar"),
        SA("top level :$:cdaadar"),
        SA("top level :$:cdaaddr"),
        SA("top level :$:cdaadr"),
        SA("top level :$:cdaar"),
        SA("top level :$:cdadaar"),
        SA("top level :$:cdadadr"),
        SA("top level :$:cdadar"),
        SA("top level :$:cdaddar"),
        SA("top level :$:cdadddr"),
        SA("top level :$:cdaddr"),
        SA("top level :$:cdadr"),
        SA("top level :$:cdar"),
        SA("top level :$:cddaaar"),
        SA("top level :$:cddaadr"),
        SA("top level :$:cddaar"),
        SA("top level :$:cddadar"),
        SA("top level :$:cddaddr"),
        SA("top level :$:cddadr"),
        SA("top level :$:cddar"),
        SA("top level :$:cdddaar"),
        SA("top level :$:cdddadr"),
        SA("top level :$:cdddar"),
        SA("top level :$:cddddar"),
        SA("top level :$:cdddddr"),
        SA("top level :$:cddddr"),
        SA("top level :$:cdddr"),
        SA("top level :$:cddr"),
        SA("top level :$:char-numeric?"),
        SA("top level :$:check-arg"),
        SA("top level :$:circular-list"),
        SA("top level :$:circular-list?"),
        SA("top level :$:command-line"),
        SA("top level :$:compile"),
        SA("top level :$:compile-library-body!"),
        SA("top level :$:compile-no-optimize"),
        SA("top level :$:compile-partial"),
        SA("top level :$:cond->if"),
        SA("top level :$:conditions->if"),
        SA("top level :$:cons*"),
        SA("top level :$:copy-identifier"),
        SA("top level :$:dd"),
        SA("top level :$:define->lambda"),
        SA("top level :$:define-is-lambda?"),
        SA("top level :$:descend-quasiquote"),
        SA("top level :$:descend-quasiquote-pair"),
        SA("top level :$:descend-quasiquote-vector"),
        SA("top level :$:display"),
        SA("top level :$:dotimes"),
        SA("top level :$:dotpair->list"),
        SA("top level :$:dotted-list?"),
        SA("top level :$:drop"),
        SA("top level :$:drop-right"),
        SA("top level :$:drop-right!"),
        SA("top level :$:eighth"),
        SA("top level :$:eq-hashtable-copy"),
        SA("top level :$:eval-core"),
        SA("top level :$:even?"),
        SA("top level :$:exact?"),
        SA("top level :$:expand-clauses"),
        SA("top level :$:expand-let"),
        SA("top level :$:expand-quasiquote"),
        SA("top level :$:field-name"),
        SA("top level :$:fifth"),
        SA("top level :$:file->string"),
        SA("top level :$:filter"),
        SA("top level :$:filter-map"),
        SA("top level :$:finalize-quasiquote"),
        SA("top level :$:find"),
        SA("top level :$:find-serial-from-head"),
        SA("top level :$:find-with-car"),
        SA("top level :$:first"),
        SA("top level :$:fold"),
        SA("top level :$:fold-left"),
        SA("top level :$:fold-right"),
        SA("top level :$:foldl"),
        SA("top level :$:foldl1"),
        SA("top level :$:foldr"),
        SA("top level :$:foldr1"),
        SA("top level :$:foldr2"),
        SA("top level :$:for-all"),
        SA("top level :$:for-each"),
        SA("top level :$:fourth"),
        SA("top level :$:generic-assoc"),
        SA("top level :$:get-closure-name"),
        SA("top level :$:hashtable->alist"),
        SA("top level :$:hashtable-entries"),
        SA("top level :$:hashtable-for-each"),
        SA("top level :$:hashtable-keys->list"),
        SA("top level :$:hashtable-map"),
        SA("top level :$:hashtable-set-true!"),
        SA("top level :$:hashtable-update!"),
        SA("top level :$:i"),
        SA("top level :$:iform-copy"),
        SA("top level :$:iform-copy-lvar"),
        SA("top level :$:iform-copy-zip-lvs"),
        SA("top level :$:iform-count-size-upto"),
        SA("top level :$:integer?"),
        SA("top level :$:interesting-to-quasiquote?"),
        SA("top level :$:internal-define->letrec"),
        SA("top level :$:lambda-has-define?"),
        SA("top level :$:last"),
        SA("top level :$:last-pair"),
        SA("top level :$:let*->let"),
        SA("top level :$:let-is-named?"),
        SA("top level :$:let1->let"),
        SA("top level :$:libname->symbol"),
        SA("top level :$:libraries"),
        SA("top level :$:library-name"),
        SA("top level :$:list"),
        SA("top level :$:list->string"),
        SA("top level :$:list->vector"),
        SA("top level :$:list-copy"),
        SA("top level :$:list-ref"),
        SA("top level :$:list-tabulate"),
        SA("top level :$:list-tail"),
        SA("top level :$:list="),
        SA("top level :$:lpad"),
        SA("top level :$:macroexpand"),
        SA("top level :$:make-empty-library"),
        SA("top level :$:make-list"),
        SA("top level :$:map"),
        SA("top level :$:map-with-index"),
        SA("top level :$:map1"),
        SA("top level :$:match:andmap"),
        SA("top level :$:match:disjoint-predicates"),
        SA("top level :$:match:disjoint-structure-tags"),
        SA("top level :$:match:error"),
        SA("top level :$:match:error-control"),
        SA("top level :$:match:expanders"),
        SA("top level :$:match:make-structure-tag"),
        SA("top level :$:match:primitive-vector?"),
        SA("top level :$:match:runtime-structures"),
        SA("top level :$:match:set-error"),
        SA("top level :$:match:set-error-control"),
        SA("top level :$:match:set-runtime-structures"),
        SA("top level :$:match:set-structure-control"),
        SA("top level :$:match:structure-control"),
        SA("top level :$:match:structure?"),
        SA("top level :$:match:syntax-err"),
        SA("top level :$:match:vector-structures"),
        SA("top level :$:match:version"),
        SA("top level :$:merge-libname-sym"),
        SA("top level :$:named-let->letrec"),
        SA("top level :$:newline"),
        SA("top level :$:ninth"),
        SA("top level :$:not"),
        SA("top level :$:not-pair?"),
        SA("top level :$:null-list?"),
        SA("top level :$:open-bytevector-output-port"),
        SA("top level :$:open-string-output-port"),
        SA("top level :$:parse-lambda-args"),
        SA("top level :$:parse-lambda-vars"),
        SA("top level :$:pass1/and->iform"),
        SA("top level :$:pass1/asm-1-arg"),
        SA("top level :$:pass1/asm-1-arg-optional"),
        SA("top level :$:pass1/asm-2-arg"),
        SA("top level :$:pass1/asm-2-arg-optional"),
        SA("top level :$:pass1/asm-3-arg"),
        SA("top level :$:pass1/asm-n-args"),
        SA("top level :$:pass1/asm-numcmp"),
        SA("top level :$:pass1/assign"),
        SA("top level :$:pass1/body->iform"),
        SA("top level :$:pass1/call"),
        SA("top level :$:pass1/define"),
        SA("top level :$:pass1/define-macro"),
        SA("top level :$:pass1/expand"),
        SA("top level :$:pass1/find-symbol-in-lvars"),
        SA("top level :$:pass1/if"),
        SA("top level :$:pass1/import->iform"),
        SA("top level :$:pass1/lambda->iform"),
        SA("top level :$:pass1/let"),
        SA("top level :$:pass1/letrec"),
        SA("top level :$:pass1/lib-assign->iform"),
        SA("top level :$:pass1/lib-refer->iform"),
        SA("top level :$:pass1/library->iform"),
        SA("top level :$:pass1/macroexpand"),
        SA("top level :$:pass1/or->iform"),
        SA("top level :$:pass1/receive"),
        SA("top level :$:pass1/refer->iform"),
        SA("top level :$:pass1/sexp->iform"),
        SA("top level :$:pass2/$asm"),
        SA("top level :$:pass2/$call"),
        SA("top level :$:pass2/$if"),
        SA("top level :$:pass2/$lambda"),
        SA("top level :$:pass2/$let"),
        SA("top level :$:pass2/$local-ref"),
        SA("top level :$:pass2/$receive"),
        SA("top level :$:pass2/$seq"),
        SA("top level :$:pass2/adjust-arglist"),
        SA("top level :$:pass2/argcount-ok?"),
        SA("top level :$:pass2/classify-calls"),
        SA("top level :$:pass2/classify-local-ref-call"),
        SA("top level :$:pass2/collect-call"),
        SA("top level :$:pass2/const-inliner"),
        SA("top level :$:pass2/dispatch-table"),
        SA("top level :$:pass2/eliminate-let"),
        SA("top level :$:pass2/empty"),
        SA("top level :$:pass2/expand-inlined-procedure"),
        SA("top level :$:pass2/local-call-embedder"),
        SA("top level :$:pass2/local-call-inliner"),
        SA("top level :$:pass2/local-call-optimizer"),
        SA("top level :$:pass2/optimize"),
        SA("top level :$:pass2/optimize-closure"),
        SA("top level :$:pass2/optimize-local-ref"),
        SA("top level :$:pass2/register"),
        SA("top level :$:pass2/remove-vars"),
        SA("top level :$:pass2/self-recursing?"),
        SA("top level :$:pass2/split-args"),
        SA("top level :$:pass3"),
        SA("top level :$:pass3/$asm"),
        SA("top level :$:pass3/$asm-1-arg"),
        SA("top level :$:pass3/$asm-2-arg"),
        SA("top level :$:pass3/$asm-3-arg"),
        SA("top level :$:pass3/$asm-n-args"),
        SA("top level :$:pass3/$call"),
        SA("top level :$:pass3/$call-cc"),
        SA("top level :$:pass3/$const"),
        SA("top level :$:pass3/$define"),
        SA("top level :$:pass3/$global-assign"),
        SA("top level :$:pass3/$global-ref"),
        SA("top level :$:pass3/$if"),
        SA("top level :$:pass3/$import"),
        SA("top level :$:pass3/$it"),
        SA("top level :$:pass3/$lambda"),
        SA("top level :$:pass3/$let"),
        SA("top level :$:pass3/$library"),
        SA("top level :$:pass3/$list"),
        SA("top level :$:pass3/$local-assign"),
        SA("top level :$:pass3/$local-ref"),
        SA("top level :$:pass3/$receive"),
        SA("top level :$:pass3/$seq"),
        SA("top level :$:pass3/$undef"),
        SA("top level :$:pass3/collect-free"),
        SA("top level :$:pass3/compile-arg"),
        SA("top level :$:pass3/compile-args"),
        SA("top level :$:pass3/compile-assign"),
        SA("top level :$:pass3/compile-refer"),
        SA("top level :$:pass3/dispatch-table"),
        SA("top level :$:pass3/exists-in-can-frees?"),
        SA("top level :$:pass3/find-free"),
        SA("top level :$:pass3/find-sets"),
        SA("top level :$:pass3/letrec"),
        SA("top level :$:pass3/make-boxes"),
        SA("top level :$:pass3/rec"),
        SA("top level :$:pass3/register"),
        SA("top level :$:pass3/return-assign-free"),
        SA("top level :$:pass3/return-assign-local"),
        SA("top level :$:pass3/return-refer-free"),
        SA("top level :$:pass3/return-refer-local"),
        SA("top level :$:pass3/symbol-lookup"),
        SA("top level :$:pass4"),
        SA("top level :$:pass4/fixup-labels"),
        SA("top level :$:pp"),
        SA("top level :$:pp-lvars"),
        SA("top level :$:pretty-iform"),
        SA("top level :$:print"),
        SA("top level :$:proper-list?"),
        SA("top level :$:push!"),
        SA("top level :$:read-line"),
        SA("top level :$:remove-tail"),
        SA("top level :$:remp"),
        SA("top level :$:reverse"),
        SA("top level :$:rpad"),
        SA("top level :$:second"),
        SA("top level :$:seventh"),
        SA("top level :$:show-profile"),
        SA("top level :$:sixth"),
        SA("top level :$:sort"),
        SA("top level :$:sort!"),
        SA("top level :$:split-at"),
        SA("top level :$:split-at!"),
        SA("top level :$:string->lines"),
        SA("top level :$:string->list"),
        SA("top level :$:string-chop"),
        SA("top level :$:substring"),
        SA("top level :$:suma"),
        SA("top level :$:symbol-concat"),
        SA("top level :$:syntax-error"),
        SA("top level :$:take"),
        SA("top level :$:take!"),
        SA("top level :$:take-right"),
        SA("top level :$:tenth"),
        SA("top level :$:third"),
        SA("top level :$:top-level-library"),
        SA("top level :$:top-level-sym"),
        SA("top level :$:typed-vector-accessor"),
        SA("top level :$:typed-vector-constructor"),
        SA("top level :$:typed-vector-mutator"),
        SA("top level :$:uniq"),
        SA("top level :$:unless->cond"),
        SA("top level :$:vector-for-each"),
        SA("top level :$:vector-map"),
        SA("top level :$:vector-type-predicate"),
        SA("top level :$:void"),
        SA("top level :$:with-input-from-file"),
        SA("top level :$:write-char"),
        SA("top level :$:write-to-file"),
        SA("top level :$:xcons"),
        SA("top level :$:zero?"),
        SA("transcoded-port"),
        SA("transcoder"),
        SA("trec"),
        SA("tst"),
        SA("type"),
        SA("typed-vector-accessor"),
        SA("typed-vector-constructor"),
        SA("typed-vector-get-nth"),
        SA("typed-vector-mutator"),
        SA("typed-vector-set-nth"),
        SA("typed-vector-type"),
        SA("typed-vector?"),
        SA("unbox"),
        SA("uniq"),
        SA("unless"),
        SA("unless->cond"),
        SA("unquote"),
        SA("unquote-splicing"),
        SA("unspecified"),
        SA("utf-8-codec"),
        SA("utf8->string"),
        SA("v"),
        SA("val"),
        SA("val1"),
        SA("vals"),
        SA("value"),
        SA("values"),
        SA("var"),
        SA("vars"),
        SA("vector"),
        SA("vector->list"),
        SA("vector-for-each"),
        SA("vector-length"),
        SA("vector-map"),
        SA("vector-ref"),
        SA("vector-set!"),
        SA("vector-type-data"),
        SA("vector-type-instance-of?"),
        SA("vector-type-predicate"),
        SA("vector-type?"),
        SA("vector?"),
        SA("vm/apply"),
        SA("void"),
        SA("vt"),
        SA("when"),
        SA("with-exception-handler"),
        SA("with-input-from-file"),
        SA("write"),
        SA("write-to-file"),
        SA("x"),
        SA("x1"),
        SA("xcons"),
        SA("y"),
        SA("zero?"),
    };
    return builtinSymbols;
}
