defmodule StixEx.Types.Object do
  @moduledoc """
  This is basically a "wrapper" type to cast from an array of
  arbitrary types to the structs that define them.
  """
  @behaviour Ecto.Type

  def type, do: :map

  # In case we're already loaded
  def cast(%_type{} = struct), do: {:ok, struct}

  def cast(%{type: type} = struct) do
    {:ok, type} = StixEx.TypeRegistry.get(type)
    type.new(struct)
  end

  def cast(%{"type" => type} = struct) do
    {:ok, type} = StixEx.TypeRegistry.get(type)
    type.new(struct)
  end

  def load(struct), do: {:ok, struct}
  def dump(struct), do: {:ok, struct}
end
