NB. This is a .macro.ijs file. See the README for more information.
load './nice-time.ijs'
(9!:1) 0

10 timeop <;._1 LF, }: 0 : 0 -. CR
A =: ? 2048 512 $ 10
B =: ? 512 2048 $ 10
A +/ . * B
)

exit 0
