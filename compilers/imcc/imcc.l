%{
/*
 * imcc.l
 *
 * Intermediate Code Compiler for Parrot
 *
 * Copyright (C) 2002 Melvin Smith
 *
 * The tokenizer.
 */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "imc.h"
#include "parser.h"

#define MAX_PARAM 16

struct params_t {
    char *name[MAX_PARAM];
    int num_param;
};

struct macro_t {
    char *name;
    struct params_t params;
    char *expansion;
    int line;
};

/* XXX: boe: rework this hack to use a hash */
struct macro_t macros[256];
int num_macros = 0;

char temp_buffer[4096];

/* parser state structure
 * the first few items are common to struct parser_state, but
 * we AFAIK need this hack as flex doesn't export YY_BUFFER_STATE
 */
struct macro_frame_t {
    struct parser_state_t s;

    /* macro stuff */
    YY_BUFFER_STATE buffer;
    struct params_t *params;
    struct params_t expansion;
    int label;
    int is_macro;
    char *heredoc_rest;
};

struct macro_frame_t *frames = NULL;

/* static function declariations */
static void pop_parser_state(Interp* interp);
static struct macro_frame_t *new_frame (Interp*);
static void scan_string (struct macro_frame_t *frame, const char *expansion);
static void scan_file (Interp* interp, struct macro_frame_t *frame, FILE *);
static void destroy_frame (struct macro_frame_t *frame);
static int yylex_skip (YYSTYPE *valp, void *interp, const char *skip);

static int read_macro (YYSTYPE *valp, Interp *interp);
static int expand_macro (YYSTYPE *valp, void *interp, const char *name);
static void include_file (Interp* interp, char *file_name);
static int in_pod;
static int prev_state;
static char *heredoc_end;
static char *heredoc_content;

#define YY_DECL int yylex(YYSTYPE *valp, Interp *interp)

#define YYCHOP() (yytext[--yyleng] = '\0')
#define DUP_AND_RET(valp, token)             \
  do {                                       \
      if (valp) (valp)->s = str_dup(yytext); \
      return token;                          \
  } while (0)

%}

%option never-interactive
%option stack

LETTER          [a-zA-Z_@]
DIGIT           [0-9]
DIGITS          {DIGIT}+
HEX        0[xX][0-9A-Fa-f]+
BIN             0[bB][01]+
DOT        [.]
SIGN            [-+]
BIGINT          {SIGN}?{DIGITS}"L"
FLOATNUM        {SIGN}?(({DIGITS}{DOT}{DIGIT}*|{DOT}{DIGITS})([eE]{SIGN}?{DIGITS})?|{DIGITS}[eE]{SIGN}?{DIGITS})
LETTERDIGIT     [a-zA-Z0-9_]
LABELLETTERDIGIT     ([a-zA-Z0-9_@]|"::")
ID              {LETTER}{LABELLETTERDIGIT}*
DQ_STRING       \"(\\.|[^"\\\n])*\"
ENCCHAR         {LETTER}|{DIGIT}|"-"
ENCCHARS        {ENCCHAR}*
ENC             {LETTER}{ENCCHARS}":"
UNICODE         {ENC}{ENC}?{DQ_STRING}
STRINGCONSTANT  {SQ_STRING}|{DQ_STRING}
SQ_STRING       \'[^'\n]*\'
RANKSPEC        \[[,]*\]
EOL        \r?\n
WS              [\t\f\r\x1a ]
SP              [ ]

%x emit
%x macro
%x pod
%x cmt1
%x cmt2
%x cmt3
%x cmt4
%x cmt5
%x heredoc1
%x heredoc2


%%
        /* for emacs "*/
        if (expect_pasm == 1 && !in_pod) {
            expect_pasm = 2;
            BEGIN(emit);
        }
        if (frames->s.pasm_file && YYSTATE == INITIAL && !in_pod) {
            if (0)
                yy_top_state(); /* silent warning */
            if (frames->s.pasm_file == 1) {
                BEGIN(emit);
                return EMIT;
        }
            return 0;
        }

<heredoc1>.*{EOL} {
            frames->heredoc_rest = str_dup(yytext);
            BEGIN(heredoc2);
        }

<heredoc2>{EOL} {
        /* heredocs have highest priority
         * arrange them befor all wildcard state matches
         */

        /* Newline in the heredoc. Realloc and cat on. */
        ++line;
        heredoc_content = mem_sys_realloc(heredoc_content,
                                          strlen(heredoc_content) +
                                          strlen(yytext) + 2);
        strcpy(heredoc_content + strlen(heredoc_content), yytext);
    }

<heredoc2>.* {
        /* Are we at the end of the heredoc? */
        if (strcmp(heredoc_end, yytext) == 0)
        {
            /* End of the heredoc. */
            int len = strlen(heredoc_content);
            heredoc_content[len] = heredoc_content[0];  /* delim */
            heredoc_content[len+1] = 0;
            mem_sys_free(heredoc_end);
            frames->buffer = YY_CURRENT_BUFFER;
            valp->s = heredoc_content;
            BEGIN(prev_state);
            yy_scan_string(frames->heredoc_rest);
            return(STRINGC); /* XXX delete quotes, -> emit, pbc */
        }
        else
        {
            /* Part of the heredoc. Realloc and cat the line on. */
            heredoc_content = mem_sys_realloc(heredoc_content,
                                              strlen(heredoc_content) +
                                              strlen(yytext) + 2);
            strcpy(heredoc_content + strlen(heredoc_content), yytext);
        }
    }


<*>^"#line"{SP}{DIGITS}{SP}["] { prev_state = YYSTATE; BEGIN(cmt2);
                       valp->t = atoi(yytext+6);
                       return LINECOMMENT;
               }
<cmt2>[^"]+    { BEGIN(cmt3);
                      valp->s = str_dup(yytext);
                      return FILECOMMENT;
               }
<cmt3>["]      { BEGIN(cmt4); }

<*>setfile{SP}+["]   { prev_state = YYSTATE; BEGIN(cmt2); }
<*>setline{SP}+      { prev_state = YYSTATE; BEGIN(cmt1); }
<cmt1>{DIGITS}       {
                       valp->t = atoi(yytext);
                       BEGIN(cmt4);
                       return LINECOMMENT;
               }
<cmt4>.*{EOL}  { BEGIN(prev_state) ; line++; }

<INITIAL,emit>{EOL} {
        if (expect_pasm == 2)
      BEGIN(INITIAL);
        expect_pasm = 0;
        line++;
        return '\n';
    }

<INITIAL,emit># { prev_state = YYSTATE; BEGIN(cmt5); }
<cmt5>.*{EOL} {
        if (expect_pasm == 2)
      BEGIN(INITIAL);
        else
          BEGIN(prev_state);
        expect_pasm = 0;
        line++;
        return '\n';
    }

^".emit"\n {
    BEGIN(emit);
    return(EMIT);
    }

<emit>^".eom"\n {
    BEGIN(INITIAL);
    return EOM;
    }

<*>[ISNP]{DIGIT}{DIGIT}? {
    valp->s = str_dup(yytext);
    return REG;
    }

<INITIAL,emit,macro>^"="            { in_pod = 1; yy_push_state(pod); }
<pod>^"=cut"{EOL}    { in_pod = 0; yy_pop_state(); ++line; }
<pod>.*         { /*ignore*/ }
<pod>{EOL}      { ++line; }

".sym"          return(LOCAL);
<INITIAL,emit>".lex"          return(LEXICAL);
".arg"          return(ARG);
".sub"          return(SUB);
".end"          return(ESUB);
".pcc_begin"    return(PCC_BEGIN);
".pcc_end"      return(PCC_END);
".pcc_call"     return(PCC_CALL);
".nci_call"     return(NCI_CALL);
".meth_call"    return(METH_CALL);
".invocant"     return(INVOCANT);
<emit,INITIAL>".pcc_sub"      return(PCC_SUB);
".pcc_begin_return"    return(PCC_BEGIN_RETURN);
".pcc_end_return"      return(PCC_END_RETURN);
".pcc_begin_yield"    return(PCC_BEGIN_YIELD);
".pcc_end_yield"      return(PCC_END_YIELD);

"method"        return(METHOD); /* old compat cruft -
                                  the canonical colon names are below */
<emit,INITIAL>"@MULTI"   return(MULTI);
<emit,INITIAL>"@MAIN"    return(MAIN);
<emit,INITIAL>"@LOAD"    return(LOAD);
<emit,INITIAL>"@IMMEDIATE"    return(IMMEDIATE);
<emit,INITIAL>"@POSTCOMP"    return(POSTCOMP);
<emit,INITIAL>"@ANON"    return(ANON);

":method"        return(METHOD);
<emit,INITIAL>":multi"   return(MULTI);
<emit,INITIAL>":main"    return(MAIN);
<emit,INITIAL>":load"    return(LOAD);
<emit,INITIAL>":immediate"    return(IMMEDIATE);
<emit,INITIAL>":postcomp"    return(POSTCOMP);
<emit,INITIAL>":anon"    return(ANON);
<emit,INITIAL>":outer"   return(OUTER);
<emit,INITIAL>":lex"     return(NEED_LEX);

".result"       return(RESULT);
".get_results"       return(GET_RESULTS);
".yield"        return(YIELDT);
".return"       return(RETURN);

":flat"         return(ADV_FLAT);
":slurpy"       return(ADV_SLURPY);
":optional"     return(ADV_OPTIONAL);
":opt_flag"     return(ADV_OPT_FLAG);

<emit,INITIAL>".namespace"    return(NAMESPACE);
<emit,INITIAL>".HLL"          return(HLL);
<emit,INITIAL>".HLL_map"      return(HLL_MAP);
".endnamespace" return(ENDNAMESPACE);
".local"        return(LOCAL);
".global"       return(GLOBAL);
<emit,INITIAL>".const"        return(CONST);
".globalconst"  return(GLOBAL_CONST);
".param"        return(PARAM);
<*>".pragma"    return(PRAGMA);
<*>"n_operators"   return(N_OPERATORS);
"goto"          return(GOTO);
"if"            return(IF);
"unless"        return(UNLESS);
"null"          return(PNULL);
"int"           return(INTV);
"num"           return(FLOATV);
"float"         return(FLOATV);
"new"           return(NEW);
"addr"          return(ADDR);
"global"        return(GLOBALOP);
"object"        return(OBJECTV);
"pmc"           return(PMCV);
"string"        return(STRINGV);
"<<"            return(SHIFT_LEFT);
">>"            return(SHIFT_RIGHT);
">>>"           return(SHIFT_RIGHT_U);
"&&"            return(LOG_AND);
"||"            return(LOG_OR);
"~~"            return(LOG_XOR);
"<"             return(RELOP_LT);
"<="            return(RELOP_LTE);
">"             return(RELOP_GT);
">="            return(RELOP_GTE);
"=="            return(RELOP_EQ);
"!="            return(RELOP_NE);
"**"            return(POW);
"->"            return(POINTY);
{WS}+"."{WS}+   return(CONCAT);
"."             return(DOT);
<emit,INITIAL>".."     return(DOTDOT);
"+="            return(PLUS_ASSIGN);
"-="            return(MINUS_ASSIGN);
"*="            return(MUL_ASSIGN);
"/="            return(DIV_ASSIGN);
"%="            return(MOD_ASSIGN);
"//"            return(FDIV);
"//="           return(FDIV_ASSIGN);
"&="            return(BAND_ASSIGN);
"|="            return(BOR_ASSIGN);
"~="            return(BXOR_ASSIGN);
">>="           return(SHR_ASSIGN);
"<<="           return(SHL_ASSIGN);
">>>="          return(SHR_U_ASSIGN);
".="            return(CONCAT_ASSIGN);

<emit,INITIAL>".macro" {
        return read_macro(valp, interp);
    }

<emit>".constant" {
        int c;
    char *name;
    struct macro_t *m;

    BEGIN(macro);
    c = yylex_skip(valp, interp, " ");
    if (c != IDENTIFIER)
        IMCC_fataly(interp, E_SyntaxError,
           "Constant names must be identifiers");

    name = str_dup(valp->s);

    c = yylex_skip(valp, interp, " ");
        if (c != INTC && c != FLOATC && c != STRINGC && c != REG)
        IMCC_fataly(interp, E_SyntaxError,
            "Constant '%s' value must be a number, "
            "stringliteral or register", name);

    m = macros + num_macros++;
    m->name = name;
    m->expansion = str_dup (valp->s);
    m->params.num_param = 0;

    BEGIN (emit);
    return MACRO;
    }

<emit,INITIAL>".include" {
        int c;

    c = yylex(valp, interp);
    if (c != STRINGC) return c;

    YYCHOP();
    include_file(interp, str_dup(yytext + 1));
    }

<emit,INITIAL>{ID}"$:" {
        char *label;

    if (valp) {
        YYCHOP();
            YYCHOP();

            if (!frames || !frames->label)
                IMCC_fataly(interp, E_SyntaxError, "missing space?");
        label = mem_sys_allocate(yyleng+10);
        sprintf(label, "%s%d", yytext, frames->label);

        valp->s = label;
    }

        return LABEL;
    }

<emit,INITIAL>{ID}"$" {
        char *label;

    if (valp) {
        YYCHOP();

            /* #32421   if$I0 is parsed as if$ I0 */
            if (!frames || !frames->label)
                IMCC_fataly(interp, E_SyntaxError, "missing space?");

        label = mem_sys_allocate(yyleng+10);
        sprintf(label, "%s%d", yytext, frames->label);

        valp->s = label;
    }

    return IDENTIFIER;
    }

<emit,INITIAL>","             return(COMMA);

<emit,INITIAL>{ID}":" {
    YYCHOP();  /* trim last ':' */
    DUP_AND_RET(valp,LABEL);
    }

<emit,INITIAL>{DOT}{LETTER}{LETTERDIGIT}* {
        int type = pmc_type(interp, string_from_cstring(interp, yytext+1, 0));

        if (type > 0) {
            char *buf = malloc(16);
        sprintf(buf, "%d", type);
        valp->s = buf;
        return INTC;
    }
    if (!expand_macro(valp, interp, yytext+1)) {
            yyless(1);
            return DOT;
        }
    }

<emit,INITIAL>{ID} {
    if (!is_def) {
        SymReg *r = find_sym(interp, yytext);
        if (r && (r->type & (VTIDENTIFIER|VT_CONSTP))) {
            valp->sr = r;
            return VAR;
        }
                if (cur_unit && cur_unit->instructions &&
                        (r = cur_unit->instructions->r[0]) &&
                        r->pcc_sub) {
                    if ((r->pcc_sub->pragma & P_METHOD) &&
                        !strcmp(yytext, "self")) {
                        valp->sr  = mk_ident(interp, str_dup("self"), 'P');
                        cur_unit->type |= IMC_HAS_SELF;
                        return VAR;
                    }
                }
    }
        valp->s = str_dup(yytext);
        return(!is_def && is_op(interp, valp->s) ? PARROT_OP : IDENTIFIER);
    }

<*>{FLOATNUM}         DUP_AND_RET(valp, FLOATC);
<*>{SIGN}?{DIGIT}+    DUP_AND_RET(valp, INTC);
<*>{HEX}              DUP_AND_RET(valp, INTC);
<*>{BIN}              DUP_AND_RET(valp, INTC);

<*>{BIGINT}         {
    valp->s = str_dup(yytext);
        valp->s[strlen(valp->s) - 1] = '\0'; /* trailing 'L' */
        return(STRINGC); /* no BIGINT native format yet */
    }

<*>{STRINGCONSTANT} {
    valp->s = str_dup(yytext);
        return(STRINGC); /* XXX delete quotes, -> emit, pbc */
    }

<*>"<<"{STRINGCONSTANT} {
        struct macro_frame_t *frame;
        /* Save the string we want to mark the end of the heredoc and snip
           off newline and quote. */
        if (frames->heredoc_rest)
            IMCC_fataly(interp, E_SyntaxError,
            "nested heredoc not supported");
        heredoc_end = str_dup(yytext + 3);
        heredoc_end[strlen(heredoc_end) - 1] = 0;
        if (!strlen(heredoc_end))
            IMCC_fataly(interp, E_SyntaxError, "empty heredoc delimiter");
        frame = new_frame(interp);
        frame->s.next = (struct parser_state_t*) frames;
        frames = frame;
        prev_state = YYSTATE;
        /* Start slurping up the heredoc. */
        heredoc_content = mem_sys_allocate(2);
        heredoc_content[0] = yytext[2];        /* preserve delim */
        heredoc_content[1] = 0;                /* eos */
        BEGIN(heredoc1);
    }

<*>{UNICODE} {
    valp->s = str_dup(yytext);    /* charset:"..." */
        /* this is actually not unicode but a string with a charset */
        return(USTRINGC);
    }


<emit,INITIAL>\$I[0-9]+          DUP_AND_RET(valp, IREG);
<emit,INITIAL>\$N[0-9]+          DUP_AND_RET(valp, NREG);
<emit,INITIAL>\$S[0-9]+          DUP_AND_RET(valp, SREG);
<emit,INITIAL>\$P[0-9]+          DUP_AND_RET(valp, PREG);

<emit,INITIAL>{WS}+ /* skip */;

<emit,cmt1,cmt2,cmt3,cmt4,cmt5,INITIAL>.     {
        /* catch all except for state macro */
        return yytext[0];
    }

<emit><<EOF>> {
        BEGIN (INITIAL);
        if (frames->s.pasm_file) {
            frames->s.pasm_file = 2;
            return EOM;
        }
        return 0;
    }

<INITIAL><<EOF>> yyterminate();

<macro>".endm"         DUP_AND_RET(valp, ENDM);

<macro>{WS}*{EOL} {
        line++;
        DUP_AND_RET(valp, '\n');
    }

<macro>"$"{ID}":"  return LABEL;
<macro>".local"{WS}+ {
        char *label;
    char *name = macros[num_macros].name;

    if (yylex(valp, interp) != LABEL)
            IMCC_fataly(interp, E_SyntaxError, "LABEL expected");

    if (valp) {
        YYCHOP();

        label = mem_sys_allocate(strlen(name) + yyleng + 15);
        sprintf(label, "local__%s__%s__$:", name, yytext+1);

        valp->s = label;
    }

    return LABEL;
    }

<macro>".$"{ID} {
        char *label;
    char *name = macros[num_macros].name;

    if (valp) {
        label = mem_sys_allocate(strlen(name) + yyleng + 15);
        sprintf(label, "local__%s__%s__$", name, yytext+2);

        valp->s = label;
    }

    return IDENTIFIER;
    }

<macro>^{WS}+                       /* skip leading ws */;
<macro>{WS}+                        DUP_AND_RET(valp, ' ');
<macro>{ID}                         DUP_AND_RET(valp, IDENTIFIER);
<macro>{DOT}{ID}                    DUP_AND_RET(valp, MACRO);
<macro>.                            DUP_AND_RET(valp, yytext[0]);
<macro><<EOF>>                      yyterminate();

%%

#ifdef yywrap
#undef yywrap
#endif

int yywrap() {
    /* Add code here to open next source file and start scanning
       yywrap returns 0 if scanning is to continue
    */
    yy_delete_buffer(YY_CURRENT_BUFFER);

    /* pop old frame */
    if (frames->s.next) {
        pop_parser_state(frames->s.interpreter);
        if (YYSTATE == INITIAL || YYSTATE == emit)
            BEGIN(frames->s.pasm_file ? emit : INITIAL);
        return 0;
    }

    return 1;
}

static struct macro_frame_t *
new_frame (Interp* interp)
{
    static int label = 0;
    struct macro_frame_t *tmp;

    tmp = mem_sys_allocate_zeroed(sizeof(struct macro_frame_t));
    tmp->label = ++label;
    tmp->s.line = line;
    tmp->s.handle = NULL;
    if (frames) {
        tmp->s.pasm_file = frames->s.pasm_file;
        tmp->s.file = frames->s.file;
        tmp->s.pragmas = frames->s.pragmas;
    }
    tmp->s.interpreter = interp;

    return tmp;
}

static void
scan_string (struct macro_frame_t *frame, const char *expansion)
{
    frame->buffer = YY_CURRENT_BUFFER;
    frame->s.next = (struct parser_state_t*) frames;
    frames = frame;

    yy_scan_string(expansion);
}

static void
destroy_frame (struct macro_frame_t *frame)
{
    YY_BUFFER_STATE buffer;
    int i;

    buffer = frame->buffer;

    for (i = 0; i < frame->expansion.num_param; i++) {
        free(frame->expansion.name[i]);
    }

    if (frame->heredoc_rest)
        mem_sys_free(frame->heredoc_rest);
    else
        line = frame->s.line;
    /* FIXME if frame->s.file was allocated free it */

    mem_sys_free(frame);

    yy_switch_to_buffer(buffer);
}

static int
yylex_skip (YYSTYPE *valp, void *interp, const char *skip)
{
    int c;
    const char *p;

    do {
        c = yylex(valp, interp);
        p = skip;
    while (*p && c != *p) p++;
    } while (*p != '\0');
    if (c)
        DUP_AND_RET(valp, c);
    else
        return c;
}

static int
read_params (YYSTYPE *valp, void *interp, struct params_t *params,
         const char *macro_name, int need_id)
{
    int c;
    YYSTYPE val;
    char *current = str_dup("");
    int len = 0;

    params->num_param = 0;
    c = yylex_skip(&val, interp, " \n");

    while(c != ')') {
        if (YYSTATE == heredoc2)
            IMCC_fataly(interp, E_SyntaxError,
                    "Heredoc in macro '%s' not allowed",
                    macro_name);
        if (c <= 0)
            IMCC_fataly(interp, E_SyntaxError,
                    "End of file reached while reading arguments in '%s'",
                    macro_name);
        else if (c == ',') {
            if (params->num_param == MAX_PARAM)
                IMCC_fataly(interp, E_SyntaxError,
                        "More then %d params in '%s'",
                        MAX_PARAM, macro_name);
            params->name[params->num_param++] = current;
            current = str_dup("");
            len = 0;
            c = yylex_skip(&val, interp, " \n");
        }
        else if (need_id && (*current || c != IDENTIFIER) && c != ' ') {
            IMCC_fataly(interp, E_SyntaxError,
                    "Parameter definition in '%s' must be IDENTIFIER",
                    macro_name);
        }
        else {
            if (!need_id || c != ' ') {
                len += strlen(val.s);
                current = realloc(current, len + 1);
                strcat(current,val.s);
            }
            free(val.s);
            c = yylex(&val,interp);
        }
    }
    params->name[params->num_param++] = current;

    if (valp) *valp = val;
    else free(val.s);

    return c;
}

static int
read_macro (YYSTYPE *valp, Interp *interp)
{
    int c;
    struct macro_t *m = macros + num_macros;
    int start_cond;

    temp_buffer[0]='\0';

    start_cond = YY_START;
    BEGIN(macro);

    c = yylex_skip(valp, interp, " ");
    if (c != IDENTIFIER)
        IMCC_fataly(interp, E_SyntaxError,
            "Macro names must be identifiers");

    m->name = valp->s;
    m->line = line;

    /* white space is allowed between macro and opening paren) */
    c = yylex_skip(valp, interp, " ");

    if (c == '(') {
    free(valp->s);

    c = read_params(NULL, interp, &m->params, m->name, 1);

    c = yylex(valp, interp);
    }

    while (c != ENDM) {
    if (c <= 0)
            IMCC_fataly(interp, E_SyntaxError,
            "File ended before macro '%s' was complete", m->name);

    strcat(temp_buffer, valp->s);
    free(valp->s);

        c = yylex(valp, interp);
    }
    free(valp->s);

    BEGIN(start_cond);

    macros[num_macros].expansion = str_dup(temp_buffer);

    num_macros++;
    return MACRO;
}

static char *
find_macro_param (const char *name)
{
    struct macro_frame_t *f;
    int i;

    for (f = frames; f; f = (struct macro_frame_t*)f->s.next) {
    if (f->params) {
        for (i = 0; i < f->params->num_param; i++) {
        if (strcmp(f->params->name[i], name) == 0) {
            return f->expansion.name[i];
        }
        }
    }
    }

    return NULL;
}

static struct macro_t *
find_macro (const char* name)
{
    int i;

    for (i = 0; i < num_macros; i++) {
    if (strcmp(name, macros[i].name) == 0) return macros + i;
    }

    return NULL;
}

static int
expand_macro (YYSTYPE *valp, void *interp, const char *name)
{
    int c;
    struct macro_frame_t *frame;
    struct macro_t *m;
    const char *expansion;
    int start_cond;
    int i;
    char *current;
    char *s;
    int len;
    union {
        const void * __c_ptr;
        void * __ptr;
    } __ptr_u;

    UNUSED(valp);
    frame = new_frame(interp);
    /* When an error occurs, then report it as being in a macro */
    frame->is_macro = 1;

    expansion = find_macro_param(name);
    if (expansion) {
    scan_string(frame, expansion);
    return 1;
    }

    m = find_macro(name);
    frame->params = &m->params;
    if (m) {
        /* remember macro name for error reporting
         */
        frame->s.file = const_cast(name);
    /* whitespace can be savely ignored */
    do {
        c = input();
    } while (c == ' ' || c == '\t');

    if (c != '(') {
        unput(c);
        if (m->params.num_param != 0)
                IMCC_fataly(interp, E_SyntaxError,
            "Macro '%s' needs %d arguments",
                        m->name, m->params.num_param);
        scan_string(frame, m->expansion);
        return 1;
    }

    start_cond = YY_START;
    BEGIN(macro);

    read_params (NULL, interp, &frame->expansion, m->name, 0);

    BEGIN(start_cond);

    if (frame->expansion.num_param == 0 && m->params.num_param == 1) {
        frame->expansion.name[0] = str_dup("");
        frame->expansion.num_param = 1;
    }

    if (frame->expansion.num_param != m->params.num_param) {
            IMCC_fataly(interp, E_SyntaxError,
           "Macro '%s' requires %d arguments, but %d given",
           m->name, m->params.num_param, frame->expansion.num_param);
    }

        /* expand arguments */
        for (i = 0; i < frame->expansion.num_param; i ++) {
            current = frame->expansion.name[i];
            if (current[0] == '.') { /* parameter of outer macro */
                s = find_macro_param(current + 1);
                if (s) {
                    frame->expansion.name[i] = strdup(s);
                    free(current);
                }
            } else {
                len = strlen(current) - 1;
                if (current[len] == '$') { /* local label */
                    current[len] = '\0';
                    s = mem_sys_allocate(len + 1 + 10);
                    sprintf(s, "%s%d", current, frames->label);
                    frame->expansion.name[i] = s;
                    free(current);
                }
            }
        }

    line = m->line;
    scan_string(frame, m->expansion);
    return 1;
    }

    return 0;
}

static void
include_file (Interp* interp, char *file_name)
{
    struct macro_frame_t *frame;
    FILE *file = 0;
    char *ext, *s;

    frame = new_frame(interp);
    s = Parrot_locate_runtime_file(interp, file_name,
        PARROT_RUNTIME_FT_INCLUDE);
    if (s) {
    file = fopen(s, "r");
        if (!file) {
            mem_sys_free(s);
            IMCC_fataly(interp, E_IOError, strerror(errno));
        }
    }
    else
        IMCC_fataly(interp, E_IOError, strerror(errno));

    frame->s.file = file_name;
    frame->s.handle = file;

    ext = strrchr(file_name, '.');
    if (ext) {
        if (strcmp (ext, ".pasm") == 0) {
            frame->s.pasm_file = 1;
            BEGIN(emit);
        }
        else if (strcmp (ext, ".imc") == 0) {
            frame->s.pasm_file = 0;
            BEGIN(INITIAL);
        }
    }

    scan_file (interp, frame, file);
}

static void
scan_file (Interp* interp, struct macro_frame_t *frame, FILE *file)
{
    frame->buffer = YY_CURRENT_BUFFER;
    frame->s.next = (struct parser_state_t*)frames;
    frames = frame;
    IMCC_INFO(interp)->state = (struct parser_state_t *) frames;

    line = 1;

    yy_switch_to_buffer(yy_create_buffer(file, YY_BUF_SIZE));
}

void
IMCC_push_parser_state(Interp* interp)
{
    struct macro_frame_t *frame;

    frame = new_frame(interp);
    frame->s.next = (struct parser_state_t*)frames;
    frames = frame;
    frame->s.line = line = 1;
    IMCC_INFO(interp)->state = (struct parser_state_t *) frames;
}

static void
pop_parser_state(Interp* interp)
{
    struct macro_frame_t *tmp;
    tmp = frames;
    if (tmp) {
        if (tmp->s.handle) fclose (tmp->s.handle);
        frames = (struct macro_frame_t*) frames->s.next;
        destroy_frame(tmp);
    }
    IMCC_INFO(interp)->state = (struct parser_state_t *) frames;
}

void
compile_file(Interp *interp, FILE *file)
{
    YY_BUFFER_STATE buffer;

    frames->s.next = NULL;
    buffer = YY_CURRENT_BUFFER;
    yy_switch_to_buffer(yy_create_buffer(file, YY_BUF_SIZE));

    emit_open(interp, 1, NULL);
    yyparse((void *) interp);
    imc_compile_all_units(interp);

    yy_switch_to_buffer(buffer);
}

void
compile_string(Interp *interp, char *s)
{
    YY_BUFFER_STATE buffer;

    frames->s.next = NULL;
    buffer = YY_CURRENT_BUFFER;

    yy_scan_string(s);
    emit_open(interp, 1, NULL);
    yyparse((void *) interp);
    imc_compile_all_units(interp);
    yy_switch_to_buffer(buffer);
}

void
IMCC_print_inc(Interp *interp)
{
    struct macro_frame_t *f;
    const char *old;

    UNUSED(interp);
    if (frames && frames->is_macro)
        fprintf(stderr, "\nin macro '.%s' line %d\n", frames->s.file, line);
    else
        fprintf(stderr, "\nin file '%s' line %d\n", frames->s.file, line);
    old = frames->s.file;
    for (f = frames; f; f = (struct macro_frame_t *)f->s.next) {
        if (strcmp(f->s.file, old)) {
            fprintf(stderr, "\tincluded from '%s' line %d\n",
                f->s.file, f->s.line);
        }
        old = f->s.file;
    }
}

/*
 * Local variables:
 * c-indentation-style: bsd
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * End:
 *
 * vim: expandtab shiftwidth=4:
 */