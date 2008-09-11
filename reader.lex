%{
#include <stdio.h>
#include "scheme.h"
#include "Object.h"
#include "Object-inl.h"
#include "Symbol.h"
#include "Codec.h"
#include "ByteArrayBinaryInputPort.h"
#include "reader.h" // include before reader.tab.hpp is included.

#include "reader.tab.hpp"
extern bool parser_input(char* buf, int max_size);
using namespace scheme;
extern Codec* parser_codec();
extern ucs4string readString(const ucs4string& s);

#undef YY_INPUT
#define YY_INPUT(buffer, result, max_size) { const bool isEOF = parser_input(buffer, max_size); if (isEOF) {result= YY_NULL; } else { result = 1;} }
%}

character-tabulation \t
line-tabulation \x0B
form-feed \x0C
paragraph-separator \x20\x29

/* Unicode categories */
/* Zs \x20|\xA0|\x16\x80|\x18\x0E|\x20\x00|\x20\x01|\x20\x02|\x20\x03|\x20\x04|\x20\x05|\x20\x06|\x20\x07|\x20\x08|\x20\x09|\x20\x0A|\x20\x2F|\x20\x5F|\x30\x00
 */
/*  ひょっとしてこれは space( では？
Zl \x20\x28 
Zp \x20\x29
*/

Zs \x20|\xA0

lexme  {identifier}|{boolean}|{number}|{character}|{string}|[()\[\]’‘,\.]|#\(|,@|#vu8\(|#’|#‘|#,|#,@
delimiter  [\(\)\[\]\";#]|{whitespace}
/* delimiter "\n\r"|[\[\]\(\)\";#\r\n\t ] */
not-delimiter   [^\[\]\(\)\";#\r\n\t ]

/* |{Zl}|{Zp} */

whitespace [ ]{character-tabulation}|{linefeed}|{line-tabulation}|{form-feed}|{carriage-return}|{next-line}|{Zs}
line-ending  {linefeed}|{carriage-return}|{carriage-return}{linefeed}|{next-line}|{carriage-return}{next-line}|{line-separator}
linefeed \n
carriage-return \r
next-line \x85

line-separator \x2028
comment (";"[^\n]*)|("#!"[^\n]*)

/* (;.*{line-ending})|(;.*{paragraph-separator}|#;{interlexeme-space}{datum}|(#!r6rs) */

identifier  ({initial}{subsequent}*)|{peculiar-identifier}
initial  {constituent}|{special-initial}|{inline-hex-escape}
letter  [a-z]|[A-Z]

identifier-with-space \|[^\|]+\|


/* not enough */
constituent {letter}|[\-\.\+@]

special-initial  [!\$%&\*\/\:\<=\>\?\^\_~]

dot "."{delimiter}?

/* not enough */
subsequent  {initial}|{digit}|[\x80-\xffff]|{special-subsequent}
digit  [0-9]
hex-digit  {digit}|[aAbBcCdDeEfF]
special-subsequent [+\-.@]
inline-hex-escape  (\\x{hex-scalar-value};)
hex-scalar-value {hex-digit}+
peculiar-identifier [\+\-]|"..."|("->"{subsequent}*)
boolean {true}{false}
true #[tT]
false #[fF]

single-char [^\n ]
character-literal #\\{single-char}+
character  ({character-literal}|#\\{character-name}|#\\x{hex-scalar-value})
                                  /*good-charactor-literal {character-literal}{delimiter}*/

good-charactor-literal #\\[^\n ]{not-delimiter}*{delimiter}

string  \"{string-element}*\"

/* todo 最初の要素の一文字が怪しい */
string-element  [^\\\"]|\\[abtnvfr\"\\\\]|\\{intraline-whitespace}{line-ending}{intraline-whitespace}|{inline-hex-escape}
intraline-whitespace  \t

regexp-element \\\/|[^/]
good-regexp "#/"{regexp-element}+"/"{delimiter}

good-num-10 {num-10}{delimiter}

numbepppr {num-2}|{num-8}|{num-10}|{num-16}
num-2 {prefix-2}{complex-2}
num-8 {prefix-8}{complex-8}
num-10 {prefix-10}{complex-10}
num-16 {prefix-16}{complex-16}

complex-2 {real-2}|{real-2}@{real-2}|{real-2}\+{ureal-2}i|{real-2}-{ureal-2}i|{real-2}+{naninf}i|{real-2}-{naninf}i|{real-2}\+i|{real-2}-i|\+{ureal-2}i|-{ureal-2}-i|\+{naninf}i|-{naninf}i|\+i|-i
complex-8 {real-8}|{real-8}@{real-8}|{real-8}\+{ureal-8}i|{real-8}-{ureal-8}i|{real-8}+{naninf}i|{real-8}-{naninf}i|{real-8}\+i|{real-8}-i|\+{ureal-8}i|-{ureal-8}-i|\+{naninf}i|-{naninf}i|\+i|-i
complex-10 {real-10}|{real-10}@{real-10}|{real-10}\+{ureal-10}i|{real-10}-{ureal-10}i|{real-10}+{naninf}i|{real-10}-{naninf}i|{real-10}\+i|{real-10}-i|\+{ureal-10}i|-{ureal-10}-i|\+{naninf}i|-{naninf}i|\+i|-i
complex-16 {real-16}|{real-16}@{real-16}|{real-16}\+{ureal-16}i|{real-16}-{ureal-16}i|{real-16}+{naninf}i|{real-16}-{naninf}i|{real-16}\+i|{real-16}-i|\+{ureal-16}i|-{ureal-16}-i|\+{naninf}i|-{naninf}i|\+i|-i

real-2 {sign}{ureal-2}|\+{naninf}|-{naninf}
real-8 {sign}{ureal-8}|\+{naninf}|-{naninf}
real-10 {sign}{ureal-10}|\+{naninf}|-{naninf}
real-16 {sign}{ureal-16}|\+{naninf}|-{naninf}
naninf nan\.0|inf\.0

ureal-2 {uinteger-2}|{uinteger-2}\/{uinteger-2}
ureal-8 {uinteger-8}|{uinteger-8}\/{uinteger-8}
ureal-10 {uinteger-10}|{uinteger-10}\/{uinteger-10}|{decimal-10}{mantissa-width}
ureal-16 {uinteger-16}|{uinteger-16}\/{uinteger-16}

decimal-10 {uinteger-10}{suffix}|\.{digit-10}+{suffix}|{digit-10}+\.{digit-10}\*{suffix}|{digit-10}+\.{suffix}
uinteger-2 {digit-2}+
prefix-2 {radix-2}{exactness}|{exactness}{radix-2}
uinteger-8 {digit-8}+
prefix-8 {radix-8}{exactness}|{exactness}{radix-8}
uinteger-10 {digit-10}+
prefix-10 {radix-10}{exactness}|{exactness}{radix-10}
uinteger-16 {digit-16}+
prefix-16 {radix-16}{exactness}|{exactness}{radix-16}
suffix ({exponent-marker}{sign}{digit-10}+)?
exponent-marker [eEsSfFdDlL]
mantissa-width (\|{digit-10}+)?
sign [\+\-]?
exactness (#[iIeE])?
radix-2 #[bB]
radix-8 #[oO]
radix-10 (#[dD])?
radix-16 #[xX]
digit-2 [01]
digit-8 [0-7]
digit-10 {digit}
digit-16 {hex-digit}
%x COMMENT
%option yylineno
%%
[\])] {
    return RIGHT_PAREN;
      }

[(\[] {
        return LEFT_PAREN; }
"#(" {
    return VECTOR_START; 

}
"#vu8(" {
    return BYTE_VECTOR_START; }

"#|"                     BEGIN(COMMENT);
<COMMENT>[^|\n]*
<COMMENT>[^|\n]*\n
<COMMENT>"|"+[^|/\n]*
<COMMENT>"|"+[^|/\n]*\n
<COMMENT><<EOF>>
<COMMENT>"|"+"#"         BEGIN(INITIAL);
{identifier} {
    yylval.stringValue = yytext;
  return IDENTIFIER;
}
{identifier-with-space} {
    yytext[yyleng - 1] = '\0';
  yylval.stringValue = yytext + 1;

  return IDENTIFIER;
}
{string} {
  // remove dobule quotation.
  yytext[yyleng - 1] = '\0';
  yylval.stringValue = yytext + 1;
  yyleng -= 2;
  return STRING;
 }

{true} {
    yylval.boolValue = true;
    return BOOLEAN;
  }
{false} {
    yylval.boolValue = false;
    return BOOLEAN;
 }

{dot} {
    return DOT; }

<<EOF>> { 
    return END_OF_FILE;
}



{good-num-10} {
//    printf("%s %s:%d<%s>\n", __func__, __FILE__, __LINE__, yytext);fflush(stdout);// debug
    yyless(yyleng - 1);
    errno = 0;
    long long ret = strtoll(yytext, NULL, 10);
    if ((errno == ERANGE && (ret == LONG_MAX || ret == LONG_MIN))
        || (errno != 0 && ret == 0)) {
      printf("error num-10");
    } else {
      yylval.intValue = ret;
    }
    return NUMBER;
 }
  {delimiter}
"`"                   { return ABBV_QUASIQUOTE; }
"'"                   { return ABBV_QUOTE; }
",@"                  { return ABBV_UNQUOTESPLICING; }
","                   { return ABBV_UNQUOTE; }
"#'"                  { return ABBV_SYNTAX; }
"#`"                  { return ABBV_QUASISYNTAX; }
"#,"                  { return ABBV_UNSYNTAX; }
"#,@"                 { return ABBV_UNSYNTAXSPLICING; }

    {good-charactor-literal} {
    ucs4string text = parser_codec()->readWholeString(new ByteArrayBinaryInputPort((uint8_t*)yytext, yyleng - 1));
    if (text == UC("#\\nul")) {
        yylval.charValue = 0x00;
    } else if (text == UC("#\\alarm")) {
        yylval.charValue = 0x07;
    } else if (text == UC("#\\backspace")) {
        yylval.charValue = 0x08;
    } else if (text == UC("#\\tab")) {
        yylval.charValue = 0x09;
    } else if (text == UC("#\\linefeed")) {
        yylval.charValue = 0x0A;
    } else if (text == UC("#\\newline")) {
        yylval.charValue = 0x0A;
    } else if (text == UC("#\\vtab")) {
        yylval.charValue = 0x0B;
    } else if (text == UC("#\\page")) {
        yylval.charValue = 0x0C;
    } else if (text == UC("#\\return")) {
        yylval.charValue = 0x0D;
    } else if (text == UC("#\\esc")) {
        yylval.charValue = 0x1B;
    } else if (text == UC("#\\space")) {
        yylval.charValue = 0x20;
    } else if (text == UC("#\\delete")) {
        yylval.charValue = 0x7F;
    } else {
        yylval.charValue = text[2];
    }
    const int charcterLength = yyleng - 1 - text.size() + 2 + 1;
    yyless(yyleng - 1); // ungetc the delimiter
    return CHARACTER;
}

{good-regexp} {
    yyless(yyleng - 1); // ungetc the delimiter
    char* character = yytext + 2;
    yytext[yyleng - 1] = '\0';
    yylval.stringValue = character;
    yyleng -= 3;
    return REGEXP;
}

{comment} { 
}

%%

int yywrap()
{
  return 1;
}
