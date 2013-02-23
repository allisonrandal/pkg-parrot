# $Id: test_bfco.t 17096 2007-02-20 20:20:48Z paultcochrane $

# Test bf interpreter
# Print TAP, Test Anything Protocol

system( "../parrot -r bf/bfco.pbc bf/test.bf" );
