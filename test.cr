test_case = [
  [:+, 1, 2],

  [:*, 2, 3],

  [:*, 2, [:+, 3, 4]],

  [:*, [:+, 1, 2], [:+3, 4]],

  [[:lambda, [:x], [:*, 2, :x]], 3],

  [:let, [[:x, 2]],
    :let [[:f, [:lambda, [:x], [:*, :x, :y]]]]
      [:f, 3]],

  [:let, [[:x, 2]],
    [:let[[:f, [:lambda, [:y], [*, x, y]]]]
      [:let, [[:x, 4]]
        [:f, 3]]]]
]
