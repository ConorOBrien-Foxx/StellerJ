#!/usr/bin/ruby 
tasks = ARGV[0] || "123"
config_path = ARGV[1] || "results-config.ini"

# WIN PLATFORM: my configuration
# ELSE: my remote configuration

if tasks == "clean"
    puts "Cleaning..."
    %x(rm *.exe *.out.ijs)
    exit
end

$config = {}
title = nil
File.read(config_path).lines.each.with_index(1) { |line, number|
    line.chomp!
    comment_index = line.gsub(/\\x..../, "XXXXX").gsub(/\\./, "XX").index ";"
    line = line[0...comment_index]
    if /^\s*\[(.+)\]\s*$/ === line
        title = $1
        raise "duplicate section #{title} at line #{number}" unless $config[title].nil?
        $config[title] = {}
    else
        raise "untitled data at line #{number}: #{line}" if title.nil?
        if /^\s*([^=;]+)\s*=\s*([^=;]+)\s*$/ === line
            key = $1
            value = $2
            # auto cast results
            if value.downcase == "true"
                value = true
            elsif value.downcase == "false"
                value = false
            elsif /^\d+$/ === value
                value = value.to_i
            end
            $config[title][key] = value
        end
    end
}

unless $config["all"]["j_on_path"]
    $PWD = %x(pwd).chomp
end

def call_j(name)
    unless $config["all"]["j_on_path"]
        "~/j#{$config["all"]["j_version"]}/jconsole.sh #$PWD/#{name}"
    else
        "jconsole #{name}"
    end
end

def exe_exists?(name)
    File.exists? Gem.win_platform? ? "#{name}.exe" : "./#{name}"
end

def call_exe(name)
    if Gem.win_platform?
        "#{name}.exe"
    else
        "./#{name}"
    end
end

$trials = $config["all"]["ntrials"]
STDERR.puts "Running tasks #{tasks.split} for #{$trials} trials"

def compile_safe(command)
    %x(#{command})
    exit 1 if $?.nil? || $?.exitstatus > 0
end

def run_task(name, short_name, params)
    task_config = $config[name]
    task_config["ntrials"] ||= $trials
    params["ntrials"] = "NTRIALS"
    key_pairs = params.map { |key, value| "#{value}=#{task_config[key]}" }
    c_key_pairs = key_pairs.map { |pair| "-D #{pair}" } * " "
    STDERR.puts "Task 1 configuration: #{key_pairs * " "}"
    
    j_path = "#{short_name}-j.out.ijs"
    unless false and exe_exists? j_path
        STDERR.puts "\"Compiling\" #{name} J..."
        transformed = File.read("#{name}.macro.ijs")
        params.each { |key, value|
            transformed.gsub! "#{value}.", "#{task_config[key]}"
        }
        # imports with local J are weird
        nice_time_path = if $config["all"]["j_on_path"]
            "'./nice-time.ijs'"
        else
            "'#$PWD/nice-time.ijs'"
        end
        transformed.gsub! "NICE_TIME.", nice_time_path
        File.write(j_path, transformed)
    end
    
    cpp_flags = "-g -Wall -Wno-unused-but-set-variable"
    
    # cpp_o0_path = "#{short_name}-cpp-o1"
    # STDERR.puts "Compiling #{name} C++ (-O1)..."
    # compile_safe "g++ #{name}-unvec.cpp -o #{cpp_o0_path} #{c_key_pairs} -O1 #{cpp_flags}"
    
    cpp_o3_path = "#{short_name}-cpp-o3"
    STDERR.puts "Compiling #{name} C++ (-O3)..."
    compile_safe "g++ #{name}-unvec.cpp -o #{cpp_o3_path} #{c_key_pairs} -O3 #{cpp_flags}"
    
    cpp_simd_path = "#{short_name}-cpp-simd"
    STDERR.puts "Compiling #{name} C++ (SIMD)..."
    compile_safe "g++ #{name}-simd.cpp -o #{cpp_simd_path} #{c_key_pairs} -O3 #{cpp_flags} -march=native"
    
    # StellerJ
    steller_j_path = "#{short_name}-stellerj"
    compile_safe "ruby ./../stellerj/stellerj.rb #{name}.steller #{steller_j_path}"
    
    # StellerJ
    STDERR.puts "StellerJ:"
    system "#{call_exe(steller_j_path)} > results/#{short_name}-stellerj.csv"

    # J
    STDERR.puts "J:"
    system "#{call_j(j_path)} > results/#{short_name}-j.csv"
    
    # # C++ (-O0)
    # STDERR.puts "C++ (-O1):"
    # system "#{call_exe(cpp_o0_path)} > results/#{short_name}-cpp-o1.csv"
    
    # C++ (-O3)
    STDERR.puts "C++ (-O3):"
    system "#{call_exe(cpp_o3_path)} > results/#{short_name}-cpp-o3.csv"
    
    # C++ (SIMD)
    STDERR.puts "C++ (SIMD):"
    system "#{call_exe(cpp_simd_path)} > results/#{short_name}-cpp-simd.csv"
    
    # put together
    STDERR.puts "Saving compiled results..."
    csv = [
        "results/#{short_name}-stellerj.csv",
        "results/#{short_name}-j.csv",
        # "results/#{short_name}-cpp-o1.csv",
        "results/#{short_name}-cpp-o3.csv",
        "results/#{short_name}-cpp-simd.csv",
    ].map { |path|
        File.read(path).lines.map(&:chomp)
    }.transpose.map { |row| row * "," } * "\n"
    File.write "results/#{short_name}.csv", csv
end
# task 1
# TODO: read configuration from file
if tasks.include? "1"
    run_task "task-1", "t1", "max"=>"MAX"
end

# task 2
if tasks.include? "2"
    run_task "task-2", "t2", "rows"=>"ROWS", "cols"=>"COLS", "seed"=>"SEED"
end

# task 3
if tasks.include? "3"
    run_task "task-3", "t3", "i"=>"DIM_I", "j"=>"DIM_J", "k"=>"DIM_K", "l"=>"DIM_L", "seed"=>"SEED"
end
