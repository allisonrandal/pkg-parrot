# $Id: /parrotcode/trunk/languages/bf/t/test_bf.t 470 2006-12-05T03:30:45.414067Z svm  $

# Test bf compiler
# Print TAP, Test Anything Protocol

system( "../parrot -r bf/bf.pbc bf/test.bf" );
