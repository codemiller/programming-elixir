defmodule CliTest do
  use ExUnit.Case

  import Barcalc.CLI, only: [ parse_args: 1, parse_drinks: 2 ]

  test ":help returned by --help switch" do
    assert parse_args(["--help", "foo"]) == :help
  end

  test "No args returns help" do
    assert parse_args([]) == :help   
  end

  test "One arg returns help" do
    assert (parse_args(["wine"])) == :help
  end

  test "Uneven number of arguments returns help" do
    assert (parse_drinks(["foo", "bar", "baz"], [])) == :help
  end

  test "Incorrect quantity returns help" do
    assert (parse_drinks(["foo", "bar"], [])) == :help
  end

  test "Unknown drink returns help" do
    assert (parse_drinks(["foo", 1], [])) == :help  
  end

  test "Float quantity returns help" do
    assert (parse_drinks(["wine", 1.0], [])) == :help  
  end

  test "Known drink and valid quantity returns result" do
    assert (parse_drinks(["wine", 1], [])) == 1.361025  
  end

  test "Multiple drinks and quantities return result" do
    assert (parse_drinks(["wine", 1, "beer", 2], [])) == 4.580145  
  end 
end
