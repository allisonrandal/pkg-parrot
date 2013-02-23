' $Id: /local/languages/BASIC/compiler/samples/count_to_100.bas 11501 2006-02-10T18:27:13.457666Z particle  $
'   
' count_to_100.bas
'
' Test scripts for [perl #22877] as reported by Clint Pierce

dim a$()
for i = 0 to 100 step .5
  for j = 1 to 30
    a$(j)=" "
  next j
  for j = 1 to 30
    print " ";
  next j
  print i
next i
