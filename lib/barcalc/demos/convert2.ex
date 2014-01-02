defmodule Barcalc.Demos.Convert2 do
  @moduledoc """
  To demonstrate list processing, recursion and list comprehensions.
  Functions to calculate number of standard drinks in a bar order. 
  """

  @doc """
  Takes a list of tuples of Drink and quantity consumed, eg: [{Drink.new, 2}, {Drink.new, 5}].
  Prints out number of standard drinks in the order.
  """
  def standard_drinks(drinks) do
    sum_standard_drinks(drinks, 0) 
  end
  
  defp sum_standard_drinks([], acc), do: acc 
  defp sum_standard_drinks([ {drink, quantity} | others ], acc) do
    sum_standard_drinks(others, acc + calc_for_item(drink, quantity))   
  end
  
  defp calc_for_item(Drink[content: ingredients], quantity) do
    quantity * (standard_per_ingredient(ingredients) |> sum_ingredients)
  end  

  defp standard_per_ingredient(ingredients) do
    lc {Liquid[alcohol_pc: pc], ml} inlist ingredients, do: calc_standard_drinks(ml, pc)
  end

  defp sum_ingredients(ingredients), do: do_sum_ingredients(ingredients, 0)
  defp do_sum_ingredients([], acc), do: acc
  defp do_sum_ingredients([ head | tail ], acc), do: head + do_sum_ingredients(tail, acc) 

  # 0.789 is the specific gravity of ethyl alcohol
  defp calc_standard_drinks(volume_ml, alcohol_pc), do: volume_ml / 1000 * alcohol_pc * 0.789
end

sav_blanc = Liquid.new(name: "Sauvignon Blanc", alcohol_pc: 11.5)
middy = Liquid.new(name: "Mid-Strength Beer", alcohol_pc: 3.4)
tequila = Liquid.new(name: "Tequila", alcohol_pc: 38)
triple_sec = Liquid.new(name: "Triple Sec", alcohol_pc: 40)
lime_juice = Liquid.new(name: "Lime Juice")

wine = Drink.new(name: "Glass of House White Wine", content: [{sav_blanc, 150}])
beer = Drink.new(name: "Schooner of Mid-Strength Beer", content: [{middy, 425}])
margarita = Drink.new(name: "Margarita", content: [{tequila, 30}, {triple_sec, 15}, {lime_juice, 15}])

Barcalc.Demos.Convert2.standard_drinks([{wine, 1}, {beer, 2}, {margarita, 1}])
