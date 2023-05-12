NB. This program is "compiled" (so as to have a fair comparison) as such:
NB.   output_file = input_file.gsub("DIM_I\x2e", i)...
A =: ? DIM_I. DIM_J. DIM_K. DIM_L. $ 100
B =: ? DIM_I. DIM_J. DIM_K. DIM_L. $ 100
C =: A * B
exit 0
