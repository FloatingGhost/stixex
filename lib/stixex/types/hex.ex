defmodule StixEx.Types.Hex do
  @moduledoc """
  It's just a string, but a very certain type of string
  which we should probably add as a type to avoid confusion...
  also maybe we should cast it to an integer db-side?

  The string MUST consist of an even number of hexadecimal characters,
  which are the digits '0' through '9' and the letters 'a' through 'f'
  """
  @behaviour Ecto.Type
  @hex_regex ~r/([0-9a-f]{2})+/

  def type, do: :string

  def cast(value) do
    if Regex.match?(@hex_regex, value) do
      {:ok, value}
    else
      :error
    end
  end

  def load(value), do: {:ok, value}
  def dump(value), do: {:ok, value}
end
