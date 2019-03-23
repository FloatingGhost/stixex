defmodule StixEx.Types.Object do
  @moduledoc """
  This is basically a "wrapper" type to cast from an array of
  arbitrary types to the structs that define them.
  """
  @behaviour Ecto.Type

  def type, do: :map

  def cast(%{type: type} = struct) do
    {:ok, type} = StixEx.TypeRegistry.get(type)
    type.new(struct)
  end

  def cast(%{"type" => type} = struct) do
    IO.puts type
    {:ok, type} = StixEx.TypeRegistry.get(type)
    type.new(struct)
  end

  def load(struct), do: {:ok, struct}
  def dump(struct), do: {:ok, struct}
end
