defmodule BarcalcTest do
  use ExUnit.Case

  import Barcalc.Convert, only: [ standard_drinks: 1 ]

  @middy Liquid.new(name: "Mid-Strength Beer", alcohol_pc: 3.4)
  @tequila Liquid.new(name: "Tequila", alcohol_pc: 38)
  @triple_sec Liquid.new(name: "Triple Sec", alcohol_pc: 40)
  @lime_juice Liquid.new(name: "Lime Juice")

  @beer Drink.new(name: "Schooner of Mid-Strength Beer", content: [{@middy, 425}])
  @margarita Drink.new(name: "Margarita", content: [{@tequila, 30}, {@triple_sec, 15}, {@lime_juice, 15}])

  test "Empty list is zero standard drinks" do
    assert(standard_drinks([]) == 0)
  end

  test "One non-mixed drink can be calculated" do
    assert(standard_drinks([{@beer, 1}]) == 1.140105)
  end

  test "Multiple non-mixed drinks can be calculated" do
    assert(standard_drinks([{@beer, 2}]) == 2.28021)
  end

  test "Mixed drink can be calculated" do
    assert(standard_drinks([{@margarita, 2}]) == 2.74572)
  end

  test "List of multiple drinks can be calculated" do
    assert(standard_drinks([{@beer, 2}, {@margarita, 5}]) == 9.14451)
  end
end
