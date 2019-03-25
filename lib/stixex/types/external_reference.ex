defmodule StixEx.Types.ExternalReference do
  @moduledoc """
  External references are used to describe pointers to information
  represented outside of STIX.

  For example, a Malware object could use an external reference to indicate an 
  ID for that malware in an external database or a report could use references to
  represent source material.
  """

  use Ecto.Schema
  import Ecto.Changeset
  import StixEx.Validation

  @derive Jason.Encoder
  @required_fields [:source_name]
  @required_one_of [:description, :url, :external_id]

  embedded_schema do
    field(:source_name, :string)
    field(:description, :string)
    field(:url, :string)
    field(:external_id, :string)
    field(:hashes, StixEx.Types.Hashes)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:source_name, :description, :url, :external_id, :hashes])
    |> validate_required(@required_fields)
    |> validate_one_of(@required_one_of)
    |> validate_change(:url, &validate_url/2)
  end
end
