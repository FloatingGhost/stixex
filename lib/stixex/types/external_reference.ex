defmodule Stixex.Types.ExternalReference do
  @moduledoc """
  External references are used to describe pointers to information
  represented outside of STIX.

  For example, a Malware object could use an external reference to indicate an 
  ID for that malware in an external database or a report could use references to
  represent source material.
  """

  use Ecto.Schema
  import Ecto.Changeset
  import Stixex.Validation

  @required_fields [:source_name]
  @required_one_of [:description, :url, :external_id]

  embedded_schema do
    field :source_name, :string
    field :description, :string
    field :url, :string
    field :hashes, Stixex.Types.Hashes
    field :external_id, :string
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:source_name, :description, :url, :hashes, :external_id])
    |> validate_required(@required_fields)
    |> validate_one_of(@required_one_of)
    |> validate_url(:url)
  end
end
