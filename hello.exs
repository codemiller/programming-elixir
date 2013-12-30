defmodule Hello do
  def greet(name // "World") do
    {:ok, "Hello " <> name <> ". Your rating is: #{rate_name name}"}
  end

  def rate_name(name), do: size(name) * :math.pi

  def print({_, str}), do: IO.puts str
end

Hello.greet |> IO.inspect
Hello.greet("codemiller") |> Hello.print
