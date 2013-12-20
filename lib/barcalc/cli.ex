defmodule Barcalc.CLI do

  @moduledoc """
  Parse command line arguments for standard drinks calculator and dispatch to
  functions to calculate result.
  """

  @sav_blanc Liquid.new(name: "Sauvignon Blanc", alcohol_pc: 11.5)
  @full_beer Liquid.new(name: "Beer", alcohol_pc: 4.8)
  @tequila Liquid.new(name: "Tequila", alcohol_pc: 38)
  @triple_sec Liquid.new(name: "Triple Sec", alcohol_pc: 40)
  @lime_juice Liquid.new(name: "Lime Juice")

  @wine Drink.new(name: "Glass of White Wine", content: [{@sav_blanc, 150}])
  @beer Drink.new(name: "Schooner of Full-Strength Beer", content: [{@full_beer, 425}])
  @margarita Drink.new(name: "Margarita", content: [{@tequila, 30}, {@triple_sec, 15}, {@lime_juice, 15}])

  @drink_list [wine: @wine, beer: @beer, margarita: @margarita]

  def run(argv) do
    argv |> parse_args |> process
  end

  @doc """
  `argv` should be --help or a list of tuples of drink names and quantities 
  consumed, eg: [{"white_wine", 1}].

  Returns the number of standard drinks consumed, or `:help`.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ])
    case parse do
      { [ help: true ], _, _ }                                             -> :help
      { _, drinks = [ _x, _y | _ys ], _ } when rem(length(drinks), 2) == 0 -> drinks
      _                                                                    -> :help
    end
  end

  def process(:help) do
    IO.puts "Usage: barcalc <drink>, <quantity>, <drink>, <quantity>\nQuantities must be integers. Drink options:"
    IO.inspect Enum.map(Keyword.keys(@drink_list), &atom_to_binary/1)
  end
  def process(drinks), do: parse_drinks(drinks, []) |> output_result

  def parse_drinks([], parsed_drinks), do: Barcalc.Convert.standard_drinks(parsed_drinks)
  def parse_drinks([drink, quantity | rest], acc) when is_integer(quantity) do
    if Enum.member?(Keyword.keys(@drink_list), binary_to_atom(drink)) do
      parse_drinks(rest, [{Keyword.get(@drink_list, binary_to_atom(drink)), quantity} | acc])
    else
      :help 
    end
  end
  def parse_drinks(_, _), do: :help

  def output_result(:help), do: process(:help)
  def output_result(result), do: IO.puts "#{:io_lib.format('~.1f', [result])} standard drinks"
end
