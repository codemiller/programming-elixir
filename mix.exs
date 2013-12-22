defmodule Barcalc.Mixfile do
  use Mix.Project

  def project do
    [ app: :barcalc,
      version: "0.0.1",
      elixir: "~> 0.12.0",
      escript_main_module: Barcalc.CLI,
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { Barcalc, [] }]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    []
  end
end
