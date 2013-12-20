defmodule BarcalcTest do
  use ExUnit.Case

  import Barcalc.Convert, only: [ standard_drinks: 1 ]

  @full_beer Liquid.new(name: "Beer", alcohol_pc: 4.8)
  @tequila Liquid.new(name: "Tequila", alcohol_pc: 38)
  @triple_sec Liquid.new(name: "Triple Sec", alcohol_pc: 40)
  @lime_juice Liquid.new(name: "Lime Juice")

  @beer Drink.new(name: "Schooner of Full-Strength Beer", content: [{@full_beer, 425}])
  @margarita Drink.new(name: "Margarita", content: [{@tequila, 30}, {@triple_sec, 15}, {@lime_juice, 15}])

  test "Empty list is zero standard drinks" do
    assert(standard_drinks([]) == 0)
  end

  test "One non-mixed drink can be calculated" do
    assert(standard_drinks([{@beer, 1}]) == 1.60956)
  end

  test "Multiple non-mixed drinks can be calculated" do
    assert(standard_drinks([{@beer, 2}]) == 3.21912)
  end

  test "Mixed drink can be calculated" do
    assert(standard_drinks([{@margarita, 2}]) == 2.74572)
  end

  test "List of multiple drinks can be calculated" do
    assert(standard_drinks([{@beer, 2}, {@margarita, 5}]) == 10.08342)
  end
end
