// Do not edit this file generated by gen-insn.scm
#ifndef __SCHEME_INSTRUCTION_H__
#define __SCHEME_INSTRUCTION_H__

#include "scheme.h"

namespace scheme {

class Instruction EXTEND_GC
{
public:
    enum {
        COMPILE_ERROR = 14,
        APPEND2 = 46,
        CALL = 78,
        APPLY = 110,
        PUSH = 142,
        ASSIGN_FREE = 174,
        ASSIGN_GLOBAL = 206,
        ASSIGN_LOCAL = 238,
        BOX = 270,
        CAAR = 302,
        CADR = 334,
        CAR = 366,
        CDAR = 398,
        CDDR = 430,
        CDR = 462,
        CLOSURE = 494,
        CONS = 526,
        CONSTANT = 558,
        DEFINE_GLOBAL = 590,
        DISPLAY = 622,
        ENTER = 654,
        EQ = 686,
        EQV = 718,
        EQUAL = 750,
        FRAME = 782,
        INDIRECT = 814,
        LEAVE = 846,
        LET_FRAME = 878,
        LIST = 910,
        LOCAL_JMP = 942,
        MAKE_CONTINUATION = 974,
        MAKE_VECTOR = 1006,
        NOP = 1038,
        NOT = 1070,
        NULL_P = 1102,
        NUMBER_ADD = 1134,
        NUMBER_EQUAL = 1166,
        NUMBER_GE = 1198,
        NUMBER_GT = 1230,
        NUMBER_LE = 1262,
        NUMBER_LT = 1294,
        NUMBER_MUL = 1326,
        NUMBER_DIV = 1358,
        NUMBER_SUB = 1390,
        PAIR_P = 1422,
        READ = 1454,
        READ_CHAR = 1486,
        REDUCE = 1518,
        REFER_FREE = 1550,
        REFER_GLOBAL = 1582,
        REFER_LOCAL = 1614,
        RESTORE_CONTINUATION = 1646,
        RETURN = 1678,
        SET_CAR = 1710,
        SET_CDR = 1742,
        SHIFT = 1774,
        SYMBOL_P = 1806,
        TEST = 1838,
        UNDEF = 1870,
        VECTOR_LENGTH = 1902,
        VECTOR_P = 1934,
        VECTOR_REF = 1966,
        VECTOR_SET = 1998,
        CONSTANT_PUSH = 2030,
        REFER_LOCAL0 = 2062,
        REFER_LOCAL1 = 2094,
        REFER_LOCAL2 = 2126,
        REFER_LOCAL3 = 2158,
        REFER_FREE0 = 2190,
        REFER_FREE1 = 2222,
        REFER_FREE2 = 2254,
        REFER_FREE3 = 2286,
        REFER_LOCAL0_PUSH = 2318,
        REFER_LOCAL0_PUSH_CONSTANT = 2350,
        REFER_LOCAL1_PUSH_CONSTANT = 2382,
        REFER_LOCAL1_PUSH = 2414,
        NUMBER_SUB_PUSH = 2446,
        PUSH_ENTER = 2478,
        HALT = 2510,
        LEAVE1 = 2542,
        CALL1 = 2574,
        NUMBER_LE_TEST = 2606,
        NUMBER_ADD_PUSH = 2638,
        RETURN1 = 2670,
        RETURN2 = 2702,
        RETURN3 = 2734,
        CALL2 = 2766,
        REFER_LOCAL0_EQV_TEST = 2798,
        PUSH_CONSTANT = 2830,
        PUSH_FRAME = 2862,
        REFER_FREE0_PUSH = 2894,
        REFER_FREE1_PUSH = 2926,
        REFER_FREE2_PUSH = 2958,
        CAR_PUSH = 2990,
        CDR_PUSH = 3022,
        REFER_FREE0_INDIRECT = 3054,
        REFER_FREE1_INDIRECT = 3086,
        REFER_LOCAL2_PUSH = 3118,
        SHIFT_CALL = 3150,
        CALL3 = 3182,
        NOT_TEST = 3214,
        REFER_GLOBAL_CALL = 3246,
        REFER_LOCAL0_NUMBER_ADD_PUSH = 3278,
        REFER_LOCAL0_VECTOR_SET = 3310,
        REFER_LOCAL0_VECTOR_REF = 3342,
        REFER_FREE_PUSH = 3374,
        REFER_LOCAL_PUSH = 3406,
        VALUES = 3438,
        RECEIVE = 3470,
        UNFIXED_JUMP = 3502,
        STOP = 3534,
        CONTINUATION_VALUES = 3566,
        SHIFTJ = 3598,
    };
};
}; // namespace scheme

#endif // __SCHEME_INSTRUCTION_H__