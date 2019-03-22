defmodule StixEx.Utils do
  def kebab_case_to_upper_camel_case(string) do
    string
    |> String.split("-")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join("")
  end
end
