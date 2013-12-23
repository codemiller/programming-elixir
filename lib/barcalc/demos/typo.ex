defmodule Barcalc.Demos.Typo do
  @moduledoc """
  Corrects if keyword typos.
  """

  defmacro fi(condition, clauses) do
    quote do: if(unquote(condition), unquote(clauses))
  end

  defmacro iff(condition, clauses) do
    quote do: if(unquote(condition), unquote(clauses))
  end

  defmacro if_inspect(condition, clauses) do
    IO.inspect condition
    IO.inspect clauses
    quote do: if(unquote(condition), unquote(clauses))
  end
end
