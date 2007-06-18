/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ASM = 258,
     ABSTRACT = 259,
     BOOL = 260,
     BREAK = 261,
     BYTE = 262,
     CHAR = 263,
     CLASS = 264,
     CONST = 265,
     CONTINUE = 266,
     DOUBLE = 267,
     DECIMAL = 268,
     ELSE = 269,
     EXTERN = 270,
     FALSE = 271,
     FLOAT = 272,
     FOR = 273,
     GET = 274,
     GOTO = 275,
     IF = 276,
     INT = 277,
     INTERNAL = 278,
     LONG = 279,
     METHOD = 280,
     MODIFIER = 281,
     NEW = 282,
     NAMESPACE = 283,
     NULLVAL = 284,
     OUT = 285,
     OVERRIDE = 286,
     OBJECT = 287,
     PRIVATE = 288,
     PROTECTED = 289,
     PUBLIC = 290,
     REF = 291,
     READONLY = 292,
     RETURN = 293,
     SBYTE = 294,
     SET = 295,
     SHORT = 296,
     STRING = 297,
     STATIC = 298,
     THIS = 299,
     TRUE = 300,
     TYPE = 301,
     UINT = 302,
     USHORT = 303,
     ULONG = 304,
     USING = 305,
     VIRTUAL = 306,
     VOID = 307,
     WHILE = 308,
     IDENTIFIER = 309,
     LITERAL = 310,
     RANKSPEC = 311,
     INC = 312,
     DEC = 313,
     LOGICAL_AND = 314,
     LOGICAL_OR = 315,
     LOGICAL_EQ = 316,
     LOGICAL_NE = 317,
     LOGICAL_LTE = 318,
     LOGICAL_GTE = 319,
     LEFT_SHIFT = 320,
     RIGHT_SHIFT = 321,
     INDEX = 322,
     UMINUS = 323
   };
#endif
/* Tokens.  */
#define ASM 258
#define ABSTRACT 259
#define BOOL 260
#define BREAK 261
#define BYTE 262
#define CHAR 263
#define CLASS 264
#define CONST 265
#define CONTINUE 266
#define DOUBLE 267
#define DECIMAL 268
#define ELSE 269
#define EXTERN 270
#define FALSE 271
#define FLOAT 272
#define FOR 273
#define GET 274
#define GOTO 275
#define IF 276
#define INT 277
#define INTERNAL 278
#define LONG 279
#define METHOD 280
#define MODIFIER 281
#define NEW 282
#define NAMESPACE 283
#define NULLVAL 284
#define OUT 285
#define OVERRIDE 286
#define OBJECT 287
#define PRIVATE 288
#define PROTECTED 289
#define PUBLIC 290
#define REF 291
#define READONLY 292
#define RETURN 293
#define SBYTE 294
#define SET 295
#define SHORT 296
#define STRING 297
#define STATIC 298
#define THIS 299
#define TRUE 300
#define TYPE 301
#define UINT 302
#define USHORT 303
#define ULONG 304
#define USING 305
#define VIRTUAL 306
#define VOID 307
#define WHILE 308
#define IDENTIFIER 309
#define LITERAL 310
#define RANKSPEC 311
#define INC 312
#define DEC 313
#define LOGICAL_AND 314
#define LOGICAL_OR 315
#define LOGICAL_EQ 316
#define LOGICAL_NE 317
#define LOGICAL_LTE 318
#define LOGICAL_GTE 319
#define LEFT_SHIFT 320
#define RIGHT_SHIFT 321
#define INDEX 322
#define UMINUS 323




/* Copy the first part of user declarations.  */
#line 1 "cola.y"

/*
 * cola.y
 *
 * Cola compiler for Parrot
 *
 * Copyright (C) 2002 Melvin Smith <melvin.smith@mindspring.com>
 *
 * Borrows heavily from Java and C#
 *     Java is a registered trademark of Sun Microsystems
 *     C# is a registered trademark of Microsoft Corporation
 *
 * The parser. Grammar for Bison.
 */


#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "cola.h"

int         yyerror(char *);
int         yylex();
extern char yytext[];
long        line;
int         indent;

AST         *ast_start = NULL;

/* Pointers to the builtin type entries in the symbol table */



/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 34 "cola.y"
{
    int ival;
    Symbol * sym;
    Type * type;
    AST * ast;
    void * p;
}
/* Line 193 of yacc.c.  */
#line 273 "parser.c"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 286 "parser.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   479

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  93
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  80
/* YYNRULES -- Number of rules.  */
#define YYNRULES  165
/* YYNRULES -- Number of states.  */
#define YYNSTATES  269

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   323

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    83,     2,     2,     2,    86,    88,     2,
      74,    81,    70,    69,    80,    68,    77,    71,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    82,    78,
      91,    72,    92,    87,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    75,     2,    85,    89,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    76,    90,    79,    84,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    73
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     4,     6,    10,    11,    14,    20,    24,
      25,    28,    31,    33,    37,    42,    43,    46,    48,    50,
      55,    56,    58,    61,    63,    65,    67,    69,    71,    73,
      77,    80,    81,    84,    86,    88,    91,    98,   101,   106,
     108,   112,   116,   118,   121,   128,   135,   136,   138,   140,
     144,   147,   149,   154,   155,   157,   159,   161,   163,   165,
     167,   169,   171,   173,   175,   176,   178,   181,   185,   188,
     191,   194,   198,   202,   205,   211,   213,   217,   218,   220,
     222,   224,   226,   234,   240,   242,   244,   250,   260,   262,
     264,   266,   268,   270,   272,   274,   276,   278,   281,   283,
     286,   288,   290,   292,   294,   296,   298,   302,   305,   308,
     311,   314,   316,   318,   320,   322,   324,   328,   330,   332,
     334,   336,   338,   340,   342,   345,   348,   351,   354,   356,
     358,   363,   365,   370,   372,   378,   380,   384,   388,   392,
     394,   398,   402,   404,   410,   412,   416,   418,   422,   424,
     428,   430,   434,   436,   440,   442,   444,   446,   448,   450,
     454,   456,   460,   464,   466,   470
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int16 yyrhs[] =
{
      95,     0,    -1,    -1,    78,    -1,    96,    98,   103,    -1,
      -1,    96,    97,    -1,    50,    54,    72,    54,    78,    -1,
      50,    54,    78,    -1,    -1,   100,   102,    -1,    28,   101,
      -1,    54,    -1,   101,    77,    54,    -1,    76,    96,   103,
      79,    -1,    -1,   103,   104,    -1,    99,    -1,   105,    -1,
     106,   110,   109,    94,    -1,    -1,   107,    -1,   107,   108,
      -1,   108,    -1,    35,    -1,    33,    -1,    34,    -1,    43,
      -1,    51,    -1,    76,   111,    79,    -1,     9,    54,    -1,
      -1,   111,   112,    -1,   115,    -1,   118,    -1,   114,    78,
      -1,    10,   141,    54,    72,    55,    78,    -1,   141,   116,
      -1,   106,   141,   116,    78,    -1,   117,    -1,   116,    80,
     117,    -1,    54,    72,   152,    -1,    54,    -1,   119,   123,
      -1,   106,   141,    54,    74,   120,    81,    -1,   106,    52,
      54,    74,   120,    81,    -1,    -1,   121,    -1,   122,    -1,
     121,    80,   122,    -1,   141,    54,    -1,   124,    -1,    76,
     125,   128,    79,    -1,    -1,   124,    -1,   130,    -1,   136,
      -1,   138,    -1,   131,    -1,   132,    -1,   133,    -1,   126,
      -1,   113,    -1,   129,    -1,    -1,   127,    -1,   128,   127,
      -1,    54,    82,   127,    -1,   146,    78,    -1,     6,    78,
      -1,    11,    78,    -1,    20,    54,    78,    -1,    38,   152,
      78,    -1,    38,    78,    -1,     3,    74,    55,    81,    78,
      -1,   135,    -1,   134,    80,   135,    -1,    -1,   152,    -1,
      36,    -1,    30,    -1,   137,    -1,    21,    74,   153,    81,
     126,    14,   126,    -1,    21,    74,   153,    81,   126,    -1,
     139,    -1,   140,    -1,    53,    74,   153,    81,   126,    -1,
      18,    74,   146,    78,   153,    78,   146,    81,   126,    -1,
     101,    -1,   142,    -1,   144,    -1,     5,    -1,    42,    -1,
      17,    -1,   143,    -1,    22,    -1,     7,    -1,   141,   145,
      -1,    56,    -1,   145,    56,    -1,   156,    -1,   147,    -1,
     150,    -1,   151,    -1,   148,    -1,   149,    -1,   155,    72,
     152,    -1,    57,   155,    -1,    58,   155,    -1,   154,    57,
      -1,   154,    58,    -1,   163,    -1,   147,    -1,   152,    -1,
      55,    -1,    54,    -1,    74,   152,    81,    -1,   158,    -1,
     156,    -1,   150,    -1,   151,    -1,   159,    -1,   157,    -1,
     154,    -1,    69,   155,    -1,    68,   155,    -1,    83,   155,
      -1,    84,   155,    -1,   148,    -1,   149,    -1,   154,    74,
     134,    81,    -1,   101,    -1,   154,    75,   152,    85,    -1,
     160,    -1,    27,   141,    74,   134,    81,    -1,   155,    -1,
     161,    70,   155,    -1,   161,    71,   155,    -1,   161,    86,
     155,    -1,   161,    -1,   162,    69,   161,    -1,   162,    68,
     161,    -1,   165,    -1,   165,    87,   152,    82,   152,    -1,
     168,    -1,   164,    59,   168,    -1,   164,    -1,   165,    60,
     164,    -1,   171,    -1,   166,    88,   171,    -1,   166,    -1,
     167,    89,   166,    -1,   167,    -1,   168,    90,   167,    -1,
      91,    -1,    92,    -1,    63,    -1,    64,    -1,   172,    -1,
     170,   169,   172,    -1,   170,    -1,   171,    61,   170,    -1,
     171,    62,   170,    -1,   162,    -1,   172,    65,   162,    -1,
     172,    66,   162,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   108,   108,   109,   113,   123,   124,   131,   133,   141,
     145,   154,   173,   175,   183,   192,   194,   203,   204,   208,
     219,   220,   224,   226,   230,   232,   234,   236,   238,   243,
     248,   265,   266,   274,   275,   290,   292,   308,   327,   346,
     347,   355,   366,   378,   386,   408,   435,   436,   445,   446,
     454,   476,   481,   494,   498,   500,   502,   504,   506,   508,
     510,   515,   516,   518,   524,   525,   527,   535,   540,   545,
     547,   549,   558,   560,   565,   570,   571,   579,   580,   582,
     584,   589,   593,   598,   605,   606,   610,   617,   629,   634,
     635,   639,   641,   643,   645,   649,   651,   656,   666,   674,
     684,   685,   686,   687,   688,   689,   693,   707,   715,   723,
     731,   739,   746,   755,   759,   766,   775,   779,   780,   781,
     782,   783,   784,   789,   791,   793,   795,   797,   799,   800,
     804,   818,   827,   838,   846,   857,   858,   862,   866,   873,
     874,   878,   885,   886,   894,   895,   902,   903,   910,   911,
     918,   919,   926,   927,   934,   936,   938,   940,   945,   946,
     954,   955,   960,   968,   969,   973
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "ASM", "ABSTRACT", "BOOL", "BREAK",
  "BYTE", "CHAR", "CLASS", "CONST", "CONTINUE", "DOUBLE", "DECIMAL",
  "ELSE", "EXTERN", "FALSE", "FLOAT", "FOR", "GET", "GOTO", "IF", "INT",
  "INTERNAL", "LONG", "METHOD", "MODIFIER", "NEW", "NAMESPACE", "NULLVAL",
  "OUT", "OVERRIDE", "OBJECT", "PRIVATE", "PROTECTED", "PUBLIC", "REF",
  "READONLY", "RETURN", "SBYTE", "SET", "SHORT", "STRING", "STATIC",
  "THIS", "TRUE", "TYPE", "UINT", "USHORT", "ULONG", "USING", "VIRTUAL",
  "VOID", "WHILE", "IDENTIFIER", "LITERAL", "RANKSPEC", "INC", "DEC",
  "LOGICAL_AND", "LOGICAL_OR", "LOGICAL_EQ", "LOGICAL_NE", "LOGICAL_LTE",
  "LOGICAL_GTE", "LEFT_SHIFT", "RIGHT_SHIFT", "INDEX", "'-'", "'+'", "'*'",
  "'/'", "'='", "UMINUS", "'('", "'['", "'{'", "'.'", "';'", "'}'", "','",
  "')'", "':'", "'!'", "'~'", "']'", "'%'", "'?'", "'&'", "'^'", "'|'",
  "'<'", "'>'", "$accept", "optional_semi", "compilation_unit",
  "using_directives", "using_directive", "attribute_list",
  "namespace_decl", "namespace_scope_start", "qualified_name",
  "namespace_body", "namespace_member_decls", "namespace_member_decl",
  "class_decl", "opt_modifiers", "modifiers", "modifier", "class_body",
  "class_scope_start", "class_member_decl_list", "class_member_decl",
  "decl_statement", "local_var_decl", "field_decl", "var_declarators",
  "var_declarator", "method_decl", "method_header", "formal_param_list",
  "fixed_params", "fixed_param", "method_body", "block", "block_scope",
  "embedded_statement", "statement", "statement_list", "labeled_statement",
  "expr_statement", "jump_statement", "return_statement", "asm_block",
  "arg_list", "arg", "selection_statement", "if_statement",
  "iteration_statement", "while_statement", "for_statement", "type",
  "predefined_type", "integral_type", "array_type", "rank_specifiers",
  "statement_expr", "assignment", "pre_inc_expr", "pre_dec_expr",
  "post_inc_expr", "post_dec_expr", "expr", "boolean_expr", "primary_expr",
  "unary_expr", "method_call", "member_access", "element_access",
  "new_expr", "new_object_expr", "mult_expr", "add_expr",
  "conditional_expr", "conditional_and_expr", "conditional_or_expr",
  "and_expr", "exclusive_or_expr", "inclusive_or_expr", "relational_op",
  "relational_expr", "equality_expr", "shift_expr", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,   316,   317,   318,   319,   320,   321,   322,    45,    43,
      42,    47,    61,   323,    40,    91,   123,    46,    59,   125,
      44,    41,    58,    33,   126,    93,    37,    63,    38,    94,
     124,    60,    62
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    93,    94,    94,    95,    96,    96,    97,    97,    98,
      99,   100,   101,   101,   102,   103,   103,   104,   104,   105,
     106,   106,   107,   107,   108,   108,   108,   108,   108,   109,
     110,   111,   111,   112,   112,   113,   113,   114,   115,   116,
     116,   117,   117,   118,   119,   119,   120,   120,   121,   121,
     122,   123,   124,   125,   126,   126,   126,   126,   126,   126,
     126,   127,   127,   127,   128,   128,   128,   129,   130,   131,
     131,   131,   132,   132,   133,   134,   134,   135,   135,   135,
     135,   136,   137,   137,   138,   138,   139,   140,   141,   141,
     141,   142,   142,   142,   142,   143,   143,   144,   145,   145,
     146,   146,   146,   146,   146,   146,   147,   148,   149,   150,
     151,   152,   152,   153,   154,   154,   154,   154,   154,   154,
     154,   154,   154,   155,   155,   155,   155,   155,   155,   155,
     156,   157,   158,   159,   160,   161,   161,   161,   161,   162,
     162,   162,   163,   163,   164,   164,   165,   165,   166,   166,
     167,   167,   168,   168,   169,   169,   169,   169,   170,   170,
     171,   171,   171,   172,   172,   172
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     0,     1,     3,     0,     2,     5,     3,     0,
       2,     2,     1,     3,     4,     0,     2,     1,     1,     4,
       0,     1,     2,     1,     1,     1,     1,     1,     1,     3,
       2,     0,     2,     1,     1,     2,     6,     2,     4,     1,
       3,     3,     1,     2,     6,     6,     0,     1,     1,     3,
       2,     1,     4,     0,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     0,     1,     2,     3,     2,     2,
       2,     3,     3,     2,     5,     1,     3,     0,     1,     1,
       1,     1,     7,     5,     1,     1,     5,     9,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     2,     1,     2,
       1,     1,     1,     1,     1,     1,     3,     2,     2,     2,
       2,     1,     1,     1,     1,     1,     3,     1,     1,     1,
       1,     1,     1,     1,     2,     2,     2,     2,     1,     1,
       4,     1,     4,     1,     5,     1,     3,     3,     3,     1,
       3,     3,     1,     5,     1,     3,     1,     3,     1,     3,
       1,     3,     1,     3,     1,     1,     1,     1,     1,     3,
       1,     3,     3,     1,     3,     3
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       5,     0,     9,     1,     0,     6,    15,     0,     4,     0,
       8,     0,    25,    26,    24,    27,    28,    17,     0,    16,
      18,     0,    21,    23,     0,    12,    11,     5,    10,     0,
       0,    22,     7,     0,    15,    30,    31,     2,    13,    20,
      20,     3,    19,    14,    29,     0,    32,    33,    34,     0,
      91,    96,    93,    95,    92,     0,    88,     0,    89,    94,
      90,    53,    43,    51,     0,    42,    98,     0,    39,    97,
      64,    46,     0,    46,    38,     0,    99,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,    12,   114,     0,
       0,     0,     0,     0,     0,     0,   131,    62,     0,    54,
      61,    65,     0,    63,    55,    58,    59,    60,    56,    81,
      57,    84,    85,     0,     0,   101,   104,   105,   119,   120,
     123,     0,   118,   122,   117,   121,   133,     0,    47,    48,
       0,    12,   131,   112,   128,   129,   119,   120,    41,   135,
     118,   139,   163,   111,   146,   142,   150,   152,   144,   160,
     148,   158,     0,    42,    40,     0,    69,     0,    70,     0,
       0,     0,     0,    73,     0,     0,     0,   107,   108,   125,
     124,     0,   126,   127,    35,    52,    66,    37,    68,   109,
     110,    77,     0,     0,    45,     0,    50,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,   156,   157,
     154,   155,     0,     0,     0,     0,     0,    44,     0,     0,
       0,    71,   113,     0,    77,    72,     0,    67,   116,    80,
      79,     0,    75,    78,     0,   106,    49,   136,   137,   138,
     135,   141,   140,   145,   147,     0,   149,   151,   153,   159,
     161,   162,   164,   165,     0,     0,     0,     0,     0,     0,
      77,   130,   132,     0,    74,     0,     0,    83,   134,    86,
      76,   143,    36,     0,     0,     0,    82,     0,    87
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,    42,     1,     2,     5,     6,    17,    18,   132,    28,
       8,    19,    20,    21,    22,    23,    37,    30,    40,    46,
      97,    98,    47,    67,    68,    48,    49,   127,   128,   129,
      62,    99,    70,   100,   101,   102,   103,   104,   105,   106,
     107,   221,   222,   108,   109,   110,   111,   112,   113,    58,
      59,    60,    69,   114,   133,   134,   135,   136,   137,   212,
     213,   120,   139,   140,   123,   124,   125,   126,   141,   142,
     143,   144,   145,   146,   147,   148,   202,   149,   150,   151
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -185
static const yytype_int16 yypact[] =
{
    -185,     7,   -21,  -185,    20,  -185,  -185,     4,    44,    27,
    -185,    31,  -185,  -185,  -185,  -185,  -185,  -185,   -38,  -185,
    -185,    25,   130,  -185,    10,  -185,   -19,  -185,  -185,    84,
      66,  -185,  -185,   101,   -21,  -185,  -185,    81,  -185,   -20,
     111,  -185,  -185,  -185,  -185,   163,  -185,  -185,  -185,    93,
    -185,  -185,  -185,  -185,  -185,   117,   -19,    46,  -185,  -185,
    -185,  -185,  -185,  -185,   100,    37,  -185,    32,  -185,   119,
     313,   245,   290,   245,  -185,   124,  -185,   109,   108,   245,
     110,   118,   137,   126,   245,   395,   127,   128,  -185,   290,
     290,   290,   290,   290,   290,   290,   -28,  -185,   131,  -185,
    -185,  -185,   253,  -185,  -185,  -185,  -185,  -185,  -185,  -185,
    -185,  -185,  -185,    59,   135,  -185,   134,   144,   -33,   -31,
      33,   147,   -12,  -185,  -185,  -185,  -185,   140,   142,  -185,
      60,  -185,   -19,  -185,  -185,  -185,  -185,  -185,  -185,   147,
    -185,   -15,    29,  -185,   164,   -54,   136,   138,   146,   -52,
     -45,    38,   145,   153,  -185,   175,  -185,    97,  -185,   290,
     162,   290,   -47,  -185,   165,   290,   313,  -185,  -185,  -185,
    -185,   160,  -185,  -185,  -185,  -185,  -185,   166,  -185,  -185,
    -185,   349,   290,   290,  -185,   245,  -185,   290,   290,   290,
     290,   290,   290,   290,   290,   290,   290,   290,  -185,  -185,
    -185,  -185,   290,   290,   290,   290,   290,  -185,   161,   172,
     167,  -185,  -185,   168,   349,  -185,   174,  -185,  -185,  -185,
    -185,    48,  -185,  -185,   176,  -185,  -185,  -185,  -185,  -185,
    -185,   -15,   -15,   146,   164,   183,   -45,   136,   138,    38,
     -52,   -52,    29,    29,   188,   213,   290,   372,    67,   372,
     349,  -185,  -185,   290,  -185,   191,   194,   262,  -185,  -185,
    -185,  -185,  -185,   290,   372,   196,  -185,   372,  -185
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -185,  -185,  -185,   251,  -185,  -185,  -185,  -185,    -9,  -185,
     247,  -185,  -185,   239,  -185,   260,  -185,  -185,  -185,  -185,
    -185,  -185,  -185,   170,   209,  -185,  -185,   212,  -185,   103,
    -185,   237,  -185,  -184,   -98,  -185,  -185,  -185,  -185,  -185,
    -185,    75,    40,  -185,  -185,  -185,  -185,  -185,   -27,  -185,
    -185,  -185,  -185,  -158,   -65,   -60,   -35,   -29,   -16,   -42,
    -162,  -185,   -70,   -10,  -185,  -185,  -185,  -185,   -30,   -39,
    -185,    99,  -185,    98,    96,   104,  -185,    -8,   102,   107
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -130
static const yytype_int16 yytable[] =
{
     121,   210,    26,   216,   176,   115,   193,     3,    11,    66,
     116,   198,   199,    12,    13,    14,   203,   204,    57,   167,
     168,   169,   170,    15,   172,   173,   -88,   214,   -88,     4,
     138,    16,   121,   194,    29,   117,    56,   115,    27,   200,
     201,   118,   116,   164,   130,  -102,   130,  -103,  -102,    33,
    -103,   171,   157,   -20,   119,   187,   188,   162,    33,    43,
     122,    96,    56,   257,    56,   259,  -100,   117,   217,  -100,
      56,   189,    11,   118,     7,    56,     9,    12,    13,    14,
     266,    24,    10,   268,   256,    25,   119,    15,    32,   121,
     179,   180,   122,    96,   115,    16,   121,   190,   191,   116,
      65,   115,    66,   205,   206,   265,   116,   181,   182,    72,
      74,    73,    75,   153,   186,    66,    66,   227,   228,   229,
     230,   230,   230,   230,   117,   230,   230,   230,   250,   251,
     118,   117,   230,   230,   230,   230,   230,   118,    35,   223,
     224,   225,    36,   119,    12,    13,    14,   250,   258,   122,
     119,   209,   235,    66,    15,    38,   122,    96,   130,    41,
     231,   232,    16,    12,    13,    14,   242,   243,    50,    61,
      51,    64,   223,    15,    71,    76,    56,   121,   153,   121,
      52,    16,   115,   155,   115,    53,   156,   116,   158,   116,
      44,   160,   159,   121,   121,   240,   241,   121,   115,   115,
     161,   165,   115,   116,   116,    54,  -128,   116,   223,   174,
     166,   261,   117,   178,   117,    55,  -129,    25,   118,   183,
     118,   184,   185,   192,   195,    72,   207,   196,   117,   117,
     208,   119,   117,   119,   118,   118,   197,   122,   118,   122,
     211,   218,   244,   215,   245,   246,    75,   119,   119,   247,
      50,   119,    51,   122,   122,   249,    77,   122,    50,    78,
      51,   252,    52,    79,    80,   253,   254,    53,   255,   262,
      52,    81,   263,    82,    83,    53,   264,   267,    34,    45,
      84,    39,    31,   177,   154,   152,    63,    54,   226,   248,
     260,    85,   234,   238,   237,    54,   233,   236,     0,    25,
       0,     0,     0,     0,     0,     0,    86,    87,    88,   239,
      89,    90,     0,     0,     0,     0,    77,    84,    50,    78,
      51,    91,    92,    79,    80,     0,     0,    93,     0,    61,
      52,    81,   175,    82,    83,    53,    94,    95,     0,     0,
      84,     0,     0,     0,   131,    88,     0,    89,    90,     0,
       0,    85,     0,     0,     0,    54,     0,     0,    91,    92,
       0,     0,     0,     0,    93,     0,    86,    87,    88,     0,
      89,    90,     0,    94,    95,    77,    84,     0,    78,   219,
       0,    91,    92,    80,     0,   220,     0,    93,     0,    61,
      81,     0,    82,    83,     0,     0,    94,    95,     0,    84,
       0,     0,     0,   131,    88,     0,    89,    90,     0,     0,
      85,     0,     0,     0,     0,     0,     0,    91,    92,     0,
       0,     0,    84,    93,     0,    86,   131,    88,     0,    89,
      90,     0,    94,    95,     0,     0,     0,     0,     0,     0,
      91,    92,     0,     0,     0,     0,    93,     0,    61,   131,
      88,     0,    89,    90,     0,    94,    95,     0,     0,     0,
       0,     0,     0,    91,    92,     0,     0,     0,     0,    93,
       0,     0,     0,   163,     0,     0,     0,     0,    94,    95
};

static const yytype_int16 yycheck[] =
{
      70,   159,    11,   165,   102,    70,    60,     0,    28,    56,
      70,    63,    64,    33,    34,    35,    61,    62,    45,    89,
      90,    91,    92,    43,    94,    95,    54,    74,    56,    50,
      72,    51,   102,    87,     9,    70,    45,   102,    76,    91,
      92,    70,   102,    85,    71,    78,    73,    78,    81,    77,
      81,    93,    79,     9,    70,    70,    71,    84,    77,    79,
      70,    70,    71,   247,    73,   249,    78,   102,   166,    81,
      79,    86,    28,   102,    54,    84,    72,    33,    34,    35,
     264,    54,    78,   267,   246,    54,   102,    43,    78,   159,
      57,    58,   102,   102,   159,    51,   166,    68,    69,   159,
      54,   166,    56,    65,    66,   263,   166,    74,    75,    72,
      78,    74,    80,    54,    54,    56,    56,   187,   188,   189,
     190,   191,   192,   193,   159,   195,   196,   197,    80,    81,
     159,   166,   202,   203,   204,   205,   206,   166,    54,   181,
     182,   183,    76,   159,    33,    34,    35,    80,    81,   159,
     166,    54,   194,    56,    43,    54,   166,   166,   185,    78,
     190,   191,    51,    33,    34,    35,   205,   206,     5,    76,
       7,    54,   214,    43,    74,    56,   185,   247,    54,   249,
      17,    51,   247,    74,   249,    22,    78,   247,    78,   249,
      79,    54,    74,   263,   264,   203,   204,   267,   263,   264,
      74,    74,   267,   263,   264,    42,    72,   267,   250,    78,
      82,   253,   247,    78,   249,    52,    72,    54,   247,    72,
     249,    81,    80,    59,    88,    72,    81,    89,   263,   264,
      55,   247,   267,   249,   263,   264,    90,   247,   267,   249,
      78,    81,    81,    78,    72,    78,    80,   263,   264,    81,
       5,   267,     7,   263,   264,    81,     3,   267,     5,     6,
       7,    85,    17,    10,    11,    82,    78,    22,    55,    78,
      17,    18,    78,    20,    21,    22,    14,    81,    27,    40,
      27,    34,    22,   113,    75,    73,    49,    42,   185,   214,
     250,    38,   193,   197,   196,    42,   192,   195,    -1,    54,
      -1,    -1,    -1,    -1,    -1,    -1,    53,    54,    55,   202,
      57,    58,    -1,    -1,    -1,    -1,     3,    27,     5,     6,
       7,    68,    69,    10,    11,    -1,    -1,    74,    -1,    76,
      17,    18,    79,    20,    21,    22,    83,    84,    -1,    -1,
      27,    -1,    -1,    -1,    54,    55,    -1,    57,    58,    -1,
      -1,    38,    -1,    -1,    -1,    42,    -1,    -1,    68,    69,
      -1,    -1,    -1,    -1,    74,    -1,    53,    54,    55,    -1,
      57,    58,    -1,    83,    84,     3,    27,    -1,     6,    30,
      -1,    68,    69,    11,    -1,    36,    -1,    74,    -1,    76,
      18,    -1,    20,    21,    -1,    -1,    83,    84,    -1,    27,
      -1,    -1,    -1,    54,    55,    -1,    57,    58,    -1,    -1,
      38,    -1,    -1,    -1,    -1,    -1,    -1,    68,    69,    -1,
      -1,    -1,    27,    74,    -1,    53,    54,    55,    -1,    57,
      58,    -1,    83,    84,    -1,    -1,    -1,    -1,    -1,    -1,
      68,    69,    -1,    -1,    -1,    -1,    74,    -1,    76,    54,
      55,    -1,    57,    58,    -1,    83,    84,    -1,    -1,    -1,
      -1,    -1,    -1,    68,    69,    -1,    -1,    -1,    -1,    74,
      -1,    -1,    -1,    78,    -1,    -1,    -1,    -1,    83,    84
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    95,    96,     0,    50,    97,    98,    54,   103,    72,
      78,    28,    33,    34,    35,    43,    51,    99,   100,   104,
     105,   106,   107,   108,    54,    54,   101,    76,   102,     9,
     110,   108,    78,    77,    96,    54,    76,   109,    54,   103,
     111,    78,    94,    79,    79,   106,   112,   115,   118,   119,
       5,     7,    17,    22,    42,    52,   101,   141,   142,   143,
     144,    76,   123,   124,    54,    54,    56,   116,   117,   145,
     125,    74,    72,    74,    78,    80,    56,     3,     6,    10,
      11,    18,    20,    21,    27,    38,    53,    54,    55,    57,
      58,    68,    69,    74,    83,    84,   101,   113,   114,   124,
     126,   127,   128,   129,   130,   131,   132,   133,   136,   137,
     138,   139,   140,   141,   146,   147,   148,   149,   150,   151,
     154,   155,   156,   157,   158,   159,   160,   120,   121,   122,
     141,    54,   101,   147,   148,   149,   150,   151,   152,   155,
     156,   161,   162,   163,   164,   165,   166,   167,   168,   170,
     171,   172,   120,    54,   117,    74,    78,   141,    78,    74,
      54,    74,   141,    78,   152,    74,    82,   155,   155,   155,
     155,   152,   155,   155,    78,    79,   127,   116,    78,    57,
      58,    74,    75,    72,    81,    80,    54,    70,    71,    86,
      68,    69,    59,    60,    87,    88,    89,    90,    63,    64,
      91,    92,   169,    61,    62,    65,    66,    81,    55,    54,
     146,    78,   152,   153,    74,    78,   153,   127,    81,    30,
      36,   134,   135,   152,   152,   152,   122,   155,   155,   155,
     155,   161,   161,   168,   164,   152,   171,   166,   167,   172,
     170,   170,   162,   162,    81,    72,    78,    81,   134,    81,
      80,    81,    85,    82,    78,    55,   153,   126,    81,   126,
     135,   152,    78,    78,    14,   146,   126,    81,   126
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 4:
#line 114 "cola.y"
    {
            unshift_ast(&ast_start, (yyvsp[(1) - (3)].ast));
            unshift_ast(&ast_start, (yyvsp[(2) - (3)].ast));
            unshift_ast(&ast_start, (yyvsp[(3) - (3)].ast));
            printf("DONE: compilation_unit.\n");
        }
    break;

  case 5:
#line 123 "cola.y"
    { (yyval.ast) = NULL; }
    break;

  case 6:
#line 125 "cola.y"
    {
            unshift_ast(&((yyval.ast)), (yyvsp[(1) - (2)].ast));
        }
    break;

  case 7:
#line 132 "cola.y"
    {    printf("using_alias_directive\n");    }
    break;

  case 8:
#line 134 "cola.y"
    {
            printf("using_directive\n");
            /*load_module($2->name);*/
        }
    break;

  case 9:
#line 141 "cola.y"
    { (yyval.ast) = NULL; }
    break;

  case 10:
#line 146 "cola.y"
    {
            pop_namespace();
            (yyval.ast) = new_ast(KIND_DECL, ASTT_NAMESPACE_DECL, (yyvsp[(2) - (2)].ast), NULL);
            (yyval.ast)->sym = (yyvsp[(1) - (2)].sym);
        }
    break;

  case 11:
#line 155 "cola.y"
    {
            Symbol *n, *t, *last = current_namespace;
            if(lookup_type_symbol((yyvsp[(2) - (2)].sym))) {
                printf("Error, redefinition of [%s]\n", (yyvsp[(2) - (2)].sym)->name);
                exit(0);
            }
            for(n = split(".", (yyvsp[(2) - (2)].sym)->name); n; n = n->tnext) {
                n->kind = (yyvsp[(2) - (2)].sym)->kind;
                t = mk_namespace_symbol(n);
                store_symbol(last->table, t);
                last = n;
            }
            push_namespace(t);
            (yyval.sym) = t;
        }
    break;

  case 12:
#line 174 "cola.y"
    { (yyval.sym) = (yyvsp[(1) - (1)].sym); fprintf(stderr, "qualified_name <- IDENTIFIER\n"); }
    break;

  case 13:
#line 176 "cola.y"
    {
            (yyval.sym) = symbol_join3((yyvsp[(1) - (3)].sym), new_symbol("."), (yyvsp[(3) - (3)].sym));
            fprintf(stderr, "qualified_name <- qualified_name . IDENTIFIER\n");
        }
    break;

  case 14:
#line 184 "cola.y"
    {
            (yyval.ast) = (yyvsp[(2) - (4)].ast);
            if((yyvsp[(3) - (4)].ast))
                unshift_ast(&((yyval.ast)), (yyvsp[(3) - (4)].ast));
        }
    break;

  case 15:
#line 192 "cola.y"
    { (yyval.ast) = NULL; }
    break;

  case 16:
#line 195 "cola.y"
    {
            (yyval.ast) = (yyvsp[(1) - (2)].ast);
            if((yyvsp[(2) - (2)].ast))
                unshift_ast(&((yyval.ast)), (yyvsp[(2) - (2)].ast));
        }
    break;

  case 19:
#line 209 "cola.y"
    {
            pop_namespace();
            (yyval.ast) = new_ast(KIND_DECL, ASTT_CLASS_DECL, NULL, NULL);
            (yyval.ast)->Attr.Class.body = (yyvsp[(3) - (4)].ast);
            (yyval.ast)->sym = (yyvsp[(2) - (4)].sym);
            (yyval.ast)->sym->flags = (yyvsp[(1) - (4)].ival);
        }
    break;

  case 20:
#line 219 "cola.y"
    { (yyval.ival) = 0; }
    break;

  case 22:
#line 225 "cola.y"
    { (yyval.ival) = (yyvsp[(1) - (2)].ival) | (yyvsp[(2) - (2)].ival); }
    break;

  case 24:
#line 231 "cola.y"
    { (yyval.ival) = MOD_PUBLIC; }
    break;

  case 25:
#line 233 "cola.y"
    { (yyval.ival) = MOD_PRIVATE; }
    break;

  case 26:
#line 235 "cola.y"
    { (yyval.ival) = MOD_PROTECTED; }
    break;

  case 27:
#line 237 "cola.y"
    { (yyval.ival) = MOD_STATIC; }
    break;

  case 28:
#line 239 "cola.y"
    { (yyval.ival) = MOD_VIRTUAL; }
    break;

  case 29:
#line 244 "cola.y"
    { (yyval.ast) = (yyvsp[(2) - (3)].ast); }
    break;

  case 30:
#line 249 "cola.y"
    {
            /* Create a new namespace for class and put it in effect */
            Symbol * c;
#if DEBUG
            fprintf(stderr, "\nclass_scope_start <- CLASS IDENTIFIER (%s)\n", (yyvsp[(2) - (2)].sym)->name);
#endif
            c = mk_class_symbol((yyvsp[(2) - (2)].sym));
            push_namespace(c);
/*
            push_scope();
*/
            (yyval.sym) = c;
        }
    break;

  case 31:
#line 265 "cola.y"
    { (yyval.ast) = NULL; }
    break;

  case 32:
#line 267 "cola.y"
    {
            (yyval.ast) = (yyvsp[(1) - (2)].ast);
            unshift_ast(&((yyval.ast)), (yyvsp[(2) - (2)].ast));
        }
    break;

  case 35:
#line 291 "cola.y"
    { (yyval.ast) = (yyvsp[(1) - (2)].ast); }
    break;

  case 36:
#line 293 "cola.y"
    {
            (yyvsp[(3) - (6)].sym)->typename = (yyvsp[(2) - (6)].sym);
            (yyvsp[(3) - (6)].sym)->literal = (yyvsp[(5) - (6)].sym);
            check_id_redecl(current_symbol_table, (yyvsp[(3) - (6)].sym)->name);
            store_symbol(current_symbol_table, (yyvsp[(3) - (6)].sym));
            (yyval.ast) = new_statement(ASTT_CONSTANT_DECL, NULL, NULL);
            (yyval.ast)->typename = (yyvsp[(2) - (6)].sym);
            if(lookup_symbol_in_tab(current_symbol_table, (yyval.ast)->sym->name)) {
                    printf("Warning: declaration of '%s' shadows previous instance.\n",
                            (yyval.ast)->sym->name);
            }
        }
    break;

  case 37:
#line 309 "cola.y"
    {
            AST * decl;
            if((yyvsp[(1) - (2)].sym) == NULL) {
                printf("Internal compiler error: local_var_decl: type is NULL\n");
                abort();
            }
            for(decl=(yyvsp[(2) - (2)].ast); decl; decl = decl->next) {
#if DEBUG
                fprintf(stderr, "local_var: [%s] typename [%s]\n",
                        decl->arg1->sym->name, (yyvsp[(1) - (2)].sym)->name);
#endif
                decl->arg1->sym->typename = (yyvsp[(1) - (2)].sym);
            }
            (yyval.ast) = (yyvsp[(2) - (2)].ast);
        }
    break;

  case 38:
#line 328 "cola.y"
    {
            AST * decl;
            if((yyvsp[(2) - (4)].sym) == NULL) {
                printf("Internal compiler error: field_decl: type is NULL\n");
                abort();
            }
            for(decl=(yyvsp[(3) - (4)].ast); decl; decl = decl->next) {
#if DEBUG
                fprintf(stderr, "field: [%s] typename [%s]\n",
                        decl->arg1->sym->name, (yyvsp[(2) - (4)].sym)->name);
#endif
                decl->arg1->sym->typename = (yyvsp[(2) - (4)].sym);
            }
            (yyval.ast) = (yyvsp[(3) - (4)].ast);
        }
    break;

  case 40:
#line 348 "cola.y"
    {
            (yyval.ast) = (yyvsp[(1) - (3)].ast);
            unshift_ast(&((yyval.ast)), (yyvsp[(3) - (3)].ast));
        }
    break;

  case 41:
#line 356 "cola.y"
    {
            AST * decl, * init;
            decl = new_expr(ASTT_IDENTIFIER, NULL, NULL);
            decl->sym = (yyvsp[(1) - (3)].sym);
            init = new_expr(ASTT_ASSIGN, decl, (yyvsp[(3) - (3)].ast));
            (yyval.ast) = new_statement(ASTT_FIELD_DECL, decl, init);
#if DEBUG
        fprintf(stderr, " var_declarator <- IDENTIFER(%s)=init_expr\n", (yyvsp[(1) - (3)].sym)->name);
#endif
        }
    break;

  case 42:
#line 367 "cola.y"
    {
            AST * decl = new_expr(ASTT_IDENTIFIER, NULL, NULL);
            decl->sym = (yyvsp[(1) - (1)].sym);
            (yyval.ast) = new_statement(ASTT_FIELD_DECL, decl, NULL);
#if DEBUG
        fprintf(stderr, " var_declarator <- IDENTIFIER(%s)\n", (yyvsp[(1) - (1)].sym)->name);
#endif
        }
    break;

  case 43:
#line 379 "cola.y"
    {
            (yyval.ast) = (yyvsp[(1) - (2)].ast);
            (yyval.ast)->Attr.Method.body = (yyvsp[(2) - (2)].ast);
        }
    break;

  case 44:
#line 387 "cola.y"
    {
            Symbol * param;
            (yyval.ast) = new_statement(ASTT_METHOD_DECL, NULL, NULL);
            (yyvsp[(3) - (6)].sym)->kind = METHOD;
            (yyvsp[(3) - (6)].sym)->typename = (yyvsp[(2) - (6)].sym);
            (yyvsp[(3) - (6)].sym)->flags = (yyvsp[(1) - (6)].ival);
            (yyval.ast)->sym = (yyvsp[(3) - (6)].sym);
            (yyval.ast)->Attr.Method.params = (yyvsp[(5) - (6)].sym);
            /* Methods/Fields stored at scope 0 of class namespace.
             * We can store these at parse time.
             */
            store_symbol(current_symbol_table, (yyval.ast)->sym);
            if((yyvsp[(1) - (6)].ival) & MOD_STATIC) {
                if(!strcmp((yyvsp[(3) - (6)].sym)->name, "Main")) {
                    if(main_method)
                        fprintf(stderr,
                        "Warning: multiple definitions of a static Main()\n");
                    main_method = (yyvsp[(3) - (6)].sym);
                }
            }
        }
    break;

  case 45:
#line 409 "cola.y"
    {
            Symbol * param;
            (yyval.ast) = new_statement(ASTT_METHOD_DECL, NULL, NULL);
            (yyvsp[(3) - (6)].sym)->kind = METHOD;
            (yyvsp[(3) - (6)].sym)->typename = new_type_symbol("void");
            (yyvsp[(3) - (6)].sym)->flags = (yyvsp[(1) - (6)].ival);
            (yyval.ast)->sym = (yyvsp[(3) - (6)].sym);
            (yyval.ast)->Attr.Method.params = (yyvsp[(5) - (6)].sym);
            /* Methods/Fields stored at scope 0 of class namespace.
             * We can store these at parse time.
             */
            store_symbol(current_symbol_table, (yyval.ast)->sym);
            if((yyvsp[(1) - (6)].ival) & MOD_STATIC) {
                if(!strcmp((yyvsp[(3) - (6)].sym)->name, "Main")) {
                    if(main_method)
                        fprintf(stderr,
                        "Warning: multiple definitions of a static Main()\n");
                    main_method = (yyvsp[(3) - (6)].sym);
                }
            }
        }
    break;

  case 46:
#line 435 "cola.y"
    { (yyval.sym) = NULL; }
    break;

  case 47:
#line 437 "cola.y"
    { (yyval.sym) = (yyvsp[(1) - (1)].sym); }
    break;

  case 49:
#line 447 "cola.y"
    {
            (yyval.sym) = (yyvsp[(1) - (3)].sym);
            tunshift_sym(&((yyval.sym)), (yyvsp[(3) - (3)].sym));
        }
    break;

  case 50:
#line 455 "cola.y"
    {
#if DEBUG
            fprintf(stderr, " fixed_param <- type IDENTIFIER(%s)\n", (yyvsp[(2) - (2)].sym)->name);
#endif
            (yyvsp[(2) - (2)].sym)->typename = (yyvsp[(1) - (2)].sym);
            (yyval.sym) = (yyvsp[(2) - (2)].sym);
        }
    break;

  case 51:
#line 477 "cola.y"
    { (yyval.ast) = (yyvsp[(1) - (1)].ast); }
    break;

  case 52:
#line 482 "cola.y"
    {
            (yyval.ast) = (yyvsp[(3) - (4)].ast);
            if((yyval.ast)) {
                (yyval.ast)->vars = pop_scope();
            }
            else {
                discard_scope();
            }
        }
    break;

  case 53:
#line 494 "cola.y"
    { push_scope(); }
    break;

  case 54:
#line 499 "cola.y"
    {(yyval.ast) = (yyvsp[(1) - (1)].ast);}
    break;

  case 55:
#line 501 "cola.y"
    { fprintf(stderr, "##End of expr_statement\n\n"); (yyval.ast) = (yyvsp[(1) - (1)].ast); }
    break;

  case 56:
#line 503 "cola.y"
    { fprintf(stderr, "##End of selection_statement\n\n"); (yyval.ast) = (yyvsp[(1) - (1)].ast); }
    break;

  case 57:
#line 505 "cola.y"
    { fprintf(stderr, "##End of iteration_statement\n\n"); (yyval.ast) = (yyvsp[(1) - (1)].ast); }
    break;

  case 58:
#line 507 "cola.y"
    { fprintf(stderr, "##End of jump_statement\n\n"); (yyval.ast) = (yyvsp[(1) - (1)].ast); }
    break;

  case 59:
#line 509 "cola.y"
    { fprintf(stderr, "##End of return_statement\n\n"); (yyval.ast) = (yyvsp[(1) - (1)].ast); }
    break;

  case 60:
#line 511 "cola.y"
    { (yyval.ast) = (yyvsp[(1) - (1)].ast); }
    break;

  case 62:
#line 517 "cola.y"
    { fprintf(stderr, "##End of decl_statement\n\n"); (yyval.ast) = (yyvsp[(1) - (1)].ast); }
    break;

  case 63:
#line 519 "cola.y"
    { fprintf(stderr, "##End of labeled_statement\n\n"); (yyval.ast) = (yyvsp[(1) - (1)].ast); }
    break;

  case 64:
#line 524 "cola.y"
    { (yyval.ast) = NULL; }
    break;

  case 65:
#line 526 "cola.y"
    { (yyval.ast) = (yyvsp[(1) - (1)].ast); }
    break;

  case 66:
#line 528 "cola.y"
    {
            (yyval.ast) = (yyvsp[(1) - (2)].ast);
            unshift_ast(&((yyval.ast)), (yyvsp[(2) - (2)].ast));
        }
    break;

  case 67:
#line 536 "cola.y"
    { (yyval.ast) = (yyvsp[(3) - (3)].ast); (yyval.ast)->sym = (yyvsp[(1) - (3)].sym); }
    break;

  case 68:
#line 541 "cola.y"
    { (yyval.ast) = (yyvsp[(1) - (2)].ast); }
    break;

  case 69:
#line 546 "cola.y"
    { (yyval.ast) = new_statement(ASTT_BREAK, NULL, NULL); }
    break;

  case 70:
#line 548 "cola.y"
    { (yyval.ast) = new_statement(ASTT_CONTINUE, NULL, NULL); }
    break;

  case 71:
#line 550 "cola.y"
    {
            (yyval.ast) = NULL;
            printf("GOTO not supported yet.\n");
            exit(0);
        }
    break;

  case 72:
#line 559 "cola.y"
    {    (yyval.ast) = new_statement(ASTT_RETURN, (yyvsp[(2) - (3)].ast), NULL); }
    break;

  case 73:
#line 561 "cola.y"
    {    (yyval.ast) = new_statement(ASTT_RETURN, NULL, NULL); }
    break;

  case 74:
#line 566 "cola.y"
    { (yyval.ast) = NULL; }
    break;

  case 76:
#line 572 "cola.y"
    {
            (yyval.ast) = (yyvsp[(1) - (3)].ast);
            unshift_ast(&((yyval.ast)), (yyvsp[(3) - (3)].ast));
        }
    break;

  case 77:
#line 579 "cola.y"
    { (yyval.ast) = NULL; }
    break;

  case 78:
#line 581 "cola.y"
    { (yyval.ast) = (yyvsp[(1) - (1)].ast);   }
    break;

  case 79:
#line 583 "cola.y"
    { (yyval.ast) = NULL; }
    break;

  case 80:
#line 585 "cola.y"
    { (yyval.ast) = NULL; }
    break;

  case 82:
#line 595 "cola.y"
    {
            (yyval.ast) = new_if((yyvsp[(3) - (7)].ast), (yyvsp[(5) - (7)].ast), (yyvsp[(7) - (7)].ast));
        }
    break;

  case 83:
#line 599 "cola.y"
    {
            (yyval.ast) = new_if((yyvsp[(3) - (5)].ast), (yyvsp[(5) - (5)].ast), NULL);
        }
    break;

  case 86:
#line 611 "cola.y"
    {
            (yyval.ast) = new_while((yyvsp[(3) - (5)].ast), (yyvsp[(5) - (5)].ast));
        }
    break;

  case 87:
#line 619 "cola.y"
    {
            if((yyvsp[(3) - (9)].ast) == NULL) {
                printf("for_statement: NULL init statement\n");
                exit(0);
            }
            (yyval.ast) = new_for((yyvsp[(3) - (9)].ast), (yyvsp[(5) - (9)].ast), (yyvsp[(7) - (9)].ast), (yyvsp[(9) - (9)].ast));
        }
    break;

  case 88:
#line 630 "cola.y"
    {
            fprintf(stderr, "!TYPE[%s]\n", (yyvsp[(1) - (1)].sym)->name);
            (yyval.sym) = (yyvsp[(1) - (1)].sym);
        }
    break;

  case 91:
#line 640 "cola.y"
    { (yyval.sym) = new_type_symbol("bool"); }
    break;

  case 92:
#line 642 "cola.y"
    { (yyval.sym) = new_type_symbol("string"); }
    break;

  case 93:
#line 644 "cola.y"
    { (yyval.sym) = new_type_symbol("float"); }
    break;

  case 95:
#line 650 "cola.y"
    { (yyval.sym) = new_type_symbol("int"); }
    break;

  case 96:
#line 652 "cola.y"
    { (yyval.sym) = new_type_symbol("byte"); }
    break;

  case 97:
#line 657 "cola.y"
    {
            (yyval.sym) = symbol_concat((yyvsp[(1) - (2)].sym), (yyvsp[(2) - (2)].sym));
#if DEBUG
            fprintf(stderr, " array_type: %s\n", (yyvsp[(1) - (2)].sym)->name);
#endif
        }
    break;

  case 98:
#line 667 "cola.y"
    {
            /* $1 is the dimension of the current rank */
            (yyval.sym) = (yyvsp[(1) - (1)].sym);
#if DEBUG
            fprintf(stderr, " rank_spec /%s/\n", (yyvsp[(1) - (1)].sym)->name);
#endif
        }
    break;

  case 99:
#line 675 "cola.y"
    {
            (yyval.sym) = symbol_concat((yyvsp[(1) - (2)].sym), (yyvsp[(2) - (2)].sym));
        }
    break;

  case 106:
#line 694 "cola.y"
    {   (yyval.ast) = new_expr(ASTT_ASSIGN, (yyvsp[(1) - (3)].ast), (yyvsp[(3) - (3)].ast));   }
    break;

  case 107:
#line 708 "cola.y"
    {
            (yyval.ast) = new_expr(ASTT_PREINC, (yyvsp[(2) - (2)].ast), NULL);
            (yyval.ast)->op = INC;
        }
    break;

  case 108:
#line 716 "cola.y"
    {
            (yyval.ast) = new_expr(ASTT_PREINC, (yyvsp[(2) - (2)].ast), NULL);
            (yyval.ast)->op = DEC;
        }
    break;

  case 109:
#line 724 "cola.y"
    {
            (yyval.ast) = new_expr(ASTT_POSTINC, (yyvsp[(1) - (2)].ast), NULL);
            (yyval.ast)->op = INC;
        }
    break;

  case 110:
#line 732 "cola.y"
    {
            (yyval.ast) = new_expr(ASTT_POSTINC, (yyvsp[(1) - (2)].ast), NULL);
            (yyval.ast)->op = DEC;
        }
    break;

  case 111:
#line 740 "cola.y"
    {
            (yyval.ast) = (yyvsp[(1) - (1)].ast);
#if DEBUG
            fprintf(stderr, " expr <- conditional_expr\n");
#endif
        }
    break;

  case 114:
#line 760 "cola.y"
    {
            (yyval.ast) = new_expr(ASTT_LITERAL, NULL, NULL); (yyval.ast)->sym = (yyvsp[(1) - (1)].sym);
#if DEBUG
            fprintf(stderr, " primary_expr <- LITERAL(%s)\n", (yyvsp[(1) - (1)].sym)->name);
#endif
        }
    break;

  case 115:
#line 767 "cola.y"
    {
            Symbol * orig;
            (yyval.ast) = new_expr(ASTT_IDENTIFIER, NULL, NULL);
            (yyval.ast)->sym = (yyvsp[(1) - (1)].sym);
#if DEBUG
            fprintf(stderr, " primary_expr <- IDENTIFIER(%s)\n", (yyvsp[(1) - (1)].sym)->name);
#endif
        }
    break;

  case 116:
#line 776 "cola.y"
    {
            (yyval.ast) = (yyvsp[(2) - (3)].ast);
        }
    break;

  case 122:
#line 785 "cola.y"
    { (yyval.ast) = new_expr(ASTT_IDENTIFIER, NULL, NULL); (yyval.ast)->sym = (yyvsp[(1) - (1)].sym); }
    break;

  case 123:
#line 790 "cola.y"
    { (yyval.ast) = (yyvsp[(1) - (1)].ast); }
    break;

  case 124:
#line 792 "cola.y"
    { (yyval.ast) = (yyvsp[(2) - (2)].ast); (yyval.ast)->op = '+'; }
    break;

  case 125:
#line 794 "cola.y"
    { (yyval.ast) = (yyvsp[(2) - (2)].ast); (yyval.ast)->op = '-'; }
    break;

  case 126:
#line 796 "cola.y"
    { (yyval.ast) = (yyvsp[(2) - (2)].ast); (yyval.ast)->op = '!'; }
    break;

  case 127:
#line 798 "cola.y"
    { (yyval.ast) = (yyvsp[(2) - (2)].ast); (yyval.ast)->op = '~'; }
    break;

  case 130:
#line 805 "cola.y"
    {
            if((yyvsp[(1) - (4)].ast)->asttype != ASTT_IDENTIFIER) {
                fprintf(stderr, "Error (line %d), method call must be a simple name or member access.\n", line);
                exit(0);
            }
            (yyval.ast) = new_expr(ASTT_METHOD_CALL, (yyvsp[(1) - (4)].ast), (yyvsp[(3) - (4)].ast));
#if DEBUG
            fprintf(stderr, " method_call <- primary_expr ( arg_list )\n");
#endif
        }
    break;

  case 131:
#line 819 "cola.y"
    { (yyval.sym) = (yyvsp[(1) - (1)].sym);
#if DEBUG
            fprintf(stderr, " member_access <- qualified_name\n");
#endif
    }
    break;

  case 132:
#line 828 "cola.y"
    {
            (yyval.ast) = new_expr(ASTT_INDEX, (yyvsp[(1) - (4)].ast), (yyvsp[(3) - (4)].ast));
            (yyval.ast)->op = INDEX;
#if DEBUG
            fprintf(stderr, " element_access <- primary-expr(pex[ex])\n");
#endif
        }
    break;

  case 134:
#line 847 "cola.y"
    {
            (yyval.ast) = new_expr(ASTT_NEW_OBJECT, (yyvsp[(4) - (5)].ast), NULL);
            /* $2 is a Symbol of a typename, will resolve to a real type
             * in semantic pass.
             */
            (yyval.ast)->typename = (yyvsp[(2) - (5)].sym);
        }
    break;

  case 136:
#line 859 "cola.y"
    {
            (yyval.ast) = new_op_expr((yyvsp[(1) - (3)].ast), '*', (yyvsp[(3) - (3)].ast));
        }
    break;

  case 137:
#line 863 "cola.y"
    {
            (yyval.ast) = new_op_expr((yyvsp[(1) - (3)].ast), '/', (yyvsp[(3) - (3)].ast));
        }
    break;

  case 138:
#line 867 "cola.y"
    {
            (yyval.ast) = new_op_expr((yyvsp[(1) - (3)].ast), '%', (yyvsp[(3) - (3)].ast));
        }
    break;

  case 140:
#line 875 "cola.y"
    {
            (yyval.ast) = new_op_expr((yyvsp[(1) - (3)].ast), '+', (yyvsp[(3) - (3)].ast));
        }
    break;

  case 141:
#line 879 "cola.y"
    {
            (yyval.ast) = new_op_expr((yyvsp[(1) - (3)].ast), '-', (yyvsp[(3) - (3)].ast));
        }
    break;

  case 143:
#line 887 "cola.y"
    {
        /* Ternary is just a if/then/else statement which can return a value */
        (yyval.ast) = new_conditional((yyvsp[(1) - (5)].ast), (yyvsp[(3) - (5)].ast), (yyvsp[(5) - (5)].ast));
    }
    break;

  case 145:
#line 896 "cola.y"
    {
        (yyval.ast) = new_logical_expr((yyvsp[(1) - (3)].ast), LOGICAL_AND, (yyvsp[(3) - (3)].ast));
    }
    break;

  case 147:
#line 904 "cola.y"
    {
        (yyval.ast) = new_logical_expr((yyvsp[(1) - (3)].ast), LOGICAL_OR, (yyvsp[(3) - (3)].ast));
    }
    break;

  case 149:
#line 912 "cola.y"
    {
            (yyval.ast) = new_op_expr((yyvsp[(1) - (3)].ast), '&', (yyvsp[(3) - (3)].ast));
        }
    break;

  case 151:
#line 920 "cola.y"
    {
            (yyval.ast) = new_op_expr((yyvsp[(1) - (3)].ast), '~', (yyvsp[(3) - (3)].ast));
        }
    break;

  case 153:
#line 928 "cola.y"
    {
            (yyval.ast) = new_op_expr((yyvsp[(1) - (3)].ast), '|', (yyvsp[(3) - (3)].ast));
        }
    break;

  case 154:
#line 935 "cola.y"
    {(yyval.ival) = '<';}
    break;

  case 155:
#line 937 "cola.y"
    {(yyval.ival) = '>';}
    break;

  case 156:
#line 939 "cola.y"
    {(yyval.ival) = LOGICAL_LTE;}
    break;

  case 157:
#line 941 "cola.y"
    {(yyval.ival) = LOGICAL_GTE;}
    break;

  case 159:
#line 947 "cola.y"
    {
            (yyval.ast) = new_expr(ASTT_COMPARISON, (yyvsp[(1) - (3)].ast), (yyvsp[(3) - (3)].ast));
            (yyval.ast)->op = (yyvsp[(2) - (3)].ival);
        }
    break;

  case 161:
#line 956 "cola.y"
    {
            (yyval.ast) = new_expr(ASTT_COMPARISON, (yyvsp[(1) - (3)].ast), (yyvsp[(3) - (3)].ast));
            (yyval.ast)->op = LOGICAL_EQ;
        }
    break;

  case 162:
#line 961 "cola.y"
    {
            (yyval.ast) = new_expr(ASTT_COMPARISON, (yyvsp[(1) - (3)].ast), (yyvsp[(3) - (3)].ast));
            (yyval.ast)->op = LOGICAL_NE;
        }
    break;

  case 164:
#line 970 "cola.y"
    {
            (yyval.ast) = new_op_expr((yyvsp[(1) - (3)].ast), LEFT_SHIFT, (yyvsp[(3) - (3)].ast));
        }
    break;

  case 165:
#line 974 "cola.y"
    {
            (yyval.ast) = new_op_expr((yyvsp[(1) - (3)].ast), RIGHT_SHIFT, (yyvsp[(3) - (3)].ast));
        }
    break;


/* Line 1267 of yacc.c.  */
#line 2712 "parser.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


#line 980 "cola.y"




extern FILE *yyin;


int main(int argc, char * argv[])
{
    fprintf(stderr, "Cola - Copyright (C) 2002 Melvin Smith <melvins@us.ibm.com>\n");
    fprintf(stderr, "colac version %s\n\n", COLA_VERSION);
    if(argc > 1) {
        if(!(yyin = fopen(argv[1], "r")))    {
            printf( "Error reading source file %s.\n", argv[1] );
            exit(0);
        }
    }
    else {
        printf( "No source file specified.\n" );
        exit(0);
    }

    line = 1;
    init_symbol_tables();
    init_builtin_types();
    /* Kludge - fake routines by adding them to symbol table
     * and emitting them.
     */
    {
        store_method(current_symbol_table, "puts", t_void);
        store_method(current_symbol_table, "puti", t_void);
        store_method(current_symbol_table, "putf", t_void);
        store_method(current_symbol_table, "gets", t_string);
        store_method(current_symbol_table, "substr", t_string);
        store_method(current_symbol_table, "strlen", t_int32);
        store_method(current_symbol_table, "strchop", t_string);
        store_method(current_symbol_table, "strrep", t_string);
        store_method(current_symbol_table, "ord", t_int32);
        store_method(current_symbol_table, "sleep", t_void);
    }

    fprintf(stderr, "Pass 1: Starting parse...\n");
    yyparse();
    fclose(yyin);

    fprintf(stderr, "Pass 2: Type checking...\n");
    fprintf(stderr, "Pass 2: Start scope is [%d]\n", scope);
    build_ast(ast_start);

    fprintf(stderr, "Pass 3: Semantic checking...\n");
    /*semant_ast(ast_start); */

    freopen("a.pir", "w", stdout);
    fprintf(stderr, "Compiling intermediate code to a.pir\n");
/*
    printf( "#Dump of global namespace:\n" );
    indent = 0;
    dump_namespace(current_namespace);
*/
    printf("# Cola (%s) generated\n#\n", COLA_VERSION);

    fprintf(stderr, "Pass 4: Code generation...\n");

    if(ast_start) {
        gen_ast(ast_start);
    }

    printf("# Include standard API stuff\n");
    printf(".include \"core.pir\"\n\n");
    fflush(stdout);
    fprintf(stderr, "%ld lines compiled to PIR.\n", line);
    fprintf(stderr, "Generating PASM\n");
    system("../../parrot -o a.pasm a.pir");
    fprintf(stderr, "Generating PBC (Bytecode)\n");
    system("../../parrot -o a.pbc a.pir");
    return 0;
}

int yyerror(char * s)
{
/*
    fprintf(stderr, "last token = [%s]\n", yylval.sym->name);
*/
    fprintf(stderr, "(error) line %ld: %s\n", line, s );
    fprintf(stderr, "Didn't create output asm.\n" );
    exit(0);
}


/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */

