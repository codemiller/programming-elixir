defmodule Barcalc.Convert do
  @moduledoc """
  Functions to calculate number of standard drinks in a bar order. 
  """

  @doc """
  Takes a list of tuples of Drink and quantity consumed, eg: [{Drink.new, 2}, {Drink.new, 5}].
  """

  def standard_drinks(drinks) do
    Enum.map(drinks, &calc_for_item/1) |> Enum.reduce(0, &(&1 + &2))
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

