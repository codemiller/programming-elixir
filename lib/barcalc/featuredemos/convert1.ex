defmodule Barcalc.Featuredemos.Convert1 do
  @moduledoc """
  To demonstrate pattern matching and guards.
  Functions to calculate number of standard drinks in a bar order.
  """

  @doc """
  Takes a tuple with a Beverage and a quantity consumed, eg: {Beverage.new, 1}.
  """

  def standard_drinks({Beverage[content: {Liquid[alcohol_pc: pc], ml}], qty}) when pc > 0 do
    std = ml / 1000 * pc * 0.789 * qty 
    IO.puts "That's #{:io_lib.format('~.1f', [std])} standard drinks."
  end
  def standard_drinks({Beverage[], _}), do: IO.puts "No alcoholic content."
end

sav_blanc = Liquid.new(name: "Sauvignon Blanc", alcohol_pc: 11.5)
soda_water = Liquid.new(name: "Soda Water")

wine = Beverage.new(name: "Glass of House White Wine", content: {sav_blanc, 150})
soda = Beverage.new(name: "Glass of Soda Water", content: {soda_water, 250})

Barcalc.Featuredemos.Convert1.standard_drinks({wine, 2})
Barcalc.Featuredemos.Convert1.standard_drinks({soda, 5})

