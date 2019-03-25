defmodule StixEx.Serialiser do
  @moduledoc """
  Ways to dump stix to a file - only JSON *has* to be implemented

  Defined as a behaviour so that extra serialisation methods can be
  implemented whenever needed.
  """

  @doc """
  Convert a STIX bundle object into a string

      iex> StixEx.Serialiser.to_string(%StixEx.Bundle{})
      {:ok, "{...}"}
  """
  @callback to_string(term) :: {atom, String.t()}

  def dump(serialiser, bundle) do
    serialiser.to_string(bundle)
  end
end
