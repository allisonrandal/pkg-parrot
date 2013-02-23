# $Id: /parrotcode/trunk/languages/lisp/include/macros/error.pir 3474 2007-05-13T11:14:07.859087Z bernhard  $

.macro ERROR_0(T,M)
  _error(.T, .M)
.endm

.macro ERROR_1(T,M,A)
  .sym string _errmsgs
  .sym pmc _errargp

  _errargp = new Array
  _errargp = 1
  _errargp[0] = .A

  sprintf _errmsgs, .M, _errargp
  _error(.T, _errmsgs)  
.endm

.macro ERROR_2(T,M,A,B)
  .sym string _errmsgs
  .sym pmc _errargp

  _errargp = new Array
  _errargp = 2
  _errargp[0] = .A
  _errargp[1] = .B

  sprintf _errmsgs, .M, _errargp
  _error(.T, _errmsgs)  
.endm

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:
