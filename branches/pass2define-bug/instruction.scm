(define-insn COMPILE_ERROR 3)
(define-insn APPEND2 0) ;; APPEND(stack0, ac)
(define-insn CALL 1)  ;; CALL(op0)
(define-insn APPLY 0) ;; APPLY2(stack0)
(define-insn PUSH 0)   ;; PUSH(ac_)
(define-insn ASSIGN_FREE 1)
(define-insn ASSIGN_GLOBAL 1)
(define-insn ASSIGN_LOCAL 1)
(define-insn BOX 1)
(define-insn CAAR 0)
(define-insn CADR 0)
(define-insn CAR 0)
(define-insn CDAR 0)
(define-insn CDDR 0)
(define-insn CDR 0)
(define-insn CLOSURE 6)  ;; (CLOSURE pcToEndOfBody body ...)
(define-insn CONS 0)
(define-insn CONSTANT 1)
(define-insn DEFINE_GLOBAL 1)
(define-insn DISPLAY 1)
(define-insn ENTER 1)
(define-insn EQ 0)
(define-insn EQV 0)
(define-insn EQUAL 0)
(define-insn FRAME 1)   ;; (FRAME pcToEndOfBody body ...)
(define-insn INDIRECT 0)
(define-insn LEAVE 1)
(define-insn LET_FRAME 1)
(define-insn LIST 1)
(define-insn LOCAL_JMP 1)    ;; (TEST N(to local_jmp) then ... LOCAL_JMP x else endof if
(define-insn MAKE_CONTINUATION 1)
(define-insn MAKE_VECTOR 0)
(define-insn NOP 0)
(define-insn NOT 0)
(define-insn NULL_P 0)
(define-insn NUMBER_ADD 0)
(define-insn NUMBER_EQUAL 0)
(define-insn NUMBER_GE 0)
(define-insn NUMBER_GT 0)
(define-insn NUMBER_LE 0)
(define-insn NUMBER_LT 0)
(define-insn NUMBER_MUL 0)
(define-insn NUMBER_DIV 0)
(define-insn NUMBER_SUB 0)
(define-insn PAIR_P 0)
(define-insn READ 0)
(define-insn READ_CHAR 0)
(define-insn REDUCE 1)
(define-insn REFER_FREE 1)
(define-insn REFER_GLOBAL 1)
(define-insn REFER_LOCAL 1)
(define-insn RESTORE_CONTINUATION 1)
(define-insn RETURN 1)
(define-insn SET_CAR 0)
(define-insn SET_CDR 0)
(define-insn SHIFT 2)
(define-insn SYMBOL_P 0)
(define-insn TEST 1)
(define-insn UNDEF 0)
(define-insn VECTOR_LENGTH 0)
(define-insn VECTOR_P 0)
(define-insn VECTOR_REF 0)
(define-insn VECTOR_SET 0)
(define-insn CONSTANT_PUSH 1)
(define-insn REFER_LOCAL0 0)
(define-insn REFER_LOCAL1 0)
(define-insn REFER_LOCAL2 0)
(define-insn REFER_LOCAL3 0)
(define-insn REFER_FREE0 0)
(define-insn REFER_FREE1 0)
(define-insn REFER_FREE2 0)
(define-insn REFER_FREE3 0)
(define-insn REFER_LOCAL0_PUSH 0)
(define-insn REFER_LOCAL0_PUSH_CONSTANT 1)
(define-insn REFER_LOCAL1_PUSH_CONSTANT 1)
(define-insn REFER_LOCAL1_PUSH 0)
(define-insn NUMBER_SUB_PUSH 0)
(define-insn PUSH_ENTER 1)
(define-insn HALT 0)
(define-insn LEAVE1 0)
(define-insn CALL1 0)
(define-insn NUMBER_LE_TEST 1)
(define-insn NUMBER_ADD_PUSH 0)
(define-insn RETURN1 0)
(define-insn RETURN2 0)
(define-insn RETURN3 0)
(define-insn CALL2 0)
(define-insn REFER_LOCAL0_EQV_TEST 1)
(define-insn PUSH_CONSTANT 1)
(define-insn PUSH_FRAME 1)
(define-insn REFER_FREE0_PUSH 0)
(define-insn REFER_FREE1_PUSH 0)
(define-insn REFER_FREE2_PUSH 0)
(define-insn CAR_PUSH 0)
(define-insn CDR_PUSH 0)
(define-insn REFER_FREE0_INDIRECT 0)
(define-insn REFER_FREE1_INDIRECT 0)
(define-insn REFER_LOCAL2_PUSH 0)
(define-insn SHIFT_CALL 3)
(define-insn CALL3 0)
(define-insn NOT_TEST 1)
(define-insn REFER_GLOBAL_CALL 2)
(define-insn REFER_LOCAL0_NUMBER_ADD_PUSH 0)
(define-insn REFER_LOCAL0_VECTOR_SET 0)
(define-insn REFER_LOCAL0_VECTOR_REF 0)
(define-insn REFER_FREE_PUSH 1)
(define-insn REFER_LOCAL_PUSH 1)
(define-insn VALUES 1)
(define-insn RECEIVE 2)
(define-insn UNFIXED_JUMP 1)
(define-insn STOP 0)
(define-insn CONTINUATION_VALUES 0)
(define-insn SHIFTJ 3)
(define-insn BRANCH_NOT_LE 1)
(define-insn BRANCH_NOT_GE 1)
(define-insn BRANCH_NOT_LT 1)
(define-insn BRANCH_NOT_GT 1)
(define-insn BRANCH_NOT_NULL 1)
