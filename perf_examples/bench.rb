require 'benchmark'

n = 10

Benchmark.bm do |x|
  x.report('rubygems') do
    n.times do
      `ruby -rubygems perf_examples/generic.rb`
    end
  end
  x.report('jambi') do
    n.times do
      `ruby -Ilib -rjambi perf_examples/generic.rb`
    end
  end
end
