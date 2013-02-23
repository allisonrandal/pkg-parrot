# $Id: test_bfc.t 17096 2007-02-20 20:20:48Z paultcochrane $

# Test bf interpreter
# Print TAP, Test Anything Protocol

system( "../parrot -r bf/bfc.pbc bf/test.bf" );
