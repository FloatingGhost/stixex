defmodule StixEx.Types.Object do
  @moduledoc """
  This is basically a "wrapper" type to cast from an array of
  arbitrary types to the structs that define them.
  """
  @behaviour Ecto.Type

  def cast(%{type: type} = struct) do
    {:ok, type} = StixEx.TypeRegistry.get(type)
  end
end
