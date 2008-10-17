;; Do not edit this file generated by ./scripts/gen-free-vars-decl.scm.
(define *free-vars-decl* '(number? cons car cdr null? set-car! set-cdr! sys-display rxmatch regexp? regexp->string rxmatch-start rxmatch-end rxmatch-after rxmatch-before rxmatch-substring make-string string-set! string-length string->symbol string->number string-append string-split string number->string reverse eof-object? read-char char=? string? get-environment-variable get-environment-variables equal? open-string-input-port sys-open-output-string sys-port-seek open-output-file close-output-port digit->integer get-remaining-input-string readdir file-exists? delete-file sys-get-output-string string->regexp char->integer integer->char format current-input-port current-output-port set-current-input-port! set-current-output-port! char? write gensym string=? vector? list? memq eq? eqv? member boolean? symbol->string string-ref error assertion-violation get-timeofday make-eq-hashtable make-eqv-hashtable hashtable-set! hashtable-ref hashtable-keys string-hash string-ci-hash symbol-hash equal-hash eq-hashtable-copy current-error-port values vm/apply pair? init-library-table make-custom-binary-input-port get-u8 bytevector-u8-set! transcoded-port utf-8-codec make-transcoder eof-object sys-open-bytevector-output-port sys-get-bytevector bytevector-length standard-input-port get-bytevector-n utf8->string open-file-output-port open-file-input-port close-input-port vector regexp-replace regexp-replace-all source-info eval apply mod div assq exit macroexpand-1 memv procedure? load symbol? char<=? char<? char>=? char>? read vector->list set-source-info! call-process %get-closure-name append append2 append! pass3/find-free pass3/find-sets pass4/fixup-labels make-code-builder code-builder-put-extra1! code-builder-put-extra2! code-builder-put-extra3! code-builder-put-extra4! code-builder-put-extra5! code-builder-append! code-builder-emit code-builder-put-insn-arg0! code-builder-put-insn-arg1! length list->vector pass3/compile-refer pass1/find-symbol-in-lvars $label $local-ref symbol-value set-symbol-value! make-hashtable hashtable? hashtable-size hashtable-delete! hashtable-contains? hashtable-copy hashtable-mutable? hashtable-clear! hashtable-keys hashtable-equivalence-function hashtable-hash-function make-record-type-descriptor make-record-constructor-descriptor record-predicate record-constructor record-accessor record-mutator record? record-rtd record-type-name record-type-parent record-type-uid record-type-generative? record-type-sealed? record-type-opaque? record-type-field-names record-field-mutable? record-type-descriptor? condition simple-conditions condition? condition-accessor condition-predicate throw < <= > >= = + - * / max min lookahead-char bytevector? current-directory standard-library-path quotient remainder native-endianness make-bytevector make-bytevector bytevector-length bytevector=? bytevector-fill! bytevector-copy! bytevector-copy bytevector-u8-ref bytevector-u8-set! bytevector-s8-ref bytevector-s8-set! bytevector->u8-list u8-list->bytevector bytevector-u16-ref bytevector-s16-ref bytevector-u16-native-ref bytevector-s16-native-ref bytevector-u16-set! bytevector-s16-set! bytevector-u16-native-set! bytevector-s16-native-set! bytevector-u32-ref bytevector-s32-ref bytevector-u32-native-ref bytevector-s32-native-ref bytevector-u32-set! bytevector-s32-set! bytevector-u32-native-set! bytevector-s32-native-set! bytevector-u64-ref bytevector-s64-ref bytevector-u64-native-ref bytevector-s64-native-ref bytevector-u64-set! bytevector-s64-set! bytevector-u64-native-set! bytevector-s64-native-set! bytevector->string string->bytevector))