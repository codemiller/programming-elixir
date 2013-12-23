defmodule Barcalc.Featuredemos.PConvert do
  @moduledoc """
  Calculates number of standard drinks in a bar order, sequentially or in parallel.
  Every time the standard drinks formula is run there is a 200 millisecond sleep, simulating
  an expensive computation. 
  """

  @doc """
  Takes a list of tuples of Drink and quantity consumed, eg: [{Drink.new, 2}, {Drink.new, 5}].
  Returns float (untruncated) representing number of standard drinks in the order.
  Calculates sequentially.
  """
  def standard_drinks(drinks) do
    Enum.map(drinks, &calc_for_item/1) |> Enum.reduce(0, &(&1 + &2))
  end

  @doc """
  Takes a list of tuples of Drink and quantity consumed, eg: [{Drink.new, 2}, {Drink.new, 5}].
  Returns float (untruncated) representing number of standard drinks in the order.
  Calculates in parallel.
  """
  def pstandard_drinks(drinks) do
    Barcalc.HOF.pmap(drinks, &calc_for_item/1) |> Enum.reduce(0, &(&1 + &2))
  end
  
  defp calc_for_item({Drink[content: ingredients], quantity}) do
    sum_drink(ingredients) * quantity
  end  

  defp sum_drink(ingredients) do
    Enum.reduce(ingredients, 0, fn {Liquid[alcohol_pc: pc], ml}, acc -> 
      calc_standard_drinks(ml, pc) + acc 
    end)
  end

  # 0.789 is the specific gravity of ethyl alcohol
  defp calc_standard_drinks(volume_ml, alcohol_pc) do
    :timer.sleep(200) # Simulate an expensive computation
    volume_ml / 1000 * alcohol_pc * 0.789
  end
end

tequila = Liquid.new(name: "Tequila", alcohol_pc: 38)
triple_sec = Liquid.new(name: "Triple Sec", alcohol_pc: 40)
lime_juice = Liquid.new(name: "Lime Juice")
margarita = Drink.new(name: "Margarita", content: [{tequila, 30}, {triple_sec, 15}, {lime_juice, 15}])

:timer.tc fn -> Barcalc.Featuredemos.PConvert.standard_drinks Enum.take(Stream.cycle([{margarita, 1}]), 3) end
:timer.tc fn -> Barcalc.Featuredemos.PConvert.pstandard_drinks Enum.take(Stream.cycle([{margarita, 1}]), 3) end

