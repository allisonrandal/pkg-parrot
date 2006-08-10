# $Id: /local/languages/bf/t/test_bf.t 11501 2006-02-10T18:27:13.457666Z particle  $

# Test bf compiler
# Print TAP, Test Anything Protocol

system( "../parrot -r bf/bf.pbc bf/test.bf" );
