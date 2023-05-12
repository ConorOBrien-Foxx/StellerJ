#!/usr/bin/ruby 
if ARGV.size < 2
    STDERR.puts "Expected #{$0} count operation"
    exit 1
end
count = ARGV[0].to_i
operation = ARGV[1]

# trials = []
count.times { |i|
    STDERR.print "#{i + 1}/#{count}...\r"
    start = Time.now
    %x(#{operation})
    stop = Time.now
    duration = stop - start
    # trials << duration
    puts duration
}
STDERR.puts
# puts
# puts trials
