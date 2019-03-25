defmodule StixEx.Serialiser.JSON do
  @behaviour StixEx.Serialiser

  @impl StixEx.Serialiser
  def to_string(struct) do
    Jason.encode(struct)
  end
end
