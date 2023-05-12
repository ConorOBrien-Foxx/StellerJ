idx =: 0&pick
ntr =: 1&pick
exp =: 2&}.
exec_time =: 6!:2
htime =: _:`(exec_time@>)`(exec_time@(_1&pick) [ ".&>"0@}:)@.(2<.#)
fmt_prog =: CR ,~ ":@[ ,~ '/' ,~ ]
rep_enum =: ;/@:>:@i.@[ ,. [ >@$ <@-.&a:@;
show_time =: stdout@(,&LF)@":@htime@exp
show_prog =: stderr@(ntr fmt_prog&": idx)
NB. (ntrials) timeop (preambles ; time_statement)
timeop =: [: stderr@LF (show_prog ; show_time)"1@rep_enum
