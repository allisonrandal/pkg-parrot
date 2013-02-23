# $Id: /parrotcode/trunk/languages/bf/t/test_bfco.t 470 2006-12-05T03:30:45.414067Z svm  $

# Test bf interpreter
# Print TAP, Test Anything Protocol

system( "../parrot -r bf/bfco.pbc bf/test.bf" );
