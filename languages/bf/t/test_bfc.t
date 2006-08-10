# $Id: /local/languages/bf/t/test_bfc.t 11501 2006-02-10T18:27:13.457666Z particle  $

# Test bf interpreter
# Print TAP, Test Anything Protocol

system( "../parrot -r bf/bfc.pbc bf/test.bf" );
