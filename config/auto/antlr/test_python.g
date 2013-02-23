// Copyright: 2005 The Perl Foundation.  All Rights Reserved.
// $Id: test_python.g 7754 2005-04-02 07:25:39Z bernhard $

// Test whether the installed antlr has python support

options {
    language=Python;
}

class test_python_l extends Lexer;

TEST : 't' 
     ;
