## .macro.ijs

A macro-parameterized version of J which replaces certain words like `NTRIALS.` or `ROWS.` with literals à la `#define` in C++.

```rb
transformed = File.read("#{name}.macro.ijs")
params.each { |key, value|
    transformed.gsub! "#{value}.", "#{task_config[key]}"
}
File.write(j_path, transformed)
```
