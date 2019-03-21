defmodule Stixex.Objects.Report do
  use Stixex.Objects, type_name: "report"

  @required_fields [:labels, :name, :published, :object_refs]

  embedded_schema do
    common_fields()
    name_and_description()
    field(:published, :utc_datetime)
    field(:object_refs, {:array, Stixex.Types.Identifier})
  end

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name, :description, :published, :object_refs])
    |> validate_required(@required_fields)
    |> Stixex.Validation.validate_values_in_vocab(:labels, "report-label-ov")
    |> validate_length(:object_refs, min: 1)
  end
end
