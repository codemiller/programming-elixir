defmodule Barcalc.Demos.TypoTest do
  require Barcalc.Demos.Typo
  import Barcalc.Demos.Typo

  alcohol_grams = 10 
   
  fi 15 > alcohol_grams do 
    IO.puts "15 grams is more than the alcohol in a standard drink."
  end

  iff (alcohol_grams < 5) do
    IO.puts "A standard drink contains less than five grams of alcohol."
  else
    IO.puts "A standard drink contains at least five grams of alcohol."
  end

  if_inspect 10 == alcohol_grams do
    IO.puts "A standard drink contains exactly 10 grams of alcohol."
  else
    IO.puts "A standard does not contain exactly 10 grams of alcohol."
  end
end
