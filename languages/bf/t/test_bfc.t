# $Id: test_bfc.t 10933 2006-01-06 01:43:24Z particle $

# Test bf interpreter
# Print TAP, Test Anything Protocol

system( "../parrot -r bf/bfc.pbc bf/test.bf" );
