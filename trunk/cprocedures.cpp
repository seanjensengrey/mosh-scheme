// Do not edit this file generated by gen-cproc.scm
const int cProcNum = 154;
static const Object cProcs[] = {
     Object::makeCProcedure(localRefEx),
     Object::makeCProcedure(labelEx),
     Object::makeCProcedure(pass1FindSymbolInLvarsEx),
     Object::makeCProcedure(pass3CompileReferEx),
     Object::makeCProcedure(listTovectorEx),
     Object::makeCProcedure(lengthEx),
     Object::makeCProcedure(codeBuilderPutInsnArg1DEx),
     Object::makeCProcedure(codeBuilderPutInsnArg0DEx),
     Object::makeCProcedure(codeBuilderEmitEx),
     Object::makeCProcedure(codeBuilderAppendDEx),
     Object::makeCProcedure(codeBuilderPutExtra5DEx),
     Object::makeCProcedure(codeBuilderPutExtra4DEx),
     Object::makeCProcedure(codeBuilderPutExtra3DEx),
     Object::makeCProcedure(codeBuilderPutExtra2DEx),
     Object::makeCProcedure(codeBuilderPutExtra1DEx),
     Object::makeCProcedure(makeCodeBuilderEx),
     Object::makeCProcedure(pass4FixupLabelsEx),
     Object::makeCProcedure(pass3FindSetsEx),
     Object::makeCProcedure(pass3FindFreeEx),
     Object::makeCProcedure(appendDEx),
     Object::makeCProcedure(appendAEx),
     Object::makeCProcedure(append2Ex),
     Object::makeCProcedure(appendEx),
     Object::makeCProcedure(internalgetClosureNameEx),
     Object::makeCProcedure(callProcessEx),
     Object::makeCProcedure(setSourceInfoDEx),
     Object::makeCProcedure(vectorTolistEx),
     Object::makeCProcedure(readEx),
     Object::makeCProcedure(charGtPEx),
     Object::makeCProcedure(charGePEx),
     Object::makeCProcedure(charLtPEx),
     Object::makeCProcedure(charLePEx),
     Object::makeCProcedure(dynamicWindEx),
     Object::makeCProcedure(symbolPEx),
     Object::makeCProcedure(loadEx),
     Object::makeCProcedure(procedurePEx),
     Object::makeCProcedure(memvEx),
     Object::makeCProcedure(macroexpand1Ex),
     Object::makeCProcedure(exitEx),
     Object::makeCProcedure(assqEx),
     Object::makeCProcedure(divEx),
     Object::makeCProcedure(modEx),
     Object::makeCProcedure(applyEx),
     Object::makeCProcedure(typedVectorTypeEx),
     Object::makeCProcedure(typedVectorPEx),
     Object::makeCProcedure(typedVectorSetNthEx),
     Object::makeCProcedure(typedVectorGetNthEx),
     Object::makeCProcedure(makeTypedVectorEx),
     Object::makeCProcedure(vectorTypeInstanceOfPEx),
     Object::makeCProcedure(vectorTypeDataEx),
     Object::makeCProcedure(vectorTypePEx),
     Object::makeCProcedure(makeVectorTypeEx),
     Object::makeCProcedure(withExceptionHandlerEx),
     Object::makeCProcedure(raiseContinuableEx),
     Object::makeCProcedure(raiseEx),
     Object::makeCProcedure(evalEx),
     Object::makeCProcedure(errorfEx),
     Object::makeCProcedure(sourceInfoEx),
     Object::makeCProcedure(regexpReplaceAllEx),
     Object::makeCProcedure(regexpReplaceEx),
     Object::makeCProcedure(vectorEx),
     Object::makeCProcedure(closeInputPortEx),
     Object::makeCProcedure(openFileInputPortEx),
     Object::makeCProcedure(openFileOutputPortEx),
     Object::makeCProcedure(utf8TostringEx),
     Object::makeCProcedure(getBytevectorNEx),
     Object::makeCProcedure(standardInputPortEx),
     Object::makeCProcedure(bytevectorU8RefEx),
     Object::makeCProcedure(bytevectorLengthEx),
     Object::makeCProcedure(sysGetBytevectorEx),
     Object::makeCProcedure(sysOpenBytevectorOutputPortEx),
     Object::makeCProcedure(eofObjectEx),
     Object::makeCProcedure(makeTranscoderEx),
     Object::makeCProcedure(utf8CodecEx),
     Object::makeCProcedure(transcodedPortEx),
     Object::makeCProcedure(bytevectorU8SetDEx),
     Object::makeCProcedure(getU8Ex),
     Object::makeCProcedure(makeCustomBinaryInputPortEx),
     Object::makeCProcedure(find10Ex),
     Object::makeCProcedure(initLibraryTableEx),
     Object::makeCProcedure(pairPEx),
     Object::makeCProcedure(vmApplyEx),
     Object::makeCProcedure(valuesEx),
     Object::makeCProcedure(currentErrorPortEx),
     Object::makeCProcedure(eqHashtableCopyEx),
     Object::makeCProcedure(hashtableKeysEx),
     Object::makeCProcedure(hashtableRefEx),
     Object::makeCProcedure(hashtableSetDEx),
     Object::makeCProcedure(makeEqHashtableEx),
     Object::makeCProcedure(getTimeofdayEx),
     Object::makeCProcedure(errorEx),
     Object::makeCProcedure(stringRefEx),
     Object::makeCProcedure(symbolTostringEx),
     Object::makeCProcedure(booleanPEx),
     Object::makeCProcedure(memberEx),
     Object::makeCProcedure(eqPEx),
     Object::makeCProcedure(memqEx),
     Object::makeCProcedure(listPEx),
     Object::makeCProcedure(vectorPEx),
     Object::makeCProcedure(stringEqPEx),
     Object::makeCProcedure(gensymEx),
     Object::makeCProcedure(writeEx),
     Object::makeCProcedure(charPEx),
     Object::makeCProcedure(setCurrentOutputPortDEx),
     Object::makeCProcedure(setCurrentInputPortDEx),
     Object::makeCProcedure(currentOutputPortEx),
     Object::makeCProcedure(currentInputPortEx),
     Object::makeCProcedure(formatEx),
     Object::makeCProcedure(integerTocharEx),
     Object::makeCProcedure(charTointegerEx),
     Object::makeCProcedure(stringToregexpEx),
     Object::makeCProcedure(sysGetOutputStringEx),
     Object::makeCProcedure(fileExistsPEx),
     Object::makeCProcedure(sysReaddirEx),
     Object::makeCProcedure(getRemainingInputStringEx),
     Object::makeCProcedure(digitTointegerEx),
     Object::makeCProcedure(closeOutputPortEx),
     Object::makeCProcedure(openOutputFileEx),
     Object::makeCProcedure(sysPortSeekEx),
     Object::makeCProcedure(sysOpenOutputStringEx),
     Object::makeCProcedure(openStringInputPortEx),
     Object::makeCProcedure(equalPEx),
     Object::makeCProcedure(getEnvironmentVariablesEx),
     Object::makeCProcedure(getEnvironmentVariableEx),
     Object::makeCProcedure(stringPEx),
     Object::makeCProcedure(charEqPEx),
     Object::makeCProcedure(readCharEx),
     Object::makeCProcedure(eofObjectPEx),
     Object::makeCProcedure(reverseEx),
     Object::makeCProcedure(numberTostringEx),
     Object::makeCProcedure(stringEx),
     Object::makeCProcedure(stringSplitEx),
     Object::makeCProcedure(stringAppendEx),
     Object::makeCProcedure(stringTonumberEx),
     Object::makeCProcedure(stringTosymbolEx),
     Object::makeCProcedure(stringLengthEx),
     Object::makeCProcedure(stringSetDEx),
     Object::makeCProcedure(makeStringEx),
     Object::makeCProcedure(rxmatchSubstringEx),
     Object::makeCProcedure(rxmatchBeforeEx),
     Object::makeCProcedure(rxmatchAfterEx),
     Object::makeCProcedure(rxmatchEndEx),
     Object::makeCProcedure(rxmatchStartEx),
     Object::makeCProcedure(regexpTostringEx),
     Object::makeCProcedure(regexpPEx),
     Object::makeCProcedure(rxmatchEx),
     Object::makeCProcedure(sysDisplayEx),
     Object::makeCProcedure(setCdrDEx),
     Object::makeCProcedure(setCarDEx),
     Object::makeCProcedure(nullPEx),
     Object::makeCProcedure(cdrEx),
     Object::makeCProcedure(carEx),
     Object::makeCProcedure(consEx),
     Object::makeCProcedure(numberPEx),
};
#ifdef ENABLE_PROFILER
static const ucs4char* cProcNames[] = {
     UC("$local-ref"),
     UC("$label"),
     UC("pass1/find-symbol-in-lvars"),
     UC("pass3/compile-refer"),
     UC("list->vector"),
     UC("length"),
     UC("code-builder-put-insn-arg1!"),
     UC("code-builder-put-insn-arg0!"),
     UC("code-builder-emit"),
     UC("code-builder-append!"),
     UC("code-builder-put-extra5!"),
     UC("code-builder-put-extra4!"),
     UC("code-builder-put-extra3!"),
     UC("code-builder-put-extra2!"),
     UC("code-builder-put-extra1!"),
     UC("make-code-builder"),
     UC("pass4/fixup-labels"),
     UC("pass3/find-sets"),
     UC("pass3/find-free"),
     UC("append!"),
     UC("appendA"),
     UC("append2"),
     UC("append"),
     UC("%get-closure-name"),
     UC("call-process"),
     UC("set-source-info!"),
     UC("vector->list"),
     UC("read"),
     UC("char>?"),
     UC("char>=?"),
     UC("char<?"),
     UC("char<=?"),
     UC("dynamic-wind"),
     UC("symbol?"),
     UC("load"),
     UC("procedure?"),
     UC("memv"),
     UC("macroexpand-1"),
     UC("exit"),
     UC("assq"),
     UC("div"),
     UC("mod"),
     UC("apply"),
     UC("typed-vector-type"),
     UC("typed-vector?"),
     UC("typed-vector-set-nth"),
     UC("typed-vector-get-nth"),
     UC("make-typed-vector"),
     UC("vector-type-instance-of?"),
     UC("vector-type-data"),
     UC("vector-type?"),
     UC("make-vector-type"),
     UC("with-exception-handler"),
     UC("raise-continuable"),
     UC("raise"),
     UC("eval"),
     UC("errorf"),
     UC("source-info"),
     UC("regexp-replace-all"),
     UC("regexp-replace"),
     UC("vector"),
     UC("close-input-port"),
     UC("open-file-input-port"),
     UC("open-file-output-port"),
     UC("utf8->string"),
     UC("get-bytevector-n"),
     UC("standard-input-port"),
     UC("bytevector-u8-ref"),
     UC("bytevector-length"),
     UC("sys-get-bytevector"),
     UC("sys-open-bytevector-output-port"),
     UC("eof-object"),
     UC("make-transcoder"),
     UC("utf-8-codec"),
     UC("transcoded-port"),
     UC("bytevector-u8-set!"),
     UC("get-u8"),
     UC("make-custom-binary-input-port"),
     UC("find10"),
     UC("init-library-table"),
     UC("pair?"),
     UC("vm/apply"),
     UC("values"),
     UC("current-error-port"),
     UC("eq-hashtable-copy"),
     UC("hashtable-keys"),
     UC("hashtable-ref"),
     UC("hashtable-set!"),
     UC("make-eq-hashtable"),
     UC("get-timeofday"),
     UC("error"),
     UC("string-ref"),
     UC("symbol->string"),
     UC("boolean?"),
     UC("member"),
     UC("eq?"),
     UC("memq"),
     UC("list?"),
     UC("vector?"),
     UC("string=?"),
     UC("gensym"),
     UC("write"),
     UC("char?"),
     UC("set-current-output-port!"),
     UC("set-current-input-port!"),
     UC("current-output-port"),
     UC("current-input-port"),
     UC("format"),
     UC("integer->char"),
     UC("char->integer"),
     UC("string->regexp"),
     UC("sys-get-output-string"),
     UC("file-exists?"),
     UC("sys-readdir"),
     UC("get-remaining-input-string"),
     UC("digit->integer"),
     UC("close-output-port"),
     UC("open-output-file"),
     UC("sys-port-seek"),
     UC("sys-open-output-string"),
     UC("open-string-input-port"),
     UC("equal?"),
     UC("get-environment-variables"),
     UC("get-environment-variable"),
     UC("string?"),
     UC("char=?"),
     UC("read-char"),
     UC("eof-object?"),
     UC("reverse"),
     UC("number->string"),
     UC("string"),
     UC("string-split"),
     UC("string-append"),
     UC("string->number"),
     UC("string->symbol"),
     UC("string-length"),
     UC("string-set!"),
     UC("make-string"),
     UC("rxmatch-substring"),
     UC("rxmatch-before"),
     UC("rxmatch-after"),
     UC("rxmatch-end"),
     UC("rxmatch-start"),
     UC("regexp->string"),
     UC("regexp?"),
     UC("rxmatch"),
     UC("sys-display"),
     UC("set-cdr!"),
     UC("set-car!"),
     UC("null?"),
     UC("cdr"),
     UC("car"),
     UC("cons"),
     UC("number?"),
};
#endif
