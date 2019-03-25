defmodule StixEx.Object.CourseOfAction do
  use StixEx.Object, type_name: "course-of-action"

  @required_fields [:name]

  embedded_schema do
    common_fields()
    field(:name, :string)
    field(:description, :string)
  end

  common_functions()

  def changeset(struct, params) do
    struct
    |> cast_common(params)
    |> cast(params, [:name, :description])
    |> validate_required(@required_fields)
  end
end
