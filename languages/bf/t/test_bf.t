# $Id: test_bf.t 10933 2006-01-06 01:43:24Z particle $

# Test bf compiler
# Print TAP, Test Anything Protocol

system( "../parrot -r bf/bf.pbc bf/test.bf" );
