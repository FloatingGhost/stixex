defmodule Stixex.Objects do
  @moduledoc """
  Wrapper type to cast to other embeds
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  @required_fields [:type, :id]
  @common_field_names [:type, :id, :created_by_ref, :revoked, :labels, :object_marking_refs, :created, :modified]

  defmacro common_fields do
    quote do
      field :type, :string
      field :id, Stixex.Types.Identifier, autogenerate: true
      field :created_by_ref, Stixex.Types.Identifier
      field :revoked, :boolean, default: false
      field :labels, {:array, :string}
      field :object_marking_refs, {:array, Stixex.Types.Identifier}
      field :created, :utc_datetime_usec
      field :modified, :utc_datetime_usec

      embeds_many(:external_references, Stixex.Types.ExternalReference)
      embeds_many(:granular_markings, Stixex.Types.GranularMarking)
    end
  end

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Stixex.Objects

      @primary_key false
    end
  end

  def cast_common(changeset, params) do
    changeset
    |> cast(params, @common_field_names)
    |> cast_embed(:external_references)
    |> cast_embed(:granular_markings)
  end

  def validate(changeset) do
    changeset
    |> validate_required(@required_fields)
  end  

  embedded_schema do
  end

  def changeset(struct, params) do
  end
end
