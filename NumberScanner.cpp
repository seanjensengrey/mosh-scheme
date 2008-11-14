/* Generated by re2c 0.13.5 on Fri Nov 14 12:33:02 2008 */
#line 1 "NumberScanner.re"
#include <stdio.h>
#include "Object.h"
#include "Pair.h"
#include "StringProcedures.h"
#include "TextualInputPort.h"
#include "TextualOutputPort.h"
#include "ucs4string.h"
#include "ScannerHelper.h"
#include "NumberScanner.h"

#include "Reader.h"
#include "NumberReader.h"
#include "NumberReader.tab.hpp"
#include "VM.h"

#define YYCTYPE ucs4char
#define YYCURSOR cursor_
#define YYMARKER marker_
#define YYLIMIT limit_
#define YYTOKEN token_
#define YYDEBUG(state, ch)  yydebug(state, ch)
#define YYFILL(n) fill(n)
extern YYSTYPE number_yylval;
#define yylval number_yylval
using namespace scheme;
extern VM* theVM;

NumberScanner::NumberScanner() : dummy_('Z'),  // for YYDEBUG
                     buffer_(NULL),
                     cursor_(&dummy_),
                     token_(buffer_),
                     limit_(buffer_),
                     marker_(buffer_),
                     bufferSize_(32)
{
}

NumberScanner::~NumberScanner()
{
}


static void yydebug(int state, ucs4char ch)
{
//    printf("state=%d ch=[%c] ch=%x\n", state, ch, ch);
}

void NumberScanner::fill(int n)
{
    TextualInputPort* const inputPort = NumberReader::port();
    const int restCharCount = limit_ - token_;
    const int tokenOffset = token_ - buffer_;
    if (buffer_ == NULL) {
        buffer_ = new(GC) ucs4char[bufferSize_];
        cursor_ = buffer_;
        limit_ = buffer_;
        token_ = buffer_;
        marker_ = buffer_;
    }

    if ((restCharCount + n) > bufferSize_) {
        ucs4char* newBuffer = new(GC) ucs4char[restCharCount + n + 1];
        bufferSize_ = restCharCount + n + 1;
        memmove(newBuffer, token_, restCharCount * sizeof(ucs4char));
        cursor_ = &newBuffer[cursor_ - buffer_];
        token_ = &newBuffer[token_ - buffer_];
        limit_ = &newBuffer[limit_ - buffer_];
        marker_ = &newBuffer[marker_ - buffer_];
        buffer_ = newBuffer;
    } else if (restCharCount > 0) {
        memmove(buffer_, token_, restCharCount * sizeof(ucs4char));
    }

    int i;
    for (i = 0; i < n; i++) {
        const ucs4char ch = inputPort->getChar();
        if (ch == EOF) {
            buffer_[i + restCharCount] = '\0';
            i++;
            break;
        } else {
            buffer_[i + restCharCount] = ch;
        }

    }
    printf("cursor=<%c>\n", *cursor_);
    const int readSize = i;
    cursor_ = cursor_ - tokenOffset;
    token_ = buffer_;
    marker_ = marker_ - tokenOffset;
    limit_ = limit_ - tokenOffset + readSize;
    printf("fill :");
    for (int k = 0; k < i; k++) {
        printf("<%c>", buffer_[k]);
    }
    printf("\n limit - cursor = %d\n", limit_ - cursor_);
    printf("after cursor=<%c>\n", *(cursor_ + 1));

}

int number_yylex()
{
    return NumberReader::port()->numberScanner()->scan();
}

int NumberScanner::scan()
{
#line 115 "NumberScanner.re"


    for(;;)
    {

#line 117 "<stdout>"
{
	YYCTYPE yych;

	if ((YYLIMIT - YYCURSOR) < 5) YYFILL(5);
	yych = *YYCURSOR;
	if (yych & ~0xFF) {
	} else {
		static void *yytarget[256] = {
			&&yy17, &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy3,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy7,  &&yy2,  &&yy9,  &&yy2,  &&yy11,
			&&yy15, &&yy15, &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy13, &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy5,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy4,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2
		};
		goto *yytarget[yych];
	}
yy2:
	YYCURSOR = YYMARKER;
	goto yy6;
yy3:
	yych = *++YYCURSOR;
	if (yych & ~0xFF) {
		goto yy2;
	} else {
		static void *yytarget[256] = {
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy29, &&yy2,  &&yy2,  &&yy33, &&yy2,  &&yy2,
			&&yy2,  &&yy31, &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy29, &&yy2,  &&yy2,  &&yy33, &&yy2,  &&yy2,
			&&yy2,  &&yy31, &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,
			&&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2,  &&yy2
		};
		goto *yytarget[yych];
	}
yy4:
	yych = *++YYCURSOR;
	if (yych == 'a') goto yy24;
	goto yy2;
yy5:
	yych = *(YYMARKER = ++YYCURSOR);
	if (yych == 'n') goto yy19;
yy6:
#line 148 "NumberScanner.re"
	{
            YYTOKEN = YYCURSOR;
            return IMAG;
        }
#line 218 "<stdout>"
yy7:
	++YYCURSOR;
#line 136 "NumberScanner.re"
	{
            YYTOKEN = YYCURSOR;
            return PLUS;
        }
#line 226 "<stdout>"
yy9:
	++YYCURSOR;
#line 140 "NumberScanner.re"
	{
            YYTOKEN = YYCURSOR;
            return MINUS;
        }
#line 234 "<stdout>"
yy11:
	++YYCURSOR;
#line 144 "NumberScanner.re"
	{
            YYTOKEN = YYCURSOR;
            return SLASH;
        }
#line 242 "<stdout>"
yy13:
	++YYCURSOR;
#line 152 "NumberScanner.re"
	{
            YYTOKEN = YYCURSOR;
            return AT;
        }
#line 250 "<stdout>"
yy15:
	++YYCURSOR;
#line 161 "NumberScanner.re"
	{
            yylval.intValue = YYTOKEN[0] - '0';
            printf("TOKEN:DIGIT_2=%d\n", yylval.intValue);
            YYTOKEN = YYCURSOR;
            return DIGIT_2;
        }
#line 260 "<stdout>"
yy17:
	++YYCURSOR;
#line 167 "NumberScanner.re"
	{
            printf("TOKEN:END_OF_FILE\n");
            YYTOKEN = YYCURSOR;
            return END_OF_FILE;
        }
#line 269 "<stdout>"
yy19:
	yych = *++YYCURSOR;
	if (yych != 'f') goto yy2;
	yych = *++YYCURSOR;
	if (yych != '.') goto yy2;
	yych = *++YYCURSOR;
	if (yych != '0') goto yy2;
	++YYCURSOR;
#line 132 "NumberScanner.re"
	{
            YYTOKEN = YYCURSOR;
            return MY_INF;
        }
#line 283 "<stdout>"
yy24:
	yych = *++YYCURSOR;
	if (yych != 'n') goto yy2;
	yych = *++YYCURSOR;
	if (yych != '.') goto yy2;
	yych = *++YYCURSOR;
	if (yych != '0') goto yy2;
	++YYCURSOR;
#line 128 "NumberScanner.re"
	{
            YYTOKEN = YYCURSOR;
            return MY_NAN;
        }
#line 297 "<stdout>"
yy29:
	++YYCURSOR;
#line 156 "NumberScanner.re"
	{
            printf("TOKEN:RADIX_2\n");
            YYTOKEN = YYCURSOR;
            return RADIX_2;
        }
#line 306 "<stdout>"
yy31:
	++YYCURSOR;
#line 124 "NumberScanner.re"
	{
            YYTOKEN = YYCURSOR;
            return INEXACT;
        }
#line 314 "<stdout>"
yy33:
	++YYCURSOR;
#line 120 "NumberScanner.re"
	{
            YYTOKEN = YYCURSOR;
            return EXACT;
        }
#line 322 "<stdout>"
}
#line 174 "NumberScanner.re"


    }
}

ucs4char* NumberScanner::currentToken() const
{
    return token_;
}
