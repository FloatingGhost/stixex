defmodule StixEx.Object.Report do
  use StixEx.Object, type_name: "report"

  @required_fields [:labels, :name, :published, :object_refs]

  embedded_schema do
    common_fields()
    name_and_description()
    field(:published, :utc_datetime)
    field(:object_refs, {:array, StixEx.Types.Identifier})
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name, :description, :published, :object_refs])
    |> validate_required(@required_fields)
    |> validate_change(:labels, validate_values_in_vocab("report-label-ov"))
    |> validate_length(:object_refs, min: 1)
  end
end
