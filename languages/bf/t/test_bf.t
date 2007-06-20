# $Id: test_bf.t 17096 2007-02-20 20:20:48Z paultcochrane $

# Test bf compiler
# Print TAP, Test Anything Protocol

system( "../parrot -r bf/bf.pbc bf/test.bf" );
