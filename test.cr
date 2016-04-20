require "./yali"


test_cases = [
  [:+, 1, 2],
  [:*, 2, 3],
  [:*, 2, [:+, 3, 4]],
  [:*, [:+, 1, 2], [:+, 3, 4]],
  [[:lambda, [:x], [:*, 2, :x]], 3],
  [:let, [[:x, 2]],
    [:let, [[:f, [:lambda, [:y], [:*, :x, :y]]]],
      [:f, 3]]],
  [:let, [[:x, 2]],
    [:let, [[:f, [:lambda, [:y], [:*, :x, :y]]]],
      [:let, [[:x, 4]],
        [:f, 3]]]]
]


test_cases.each do |test_case|
  puts interpreter test_case
end
