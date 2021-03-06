defmodule StixEx.Enum do
  @moduledoc """
  Like a vocabulary but it FORCES values to be part of it, instead of sending them a strongly worded letter
  if they don't.
  """

  @callback values :: [String.t()]

  @doc """
  Get an enum based on its name
  """
  def get(name) do
    if String.ends_with?(name, "-enum") do
      module =
        name
        |> String.trim_trailing("-enum")
        |> StixEx.Utils.kebab_case_to_upper_camel_case()
        |> (&"#{__MODULE__}.#{&1}").()

      try do
        module = String.to_existing_atom(module)
        {:ok, module}
      rescue
        _e in ArgumentError -> {:error, {:does_not_exist, name}}
      end
    else
      {:error, {:invalid_name, name}}
    end
  end

  def has_value?(enum, value) when is_atom(enum) do
    Enum.member?(enum, value)
  end

  def has_value?(enum, value) when is_binary(enum) do
    enum
    |> get()
    |> has_value?(value)
  end
end
