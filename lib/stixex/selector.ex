defmodule Stixex.Selector do
  @moduledoc """
  Functions to deal with "selectors", little strings of JSONPath-alike
  format to select from a map

    iex> Stixex.Selector.select("akari.[0]",
          %{yui: "is cute", akari: ["akariiiin", %{presence: 0}]})
    akariiiin
  """
  def select(selector, from) when is_binary(selector) do
    selector
    |> String.split(".")
    |> select(from)
  end

  def select([], from) do
    {:ok, from}
  end

  def select([selector | rest], from) when is_list(from) do
    # If we're selecting from a list, the selector MUST be
    # of the form [x], where x is the index
    {index, ""} =
      selector
      |> String.trim_leading("[")
      |> String.trim_trailing("]")
      |> Integer.parse()
    if Enum.count(from) < index do
      # Out of range!
      {:error, {:out_of_range, index}}
    else
      {element, _rest} = List.pop_at(from, index)
      select(rest, element)
    end
  end

  def select([selector | rest], from) when is_map(from) do
    selector = String.to_atom(selector)

    if Map.has_key?(from, selector) do
      element = Map.get(from, selector)
      select(rest, element)
    else
      {:error, {:no_key, selector}}
    end
  end
end
