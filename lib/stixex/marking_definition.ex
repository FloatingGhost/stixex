defmodule StixEx.MarkingDefinition do
  @moduledoc """
  The marking-definition object represents a specific marking.
  Data markings typically represent handling or sharing requirements for data,
  and are applied in the object_marking_refs and granular_markings properties
  on STIX Object, which reference a list of IDs for marking-definition objects.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias StixEx.MarkingDefinition

  @derive Jason.Encoder
  @required_fields [:type, :id, :created, :definition_type, :definition]
  @type_name "marking-definition"
  @primary_key {:id, StixEx.Types.Identifier, []}

  embedded_schema do
    field(:type, :string)
    field(:created_by_ref, StixEx.Types.Identifier)
    field(:created, :utc_datetime_usec)
    field(:object_marking_refs, {:array, StixEx.Types.Identifier})
    field(:definition_type, :string)
    field(:definition, :map)
    embeds_many(:granular_markings, StixEx.Types.GranularMarking)
    embeds_many(:external_references, StixEx.Types.ExternalReference)
  end

  def new(params) do
    new_changeset =
      changeset(%__MODULE__{}, params)
      |> StixEx.Utils.put_if_not_set(:id, StixEx.Types.Identifier.generate(@type_name))

    if new_changeset.valid? do
      Ecto.Changeset.apply_action(new_changeset, :insert)
    else
      {:error, {:invalid, new_changeset}}
    end
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :type,
      :id,
      :created_by_ref,
      :object_marking_refs,
      :definition_type,
      :definition
    ])
    |> cast_embed(:granular_markings, with: &StixEx.Types.GranularMarking.changeset/2)
    |> cast_embed(:external_references, with: &StixEx.Types.ExternalReference.changeset/2)
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

  defp validate_definition(
         %{changes: %{definition: definition, definition_type: "tlp"}} = changeset
       ) do
    tlp_changeset = MarkingDefinition.TLP.changeset(%MarkingDefinition.TLP{}, definition)

    if tlp_changeset.valid? do
      changeset
    else
      add_error(changeset, :definition, "Invalid TLP definition")
    end
  end

  defp validate_definition(
         %{changes: %{definition: definition, definition_type: "statement"}} = changeset
       ) do
    statement_changeset =
      MarkingDefinition.Statement.changeset(%MarkingDefinition.Statement{}, definition)

    if statement_changeset.valid? do
      changeset
    else
      add_error(changeset, :definition, "Invalid statement definition")
    end
  end

  defp validate_definition(changeset), do: changeset
end
