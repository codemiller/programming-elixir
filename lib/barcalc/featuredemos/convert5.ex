defmodule Barcalc.Featuredemos.Convert5 do
  @moduledoc """
  To demonstrate use of the streams.
  Functions to calculate number of standard drinks in a bar order. 
  """

  @doc """
  Takes a list of tuples of Drink and quantity consumed, eg: [{Drink.new, 2}, {Drink.new, 5}].
  """

  def standard_drinks(drinks) do
    Stream.map(drinks, &calc_standard/1) |> Stream.scan(0, &(&1 + &2))
  end

  defp calc_standard({Drink[content: ingredients], quantity}) do
    drink_total = standard_per_ingredient(ingredients) |> sum_ingredients 
    drink_total * quantity
  end  

  defp standard_per_ingredient(ingredients) do
    Enum.map(ingredients, fn {Liquid[alcohol_pc: pc], ml} -> calc_standard_drinks(ml, pc) end)
  end

  defp sum_ingredients(ingredients), do: Enum.reduce(ingredients, 0, &(&1 + &2))

  # 0.789 is the specific gravity of ethyl alcohol
  defp calc_standard_drinks(volume_ml, alcohol_pc), do: volume_ml / 1000 * alcohol_pc * 0.789
end

sav_blanc = Liquid.new(name: "Sauvignon Blanc", alcohol_pc: 11.5)
beer = Liquid.new(name: "Beer", alcohol_pc: 4.8)
tequila = Liquid.new(name: "Tequila", alcohol_pc: 38)
triple_sec = Liquid.new(name: "Triple Sec", alcohol_pc: 40)
lime_juice = Liquid.new(name: "Lime Juice")

wine = Drink.new(name: "Glass of House White Wine", content: [{sav_blanc, 150}])
beer = Drink.new(name: "Schooner of Full-Strength Beer", content: [{beer, 425}])
margarita = Drink.new(name: "Margarita", content: [{tequila, 30}, {triple_sec, 15}, {lime_juice, 15}])

Barcalc.Featuredemos.Convert5.standard_drinks(Stream.cycle([{wine, 1}, {beer, 1}, {margarita, 1}])) |> Enum.take(10) |> IO.inspect

