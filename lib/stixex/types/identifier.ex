defmodule StixEx.Types.Identifier do
  @moduledoc """
  An identifier universally and uniquely identifies a SDO, SRO,
  Bundle, or Marking Definition.
  Identifiers MUST follow the form object-type--UUIDv4,
  where object-type is the exact value (all type names are lowercase strings, by definition)
  from the type property of the object being identified or referenced and
  where the UUIDv4 is an RFC 4122-compliant Version 4 UUID.
  """
  @behaviour Ecto.Type
  @uuid4_regex ~r/[a-f0-9]{8}-?[a-f0-9]{4}-?4[a-f0-9]{3}-?[89ab][a-f0-9]{3}-?[a-f0-9]{12}/

  def type, do: :string

  defp valid_uuid?(uuid) do
    @uuid4_regex
    |> Regex.match?(uuid)
  end

  def cast(identifier) when is_binary(identifier) do
    identifier
    |> String.split("--")
    |> case do
      [_type, uuid] ->
        if valid_uuid?(uuid) do
          {:ok, identifier}
        else
          :error
        end

      _other ->
        :error
    end
  end

  def generate(type_name) do
    IO.puts("GEN #{type_name}")
    "#{type_name}--#{Ecto.UUID.generate()}"
  end

  def load(id), do: {:ok, id}
  def dump(id), do: {:ok, id}
end
