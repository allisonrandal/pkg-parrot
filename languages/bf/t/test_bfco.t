# $Id: /local/languages/bf/t/test_bfco.t 11501 2006-02-10T18:27:13.457666Z particle  $

# Test bf interpreter
# Print TAP, Test Anything Protocol

system( "../parrot -r bf/bfco.pbc bf/test.bf" );
