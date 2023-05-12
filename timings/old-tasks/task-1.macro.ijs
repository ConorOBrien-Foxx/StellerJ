NB. This program is "compiled" (so as to have a fair comparison) as such:
NB.   output_file = input_file.gsub("MAX\x2e", rows)
max =: MAX.

NB. generate step
array =: i. max

NB. summation step
sum =: +/ array

NB. output step
echo sum

exit 0
