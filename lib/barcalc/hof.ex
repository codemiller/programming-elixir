defmodule Barcalc.HOF do 
  @moduledoc """
  Useful higher-order functions. 
  """

  @doc """
  Parallel version of map. Refactored version of the pmap in Dave Thomas' book Programming Elixir.

  Takes a collection and a function and applies that function to every element
  of the collection in parallel. 

  Returns a new collection containing the results.
  """
  def pmap(collection, func) do
    collection |> spawn_processes(func) |> collect_results
  end
    
  defp spawn_processes(collection, func) do
    this_pid = self
    Enum.map(collection, fn (item) ->
      spawn_link fn -> (this_pid <- { self, func.(item) }) end
    end)
  end

  defp collect_results(pid_list) do
    Enum.map(pid_list, fn (pid) ->
      receive do { ^pid, result } -> result end
    end)
  end
end
