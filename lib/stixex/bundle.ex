defmodule StixEx.Bundle do
  use Ecto.Schema
  import Ecto.Changeset
  alias StixEx.{
    Types,
    Utils
  }

  @type_name "bundle"
  @spec_version "2.0"
  @primary_key false
  @required_fields [:type, :id, :spec_version]

  embedded_schema do
    field(:type, :string)
    field(:id, Types.Identifier, autogenerate: {Types.Identifier, :generate, [@type_name]})
    field(:spec_version, :string)

    embeds_many(:objects, Types.Object)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :spec_version])
    |> Utils.put_if_not_set(:type_name, @type_name)
    |> Utils.put_if_not_set(:spec_version, @spec_version)
    |> cast_embed(:objects, with: &Object.changeset/2)
    |> validate_length(:objects, min: 1)
    |> validate_required(@required_fields)
  end
end
