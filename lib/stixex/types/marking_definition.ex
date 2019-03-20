defmodule Stixex.Types.MarkingDefinition do
  @moduledoc """
  The marking-definition object represents a specific marking.
  Data markings typically represent handling or sharing requirements for data,
  and are applied in the object_marking_refs and granular_markings properties
  on STIX Objects, which reference a list of IDs for marking-definition objects.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Stixex.Types.MarkingDefinition

  @required_fields [:type, :id, :created, :definition_type, :definition]
  @primary_key false

  embedded_schema do
    field :type, :string
    field :id, Stixex.Types.Identifier
    field :created_by_ref, Stixex.Types.Identifier
    field :created, :utc_datetime_usec
    field :external_references, {:array, Stixex.Types.ExternalReference}
    field :object_marking_refs, {:array, Stixex.Types.Identifier}
    field :granular_markings, {:array, Stixex.Types.GranularMarking}
    field :definition_type, :string
    field :definition, :map
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:type, :id, :created_by_ref, :external_references, :object_marking_refs, :granular_markings, :definition_type, :definition])
    |> put_created_at()
    |> validate_required(@required_fields)
    |> validate_length(:external_references, min: 1)
    |> validate_length(:object_marking_refs, min: 1)
    |> validate_length(:granular_markings, min: 1)
    |> validate_definition()
  end

  defp put_created_at(changeset) do
    changeset
    |> put_change(:created, DateTime.utc_now())
  end

  defp validate_definition(%{changes: %{definition: definition, definition_type: "tlp"}} = changeset) do
    tlp_changeset = MarkingDefinition.TLP.changeset(%MarkingDefinition.TLP{}, definition)
    if tlp_changeset.valid? do
      changeset
    else
      add_error(changeset, :definition, "Invalid TLP definition")
    end
  end

  defp validate_definition(%{changes: %{definition: definition, definition_type: "statement"}} = changeset) do
    statement_changeset = MarkingDefinition.Statement.changeset(%MarkingDefinition.Statement{}, definition)
    if statement_changeset.valid? do
      changeset
    else                                 
      add_error(changeset, :definition, "Invalid statement definition")
    end                                  
  end 

  defp validate_definition(changeset), do: changeset
end
