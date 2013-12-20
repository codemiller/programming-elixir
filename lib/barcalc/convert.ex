defmodule Barcalc.Convert do
  @moduledoc """
  Functions to calculate number of standard drinks in a bar order. 
  """

  @doc """
  Takes a list of tuples of Drink and quantity consumed, eg: [{Drink.new, 2}, {Drink.new, 5}].
  """

  def standard_drinks(drinks) do
    Enum.map(drinks, &calc_standard/1) |> Enum.reduce(0, &(&1 + &2))
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

