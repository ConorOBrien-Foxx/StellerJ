   perm=: 3 : 0
assert. T

for. T do. break. continue. end.

for.     T do. B end.
for_xyz. T do. B end.

goto_name.
label_name.

if. T do. B end.

if. T do. B else. B1 end.

if.     T  do. B
elseif. T1 do. B1
elseif. T2 do. B2
end.

return.

{{ y }}

select. T
 case.  T0 do. B0
 fcase. T1 do. B1
 case.  T2 do. B2
end.

throw.

try. B catch. B1 catchd. B2 catcht. B3 end.

while.  T do. B end.
whilst. T do. B end.
   )

boxes =: 1 (5!:7) <'perm'
keepctl =: '.'&e.
ctls =: boxes #~ keepctl@>@{:"1 boxes
codes =: (0 { 1&pick)"1 ctls
mask =: ~: codes
sort =: /: codes
uniq =: (sort{mask) # sort { ctls
echo uniq
