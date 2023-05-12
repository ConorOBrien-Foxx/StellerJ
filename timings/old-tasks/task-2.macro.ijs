NB. This program is "compiled" (so as to have a fair comparison) as such:
NB.   output_file = input_file.gsub("ROWS\x2e", rows).gsub("COLS\x2e", cols)

A =: ? ROWS. COLS. $ 10
B =: ? COLS. ROWS. $ 10
C =: A +/ . * B
echo $C

exit 0
