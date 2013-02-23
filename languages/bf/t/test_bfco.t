# $Id: test_bfco.t 10933 2006-01-06 01:43:24Z particle $

# Test bf interpreter
# Print TAP, Test Anything Protocol

system( "../parrot -r bf/bfco.pbc bf/test.bf" );
