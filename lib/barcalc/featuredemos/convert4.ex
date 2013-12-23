defmodule Barcalc.Featuredemos.Convert4 do
  @moduledoc """
  To demonstrate use of the streams.
  Functions to calculate number of standard drinks in a bar order. 
  """

  @doc """
  Takes a list of tuples of Drink and quantity consumed, eg: [{Drink.new, 2}, {Drink.new, 5}].
  Returns number of standard drinks in each item.
  """

  def standard_drinks(drinks) do
    Stream.map(drinks, &calc_for_item/1) |> Stream.scan(0, &(&1 + &2))
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

Barcalc.Featuredemos.Convert4.standard_drinks(Stream.cycle([{wine, 1}, {beer, 1}, {margarita, 1}])) |> Enum.take(10) |> IO.inspect

